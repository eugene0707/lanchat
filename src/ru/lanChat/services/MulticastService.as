/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.services
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.GroupSpecifier;
	import flash.net.NetConnection;
	import flash.net.NetGroup;
	
	import ru.lanChat.dto.ConnectionParams;
	import ru.lanChat.dto.MulticastMessage;
	import ru.lanChat.events.MulticastEvent;
	
	[Event(name = "failed", type = "ru.lanChat.events.MulticastEvent")]
	[Event(name = "connected", type = "ru.lanChat.events.MulticastEvent")]
	[Event(name = "disconnected", type = "ru.lanChat.events.MulticastEvent")]
	[Event(name = "messageReceived", type = "ru.lanChat.events.MulticastEvent")]
	[Event(name = "neighborDisconnected", type = "ru.lanChat.events.MulticastEvent")]
		
	public class MulticastService extends EventDispatcher
	{
		private var _netConnection:NetConnection;
		
		private var _netGroup:NetGroup;
		
		private var _groupSpecifier:GroupSpecifier;
		
		private var _connectionParams:ConnectionParams;
		
		public function MulticastService()
		{
			super();
			init();
		}
				
		public function connect(connectionParams:ConnectionParams):void
		{
			_connectionParams = connectionParams;
			_groupSpecifier = buildGroupSpec(_connectionParams.groupAddr, _connectionParams.multicastAddr);
			
			_netConnection.connect(_connectionParams.serverAddr);
		}
		
		public function disconnect():void
		{
			_netConnection.close();
		}
		
		public function postGroupMessage(multicastMessage:MulticastMessage):void
		{
			_netGroup.post(multicastMessage.toObject());
		}
		
		public function postNeighborMessage(multicastMessage:MulticastMessage, neighborId:String):void
		{
			var peerAddress:String = _netGroup.convertPeerIDToGroupAddress(neighborId);
			var result:String = _netGroup.sendToNearest(multicastMessage.toObject(), peerAddress);
		}
			
		private var _connected:Boolean=false;
		
		public function get connected():Boolean
		{
			return _connected;
		}
		
		public function get peerId():String
		{
			return (_connected) ? _netConnection.nearID : '';
		}
		
		private function init():void
		{
			_netConnection = new NetConnection();
			_netConnection.addEventListener(NetStatusEvent.NET_STATUS, netConnectionStatusHandler);
		}
		
		private function setConnected(value:Boolean):void
		{
			if (_connected==value)
				return;
			
			_connected=value;
			
			if (_connected)
				dispatchEvent(new MulticastEvent(MulticastEvent.CONNECTED,_connectionParams))
			else
				dispatchEvent(new MulticastEvent(MulticastEvent.DISCONNECTED))
		}
		
		private function cleanUp():void
		{
			_groupSpecifier = null;
			_connectionParams = null;

			if (!_netGroup)
				return;
			
			_netGroup.close();
			_netGroup.removeEventListener(NetStatusEvent.NET_STATUS, netGroupStatusHandler);
			_netGroup = null;
		}
		
		private function buildGroupSpec(groupAddr:String, multicastAddr:String):GroupSpecifier
		{
			var groupSpecifier:GroupSpecifier;
			
			groupSpecifier = new GroupSpecifier(groupAddr);
			groupSpecifier.multicastEnabled = true;
			groupSpecifier.objectReplicationEnabled = true;
			groupSpecifier.postingEnabled = true;
			groupSpecifier.routingEnabled = true;
			groupSpecifier.ipMulticastMemberUpdatesEnabled = true; 
			
			groupSpecifier.addIPMulticastAddress(multicastAddr);
			
			return groupSpecifier;
		}
		
		private function connectGroup():void
		{
			_netGroup = new NetGroup(_netConnection, _groupSpecifier.groupspecWithAuthorizations());
			_netGroup.addEventListener(NetStatusEvent.NET_STATUS, netGroupStatusHandler);
			
		}
		
		private function processMessage(message: Object):void
		{
			var multicastMessage:MulticastMessage = MulticastMessage.fromObject(message);
			dispatchEvent(new MulticastEvent(MulticastEvent.MESSAGE_RECEIVED, multicastMessage));
		}
		
		private function netConnectionStatusHandler(event:NetStatusEvent):void
		{
			switch(event.info.code)
			{
				case "NetConnection.Connect.Success":
					connectGroup();
					break;

				case "NetConnection.Connect.Closed":
					setConnected(false);
					break;
				
				case "NetConnection.Connect.AppShutdown":
				case "NetConnection.Connect.Failed":
				case "NetConnection.Connect.InvalidApp":
				case "NetConnection.Connect.Rejected":
					dispatchEvent(new MulticastEvent(MulticastEvent.FAILED))
					cleanUp();
					break;
				
				case "NetGroup.Connect.Success":
					setConnected(true);
					break;
				
				default:
					break;
				
			}
		}
		
		private function netGroupStatusHandler(event:NetStatusEvent):void
		{
			switch(event.info.code)
			{
				
				case "NetGroup.Connect.Rejected":
				case "NetGroup.Connect.Failed": 
					disconnect();
					break;
				
				case "NetGroup.SendTo.Notify": 
					processMessage(event.info.message);
					break;
				case "NetGroup.Posting.Notify":
					processMessage(event.info.message);
					break;
				
				case "NetGroup.Neighbor.Connect":
					dispatchEvent(new MulticastEvent(MulticastEvent.NEIGHBOR_CONNECTED, event.info.peerID));
					break;
				case "NetGroup.Neighbor.Disconnect":
					dispatchEvent(new MulticastEvent(MulticastEvent.NEIGHBOR_DISCONNECTED, event.info.peerID));
					break;
				
				default:
					break;
			}
		}
	}
}
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
	
	import ru.lanChat.dto.MulticastMessage;
	import ru.lanChat.dto.Participant;
	import ru.lanChat.events.MulticastEvent;
	
	[Event(name = "failed", type = "ru.lanChat.events.MulticastEvent")]
	[Event(name = "connected", type = "ru.lanChat.events.MulticastEvent")]
	[Event(name = "disconnected", type = "ru.lanChat.events.MulticastEvent")]
	[Event(name = "messageReceived", type = "ru.lanChat.events.MulticastEvent")]
	
	public class MulticastService extends EventDispatcher
	{
		public static const CHAT_MESSAGE_TYPE:String = "chatMessage";
				
		private var _netConnection:NetConnection;
		
		private var _netGroup:NetGroup;
		
		private var _groupSpecifier:GroupSpecifier;
		
		private var _myParticipant:Participant;
		
		public function MulticastService()
		{
			super();
			init();
		}
				
		public function connect(userName:String, serverAddr:String="rtmfp:", groupAddr:String="lanChat/room", multicastAddr:String="235.255.255.1:10000"):void
		{
			_myParticipant = new Participant(userName);
			_groupSpecifier = buildGroupSpec(groupAddr, multicastAddr);
			
			_netConnection.connect(serverAddr);
		}
		
		public function disconnect():void
		{
			_netConnection.close();
		}
		
		public function sendChatMessage(message:String):void
		{
			var multicastMessage:MulticastMessage = new MulticastMessage(CHAT_MESSAGE_TYPE, _myParticipant, message);
			_netGroup.post(multicastMessage);
		}
			
		private var _connected:Boolean=false;
		
		public function set connected(value:Boolean):void
		{
			if (_connected==value)
				return;
			
			_connected=value;
			
			if (_connected)
				dispatchEvent(new MulticastEvent(MulticastEvent.CONNECTED,_myParticipant))
			else
				dispatchEvent(new MulticastEvent(MulticastEvent.DISCONNECTED))
		}
		
		public function get connected():Boolean
		{
			return _connected;
		}
		
		private function cleanUp():void
		{
			_groupSpecifier = null;
			_myParticipant = null;

			if (!_netGroup)
				return;
			
			_netGroup.close();
			_netGroup.removeEventListener(NetStatusEvent.NET_STATUS, netGroupStatusHandler);
			_netGroup = null;
		}
		
		private function init():void
		{
			_netConnection = new NetConnection();
			_netConnection.addEventListener(NetStatusEvent.NET_STATUS, netConnectionStatusHandler);
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
			dispatchEvent(new MulticastEvent(MulticastEvent.MESSAGE_RECEIVED, message));
		}
		
		private function netConnectionStatusHandler(event:NetStatusEvent):void
		{
			switch(event.info.code)
			{
				case "NetConnection.Connect.Success":
					connectGroup();
					break;

				case "NetConnection.Connect.Closed":
					connected = false;
					break;
				
				case "NetConnection.Connect.AppShutdown":
				case "NetConnection.Connect.Failed":
				case "NetConnection.Connect.InvalidApp":
				case "NetConnection.Connect.Rejected":
					dispatchEvent(new MulticastEvent(MulticastEvent.FAILED))
					cleanUp();
					break;
				
				case "NetGroup.Connect.Success": 
					connected = true;
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
					break;
				case "NetGroup.Posting.Notify":
					processMessage(event.info.message);
					break;
				
				case "NetGroup.Neighbor.Connect":
//					tbc
					break;
				case "NetGroup.Neighbor.Disconnect":
//					tbc 
					break;
				
				default:
					break;
			}
		}
	}
}
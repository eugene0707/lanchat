/**
 * @author Eugene Kondrashov
 * Mar 29, 2015
 */
package ru.lanChat.dto
{
	public class ConnectionParams
	{
		private static const DEFAULT_SERVER_ADDRESS:String = "rtmfp:";
		private static const DEFAULT_GROUP_ADDRESS:String = "lanChat/room";
		private static const DEFAULT_MULTICAST_ADDRESS:String = "235.255.255.1:10000";
		
		
		public function ConnectionParams(userName:String, serverAddr:String, groupAddr:String, multicastAddr:String)
		{
			_userName = userName;
			_serverAddr = (serverAddr) ? serverAddr : DEFAULT_SERVER_ADDRESS;
			_groupAddr = (groupAddr) ? groupAddr : DEFAULT_GROUP_ADDRESS;
			_multicastAddr = (multicastAddr) ? multicastAddr : DEFAULT_MULTICAST_ADDRESS;
		}
		
		private var _userName:String;
		
		public function get userName():String
		{
			return _userName;
		}
		
		private var _serverAddr:String;
		
		public function get serverAddr():String
		{
			return _serverAddr;
		}
		
		private var _groupAddr:String;
		
		public function get groupAddr():String
		{
			return _groupAddr;
		}
		
		private var _multicastAddr:String;
		
		public function get multicastAddr():String
		{
			return _multicastAddr;
		}
		
		public static function fromObject(value:Object):ConnectionParams
		{
			var connectionParams:ConnectionParams = new ConnectionParams(value.userName, value.serverAddr, value.groupAddr, value.multicastAddr);
			return connectionParams;
		}
		
	}
}
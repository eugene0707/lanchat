/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.dto
{
	public class Participant
	{
		
		public function Participant(userName:String, peerId:String)
		{
			_userName = userName;
			_peerId = peerId;
			_since = new Date();
		}
		
		public function toObject():Object
		{
			var object:Object = new Object();
			object.userName = this.userName;
			object.peerId = this.peerId;
			object.since = this.since;
			return object;
		}
		
		private var _userName:String;
		
		public function get userName():String
		{
			return _userName;
		}
		
		private var _peerId:String;
		
		public function get peerId():String
		{
			return _peerId;
		}
		
		private var _since:Date;
		
		public function get since():Date
		{
			return _since;
		}
		
		public static function fromObject(value:Object):Participant
		{
			var participant:Participant = new Participant(value.userName, value.peerId);
			
			return participant;
		}
		
	}
}
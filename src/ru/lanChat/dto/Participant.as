package ru.lanChat.dto
{
	public class Participant
	{
		
		public function Participant(userName:String, id:String=null, nearId:String=null)
		{
			_id = (id) ? id : MulticastMessage.generateId(16);
			_nearId = nearId;
			_userName = userName;
		}
		
		public function toObject():Object
		{
			var object:Object = new Object();
			object.id = this.id;
			object.userName = this.userName;
			object.nearId = this.nearId;
			return object;
		}
		
		private var _id:String;
		
		public function get id():String
		{
			return _id;
		}
		
		private var _userName:String;
		
		public function get userName():String
		{
			return _userName;
		}
		
		private var _nearId:String;
		
		public function get nearId():String
		{
			return _nearId;
		}
		
	}
}
package ru.lanChat.dto
{
	public class MulticastMessage
	{
		public var type:String;
		public var data:Object;
		public var sender:Object;
		public var messageId:String;

		public function MulticastMessage(type:String, sender: Participant, data:Object)
		{
			this.type = type;
			this.sender = sender.toObject();
			this.data = data;
			this.messageId = generateId(16);
		}
		
		public function toObject():Object
		{
			var object:Object = new Object();
			object.type = this.type;
			object.sender = this.sender;
			object.data = this.data;
			object.messageId = this.messageId;
			return object;
		}
		
		public static function generateId(size:uint):String
		{
			var chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
			var returnString:String = new String();
			for (var a:uint = 0; a < size; a++) 
			{
				returnString += chars.charAt(Math.floor(Math.random()*chars.length));
			}
			return returnString;
		}
		
	}
}
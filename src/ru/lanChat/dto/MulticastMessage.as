package ru.lanChat.dto
{
	public class MulticastMessage
	{
		public var type:String;
		public var data:Object;
		public var sender:Participant;
		public var messageId:String;

		public function MulticastMessage(type:String, sender: Participant, data:Object = null)
		{
			this.type = type;
			this.sender = sender;
			this.data = data;
			this.messageId = generateId(16);
		}
		
		public function toObject():Object
		{
			var object:Object = new Object();
			object.type = this.type;
			object.sender = this.sender.toObject();
			object.data = this.data;
			object.messageId = this.messageId;
			return object;
		}
		
		public static function fromObject(value:Object):MulticastMessage
		{
			var sender:Participant = Participant.fromObject(value.sender);
			var multicastMessage:MulticastMessage = new MulticastMessage(value.type, sender, value.data);
			
			multicastMessage.messageId = value.messageId;

			return multicastMessage;
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
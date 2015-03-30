/**
 * @author Eugene Kondrashov
 * Mar 29, 2015
 */
package ru.lanChat.dto
{
	public class ChatMessage
	{
		
		public function ChatMessage(sender: Participant, text:String)
		{
			_text = text;
			_sender = sender;
			_date = new Date();
		}
		
		public function toObject():Object
		{
			var object:Object = new Object();
			object.text = _text;
			object.sender = _sender;
			object.date = _date;
			return object;
		}
		
		private var _text:String;
		
		public function get text():String
		{
			return _text;
		}
		
		private var _sender:Participant;
		
		public function get sender():Participant
		{
			return _sender;
		}
		
		private var _date:Date;
		
		public function get date():Date
		{
			return _date;
		}
		
	}
}
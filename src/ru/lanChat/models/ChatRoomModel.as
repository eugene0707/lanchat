/**
 * @author Eugene Kondrashov
 * Mar 25, 2015
 */
package ru.lanChat.models
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import ru.lanChat.dto.ChatMessage;
	import ru.lanChat.dto.Participant;
	import ru.lanChat.events.ChatRoomEvent;
	
	[Event(name = "participantAdded", type = "ru.lanChat.events.ChatRoomEvent")]
	[Event(name = "participantRemoved", type = "ru.lanChat.events.ChatRoomEvent")]
	[Event(name = "chatMessageAdded", type = "ru.lanChat.events.ChatRoomEvent")]
	[Event(name = "chatRoomEntered", type = "ru.lanChat.events.ChatRoomEvent")]
	[Event(name = "chatRoomLeaved", type = "ru.lanChat.events.ChatRoomEvent")]

	public class ChatRoomModel extends EventDispatcher
	{
		public static const CHAT_MESSAGE_TYPE:String = "chatMessage";
		
		public static const PARTICIPANT_CONNECTED_TYPE:String = "participantConnected";
		
		public static const PARTICIPANT_DICONNECTED_TYPE:String = "participantDisconnected";
		
		public function ChatRoomModel(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function start(participant:Participant):void
		{
			_myParticipant = participant;
			dispatchEvent(new ChatRoomEvent(ChatRoomEvent.CHAT_ROOM_ENTERED, _myParticipant));
			
			_participants = new Dictionary();
			addParticipant(_myParticipant);
		}
		
		public function stop():void
		{
			_myParticipant = null;
			_participants = null;
			dispatchEvent(new ChatRoomEvent(ChatRoomEvent.CHAT_ROOM_LEAVED));

		}
		
		public function addChatMessage(message:ChatMessage):void
		{
			dispatchEvent(new ChatRoomEvent(ChatRoomEvent.CHAT_MESSAGE_ADDED, message));
		}
		
		private var _myParticipant:Participant;
		
		public function get myParticipant():Participant
		{
			return _myParticipant;
		}
		
		private var _participants:Dictionary;
		
		public function get participants():Dictionary
		{
			return _participants;
		}
		
		public function addParticipant(value:Participant):void
		{
			if (_participants.hasOwnProperty(value.peerId))
				return;
			
			_participants[value.peerId] = value;
			
			dispatchEvent(new ChatRoomEvent(ChatRoomEvent.PARTICIPANT_ADDED, value));
		}
		
		public function removeParticipant(peerId:String):void
		{
			var removedValue:Participant = _participants[peerId];
			
			if (!removedValue)
				return;
			
			delete _participants[peerId];
			
			dispatchEvent(new ChatRoomEvent(ChatRoomEvent.PARTICIPANT_REMOVED, removedValue));
		}
		
		
	}
}
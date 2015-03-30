/**
 * @author Eugene Kondrashov
 * Mar 25, 2015
 */
package ru.lanChat.events
{

    public class ChatRoomEvent extends ValueEvent
    {

		static public const PARTICIPANT_ADDED:String = "participantAdded";
		
		static public const PARTICIPANT_REMOVED:String = "participantRemoved";
		
		static public const CHAT_MESSAGE_ADDED:String = "chatMessageAdded";
		
		static public const CHAT_ROOM_ENTERED:String = "chatRoomEntered";
		
		static public const CHAT_ROOM_LEAVED:String = "chatRoomLeaved";
		
        public function ChatRoomEvent(type:String, value:* = null, bubbles:Boolean = false,
                                       cancelable:Boolean = false)
        {
            super(type, value, bubbles, cancelable);
        }
    }
}

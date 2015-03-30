/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.controllers
{
    import ru.lanChat.dto.ChatMessage;
    import ru.lanChat.dto.MulticastMessage;
    import ru.lanChat.events.MulticastEvent;
    import ru.lanChat.models.ChatRoomModel;
    import ru.lanChat.services.MulticastService;

    public class MulticastMessagesController
    {
		private var _multicastService:MulticastService;
		
		private var _chatRoomModel:ChatRoomModel;
		
        public function MulticastMessagesController(multicastService:MulticastService, chatRoomModel:ChatRoomModel)
        {			
			_chatRoomModel = chatRoomModel;
			
			_multicastService = multicastService;
			_multicastService.addEventListener(MulticastEvent.MESSAGE_RECEIVED, multicastMessageReceivedHandler);
			
        }

		private function multicastMessageReceivedHandler(event:MulticastEvent):void
		{
			var multicastMessage:MulticastMessage = event.value;
			
			switch(multicastMessage.type)
			{
				case ChatRoomModel.CHAT_MESSAGE_TYPE:
					var chatMessage:ChatMessage = new ChatMessage(multicastMessage.sender, multicastMessage.data.toString());
					_chatRoomModel.addChatMessage(chatMessage);
					break;

				case ChatRoomModel.PARTICIPANT_CONNECTED_TYPE:
					_chatRoomModel.addParticipant(multicastMessage.sender);
					break;
			}
		}
		
    }
}

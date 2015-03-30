/**
 * @author Eugene Kondrashov
 * Mar 29, 2015
 */
package ru.lanChat.controllers
{
    import ru.lanChat.dto.ChatMessage;
    import ru.lanChat.dto.MulticastMessage;
    import ru.lanChat.dto.Participant;
    import ru.lanChat.events.ChatRoomEvent;
    import ru.lanChat.events.ExternalEvent;
    import ru.lanChat.models.ChatRoomModel;
    import ru.lanChat.services.ExternalService;
    import ru.lanChat.services.MulticastService;

    public class ChatMessagesController
    {
		private var _externalService:ExternalService;
		
		private var _multicastService:MulticastService;
		
		private var _chatRoomModel:ChatRoomModel;
		
        public function ChatMessagesController(externalService:ExternalService, multicastService:MulticastService, chatRoomModel:ChatRoomModel)
        {
			_multicastService = multicastService;
			
			_externalService = externalService;
			_externalService.addEventListener(ExternalEvent.SEND_MESSAGE, externalSendMessageHandler);
			
			_chatRoomModel = chatRoomModel;
			_chatRoomModel.addEventListener(ChatRoomEvent.CHAT_MESSAGE_ADDED, chatMessageAddedHandler);
        }

		private function externalSendMessageHandler(event:ExternalEvent):void
		{
			var chatMessage:ChatMessage = new ChatMessage(_chatRoomModel.myParticipant, event.value);
			var multicastMessage:MulticastMessage = new MulticastMessage(ChatRoomModel.CHAT_MESSAGE_TYPE, _chatRoomModel.myParticipant, event.value);
			
			_multicastService.postGroupMessage(multicastMessage);
			_chatRoomModel.addChatMessage(chatMessage);
		}
		
		private function chatMessageAddedHandler(event:ChatRoomEvent):void
		{
			_externalService.sendChatMessage(event.value);
		}
		
    }
}

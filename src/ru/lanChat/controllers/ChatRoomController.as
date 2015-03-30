/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.controllers
{
    import ru.lanChat.dto.ConnectionParams;
    import ru.lanChat.dto.MulticastMessage;
    import ru.lanChat.dto.Participant;
    import ru.lanChat.events.ChatRoomEvent;
    import ru.lanChat.events.MulticastEvent;
    import ru.lanChat.models.ChatRoomModel;
    import ru.lanChat.services.ExternalService;
    import ru.lanChat.services.MulticastService;

    public class ChatRoomController
    {
		private var _externalService:ExternalService;
		
		private var _multicastService:MulticastService;
		
		private var _chatRoomModel:ChatRoomModel;
		
        public function ChatRoomController(externalService:ExternalService, multicastService:MulticastService, chatRoomModel:ChatRoomModel)
        {
			_multicastService = multicastService;
			_multicastService.addEventListener(MulticastEvent.CONNECTED, multicastConnectedHandler);
			_multicastService.addEventListener(MulticastEvent.DISCONNECTED, multicastDisconnectedHandler);
			
			_externalService = externalService;
			
			_chatRoomModel = chatRoomModel;
			_chatRoomModel.addEventListener(ChatRoomEvent.CHAT_ROOM_ENTERED, chatRoomEnteredHandler);
			_chatRoomModel.addEventListener(ChatRoomEvent.CHAT_ROOM_LEAVED, chatRoomLeavedHandler);
        }

		private function multicastConnectedHandler(event:MulticastEvent):void
		{
			var connectionParams:ConnectionParams = event.value;
			var participant:Participant = new Participant(connectionParams.userName, _multicastService.peerId);
			_chatRoomModel.start(participant);
		}
		
		private function multicastDisconnectedHandler(event:MulticastEvent):void
		{
			_chatRoomModel.stop();
		}
		
		private function chatRoomEnteredHandler(event:ChatRoomEvent):void
		{
			var multicastMessage:MulticastMessage = new MulticastMessage(ChatRoomModel.PARTICIPANT_CONNECTED_TYPE, event.value);
			
			_multicastService.postGroupMessage(multicastMessage);
			_externalService.sendConnected(event.value);
			
		}
		
		private function chatRoomLeavedHandler(event:ChatRoomEvent):void
		{
			_externalService.sendDisconnected();
		}
		
    }
}

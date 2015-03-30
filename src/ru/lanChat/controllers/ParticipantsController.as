/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.controllers
{
    import ru.lanChat.dto.MulticastMessage;
    import ru.lanChat.events.ChatRoomEvent;
    import ru.lanChat.events.MulticastEvent;
    import ru.lanChat.models.ChatRoomModel;
    import ru.lanChat.services.ExternalService;
    import ru.lanChat.services.MulticastService;

    public class ParticipantsController
    {
		private var _externalService:ExternalService;
		
		private var _multicastService:MulticastService;
		
		private var _chatRoomModel:ChatRoomModel;
		
        public function ParticipantsController(externalService:ExternalService, multicastService:MulticastService, chatRoomModel:ChatRoomModel)
        {
			_multicastService = multicastService;
			_multicastService.addEventListener(MulticastEvent.NEIGHBOR_CONNECTED, multicastNeighborConnectedHandler);
			_multicastService.addEventListener(MulticastEvent.NEIGHBOR_DISCONNECTED, multicastNeighborDisconnectedHandler);
			
			_externalService = externalService;
			
			_chatRoomModel = chatRoomModel;
			_chatRoomModel.addEventListener(ChatRoomEvent.PARTICIPANT_ADDED, chatRoomParticipantAddedHandler);
			_chatRoomModel.addEventListener(ChatRoomEvent.PARTICIPANT_REMOVED, chatRoomParticipantRemovedHandler);
        }

		private function multicastNeighborConnectedHandler(event:MulticastEvent):void
		{
			var multicastMessage:MulticastMessage = new MulticastMessage(ChatRoomModel.PARTICIPANT_CONNECTED_TYPE, _chatRoomModel.myParticipant);
			_multicastService.postNeighborMessage(multicastMessage, event.value);
		}
		
		private function multicastNeighborDisconnectedHandler(event:MulticastEvent):void
		{
			_chatRoomModel.removeParticipant(event.value);
		}
		
		private function multicastDisconnectedHandler(event:MulticastEvent):void
		{
			_chatRoomModel.stop();
		}
		
		private function chatRoomParticipantAddedHandler(event:ChatRoomEvent):void
		{
			_externalService.sendParticipantConnected(event.value);
		}
		
		private function chatRoomParticipantRemovedHandler(event:ChatRoomEvent):void
		{
			_externalService.sendParticipantDisconnected(event.value);
		}
		
    }
}

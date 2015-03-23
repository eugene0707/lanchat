/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.controllers
{
    import ru.lanChat.dto.MulticastMessage;
    import ru.lanChat.events.ExternalEvent;
    import ru.lanChat.events.MulticastEvent;
    import ru.lanChat.services.ExternalService;
    import ru.lanChat.services.MulticastService;

    public class ChatController
    {
		private var _externalService:ExternalService;
		
		private var _multicastService:MulticastService;
		
        public function ChatController(externalService:ExternalService, multicastService:MulticastService)
        {
			_multicastService = multicastService;
			_multicastService.addEventListener(MulticastEvent.MESSAGE_RECEIVED, multicastMessageReceivedHandler);
			
			_externalService = externalService;
			_externalService.addEventListener(ExternalEvent.SEND_MESSAGE, externalSendMessageHandler);
        }

		private function externalSendMessageHandler(event:ExternalEvent):void
		{
			_multicastService.sendChatMessage(event.value);
		}
		
		private function multicastMessageReceivedHandler(event:MulticastEvent):void
		{
			_externalService.sendChatMessage(event.value);
		}
		
    }
}

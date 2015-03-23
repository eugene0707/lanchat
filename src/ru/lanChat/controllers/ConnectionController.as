/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.controllers
{
    import ru.lanChat.events.ExternalEvent;
    import ru.lanChat.events.MulticastEvent;
    import ru.lanChat.services.ExternalService;
    import ru.lanChat.services.MulticastService;

    public class ConnectionController
    {
		private var _externalService:ExternalService;
		
		private var _multicastService:MulticastService;
		
        public function ConnectionController(externalService:ExternalService, multicastService:MulticastService)
        {
			_multicastService = multicastService;
			_multicastService.addEventListener(MulticastEvent.CONNECTED, multicastConnectedHandler);
			_multicastService.addEventListener(MulticastEvent.DISCONNECTED, multicastDisconnectedHandler);
			_multicastService.addEventListener(MulticastEvent.FAILED, multicastConnectionFailedHandler);
			
			_externalService = externalService;
			_externalService.addEventListener(ExternalEvent.CONNECT, externalConnectHandler);
			_externalService.addEventListener(ExternalEvent.DISCONNECT, externalDisconnectHandler);
        }

		private function externalConnectHandler(event:ExternalEvent):void
		{
			_multicastService.connect(event.value);
		}
		
		private function externalDisconnectHandler(event:ExternalEvent):void
		{
			_multicastService.disconnect();
		}
		
		private function multicastConnectedHandler(event:MulticastEvent):void
		{
			_externalService.sendConnected(event.value);
		}
		
		private function multicastDisconnectedHandler(event:MulticastEvent):void
		{
			_externalService.sendDisconnected();
		}
		
		private function multicastConnectionFailedHandler(event:MulticastEvent):void
		{
			_externalService.sendConnectionFailed();
		}
		
    }
}

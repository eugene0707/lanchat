/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.controllers
{
    import ru.lanChat.events.ExternalEvent;
    
    import ru.lanChat.services.ExternalService;

    public class EchoController
    {
        private var _externalService:ExternalService;

        public function EchoController(externalService:ExternalService)
        {
            _externalService = externalService;
			_externalService.addEventListener(ExternalEvent.ECHO, echoHandler);
        }

        private function echoHandler(event:ExternalEvent):void
        {
            _externalService.sendEcho(event.value);
        }

    }
}

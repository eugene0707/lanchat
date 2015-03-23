package
{
	import flash.display.Sprite;
	
	import ru.lanChat.controllers.ChatController;
	import ru.lanChat.controllers.ConnectionController;
	import ru.lanChat.controllers.EchoController;
	import ru.lanChat.services.ExternalService;
	import ru.lanChat.services.MulticastService;
	
	public class LanChat extends Sprite
	{
		// Services
		
		protected var externalService:ExternalService = new ExternalService();
		
		protected var multicastService:MulticastService = new MulticastService();
		
		// Models
		

		// Controllers
		
		protected var echoController:EchoController;
		
		protected var connectionController:ConnectionController;
		
		protected var chatController:ChatController;
		
		public function LanChat()
		{
			super();
			init();
		}

		private function init():void
		{
			echoController = new EchoController(externalService);
			connectionController = new ConnectionController(externalService, multicastService);
			chatController = new ChatController(externalService, multicastService);
			
		}
		
	}
}
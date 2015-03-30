package
{
	import flash.display.Sprite;
	
	import ru.lanChat.controllers.ChatMessagesController;
	import ru.lanChat.controllers.ChatRoomController;
	import ru.lanChat.controllers.ConnectionController;
	import ru.lanChat.controllers.EchoController;
	import ru.lanChat.controllers.MulticastMessagesController;
	import ru.lanChat.controllers.ParticipantsController;
	import ru.lanChat.models.ChatRoomModel;
	import ru.lanChat.services.ExternalService;
	import ru.lanChat.services.MulticastService;
	
	public class LanChat extends Sprite
	{
		// Services
		
		protected var externalService:ExternalService = new ExternalService();
		
		protected var multicastService:MulticastService = new MulticastService();
		
		// Models
		
		protected var chatRoomModel:ChatRoomModel = new ChatRoomModel();
		
		// Controllers
		
		protected var echoController:EchoController;
		
		protected var connectionController:ConnectionController;
		
		protected var multicastMessagesController:MulticastMessagesController;
		
		protected var chatRoomController:ChatRoomController;
		
		protected var chatMessagesController:ChatMessagesController;
		
		protected var participantsController:ParticipantsController;
		
		public function LanChat()
		{
			super();
			init();
		}

		private function init():void
		{
			echoController = new EchoController(externalService);

			connectionController = new ConnectionController(externalService, multicastService);
			multicastMessagesController = new MulticastMessagesController(multicastService, chatRoomModel);

			chatRoomController = new ChatRoomController(externalService, multicastService, chatRoomModel);
			chatMessagesController = new ChatMessagesController(externalService, multicastService, chatRoomModel);
			participantsController = new ParticipantsController(externalService, multicastService, chatRoomModel);
			
		}
		
	}
}
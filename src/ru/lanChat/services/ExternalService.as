/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.services
{
    import flash.events.EventDispatcher;
    import flash.events.IEventDispatcher;
    import flash.external.ExternalInterface;
    import flash.utils.ByteArray;
    
    import ru.lanChat.dto.ChatMessage;
    import ru.lanChat.dto.ConnectionParams;
    import ru.lanChat.dto.Participant;
    import ru.lanChat.events.ExternalEvent;
    
    [Event(name = "externalStatus", type = "ru.lanChat.events.ExternalEvent")]
    [Event(name = "connect", type = "ru.lanChat.events.ExternalEvent")]
	[Event(name = "disconnect", type = "ru.lanChat.events.ExternalEvent")]
	[Event(name = "sendMessage", type = "ru.lanChat.events.ExternalEvent")]
	[Event(name = "echo", type = "ru.lanChat.events.ExternalEvent")]
	
    public class ExternalService extends EventDispatcher
    {
        private var _objectId:String;

        // internal callbacks

        private const EXTERNAL_STATUS_CALLBACK:String = "externalStatus";

        private const CONNECT_CALLBACK:String = "connect";

		private const DISCONNECT_CALLBACK:String = "disconnect";
		
		private const SEND_MESSAGE_CALLBACK:String = "sendMessage";
		
		private const ECHO_CALLBACK:String = "echo";
		
        // external calls

		private const SEND_CONNECTED_CALL:String = "flashConnected";
		
		private const SEND_DISCONNECTED_CALL:String = "flashDisconnected";
		
		private const SEND_CONNECTION_FAILED_CALL:String = "flashConnectionFailed";
		
		private const SEND_CHAT_MESSAGE_CALL:String = "flashChatMessage";

		private const SEND_PARTICIPANT_CONNECTED_CALL:String = "flashParticipantConnected";
		
		private const SEND_PARTICIPANT_DISCONNECTED_CALL:String = "flashParticipantDisconnected";
		
		private const SEND_STATUS_CALL:String = "flashStatus";
				
		private const SEND_ECHO_CALL:String = "flashEcho";
		
        public function ExternalService()
        {
            super();
            init();
        }

        private function init():void
        {

            _objectId = ExternalInterface.objectID;

            ExternalInterface.addCallback(EXTERNAL_STATUS_CALLBACK, externalStatus);

            ExternalInterface.addCallback(CONNECT_CALLBACK, connect);
			ExternalInterface.addCallback(DISCONNECT_CALLBACK, disconnect);
			ExternalInterface.addCallback(SEND_MESSAGE_CALLBACK, sendMessage);
			
			ExternalInterface.addCallback(ECHO_CALLBACK, echo);
			
        }

        private function serialize(value:*):String
        {
            var serializedValue:String = JSON.stringify(value);
            return serializedValue;
        }

        private function deserialize(value:String):Object
        {
            var deserializedValue:Object = JSON.parse(value);
            return deserializedValue;
        }

        // internal callbacks

        private function externalStatus(status:String):void
        {
            dispatchEvent(new ExternalEvent(ExternalEvent.EXTERNAL_STATUS, status));
        }
		
        private function connect(connectionParamsJson:String=null):void
        {
			var value:Object = deserialize(connectionParamsJson);
			
            dispatchEvent(new ExternalEvent(ExternalEvent.CONNECT, ConnectionParams.fromObject(value)));
        }

		private function disconnect():void
		{
			dispatchEvent(new ExternalEvent(ExternalEvent.DISCONNECT));
		}
		
		private function sendMessage(message:String=null):void
		{
			dispatchEvent(new ExternalEvent(ExternalEvent.SEND_MESSAGE, message));
		}
		
		private function echo(message:String=null):void
		{
			dispatchEvent(new ExternalEvent(ExternalEvent.ECHO, message));
		}
		
       // external calls

		public function sendConnected(participant:Participant):void
		{
			ExternalInterface.call(SEND_CONNECTED_CALL, ExternalInterface.objectID, serialize(participant.toObject()));
		}
		
		public function sendDisconnected():void
		{
			ExternalInterface.call(SEND_DISCONNECTED_CALL, ExternalInterface.objectID);
		}
		
		public function sendConnectionFailed():void
		{
			ExternalInterface.call(SEND_CONNECTION_FAILED_CALL, ExternalInterface.objectID);
		}
		
		public function sendChatMessage(message:ChatMessage):void
		{
			ExternalInterface.call(SEND_CHAT_MESSAGE_CALL, ExternalInterface.objectID, serialize(message.toObject()));
		}
		
		public function sendParticipantConnected(participant:Participant):void
		{
			ExternalInterface.call(SEND_PARTICIPANT_CONNECTED_CALL, ExternalInterface.objectID, serialize(participant.toObject()));
		}
		
		public function sendParticipantDisconnected(participant:Participant):void
		{
			ExternalInterface.call(SEND_PARTICIPANT_DISCONNECTED_CALL, ExternalInterface.objectID, serialize(participant.toObject()));
		}
		
		public function sendStatus(statusName:String, statusValue:*):void
		{
			ExternalInterface.call(SEND_STATUS_CALL, ExternalInterface.objectID, statusName, serialize(statusValue));
		}
		
		public function sendEcho(message:String):void
		{
			ExternalInterface.call(SEND_ECHO_CALL, ExternalInterface.objectID, message);
		}
		


    }
}

/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.events
{

    public class ExternalEvent extends ValueEvent
    {
        static public const EXTERNAL_STATUS:String = "externalStatus";

        static public const CONNECT:String = "connect";

		static public const DISCONNECT:String = "disconnect";
		
		static public const SEND_MESSAGE:String = "sendMessage";
				
		static public const ECHO:String = "echo";
		
        public function ExternalEvent(type:String, value:* = null, bubbles:Boolean = false,
                                      cancelable:Boolean = false)
        {
            super(type, value, bubbles, cancelable);
        }
    }
}

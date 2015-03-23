/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.events
{

    public class MulticastEvent extends ValueEvent
    {

		static public const CONNECTED:String = "connectionConnected";
		
		static public const DISCONNECTED:String = "connectionDisconnected";
		
		static public const FAILED:String = "connectionFailed";
		
		static public const MESSAGE_RECEIVED:String = "messageReceived";
		
        public function MulticastEvent(type:String, value:* = null, bubbles:Boolean = false,
                                       cancelable:Boolean = false)
        {
            super(type, value, bubbles, cancelable);
        }
    }
}

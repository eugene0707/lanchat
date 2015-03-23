/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.events
{

    public class ConnectionEvent extends ValueEvent
    {

        static public const STATE_CHANGED:String = "connectionStateChanged";

        public function ConnectionEvent(type:String, value:* = null, bubbles:Boolean = false,
                                       cancelable:Boolean = false)
        {
            super(type, value, bubbles, cancelable);
        }
    }
}

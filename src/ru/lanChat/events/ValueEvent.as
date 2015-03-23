/**
 * @author Eugene Kondrashov
 * Mar 21, 2015
 */
package ru.lanChat.events
{
    import flash.events.Event;
    import flash.utils.getQualifiedClassName;

    public class ValueEvent extends Event
    {
        public var value:*;

        public function ValueEvent(type:String, value:* = null, bubbles:Boolean = false,
                                   cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
            this.value = value;
        }

        override public function clone():Event
        {
            return new ValueEvent(type, value, bubbles, cancelable);
        }

        override public function toString():String
        {
            return formatToString(getQualifiedClassName(this), "type", "value", "bubbles", "cancelable", "eventPhase");
        }

    }
}

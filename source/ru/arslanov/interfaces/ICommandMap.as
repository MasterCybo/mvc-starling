/**
 * Created by Artem-Home on 13.02.2017.
 */
package ru.arslanov.starling.mvc.interfaces
{
	import flash.events.Event;
	
	public interface ICommandMap
	{
		function hasEventType(eventType:String):Boolean;
		function unmap(eventType:String):void;
		function map(eventType:String):ICommandMap;
		function toCommand(commandClass:Class):void;
		function tryExecute(event:Event):Boolean;
	}
}

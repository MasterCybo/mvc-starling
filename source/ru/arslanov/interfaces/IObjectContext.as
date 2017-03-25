/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.starling.mvc.interfaces
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface IObjectContext extends IObjectAccessor
	{
		function get context():IContext;

		function destroy():void;
		
		function hasContextListener(type:String):Boolean;
		function willTrigger(type:String):Boolean;
		function addContextListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		function removeContextListener(type:String, listener:Function, useCapture:Boolean = false):void;
		function dispatchEvent(event:Event):Boolean;
		
	}
}

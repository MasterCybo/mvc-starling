/**
 * Created by Artem-Home on 13.02.2017.
 */
package ru.arslanov.starling.mvc.interfaces
{
	import starling.display.DisplayObject;
	
	public interface IMediatorMap
	{
		function addExtension(extensionClass:Class):void;
		function hasMediator(mediatorClass:Class):Boolean;
		function map(mediatorClass:Class):IMediatorMap;
		function toMediate(viewClass:Class):void;
		function unmap(mediatorClass:Class):void;
		function mediate(view:DisplayObject):void;
		function unmediate(view:DisplayObject):void;
	}
}

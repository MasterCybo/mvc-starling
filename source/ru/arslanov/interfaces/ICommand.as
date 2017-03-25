package ru.arslanov.starling.mvc.interfaces
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface ICommand
	{
		function execute():void;
		function destruct():void;
		function getEvent():Event;
		function get mapper():IMapper;
		function get mediatorMap():IMediatorMap;
		function dispatchEvent(event:Event):Boolean
	}
	
}
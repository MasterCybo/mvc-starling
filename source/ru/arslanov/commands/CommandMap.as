package ru.arslanov.starling.mvc.commands
{
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import ru.arslanov.starling.mvc.interfaces.IContext;
	import ru.arslanov.starling.mvc.interfaces.ICommand;
	import ru.arslanov.starling.mvc.interfaces.ICommandMap;
	
	/**
	 * Карта команд
	 * @author Artem Arslanov
	 */
	public class CommandMap implements ICommandMap
	{
		private var _context:IContext;
		
		private var _map:Dictionary = new Dictionary(); // eventType = commandClass
		
		private var _mappedType:String;
		
		public function CommandMap(context:IContext)
		{
			_context = context;
		}
			
		public function hasEventType(eventType:String):Boolean { return _map[eventType]; }
		
		public function unmap(eventType:String):void
		{
			if (hasEventType(eventType)) delete _map[eventType];
		}
		
		public function map(eventType:String):ICommandMap
		{
			_mappedType = eventType;
			return this;
		}
		
		public function toCommand(commandClass:Class):void
		{
			_map[_mappedType] = commandClass;
			
			trace(this, "Mapped '" + _mappedType + "' to command " + commandClass);
			
			_mappedType = null;
		}
		
		public function tryExecute(event:Event):Boolean
		{
			if (!hasEventType(event.type)) return false;
			
			var CommandClass:Class = _map[event.type];
			var command:ICommand = new CommandClass(_context, event);
			command.execute();
			command.destruct();
			return true;
		}
	}
}
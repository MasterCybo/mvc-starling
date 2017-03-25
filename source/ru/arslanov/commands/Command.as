package ru.arslanov.starling.mvc.commands
{
	import flash.events.Event;
	
	import ru.arslanov.starling.mvc.interfaces.ICommand;
	import ru.arslanov.starling.mvc.interfaces.IContext;
	import ru.arslanov.starling.mvc.interfaces.IObjectAccessor;
	import ru.arslanov.starling.mvc.interfaces.IMapper;
	import ru.arslanov.starling.mvc.interfaces.IMediatorMap;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class Command implements ICommand, IObjectAccessor
	{
		public var verbose:Boolean = false; // Выводить запуск команды в trace
		
		private var _context:IContext;
		protected var _event:Event;
		
		public function Command(context:IContext, event:Event)
		{
			_context = context;
			_event = event;
		}

		public function execute():void
		{
			if (!verbose) trace("[Command " + this + "] execute");
		}
		
		public function destruct():void
		{
			_event = null;
			_context = null;
		}
		
		/*
		 * For fast access
		 */
		public function getEvent():Event { return _event }
		
		public function get mapper():IMapper { return _context.mapper; }
		public function get mediatorMap():IMediatorMap { return _context.mediatorMap; }
		
		public function getOf(type:*):* { return _context.getOf(type); }
		public function hasObject(type:*):Boolean { return _context.hasObject(type); }

		public function dispatchEvent(event:Event):Boolean { return _context.dispatchEvent(event); }
	}

}
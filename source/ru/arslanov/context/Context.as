/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.starling.mvc.context
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.describeType;
	
	import ru.arslanov.starling.mvc.Mapper;
	import ru.arslanov.starling.mvc.commands.CommandMap;
	import ru.arslanov.starling.mvc.injection.ObjectMap;
	import ru.arslanov.starling.mvc.interfaces.ICommandMap;
	import ru.arslanov.starling.mvc.interfaces.IContext;
	import ru.arslanov.starling.mvc.interfaces.IObjectMap;
	import ru.arslanov.starling.mvc.interfaces.IMapper;
	import ru.arslanov.starling.mvc.interfaces.IMediatorMap;
	import ru.arslanov.starling.mvc.interfaces.IMediatorMapExtension;
	import ru.arslanov.starling.mvc.mediators.MediatorMap;
	
	import starling.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class Context extends EventDispatcher implements IContext
	{
		private var _mapper:IMapper;
		private var _injectionMap:IObjectMap;
		private var _commandMap:ICommandMap;
		private var _mediatorMap:IMediatorMap;
		
		private var _contextView:DisplayObjectContainer;
		
		public function Context(contextView:DisplayObjectContainer)
		{
			_contextView = contextView;
			_injectionMap = new ObjectMap();
			_mediatorMap = new MediatorMap(this);
			_commandMap = new CommandMap(this);
			_mapper = new Mapper(_injectionMap, _mediatorMap, _commandMap);
		}
		
		public function get contextView():DisplayObjectContainer { return _contextView; }
		
		public function get mapper():IMapper { return _mapper; }
		
		public function get mediatorMap():IMediatorMap { return _mediatorMap; }
		
		public function extend(extensionClass:Class):IContext
		{
			switch (true) {
				case isImplementsOf(extensionClass, IMediatorMapExtension):
					_mediatorMap.addExtension(extensionClass);
					break;
//				case isImplementsOf(extensionClass, ICommandMapExtension):
//					break;
			}
			return this;
		}
		
		public function configurate(configClass:Class):IContext
		{
			new configClass(this).initialize();
			return this;
		}
		
		/*
		 *	ObjectMap for fast access
		 */
		public function getOf(type:*):* { return _injectionMap.getOf(type); }
		
		public function hasObject(type:*):Boolean { return _injectionMap.hasObject(type); }
		
		/*
		 *	Events
		 */
		override public function dispatchEvent(event:Event):Boolean
		{
			_commandMap.tryExecute(event);
			return super.dispatchEvent(event);
		}
		
		/**
		 * Утилитная внутренняя функция проверки цепочки наследования класса
		 * @param implementor
		 * @param prototype
		 * @return
		 */
		private function isImplementsOf(implementor:Class, prototype:Class):Boolean
		{
			var xml:XML = describeType(implementor);
			var xmlImplements:XMLList = xml..implementsInterface;
			var proto:String = prototype.toString();
			proto = proto.substring(7, proto.length - 1);
			
			var item:XML;
			var itemType:String;
			var idx:int;
			for each (item in xmlImplements) {
				itemType = item.@type.toString();
				idx = itemType.indexOf(proto);
				if (idx != -1) return true;
			}
			return false;
		}
	}
}
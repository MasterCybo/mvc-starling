/**
 * Created by Artem-Home on 13.02.2017.
 */
package ru.arslanov.starling.mvc
{
	import ru.arslanov.starling.mvc.interfaces.ICommandMap;
	import ru.arslanov.starling.mvc.interfaces.IObjectMap;
	import ru.arslanov.starling.mvc.interfaces.IMapper;
	import ru.arslanov.starling.mvc.interfaces.IMediatorMap;
	
	public class Mapper implements IMapper
	{
		private var _injectionMap:IObjectMap;
		private var _mediatorMap:IMediatorMap;
		private var _commandMap:ICommandMap;
		
		private var _mappingType:*;
		
		public function Mapper(injectionMap:IObjectMap, mediatorMap:IMediatorMap, commandMap:ICommandMap)
		{
			_injectionMap = injectionMap;
			_mediatorMap = mediatorMap;
			_commandMap = commandMap;
		}
		
		public function map(type:*):IMapper
		{
			_mappingType = type;
			return this;
		}
		
		public function toMediate(viewClass:Class):IMediatorMap
		{
			checkType();
			_mediatorMap.map(_mappingType).toMediate(viewClass);
			_mappingType = null;
			return _mediatorMap;
		}
		
		public function asSingleton(singletonClass:Class):IObjectMap
		{
			checkType();
			_injectionMap.map(_mappingType).asSingleton(singletonClass);
			_mappingType = null;
			return _injectionMap;
		}
		
		public function toValue(value:Object):IObjectMap
		{
			checkType();
			_injectionMap.map(_mappingType).toValue(value);
			_mappingType = null;
			return _injectionMap;
		}
		
		public function toCommand(commandClass:Class):ICommandMap
		{
			checkType();
			_commandMap.map(_mappingType).toCommand(commandClass);
			_mappingType = null;
			return _commandMap;
		}
		
		public function unmap(type:*):IMapper
		{
			if (!type) throw new ArgumentError("Argument is null!");
			switch (true) {
				case _mediatorMap.hasMediator(type):
					_mediatorMap.unmap(type);
					break;
				case _injectionMap.hasObject(type):
					_injectionMap.unmap(type);
					break;
				case _commandMap.hasEventType(type):
					_commandMap.unmap(type);
					break;
			}
			return this;
		}
		
		private function checkType():void
		{
			if (!_mappingType) throw new ArgumentError("Missing type! First call map(type:*) method!");
		}
	}
}

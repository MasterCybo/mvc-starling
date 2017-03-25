/**
 * Created by Artem-Home on 13.02.2017.
 */
package ru.arslanov.starling.mvc.interfaces
{
	public interface IMapper
	{
		function unmap(type:*):IMapper;
		function map(type:*):IMapper;
		function asSingleton(singletonClass:Class):IObjectMap;
		function toValue(value:Object):IObjectMap;
		function toMediate(viewClass:Class):IMediatorMap;
		function toCommand(commandClass:Class):ICommandMap;
	}
}

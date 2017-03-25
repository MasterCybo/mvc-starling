/**
 * Created by Artem-Home on 13.02.2017.
 */
package ru.arslanov.starling.mvc.interfaces
{
	public interface IObjectMap extends IObjectAccessor
	{
		function unmap(type:*):void;
		function map(type:*):IObjectMap;
		function asSingleton(singletonClass:Class):*;
		function toValue(value:Object):*;
		function unmapAll():void;
		function getAllTypes():Vector.<*>;
	}
}

/**
 * Copyright (c) 2015 SmartHead. All rights reserved.
 */
package ru.arslanov.starling.mvc.interfaces
{
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public interface IObjectAccessor
	{
		function getOf(type:*):*;
		function hasObject(type:*):Boolean;
	}
}

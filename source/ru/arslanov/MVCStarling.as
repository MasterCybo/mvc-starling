/**
 * Copyright (c) 2015 SmartHead. All rights reserved.
 */
package ru.arslanov.starling.mvc
{
	import ru.arslanov.starling.mvc.context.Context;
	import ru.arslanov.starling.mvc.extensions.StarlingMediatorMapExtension;
	import ru.arslanov.starling.mvc.interfaces.IContext;

	import starling.display.DisplayObjectContainer;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class MVCStarling
	{
		static public function createContext(contextView:DisplayObjectContainer):IContext
		{
			return new Context(contextView).extend(StarlingMediatorMapExtension);
		}
	}
}

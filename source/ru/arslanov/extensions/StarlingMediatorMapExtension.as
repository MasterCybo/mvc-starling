/**
 * Created by Artem-Home on 15.02.2017.
 */
package ru.arslanov.starling.mvc.extensions
{
	import ru.arslanov.starling.mvc.interfaces.IMediatorMapExtension;
	
	public class StarlingMediatorMapExtension implements IMediatorMapExtension
	{
		public function StarlingMediatorMapExtension()
		{
		}
		
		public function initialize(displayObject:*, onComplete:Function):Boolean
		{
//			trace("*execute* " + this + "::initialize() : " + displayObject);
			if (onComplete != null) onComplete(displayObject);
			return true;
		}
	}
}

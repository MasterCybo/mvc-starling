/**
 * Created by Artem-Home on 11.02.2017.
 */
package ru.arslanov.starling.mvc.extensions
{
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	
	import flash.utils.Dictionary;
	
	import ru.arslanov.starling.mvc.interfaces.IMediatorMapExtension;
	
	import starling.events.Event;
	
	public class FeathersMediatorMapExtension implements IMediatorMapExtension
	{
		private var _mapCallbacks:Dictionary = new Dictionary(true);
		
		public function FeathersMediatorMapExtension()
		{
		}
		
		public function initialize(displayObject:*, onComplete:Function):Boolean
		{
			var feathersControl:FeathersControl = displayObject as FeathersControl;
			if (!feathersControl) return false;
			
//			trace("*execute* " + this + "::initialize() : " + displayObject);
			_mapCallbacks[feathersControl] = onComplete;
			
//			feathersControl.addEventListener(FeathersEventType.CREATION_COMPLETE, onCreated);
			feathersControl.addEventListener(FeathersEventType.INITIALIZE, onInitialized);
			
//			trace(this + " initialized " + displayObject);
			return true;
		}
		/*
		private function onCreated(event:Event):void
		{
			trace("*execute* " + this + "::onCreated() : " + event.target);
			callComplete(event);
		}
		*/
		private function onInitialized(event:Event):void
		{
//			trace("*execute* " + this + "::onInitialized() : " + event.target);
			callComplete(event);
		}
		
		private function callComplete(event:Event):void
		{
			var feathersControl:FeathersControl = event.target as FeathersControl;
//			feathersControl.removeEventListener(FeathersEventType.CREATION_COMPLETE, onCreated);
			feathersControl.removeEventListener(FeathersEventType.INITIALIZE, onInitialized);
			
			var callback:Function = _mapCallbacks[feathersControl];
			if (callback != null) {
				delete _mapCallbacks[feathersControl];
				callback(feathersControl);
			}
		}
	}
}

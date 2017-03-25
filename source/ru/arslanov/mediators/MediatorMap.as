package ru.arslanov.starling.mvc.mediators
{
	import flash.utils.Dictionary;
	
	import ru.arslanov.starling.mvc.interfaces.IContext;
	import ru.arslanov.starling.mvc.interfaces.IMediator;
	import ru.arslanov.starling.mvc.interfaces.IMediatorMap;
	import ru.arslanov.starling.mvc.interfaces.IMediatorMapExtension;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class MediatorMap implements IMediatorMap
	{
		private var _context:IContext;
		private var _mapMediators:Dictionary = new Dictionary(); // DisplayObjectClass = MediatorClass
		private var _mapInstances:Dictionary = new Dictionary(); // displayObject = mediator
		private var _mapViews:Dictionary = new Dictionary(); // MediatorClass = DisplayObjectClass
		private var _extensions:Vector.<IMediatorMapExtension> = new Vector.<IMediatorMapExtension>();
		private var _mapExtensions:Dictionary = new Dictionary(); // extensionClass = IMediatorMapExtension
		
		private var _mappedClass:Class;
		
		public function MediatorMap(context:IContext)
		{
			_context = context;
			
			if (_context.contextView.stage) {
				mediateContextView(true);
			}
			_context.contextView.addEventListener(Event.ADDED_TO_STAGE, contextViewHandler);
			_context.contextView.addEventListener(Event.REMOVED_FROM_STAGE, contextViewHandler);
		}
		
		private function contextViewHandler(event:Event):void
		{
			switch (event.type) {
				case Event.ADDED_TO_STAGE:
					mediateContextView(true);
					break;
				case Event.REMOVED_FROM_STAGE:
					mediateContextView(false);
					break;
			}
		}
		
		private function mediateContextView(value:Boolean):void
		{
			if (value) {
				_context.contextView.stage.addEventListener(Event.ADDED, onAdded);
				_context.contextView.stage.addEventListener(Event.REMOVED, onRemoved);
				mediate(_context.contextView);
			} else {
				_context.contextView.stage.removeEventListener(Event.ADDED, onAdded);
				_context.contextView.stage.removeEventListener(Event.REMOVED, onRemoved);
				unmediate(_context.contextView);
			}
		}
		
		public function addExtension(extensionClass:Class):void
		{
			if (_mapExtensions[extensionClass] != undefined) {
				trace("WARNING! " + extensionClass + " already added!");
				return;
			}
			var extension:IMediatorMapExtension = new extensionClass();
			_mapExtensions[extensionClass] = extension;
			_extensions.push(extension);
			trace(this, "Extension added " + extensionClass);
		}
		
		public function hasMediator(mediatorClass:Class):Boolean { return _mapViews[mediatorClass]; }
		
		public function map(mediatorClass:Class):IMediatorMap
		{
			_mappedClass = mediatorClass;
			return this;
		}
		
		public function toMediate(viewClass:Class):void
		{
			if (_mapMediators[viewClass] != undefined) {
				trace("WARNING! " + this + "::toMediate() : " + _mappedClass + " already mapped to " + viewClass);
				_mappedClass = null;
				return;
			}
			
			_mapMediators[viewClass] = _mappedClass;
			_mapViews[_mappedClass] = viewClass;
			
			trace(this, "Mapped " + _mappedClass + " to mediate " + viewClass);
			
			_mappedClass = null;
		}
		
		public function unmap(mediatorClass:Class):void
		{
			var viewClass:Class = _mapViews[mediatorClass];
			
			if (viewClass) {
				delete _mapMediators[viewClass];
				delete _mapViews[mediatorClass];
				trace(this, "Unmapped " + mediatorClass + " to mediate " + viewClass);
			}
		}
				
		public function mediate(view:DisplayObject):void
		{
			var viewClass:Class = view["constructor"];
			var mediatorClass:Class = _mapMediators[viewClass];
			
			if (!mediatorClass) return;
			
			trace(this, "Mediate " + viewClass);
			
			var mediator:IMediator = new mediatorClass(_context);
			_mapInstances[viewClass] = mediator;
			mediator.initialize(view);
		}
		
		public function unmediate(view:DisplayObject):void
		{
			var viewClass:Class = view["constructor"];
			var mediator:IMediator = _mapInstances[viewClass];
			
			if (!mediator) return;
			
			trace(this, "Unmediate " + viewClass);
			
			mediator.destroy();
			delete _mapInstances[viewClass];
		}
		
		private function onAdded(event:Event):void
		{
//			trace("------------------------------------------------------");
//			trace("*execute* " + this + "::onAdded() : " + event.target);
			processMediateRecursively(event.target as DisplayObject);
		}
		
		private function processMediateRecursively(view:DisplayObject):void
		{
//			trace("*execute* " + this + "::processMediateRecursively() : " + view);
			var container:DisplayObjectContainer = view as DisplayObjectContainer;
			if (container) {
				processExtensionsMediate(container);
				
				var child:DisplayObject;
				for (var i:int = 0; i < container.numChildren; i++) {
					child = container.getChildAt(i);
					processMediateRecursively(child);
				}
			} else {
				processExtensionsMediate(view);
			}
		}
		
		private function processExtensionsMediate(view:DisplayObject):void
		{
			if (_extensions.length > 0) {
				var extension:IMediatorMapExtension;
				var len:uint = _extensions.length - 1;
				for (var i:int = len; i >= 0; i--) {
					extension = _extensions[i];
					if (extension.initialize(view, mediate)) break;
				}
			} else {
				mediate(view);
			}
		}
		
		private function onRemoved(event:Event):void
		{
			processUnmediateRecursively(event.target as DisplayObject);
		}
		
		private function processUnmediateRecursively(view:DisplayObject):void
		{
			var container:DisplayObjectContainer = view as DisplayObjectContainer;
			if (container) {
				unmediate(container);
				
				var child:DisplayObject;
				for (var i:int = 0; i < container.numChildren; i++) {
					child = container.getChildAt(i);
					processUnmediateRecursively(child);
				}
			} else {
				unmediate(view);
			}
		}
	}
}
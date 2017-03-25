package ru.arslanov.starling.mvc.mediators
{
	import ru.arslanov.starling.mvc.context.ObjectContext;
	import ru.arslanov.starling.mvc.interfaces.IContext;
	import ru.arslanov.starling.mvc.interfaces.IMediator;
	
	import starling.display.DisplayObject;
	
	import starling.display.DisplayObjectContainer;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class Mediator extends ObjectContext implements IMediator
	{
		public var verbose:Boolean = false; // Выводиль ли отладочные сообщения
		
		protected var _view:DisplayObject;

		public function Mediator(context:IContext)
		{
			super(context);
		}
		
		public function initialize(displayObject:DisplayObject):void
		{
			_view = displayObject;
			if (verbose) trace("[Mediator " + this + "] initialize");
			// override me
		}
		
		override public function destroy():void
		{
			if (verbose) trace("[Mediator " + this + "] destroy");
			_view = null;
			super.destroy();
			// override me
		}

		public function getView():DisplayObject  { return _view; }

		public function addViewListener(eventType:String, listener:Function):void { _view.addEventListener(eventType, listener); }
		public function removeViewListener(eventType:String, listener:Function = null):void { _view.removeEventListener(eventType, listener); }
	}

}
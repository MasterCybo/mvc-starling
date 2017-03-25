package ru.arslanov.starling.mvc
{
	import ru.arslanov.starling.mvc.interfaces.IConfig;
	import ru.arslanov.starling.mvc.interfaces.IContext;
	import ru.arslanov.starling.mvc.interfaces.IMapper;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class Config implements IConfig
	{
		private var _context:IContext;
		
		public function Config(context:IContext)
		{
			_context = context;
		}
		
		public function initialize():void
		{
			trace(this + "::initialize()");
			// override me
		}
		
		public function get context():IContext { return _context }
		
		// For short access
		public function map(type:*):IMapper { return _context.mapper.map(type); }
	}
}
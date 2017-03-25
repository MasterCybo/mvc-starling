/**
 * Created by Artem-Home on 13.02.2017.
 */
package ru.arslanov.starling.mvc.interfaces
{
	public interface IConfig
	{
		function initialize():void;
		
		function get context():IContext;
		
		function map(type:*):IMapper;
	}
}

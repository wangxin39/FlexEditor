package cn.ideasoft.datasource
{
	import cn.ideasoft.event.AppEvent;
	
	public interface IDataSourceProxy 
	{
		function get id():String;
		
		
		function set eventHandler(f:Function):void;
		function onDataSourceEvent(event:AppEvent):void;
	}
}
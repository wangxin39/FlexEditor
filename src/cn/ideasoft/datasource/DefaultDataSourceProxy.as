package cn.ideasoft.datasource
{
	import cn.ideasoft.event.AppEvent;
	
	import mx.utils.UIDUtil;
	
	public class DefaultDataSourceProxy  implements IDataSourceProxy
	{
		private var _id:String = UIDUtil.createUID();
		
		private var _eventHandler:Function;
		
		public function set eventHandler(f:Function):void{
			_eventHandler = f;
		}
		public function get eventHandler():Function{
			return _eventHandler;
		}
		
		public function onDataSourceEvent(event:AppEvent):void{
			if(eventHandler!=null){
				eventHandler(event);
			}
		}
		
		
		public function get id():String{
			return _id;
		}
		
		
	}
}
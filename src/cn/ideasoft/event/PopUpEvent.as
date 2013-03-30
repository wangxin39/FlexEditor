package cn.ideasoft.event
{
	import flash.events.Event;

	public class PopUpEvent extends Event
	{
		public var data:*;			
		
		public function PopUpEvent(type:String, data:*=null)
		{
			super(type);
			this.data = data;
		}
	}
}
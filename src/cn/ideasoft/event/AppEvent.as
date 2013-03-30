package cn.ideasoft.event
{
	public class AppEvent
	{
		[Selector]
		public var type:String;
		public var data:*;		
		
		public function AppEvent(type:String, data:*=null)
		{
			this.type = type;
			this.data = data;					
		}
	}
}
package cn.ideasoft.button
{
	import flash.events.MouseEvent;
	import mx.controls.Image;
	
	/**
	 * 图像按钮的辅助行为
	 */
	public class ImageButtonStyle
	{
		/**
		 * 表示鼠标松开按键
		 */
		public static var UP:int = -1;
		
		/**
		 * 表示鼠标按下按键
		 */
		public static var DOWN:int = 1;
		
		/**
		 * 表示鼠标覆盖对象
		 */
		public static var OVER:int = 2;
		
		/**
		 * 表示鼠标离开对象
		 */
		public static var OUT:int = 0;
		
		
		
		private static var buttonX:int = 0;
		private static var buttonY:int = 0;		
		
		
		public function ImageButtonStyle()
		{
		}	
		
		/**
		 * 当鼠标点击对象时激活的事件
		 * 
		 * @param button 图像按钮对象
		 * @param event 鼠标事件
		 */
		public static function onClick(event:MouseEvent):void
		{
			var button:Image = event.currentTarget as Image;
			if(button!=null)
			{
				var state:int;
				if(event.buttonDown)
				{
					buttonX = button.x;
					buttonY = button.y;
					
					state = DOWN;    
					button.x=button.x+0.5*state;
					button.y=button.y+0.5*state;					
				}
				else
				{
					state = UP;
					button.x = buttonX;
					button.y = buttonY;					
				}
				
				button.data = state;

			}			
		}
	}	
}
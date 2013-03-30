package com.graphics
{//抽象画图类 
	import flash.display.MovieClip;
	import flash.display.Graphics;
	public class AbstractDraw
	{
		protected var _target:Graphics; 
		public function get target():Graphics { 
			return _target; 
		} 
		public function set target(mc:Graphics):void { 
			_target = mc; 
		} 

		//定义统一接口 
		public function draw():void{ 
		} 

	}
}
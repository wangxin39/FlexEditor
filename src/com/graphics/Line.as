package com.graphics
{//画直线 
	import flash.display.Graphics;
	
	public class Line extends AbstractDraw
	{
		
		private var _x1:Number; 
		private var _x2:Number; 
		private var _y1:Number; 
		private var _y2:Number; 
		public function Line(x1:Number, y1:Number, x2:Number, y2:Number) { 
			_x1 = x1; 
			_x2 = x2; 
			_y1 = y1; 
			_y2 = y2; 
		} 

		//绘制实直线 
		public override function draw():void{ 
			lineFunc(_x1, _y1, _x2, _y2); 
		} 

		//绘制直线函数 
		private function lineFunc(x1:Number, y1:Number, x2:Number, y2:Number):void { 
			_target.moveTo(x1, y1); 
			_target.lineTo(x2, y2); 
		} 

	}
}
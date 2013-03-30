package com.graphics
{//画矩形
	public class Rect extends AbstractDraw
	{
		private var _x:Number; 
private var _y:Number; 
private var _w:Number; 
private var _h:Number; 
public function Rect(x:Number, y:Number, w:Number, h:Number) { 
_x = x; 
_y = y; 
_w = w; 
_h = h; 
} 
public override function draw():void { 
rectFunc(_x, _y, _w, _h); 
} 

//绘制矩形 
private function rectFunc(x:Number, y:Number, w:Number, h:Number):void { 
_target.moveTo(x, y); 
_target.lineTo(x+w, y); 
_target.lineTo(x+w, y+h); 
_target.lineTo(x, y+h); 
_target.lineTo(x, y); 
} 

	}
}
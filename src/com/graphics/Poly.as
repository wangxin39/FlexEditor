package com.graphics
{//画正多边
	public class Poly extends AbstractDraw
	{
		private var _x:Number; 
private var _y:Number; 
private var _r:Number; 
private var _n:Number; 
public function Poly(x:Number, y:Number, r:Number, n:Number) { 
_x = x; 
_y = y; 
_r = r; 
_n = n; 
} 
public override function draw():void { 
polyFunc(_x, _y, _r, _n); 
} 

//绘制多边形 
private function polyFunc(x:Number, y:Number, r:Number, n:Number):void { 
var pai:Number = 2*Math.PI; 
_target.moveTo(r+x, y); 
for (var i:int = 0; i<pai/n*(n+1); i += pai/n) { 
_target.lineTo(Math.cos(i)*r+x, Math.sin(i)*r+y); 
} 
} 

	}
}
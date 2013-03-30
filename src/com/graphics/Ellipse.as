package com.graphics
{//椭圆，圆 
	public class Ellipse extends AbstractDraw
	{
		private var _x:Number; 
private var _y:Number; 
private var _rx:Number; 
private var _ry:Number; 
public function Ellipse(x:Number, y:Number, rx:Number, ry:Number) { 
_x = x; 
_y = y; 
_rx = rx; 
_ry = ry; 
} 
public function draw() { 
ellipseFunc(_x, _y, _rx, _ry); 
} 

//绘制椭圆(圆)函数 
public function ellipseFunc(x:Number, y:Number, rx:Number, ry:Number) { 
if (ry == null) { 
ry = rx; 
} 
var controlx = rx*(Math.SQRT2-1); 
var controly = ry*(Math.SQRT2-1); 
var anchorx = rx*Math.SQRT1_2; 
var anchory = ry*Math.SQRT1_2; 
_target.moveTo(x+rx, y); 
_target.curveTo(x+rx, y+controly, x+anchorx, y+anchory); 
_target.curveTo(x+controlx, y+ry, x, y+ry); 
_target.curveTo(x-controlx, y+ry, x-anchorx, y+anchory); 
_target.curveTo(x-rx, y+controly, x-rx, y); 
_target.curveTo(x-rx, y-controly, x-anchorx, y-anchory); 
_target.curveTo(x-controlx, y-ry, x, y-ry); 
_target.curveTo(x+controlx, y-ry, x+anchorx, y-anchory); 
_target.curveTo(x+rx, y-controly, x+rx, y); 
} 

	}
}
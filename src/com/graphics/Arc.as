package com.graphics
{
	public class Arc extends AbstractDraw
	{
		private var _staAngle; 
private var _endAngle; 
public function Arc(x:Number, y:Number, rx:Number, ry:Number, staAngle, 
endAngle) { 
_x = x; 
_y = y; 
_rx = rx; 
_ry = ry; 
_staAngle = staAngle; 
_endAngle = endAngle; 
} 
public function draw() { 
arcFunc(_x, _y, _rx, _ry, _staAngle, _endAngle); 
} 

//绘制椭圆（圆）形曲线 
public function arcFunc(x, y, rx, ry, staAngle, endAngle) { 
if (endAngle == staAngle) { 
return; 
} 
if (Math.abs(endAngle-staAngle)>=360) { 
ellipseFunc(x, y, rx, ry); 
return; 
} 
if (ry == null) { 
ry = rx; 
} 
var curAngle = staAngle; 
var nextAngle = staAngle<endAngle ? (Math.floor(staAngle/45)+1)*45 : 
(Math.ceil(staAngle/45)-1)*45; 
var midcos, midAngle, controlx, controly, anchorx, anchory; 
_target.moveTo(x+Degree.cosD(staAngle)*rx, 
y+Degree.sinD(staAngle)*ry); 
while (true) { 
if (staAngle<endAngle && nextAngle>endAngle || staAngle>endAngle 
&& nextAngle<endAngle) { 
nextAngle = endAngle; 
} 
midcos = Degree.cosD((nextAngle-curAngle)/2); 
midAngle = (nextAngle+curAngle)/2; 
controlx = x+Degree.cosD(midAngle)/midcos*rx; 
controly = y+Degree.sinD(midAngle)/midcos*ry; 
anchorx = x+Degree.cosD(nextAngle)*rx; 
anchory = y+Degree.sinD(nextAngle)*ry; 
_target.curveTo(controlx, controly, anchorx, anchory); 
if (nextAngle == endAngle) { 
break; 
} 
curAngle = nextAngle; 
nextAngle += staAngle<endAngle ? 45 : -45; 
} 
} 

	}
}
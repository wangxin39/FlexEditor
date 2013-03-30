package com.graphics
{//扇形 

	public class Sector extends Arc
	{
		public function Sector(x:Number, y:Number, rx:Number, ry:Number, staAngle, 
endAngle) { 
_x = x; 
_y = y; 
_rx = rx; 
_ry = ry; 
_staAngle = staAngle; 
_endAngle = endAngle; 
} 
public function draw() { 
sectorFunc(_x, _y, _rx, _ry, _staAngle, _endAngle); 
} 

//绘制扇形 
private function sectorFunc(x, y, rx, ry, staAngle, endAngle) { 
arcFunc(x, y, rx, ry, staAngle, endAngle); 
if (Math.abs(staAngle-endAngle)>0 && Math.abs(staAngle-endAngle)<360) 
{ 
_target.lineTo(x, y); 
_target.lineTo(x+Degree.cosD(staAngle)*rx, 
y+Degree.sinD(staAngle)*ry); 
} 
} 

	}
}
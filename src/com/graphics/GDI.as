package com.graphics
{//绘图类 
	import flash.display.MovieClip;
	import flash.display.Graphics;
	
	public class GDI
	{
		private var _target:Graphics; 
		//设置和获取绘图的目标 
		public function get target():Graphics { 
			return _target; 
		} 
		public function set target(mc:Graphics):void { 
			_target = mc; 
		} 

		//画线方法 
		public function line(p:Graphics, d:AbstractDraw):void { 
			startPen(p); 
			d.target = _target; 
			d.draw(); 
			endPen(); 
		} 

		//填充方法 
		public function fill(b:Graphics, d:AbstractDraw):void { 
			startBrush(b); 
			d.target = _target; 
			d.draw(); 
			endBrush(); 
		} 

		private function startPen(p:Graphics):void { 
			_target.lineStyle(3,0xFF0000);
		} 
		
		private function endPen():void { 
			_target.lineStyle(0, 0, 0); 
		} 
		private function startBrush(b:Graphics):void { 
			//b.fill(_target); 
		} 
		private function endBrush():void { 
			_target.endFill(); 
		} 

//清除绘图方法 
		public function clear():void { 
			if (_target != null) { 
				_target.clear(); 
			} 
		} 
	}
} 

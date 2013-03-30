package com.Paint
{
	import mx.containers.Canvas;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import mx.events.FlexMouseEvent;
	import mx.controls.Alert;
	
	public class EditPaint extends Canvas
	{
		protected var fBeginPaint:Boolean;
		protected var _minx:int;
		protected var _miny:int;
		protected var _maxx:int;
		protected var _maxy:int;
		
		public function EditPaint(){
			this.addEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP,OnMouseUP);
			this.addEventListener(MouseEvent.MOUSE_MOVE,OnMouseMove);
			this.addEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
			fBeginPaint = false;
			this.width = 400;
			this.height = 400;
			//this.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE,OnMouseOutDown);
			SetGraphicArea();
		}
		
		protected function OnMouseDown(e:Event):void{
			
			if( e.target != this )
			{
				//从界面中删除
				//Alert.show(e.target.toString());
			}
			else
			{
				fBeginPaint = true;
				BeginDraw();
			}
		}
		
		protected function SetGraphicArea():void{
			if( _minx == -1 )_minx = this.mouseX;
			if( _miny == -1 ) _miny = this.mouseY;
			if( _maxx == -1 ) _maxx = this.mouseX;
			if( _maxy == -1 ) _maxy = this.mouseY;
			
			if( this.mouseX < _minx ) _minx = this.mouseX; 
			if( this.mouseY < _miny ) _miny = this.mouseY; 
			if( this.mouseX > _maxx ) _maxx = this.mouseX; 
			if( this.mouseY > _maxy ) _maxy = this.mouseX; 
		}
		
		protected function OnMouseUP(e:Event):void{
			EndDraw();
			fBeginPaint = false;
		}
		
		protected function OnMouseMove(e:Event):void{
			if ( fBeginPaint == true )
			{
				DrawIng();
			}
			trace(this.mouseX);
		}
		
		protected function OnMouseOut(e:Event):void{
			fBeginPaint = false;
		}
		
		//继承
		protected function BeginDraw():void{
			//this.graphics.lineStyle(2);
			//this.graphics.moveTo(this.mouseX,this.mouseY);
			//SetGraphicArea();
		}
		
		protected function DrawIng():void{
			//this.graphics.lineTo(this.mouseX,this.mouseY);
			//SetGraphicArea();
		}
		protected function EndDraw():void{
			//this.graphics.lineTo(this.mouseX,this.mouseY);
		}
		//private function OnMouseOutDown(e:Event):void{
			
		//}
	}
}
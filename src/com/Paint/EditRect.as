package com.Paint
{
	import mx.events.IndexChangedEvent;
	
	public class EditRect extends EditPaint
	{
		private var _x:int;
		private var _y:int;
		public function EditRect(){
			
		}
		
		protected override  function BeginDraw():void{
			this.graphics.lineStyle(2);
			this.graphics.beginFill(0xFF0000);
			_x = this.mouseX;
			_y = this.mouseY;
			SetGraphicArea();
		}
		
		protected override function DrawIng():void{
			//this.graphics.lineTo(this.mouseX,this.mouseY);
			//this.graphics.drawRect(_x,_y,this.mouseX,this.mouseY);
			SetGraphicArea();
		}
		protected override function EndDraw():void{
			this.graphics.drawRect(_x,_y,this.mouseX-_x,this.mouseY-_y);
			this.graphics.endFill();
		}
		
	}
}
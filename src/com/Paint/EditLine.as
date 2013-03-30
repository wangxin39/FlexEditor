package com.Paint
{
	public class EditLine extends EditPaint
	{
		public function EditLine(){
			
		}
		protected override  function BeginDraw():void{
			this.graphics.lineStyle(2);
			this.graphics.moveTo(this.mouseX,this.mouseY);
			SetGraphicArea();
		}
		
		protected override function DrawIng():void{
			this.graphics.lineTo(this.mouseX,this.mouseY);
			SetGraphicArea();
		}
		protected override function EndDraw():void{
			this.graphics.lineTo(this.mouseX,this.mouseY);
		}
	}
}
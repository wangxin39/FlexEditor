package cn.ideasoft.image
{
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class LOMO
	{
		
		private var bitmap_data:BitmapData;
		private var lightBitmapData:BitmapData;
		
		public function LOMO()
		{
			
		}
		
		public function filters(mc1:BitmapData):void{
			this.bitmap_data = mc1;
			this.lightBitmapData = mc1;
			var i:int = 0;
			var j:int = 0;
			sereenBitmaps(i,j);
			processInvert();
			redadd(i,j);
			drawShape();
		}
		
		
		//1.滤色
		/**
		 * 我们可以在DisplayObject的叠加模式里面找到滤色BlendMode.SCREEN，
		 * 具体解释是：将显示对象颜色的补色（反色）与背景颜色的补色相乘，会产生漂白效果。
		 * 此设置通常用于产生加亮效果或用来删除显示对象的黑色区域。
      	 * 这里实际是原图上面复制一个同样的一张图片，上面的图片和原图以滤色的模式叠加,
		 * 具体的RGB的计算公式是 (255 - ((255 - topPixel) * (255 -bottomPixel))/255),
		 * 这个只是一个通道的计算公式，每一个通道都要叠，先得到像素点的数值，分解成RGB三个通道，
		 * 每一个都执行这个公式，然后在混合成16位色，赋值给像素点
		 * 
		 * 
		 * 
		 * */
		private function sereenBitmaps(i:int,j:int):void{
			var color32:uint = bitmap_data.getPixel(i,j);
			var red:int = color32 >> 16;
			var green:int = color32 >> 8 & 0xFF;
			var blue:int = color32 & 0xFF;
			
			var redInt:int = screenBase(red,red);
			var greenInt:int = screenBase(green,green);
			var blueInt:int = screenBase(blue,blue);
			
			var newUint:uint = redInt << 16 | greenInt << 8 | blueInt;
			bitmap_data.setPixel(i,j,newUint);
		}
		private function screenBase(topPixel:int, bottomPixel:int):int {
			return (255 - ((255 - topPixel) * (255 - bottomPixel))/255);
		}		
		//2.反相
		/**
		 * 这一步是要对滤色后的图案进行反相，由于下一步要对反相的图片和滤色的图片进行叠加，要把滤色的图片复制一份，存起来供下一步使用。反相的也就是BlendMode.INVERT，就是我们在QQ聊天中选中图片的效果，像是胶片的底片一样，这个原理比较简单，就是把RGB的每一个通道乘负一，这里用滤镜也可以实现，我们之间用bitmapdata的colorTransform方法实现
       * new ColorTransform(-1,-1,-1,1,255,255,255,1)，这里的参数看帮助文件就明白了
	   * 
	   * */
		private function processInvert():void{
			bitmap_data.colorTransform(new Rectangle(0,0,bitmap_data.width,bitmap_data.height),
				new ColorTransform(-1,-1,-1,1,255,255,255,1));
		}
		//3.反相的红色通道叠加
		/**
		 * 
		 * 这里我们只需要把反相红色通道的20%叠加到底图上面就可以了，不透明图片的的叠加，
		 * 而且只叠加一个通道，在网上找到了这个不同alpah
		 * 图片颜色叠加的公式：叠加色r=覆盖色r*覆盖alpha+底色r*（1-覆盖色alpha），我们直接计算
		 * 
		 * 
		 * */
		private function redadd(i:int,j:int):void{
			var top:uint = bitmap_data.getPixel(i,j);
			var bottom:uint = lightBitmapData.getPixel(i,j);
			
			var red:int = top >> 16;
			var green:int = top >> 8 & 0xFF;
			var blue:int = top & 0xFF;
			
			var redbottom:int = bottom >> 16;
			var greenbottom:int = bottom >> 8 & 0xFF;
			var bluebottom:int = bottom & 0xFF;
			
			var resultR:int = redbottom;
			var resultG:int = greenbottom;
			var resultB:int = blue*0.2 + bluebottom*0.8;
			
			var newUint:uint = resultR << 16 | resultG << 8 | resultB;
			bitmap_data.setPixel(i,j,newUint);
		}		
		//4.添加四角的阴影效果
		/**
		 * 这个效果是中间是空白的，边角是渐变的黑色，这个用Graphics的beginGradientFill非常容易实现，
		 * 就是参数调整的问题，画一个shape画出这个形状，然后之间draw在bitmapdata上就可以了
		 * */
		private function drawShape():void{
			var shape:Shape = new Shape;
			var g:Graphics = shape.graphics;
			var fillType:String = GradientType.RADIAL;
			var colors:Array = [0x000000, 0x000000];
			var alphas:Array = [0, 0.3];
			var ratios:Array = [200,255];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(bitmap_data.width+160, bitmap_data.height+160, 0, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			g.beginGradientFill(fillType, colors, alphas, ratios,matr);  
			g.drawRect(0,0,bitmap_data.width+160,bitmap_data.height+160);
			matr = new Matrix();
			matr.tx = -80;
			matr.ty = -80;
			bitmap_data.draw(shape,matr);
		}		
	}
}
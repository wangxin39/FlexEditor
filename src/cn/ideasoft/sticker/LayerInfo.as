package cn.ideasoft.sticker
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class LayerInfo
	{		
		
		public var x:int = 0;
		public var y:int = 0;		
		public var width:int = 0;
		public var height:int = 0;		
		public var data:BitmapData; //当前缓存		
		// 双缓冲处理,cache为当前屏幕处理中，data为干净的数据
		// canvas为显示到屏幕的
		public var cache:BitmapData; //屏幕显示的数据
		public var canvas:Bitmap; //当前使用位图		
		public var original:BitmapData; //原始图缓存 1024x768
		public var thumb:BitmapData; //原始图缓存 320x240
		public var outputX:int = 0; //输出在1024x768下的X坐标
		public var outputY:int = 0;// 输出在1024x768下的Y坐标
		
		public var index:int = 0; //图层位置
		public var isSelected:Boolean = false;
		public var isTeXiao:Boolean = false;
		public var teXiaoIndex:int = 0;
		
		public var scaleX:int = 0;	//X缩放	
		public var scaleY:int = 0; //Y缩放倍数
		public var scale:Number;		
		public var matrix:Matrix = new Matrix();
		
//		//定义处理透明
//		public var point:Point = new Point(0,0);
		public var rect:Rectangle;
		public var threshold:uint =  0x00FFFFFF; //参照色
		public var color:uint = 0x00FF0000;  //透明色 0x 后为透明度数
		public var maskColor:uint = 0x00FFFFFF; //用于隔离颜色成分的遮罩。		
		
		
		
		public var isChildAdded:Boolean = false;
	

		
		
		public function LayerInfo()
		{
			
		}
	}
}
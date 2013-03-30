package cn.ideasoft.sticker
{
	import cn.ideasoft.image.ColorMatrix;
	
	import com.riaoo.adjustDisplayObject.filters.DisplayObjectFilter;
	import com.riaoo.utils.BitArray;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import mx.containers.Canvas;
	import mx.controls.Alert;
	import mx.graphics.codec.JPEGEncoder;
	
	import org.spicefactory.lib.util.collection.ArrayMap;
	import org.spicefactory.parsley.core.context.Context;
	
	public class Sticker extends Canvas
	{
		private var eventType:String = "StickerEnterFrame";
		//图层
		private var list:ArrayList = new ArrayList();
		
		private var index:int = 0;
		private var canvas:BitmapData; //当前画布
		private var cache:Bitmap;
		private var output:BitmapData; //输出图片
		
		//当前选中的图层编号
		private var layer:int = 0; 
		//模板编号
		private var templateId:int = 0;
		//图片编号
		private var photoId:int = 0;
		//围脖编号
		private var weiboId:int = 0;
		//眼睛编号
		private var yanjingId:int = 0;
		
		private var templateIndex:int = 0;
		private var photoIndex:int = 0;
		private var weiboIndex:int = 0;
		private var yanjingIndex:int = 0;		
		
		
		//是否使用默白特效
		private var isHeBai:Boolean = false;
		//是否使用素描特效
		private var isSuMiao:Boolean = false;
		//是否使用水彩特效
		private var isSuiCai:Boolean = false;	
		
		//背景装载
		private var loader:Loader;	
		
		public function Sticker()
		{			
			super();
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,backgroundLoad);
			loader.load(new URLRequest("assets/images/canvas2.png"));

			addEventListener(eventType,draw);
		}
		
		public function backgroundLoad(event:Event):void
		{		
			
			var li:LayerInfo = new LayerInfo();
			li.index = 1;
			li.original = new BitmapData(loader.width,loader.height);
			li.original.draw(loader);			
			li.width = li.original.width;
			li.height = li.original.height;
			li.data = li.original;
			li.cache = li.original;
			
			list.addItem(li);			
			//调用重绘屏幕
			this.dispatchEvent(new Event(eventType));			
		}		
		public function draw(event:Event):void{			
			var i:int;
			var len:int;
			var li:LayerInfo;
			var tmp:Bitmap;
			var keys:ArrayCollection = new ArrayCollection();
			canvas = new BitmapData(320,240,true,0x00000000);
			output = new BitmapData(1024,768,true,0x00000000);
			keys.addAll(list);
			var sort:Sort = new Sort();
			sort.fields =  [new SortField("index")];
			keys.sort = sort;			
			keys.refresh();
			len = keys.length;
			for(i=0;i<len;i++){
				li = keys.getItemAt(i) as LayerInfo;
				canvas.copyPixels(li.data,li.data.rect,new Point(li.x,li.y),null,null,false);
				output.copyPixels(li.original,li.original.rect,new Point(),null,null,false);
				
				cache = new Bitmap(canvas);	
				if(li.index == 2){ //template
					if(templateIndex > 0){
						this.removeChildAt(templateIndex);					
						this.addChildAt(cache,templateIndex);				
					}else{
						this.addChild(cache);
						templateIndex = this.getChildIndex(cache);
					}					
				}else if(li.index == 3){ //photo
					if(photoIndex > 0){
						this.removeChildAt(photoIndex);					
						this.addChildAt(cache,photoIndex);				
					}else{
						this.addChild(cache);
						photoIndex = this.getChildIndex(cache);
					}					
				}else if(li.index == 4){ //weibo
					if(weiboIndex > 0){
						this.removeChildAt(weiboIndex);					
						this.addChildAt(cache,weiboIndex);				
					}else{
						this.addChild(cache);
						weiboIndex = this.getChildIndex(cache);
					}										
				}else if(li.index == 5){ //yanjing
					if(yanjingIndex > 0){
						this.removeChildAt(yanjingIndex);					
						this.addChildAt(cache,yanjingIndex);				
					}else{
						this.addChild(cache);
						yanjingIndex = this.getChildIndex(cache);
					}					
				}else{
					if(this.numChildren > 1){
						this.removeChildAt(1);					
						this.addChildAt(cache,1);				
					}else{
						this.addChild(cache);
					}	
				}

			}		
		}
		public function clear():void{		
			// 删除模板
			list.removeItemAt(templateId);
			
			this.templateId = 0;			
			this.isHeBai = false;	
			this.isSuMiao = false;
			this.isSuiCai = false;	
			this.layer = 0; //当前选中的图层			
			
			this.dispatchEvent(new Event(eventType));
		}
		
		public function addTemplate(bmp:BitmapData):void {
			
			var li:LayerInfo = new LayerInfo();
			li.original = bmp;
			li.index = 2;
			li.data = new BitmapData(width,height,true,0x00000000);
			li.matrix = new Matrix();
			li.matrix.scale(0.3125,0.3125);	
			li.scaleX = 0.3125;
			li.scaleY = 0.3125;
			li.data.draw(bmp,li.matrix);
			li.cache = li.data;
			li.width = li.cache.width;
			li.height = li.cache.height;			
			if(templateId > 0){
				list.removeItemAt(templateId);
				list.addItemAt(li,templateId);				
			}else{
				templateId = list.length;
				list.addItem(li);				
			}			
			this.dispatchEvent(new Event(eventType));
		}
		
		public function addYanJing(bmp:BitmapData):void{
			
			var li:LayerInfo = new LayerInfo();
			li.index = 5;
			li.original = bmp;
			li.data = new BitmapData(width,height,true,0x00000000);
			var scale:Number= Math.min(320 / bmp.width, 240 / bmp.height);
			li.scale = scale;			
			li.matrix = new Matrix();
			li.matrix.scale(scale/2,scale/2);	
			li.scaleX = scale/2;
			li.scaleY = scale/2;
			li.data.draw(bmp,li.matrix);
			li.cache = li.data;
			li.rect = li.cache.getColorBoundsRect(li.maskColor,li.color,true);
			li.x = li.rect.x;
			li.y = li.rect.y;
			li.width = li.rect.width;
			li.height = li.rect.height;
			if(yanjingId > 0){
				list.removeItemAt(yanjingId);
				list.addItemAt(li,yanjingId);				
			}else{
				
				yanjingId = list.length;
				list.addItem(li);				
			}
			layer = yanjingId;
			this.dispatchEvent(new Event(eventType));			
		}
		public function addWeiBo(bmp:BitmapData):void{
			var li:LayerInfo = new LayerInfo();
			li.index = 4;
			li.original = bmp;
			li.data = new BitmapData(width,height,true,0x00000000);
			li.scale = Math.min(320 / bmp.width, 240 / bmp.height);
			li.matrix = new Matrix();
			li.matrix.scale(li.scale/2,li.scale/2);		
			li.scaleX = li.scale/2;
			li.scaleY = li.scale/2;				
			li.data.draw(bmp,li.matrix);
			li.cache = li.data;
			li.rect = li.cache.getColorBoundsRect(li.maskColor,li.color,true);
			li.x = li.rect.x;
			li.y = li.rect.y;
			li.width = li.rect.width;
			li.height = li.rect.height;							
			if(weiboId > 0){
				list.removeItemAt(weiboId);
				list.addItemAt(li,weiboId);				
			}else{
				weiboId = list.length;
				list.addItem(li);				
			}	
			layer = weiboId;
			this.dispatchEvent(new Event(eventType));
		}
		public function addPhoto(bmp:BitmapData):void
		{
			
			var li:LayerInfo = new LayerInfo();
			li.index = 3;
			li.original = bmp;
			li.data = new BitmapData(width,height,true,0x00000000);
			li.scale = Math.min(320 / bmp.width, 240 / bmp.height);
			li.matrix = new Matrix();
			li.matrix.scale(li.scale/2,li.scale/2);				
			li.scaleX = li.scale/2;
			li.scaleY = li.scale/2;	
			li.data.draw(bmp,li.matrix);
			li.cache = li.data;
			li.rect = li.cache.getColorBoundsRect(li.maskColor,li.color,true);
			li.x = li.rect.x;
			li.y = li.rect.y;
			li.width = li.rect.width;
			li.height = li.rect.height;							
			if(photoId > 0){
				list.removeItemAt(photoId);
				list.addItemAt(li,photoId);				
			}else{				
				photoId = list.length;
				list.addItem(li);				
			}	
			layer = photoId;			
			this.dispatchEvent(new Event(eventType));

		}
		/**
		 * 
		 * 选中眼睛
		 * */
		public function clickSelectYanJing():void{
			layer = yanjingId;	
			this.dispatchEvent(new Event(eventType));
		}
		/**
		 * 
		 * 选中围脖
		 * */

		public function clickSelectWeiBo():void{
			layer = weiboId;				
			this.dispatchEvent(new Event(eventType));
		}
		/**
		 * 
		 * 选中图片
		 * */
		public function clickSelectPhoto():void{
			layer = photoId;				
			this.dispatchEvent(new Event(eventType));
		}
		
		public function clickDeleteSticker():void{
			if(layer > 1 && layer < this.list.length){
				this.list.removeItemAt(layer);
				this.dispatchEvent(new Event(eventType));
			}
		}
		
		/**
		 * 
		 * 向上移动 
		 **/
		public function onUpMove():void{			
			if(layer > 0){				
				var tmp:LayerInfo = this.list.getItemAt(layer) as LayerInfo;
				var bmp:BitmapData = new BitmapData(tmp.width,tmp.height,true,0x00000000);	
				//确定位图图像中完全包含指定颜色的所有像素的矩形区域,以找到重叠区域
				var tmpRect:Rectangle = bmp.getColorBoundsRect(0xFF000000,0x00000000,false);
				bmp.copyPixels(tmp.cache,tmpRect,new Point());				
				if((tmp.y+tmpRect.y) >= 2){
					tmp.y -= 6;		
					list.addItemAt(tmp,layer);
					this.dispatchEvent(new Event(eventType));					
				}				
				
			}
		}
		//向下移动
		public function onDownMove():void{
			if(layer > 0){				
				var tmp:LayerInfo = this.list.getItemAt(layer) as LayerInfo;
				var bmp:BitmapData = new BitmapData(tmp.width,tmp.height,true,0x00000000);	
				//确定位图图像中完全包含指定颜色的所有像素的矩形区域,以找到重叠区域
				var tmpRect:Rectangle = bmp.getColorBoundsRect(0xFF000000,0x00000000,false);
				bmp.copyPixels(tmp.cache,tmpRect,new Point());
				//Alert.show("tmp.y:"+tmp.y+"|tmpRect:"+tmpRect);								
				if((tmp.y+tmpRect.y+tmpRect.height) <= (height-6)){
					tmp.y += 6;	
					list.addItemAt(tmp,layer);
					this.dispatchEvent(new Event(eventType));									
				}
			}			
		}
		//向左移动
		public function onLeftMove():void{
			if(layer > 0){				
				var tmp:LayerInfo = this.list.getItemAt(layer) as LayerInfo;
				if(tmp.x > (x-6)){
					tmp.x -= 6;
					list.addItemAt(tmp,layer);
					this.dispatchEvent(new Event(eventType));
					
				}				
				
			}			
			
		}
		//向右移动
		public function onRightMove():void 
		{
			if(layer > 0){				
				var tmp:LayerInfo = this.list.getItemAt(layer) as LayerInfo;
				var bmp:BitmapData = new BitmapData(tmp.width,tmp.height,true,0x00000000);	
				//确定位图图像中完全包含指定颜色的所有像素的矩形区域,以找到重叠区域
				var tmpRect:Rectangle = bmp.getColorBoundsRect(0xFF000000,0x00000000,false);
				bmp.copyPixels(tmp.cache,tmpRect,new Point());		
				//Alert.show("x:"+tmp.x+"|x:"+tmpRect.x+"|right:"+tmpRect.right+"|rect.right:"+rect.right);
				// 去掉右侧透明
				if((tmp.x+tmpRect.right) < width){
					tmp.x += 6;
					list.addItemAt(tmp,layer);
					this.dispatchEvent(new Event(eventType));								
				}				
				
			}			
		}
		//左旋转
		public function onLeftRotation():void
		{		
			if(layer > 0){				
				var tmp:LayerInfo = this.list.getItemAt(layer) as LayerInfo;
//				var bmp:BitmapData = tmp.bitmapData;
//				tmp.rotation +=10;
				list.addItemAt(tmp,layer);
				this.dispatchEvent(new Event(eventType));
			}
		}
		//右旋转
		public function onRightRotation():void
		{
			if(layer > 0){				
				var tmp:LayerInfo = this.list.getItemAt(layer) as LayerInfo;
//				var bmp:BitmapData = tmp.bitmapData;
//				tmp.rotation -= 10;
				list.addItemAt(tmp,layer);
				this.dispatchEvent(new Event(eventType));						
			}
			
		}
		//放大
		public function onScale():void 
		{
			
			if(layer > 0){				
				var tmp:LayerInfo = this.list.getItemAt(layer) as LayerInfo;
//				var bmp:BitmapData = tmp.bitmapData;				
				if(tmp.scaleX < 1){
					tmp.scaleX += 0.1;
					tmp.scaleY += 0.1;	
					list.addItemAt(tmp,layer);
					this.dispatchEvent(new Event(eventType));					
				}			
				
			}
		}
		//缩小
		public function onReduce():void {
			
			if(layer > 0){				
				var tmp:LayerInfo = this.list.getItemAt(layer) as LayerInfo;
//				var bmp:BitmapData = tmp.bitmapData;
				if(tmp.scaleX > 0.3 && tmp.scaleY > 0.3){
					tmp.scaleX -= 0.1;
					tmp.scaleY -= 0.1;	
					list.addItemAt(tmp,layer);
					this.dispatchEvent(new Event(eventType));						
				}				
			}
		}	
		public function onSuMiaoTeXiao():void{
			isHeBai = false;			
			isSuMiao = true;
			isSuiCai = false;			
			this.filters = [];
			var tmp:Bitmap;
			var li:LayerInfo;
			if(templateId >0){
				li = list.getItemAt(templateId) as LayerInfo;
				tmp = new Bitmap(DisplayObjectFilter.sketchFilter(li.cache,19));
				list.addItemAt(tmp,templateId);				
			}
			if(photoId >0){
				li = list.getItemAt(photoId) as LayerInfo;
				tmp = new Bitmap(DisplayObjectFilter.sketchFilter(li.cache,19));
				tmp.x = li.x;
				tmp.y = li.y;
				list.addItemAt(tmp,photoId);				
			}
			if(weiboId >0){
				li = list.getItemAt(weiboId) as LayerInfo;				
				tmp = new Bitmap(DisplayObjectFilter.sketchFilter(li.cache,19));
				tmp.x = li.x;
				tmp.y = li.y;
				list.addItemAt(tmp,weiboId);
			}
			if(yanjingId >0){
				li = list.getItemAt(yanjingId) as LayerInfo;				
				tmp = new Bitmap(DisplayObjectFilter.sketchFilter(li.cache,19));
				tmp.x = li.x;
				tmp.y = li.y;
				list.addItemAt(tmp,yanjingId);
			}			
			this.dispatchEvent(new Event(eventType));			
			
		}
		public function onSuiCaiTeXiao():void{
			isHeBai = false;			
			isSuMiao = false;
			isSuiCai = true;			
			this.filters = [];
			var tmp:Bitmap;
			var li:LayerInfo;
			if(templateId >0){
				li = list.getItemAt(templateId) as LayerInfo;
				tmp = new Bitmap(DisplayObjectFilter.waterColorFilter(li.cache));
				list.addItemAt(tmp,templateId);			
			}
			if(photoId >0){
				li = list.getItemAt(photoId) as LayerInfo;
				tmp = new Bitmap(DisplayObjectFilter.waterColorFilter(li.cache));
				tmp.x = li.x;
				tmp.y = li.y;
				list.addItemAt(tmp,photoId);
			}
			if(weiboId >0){
				li = list.getItemAt(weiboId) as LayerInfo;				
				tmp = new Bitmap(DisplayObjectFilter.waterColorFilter(li.cache));
				tmp.x = li.x;
				tmp.y = li.y;
				list.addItemAt(tmp,weiboId);
			}
			if(yanjingId >0){
				li = list.getItemAt(yanjingId) as LayerInfo;				
				tmp = new Bitmap(DisplayObjectFilter.waterColorFilter(li.cache));
				tmp.x = li.x;
				tmp.y = li.y;
				list.addItemAt(tmp,yanjingId);
			}			
			this.dispatchEvent(new Event(eventType));			
			
		}
		public function onHeBaiTeXiao():void{
			isHeBai = true;			
			isSuMiao = false;
			isSuiCai = false;
			
			var cm:ColorMatrix = new ColorMatrix();
			cm.adjustColor(00, 0, -100, 0);
			this.filters = [new ColorMatrixFilter(cm)];
			
			this.dispatchEvent(new Event(eventType));			
			
		}	
		
		public function makeImage(w:int,h:int,isPreview:Boolean):BitmapData {
			var result:BitmapData;
			if(isPreview){
				result  = new BitmapData(w,h,true,0x00000000); 
			}else{
				result = new BitmapData(w,h,true,0xFFFFFF);				
			}
//			var li:LayerInfo;
//			var bmp:BitmapData;
////			var tmpRect:Rectangle;
//			var scaleX:int = 3.125;
//			var scaleY:int = 3.125;
//			var m:Matrix;
//			var p:Point;
//			var i:int;
//			// 当前屏幕显示的层数
//			var total:int = this.numChildren;
//			// 需要处理的层数
//			var elementTotal:int = list.length;			
//			var keys:ArrayCollection = new ArrayCollection();
//			keys.addAll(list);
//			var sort:Sort = new Sort();
//			sort.fields =  [new SortField("index")];;
//			keys.sort = sort;			
//			keys.refresh(); 
//			
//			//result.threshold(result, result.rect, new Point(0,0), "==", 0x00FFFFFF, 0x00FF0000, 0x00FFFFFF, true);			
//			
//			// 去掉背景
//			for(i=1;i<keys.length;i++){
//				//调整图层
//				li = keys.getItemAt(i) as LayerInfo;
//				if(li.index == 2){ //template														
//					if(isPreview){
//						result.copyPixels(li.cache,li.cache.rect,new Point(),null,null,true);
//					}else{
////						result.copyPixels(li.original,li.original.getColorBoundsRect(),new Point(),null,null,true);
//						bmp = new BitmapData(w,h,true,0xFFFFFF);
//						bmp.draw(li.original);
//						p = new Point(0,0);
//						result.copyPixels(bmp,bmp.rect,p,null,null,true);
//					}
//				}
//				else { // yanjing,weibo,photo
//					bmp = new BitmapData(w,h,true,0x00000000);					
//					if(isPreview){
//						p = new Point(li.canvas.x,li.canvas.y);						
//						bmp.draw(li.original,li.matrix);								
//					}else{
//						m = new Matrix();
//						p = new Point(li.canvas.x*scaleX,li.canvas.y*scaleY);
//						m.scale(scaleX,scaleY);
//						bmp.draw(li.original,m);						
//					}										
//					result.copyPixels(bmp,bmp.rect,p,null,null,true);									
//				}
//			
//			}	
//			
//			if(isSuiCai){
//				result = DisplayObjectFilter.waterColorFilter(result);
//			}
//			if(isHeBai){
//				var filterBitmap:Bitmap = new Bitmap(result);
//				var cm:ColorMatrix = new ColorMatrix();
//				cm.adjustColor(00, 0, -100, 0);
//				filterBitmap.filters = [new ColorMatrixFilter(cm)];
//				result = filterBitmap.bitmapData;
//			}
//			if(isSuMiao){
//				result = DisplayObjectFilter.sketchFilter(result,19);
//			}			
			
			return result;
		}
		
		
		public function outputPreviewImage():BitmapData {			

			return makeImage(320,240,true);
		}		
		
		private function testJpg(bmp:BitmapData):void{
			var jpg:JPEGEncoder=new JPEGEncoder(80);			
			var bytes:ByteArray=jpg.encode(bmp);		
			var file:FileReference = new FileReference();
			file.save(bytes,"test.jpg");
		}
		
		
		//BitmapData.getPixels来生成ByteArray交由服务器处理即可
		public function outputImage():ByteArray {			
			var jpg:JPEGEncoder=new JPEGEncoder(80);			
			var bytes:ByteArray=jpg.encode(makeImage(1024,768,false));		
			trace("output bytes:"+bytes.length);
			
			var file:FileReference = new FileReference();
			file.save(bytes,"test.jpg");
			
			return bytes;
		}
		
//		private function isPointInRect(rt:Rectangle,local:Point):Boolean{
//			if(local.x < rt.x || local.y < rt.y || local.x >= (rt.x+rt.right) || local.y >= (rt.y+rt.bottom)){
//				return false;	
//			}		
//			
//			return true;
//		}
		
		
		// 判断当前选择的图层
		public function mouseClickLayer(event:MouseEvent):void{
			
//			var p:Point = new Point(event.stageX,event.stageY);
//			var rt:Rectangle = new Rectangle(11,16,320,240); //new Rectangle(11,16,320,240)
//			var tmp:Bitmap;
//			if(p.x >= rt.x && p.y >= rt.y && p.x <= rt.right && p.y <= rt.bottom){
//				//true
//				//Alert.show("true|x:"+p.x+"|y:"+p.y+"|right:"+rt.right+"|bottom:"+rt.bottom+"|top:"+rt.top+"|top_left:"+rt.topLeft);	
//				//点选：眼睛，围脖，照片
//				if(weiboIndex > 0){
//					tmp = this.getChildAt(weiboIndex) as Bitmap;					
//					var weiboPoint:Point = new Point(event.localX,event.localY);
//					//					var tmpRect:Rectangle = tmp.bitmapData.getColorBoundsRect(0xFF000000,0x00000000,false);	
//					if(tmp.bitmapData.getPixel32(weiboPoint.x,weiboPoint.y) != 0x00000000){
//						//					if(isPointInRect(tmpRect,weiboPoint)){
//						//					if(tmp.bitmapData.hitTest(weiboPoint,0x00000000,null)){
//						layer = weiboIndex;
//					}
//				}else if(yanjingIndex > 0){
//					tmp = this.getChildAt(yanjingIndex) as Bitmap;					
//					var yanjingPoint:Point = new Point(event.localX,event.localY);
//					//					var tmpRect:Rectangle = tmp.bitmapData.getColorBoundsRect(0xFF000000,0x00000000,false);
//					if(tmp.bitmapData.getPixel32(yanjingPoint.x,yanjingPoint.y) != 0x00000000){
//						//					if(isPointInRect(tmpRect,yanjingPoint)){
//						layer = yanjingIndex;						
//					}			
//					
//				}else if(photoIndex > 0)
//				{
//					tmp = this.getChildAt(photoIndex) as Bitmap;					
//					var photoPoint:Point = new Point(event.localX,event.localY);
//					//					var tmpRect:Rectangle = tmp.bitmapData.getColorBoundsRect(0xFF000000,0x00000000,false);
//					if(tmp.bitmapData.getPixel32(photoPoint.x,photoPoint.y) != 0x00000000){
//						//					if(isPointInRect(tmpRect,photoPoint)){					
//						layer = photoIndex;
//					}				
//					
//				}
//				
//				if(layer > 0)
//				{
//					if(layer == photoIndex){
//						Alert.show("您选择了图片");						
//					}else if(layer == yanjingIndex){
//						Alert.show("您选择了眼睛");						
//					}else if(layer == weiboIndex){
//						Alert.show("您选择了围脖");												
//					}
//				}
//				
//			}
			
			
		}
		
			
		
//		public function onSelect(obj:*):void {		
//			
//			obj.addEventListener(MouseEvent.MOUSE_OVER,function(){Mouse.cursor = MouseCursor.HAND });
//			obj.addEventListener(MouseEvent.MOUSE_OUT,function(){Mouse.cursor = MouseCursor.AUTO });
//			obj.addEventListener(MouseEvent.MOUSE_DOWN,MouseDownHandler);			
//		}
		
		
//		function MouseDownHandler(e:MouseEvent) {		
//			stage.addEventListener(MouseEvent.MOUSE_UP, MouseUpHandler);		
//			//第一参数如果为true,则表示拖动时，鼠标所在点自动对齐对象中心--即所谓的锁定中心			
////			ball.startDrag(true,new Rectangle(posX-rectSize/2, posY-rectSize/2, rectSize, rectSize));		
//			//画出边界，方便更直观显示
//			graphics.clear();
//			graphics.lineStyle(1);
////			graphics.drawRect(posX-rectSize/2, posY-rectSize/2, rectSize, rectSize);
//			
//		}
//		
//		function MouseUpHandler(e:MouseEvent) {
////			ball.stopDrag();			
//		}

		
	}
}
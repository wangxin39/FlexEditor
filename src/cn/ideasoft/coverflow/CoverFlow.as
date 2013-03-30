package cn.ideasoft.coverflow
{	
	import caurina.transitions.Tweener;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.*;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	
	/**
	 * Alternativa3D 7.7.0
	 * CoverFlow 图像展示效果
	 * @by ssnangua
	 */
	[SWF(backgroundColor="#CCCCCC", frameRate="100", width="980", height="470")]
	public class CoverFlow extends Sprite
	{
//		private var scene:AlternativaTemplate; // 三维环境
//		private var imageNum:uint = 11;   // 图片总数
//		private var radius:Number = 600;  // 图片分布范围半径
//		private var i:uint;      // 用于for循环的变量
//		private var imageLoadedNum:uint = 0; // 已加载图片数
//		private var loadProgressTxt:TextField; // 显示加载进度的文本
//		private var imageContainer:Object3DContainer; // 图片容器
//		private var materials:Vector.<TextureMaterial>; // 存放材质的数组
//		private var selectIndex:uint = 0;  // 目前所选 Plane 序号
//		
//		public function CoverFlow():void
//		{
//			if (stage) init();
//			else addEventListener(Event.ADDED_TO_STAGE, init);
//		}
//		private function init(e:Event=null):void
//		{
//			removeEventListener(Event.ADDED_TO_STAGE, init);
//			// 三维环境
//			scene = new AlternativaTemplate(this);
//			scene.cameraController.setObjectPosXYZ(0,-1200,0);
//			scene.cameraController.lookAtXYZ(0, 0, 0);
//			scene.camera.view.hideLogo();
//			
//			// 平面容器
//			imageContainer = new Object3DContainer();
//			scene.container.addChild(imageContainer);
//			
//			// 加载进度显示
//			loadProgressTxt = new TextField();
//			loadProgressTxt.autoSize = "left";
//			stage.addChild(loadProgressTxt);
//			
//			// 材质
//			materials = new Vector.<TextureMaterial>;
//			for(i=0; i<imageNum; i++) {
//				var mat:TextureMaterial = new TextureMaterial();
//				mat.diffuseMapURL = "images/" + String(i) + ".jpg";
//				materials.push(mat);
//			}
//			var context:LoaderContext = new LoaderContext(true);
//			var matLoader:MaterialLoader = new MaterialLoader();
//			matLoader.load(materials,context);
//			// 加载进度
//			matLoader.addEventListener(LoaderEvent.PART_COMPLETE, matLoading);
//			// 材质加载完成添加图片
//			matLoader.addEventListener(Event.COMPLETE, matLoadComplete);
//			
//			// 渲染
//			scene.startRendering();
//		}
//		
//		// 监测材质加载进度
//		private function matLoading(e:LoaderEvent):void {
//			imageLoadedNum ++;
//			loadProgressTxt.text = "Loading : " + imageLoadedNum + " / " + imageNum;
//			loadProgressTxt.x = (stage.stageWidth - loadProgressTxt.width) / 2;
//			loadProgressTxt.y = (stage.stageHeight - loadProgressTxt.height) / 2;
//		}
//		
//		// 材质加载完成 创建平面
//		private function matLoadComplete(e:Event):void
//		{
//			stage.removeChild(loadProgressTxt);
//			for(i=0; i<imageNum; i++) {
//				// 图片
//				var plane:Plane = new Plane(200,150);
//				plane.setMaterialToAllFaces(materials[i]);
//				imageContainer.addChild(plane);
//				plane.useHandCursor = true;
//				plane.rotationX = Math.PI / 2; // 将平面立起来
//				plane.addEventListener(MouseEvent3D.CLICK, selectPlane);
//				// 影子
//				var shadow:Plane = new Plane(200,150);
//				shadow.setMaterialToAllFaces(new TextureMaterial(reflect(materials[i].texture)));
//				imageContainer.addChild(shadow);
//				shadow.filters = [new BlurFilter()];
//				shadow.rotationX = Math.PI / 2;
//				shadow.z = -150;
//			}
//			// 初始化 跳到第6张图片
//			shiftToPlane(10);
//			// 添加舞台滚轮事件
//			stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
//		}
//		
//		// 点击平面变大 并移到舞台中间
//		private function selectPlane(e:MouseEvent3D):void {
//			shiftToPlane(imageContainer.getChildIndex(e.currentTarget as Plane));
//		}
//		
//		// 舞台鼠标滚轮事件
//		private function mouseWheel(e:MouseEvent):void {
//			if(e.delta < 0) {
//				if (selectIndex < (imageNum-1)*2) {
//					shiftToPlane(selectIndex + 2);
//				}
//			} else {
//				if (selectIndex > 0) {
//					shiftToPlane(selectIndex - 2);
//				}
//			}
//		}
//		
//		// 跳到指定 Plane
//		private function shiftToPlane(id:uint):void {
//			selectIndex = id;
//			var planeTemp1:Plane;
//			var planeTemp2:Plane;
//			var dis:int;
//			for(var i:uint=0; i<imageContainer.numChildren; i+=2) {
//				planeTemp1 = imageContainer.getChildAt(i) as Plane; //平面
//				planeTemp2 = imageContainer.getChildAt(i+1) as Plane; //影子
//				dis = i-id;
//				// 当前平面
//				if(i==id) {
//					Tweener.to(planeTemp1, 0.5, {
//						x : 0, 
//						y : -750, 
//						rotationZ : 0
//					});
//					Tweener.to(planeTemp2, 0.5, {
//						x : 0, 
//						y : -750, 
//						rotationZ : 0
//					});
//				}
//					// 当前平面左边的平面
//				else if(i<id) {
//					Tweener.to(planeTemp1, 0.5, {
//						x : dis * 70 - 180, 
//						y : 0, 
//						rotationZ : 60 * Math.PI/180
//					});
//					Tweener.to(planeTemp2, 0.5, {
//						x : dis * 70 - 180, 
//						y : 0, 
//						rotationZ : 60 * Math.PI/180
//					});
//				}
//					// 当前平面右边的平面
//				else {
//					Tweener.to(planeTemp1, 0.5, {
//						x : dis * 70 + 180, 
//						y : 0, 
//						rotationZ : -60 * Math.PI/180
//					});
//					Tweener.to(planeTemp2, 0.5, {
//						x : dis * 70 + 180, 
//						y : 0, 
//						rotationZ : -60 * Math.PI/180
//					});
//				}
//			}
//		}
		
		// 倒影
		/**
		 * pTarget  : 需要被透明度渐变的 BitmapData
		 * pRatioFade : 开始渐变的透明度 值在[0,1]间
		 * pRatioEndFade: 结束渐变的透明度 值在[0,1]间
		 * _numMidLoc : 开始渐变的位置 值在[0,1]间
		 * 返回 : 透明度渐变后的 BitmapData
		 */
		private function reflect(pTarget:BitmapData, pRatioFade:Number = .6, pRatioEndFade:Number = 0, _numMidLoc:Number = .4 ):BitmapData
		{
			var _resultBmp :BitmapData = new BitmapData(pTarget.width, pTarget.height, true, 0);    
			var _matSkew :Matrix = new Matrix(1, 0, 0, -1, 0, pTarget.height);   
			var _recDraw :Rectangle = new Rectangle(0, 0, pTarget.width, pTarget.height);   
			var _potSkew :Point = _matSkew.transformPoint(new Point(0, pTarget.height));
			_matSkew.tx = _potSkew.x * -1;
			_matSkew.ty = (_potSkew.y - pTarget.height) * -1;   
			_resultBmp.draw(pTarget, _matSkew, null, null, _recDraw, true);
			
			var _gradientShape:Shape = new Shape();   
			var _fillType   :String = GradientType.LINEAR;
			var _colorsArr   :Array = [0, 0 , 0];
			var _alphasArr   :Array = [pRatioFade, (pRatioFade - pRatioEndFade) / 2, pRatioEndFade];
			var _ratiosArr   :Array = [0, 0xFF * _numMidLoc, 0xFF];
			var _gradientMat  :Matrix = new Matrix();
			var _spreadMethod :String = SpreadMethod.PAD;
			
			_gradientMat.createGradientBox(pTarget.width, pTarget.height / 2, Math.PI / 2);         
			_gradientShape.graphics.beginGradientFill(_fillType, _colorsArr, _alphasArr, _ratiosArr, _gradientMat, _spreadMethod)   
			_gradientShape.graphics.drawRect(0, 0, pTarget.width, pTarget.height);
			_gradientShape.graphics.endFill();
			_resultBmp.draw(_gradientShape, null, null, BlendMode.ALPHA);
			
			_gradientShape = null;
			return _resultBmp  
		}
		
	}
	
}
}
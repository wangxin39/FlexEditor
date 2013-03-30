package cn.ideasoft.common
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import mx.events.FlexEvent;
	import mx.preloaders.DownloadProgressBar;

	public class PreLoading extends DownloadProgressBar
	{	
//		private var cp:MLoading;
		
		public function PreLoading()
		{
//			cp = new MLoading();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
//			addChild(cp);
		}
		
		public override function set preloader(preloader:Sprite):void
		{
			preloader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			preloader.addEventListener(FlexEvent.INIT_COMPLETE, initComplete);
		}
		
		private function onProgress(e:ProgressEvent):void
		{
//			cp.percent = Math.ceil(e.bytesLoaded/e.bytesTotal*100);
		}
		
		private function initComplete(e:Event):void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function onAdded(e:Event):void
		{
//			cp.stop();
//			cp.x = stage.stageWidth*0.5;
//			cp.y = stage.stageHeight*0.5;
		}
		
	}
}
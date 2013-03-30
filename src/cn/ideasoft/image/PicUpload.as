package cn.ideasoft.image
{
	import flash.display.Bitmap;  
	import flash.display.BitmapData;  
	import flash.display.Loader;  
	import flash.events.*;  
	import flash.net.FileFilter;  
	import flash.net.FileReference;  
	import flash.net.URLRequest;  
	import flash.system.Security;  
	import flash.utils.ByteArray;  
	
	import mx.controls.Alert;  
	import mx.controls.Button;  
	import mx.controls.Image;  
	import mx.controls.TextInput;  
	import mx.managers.CursorManager;  
	
	
	public class PicUpload  
	{   
		//Events  
		public var completeEvent:Event;  
		
		//UI Vars  
		private var _browsebutton:Button;  
		private var _uploadbutton:Button;  
		private var picInput:TextInput;  
		private var csmallPic:TextInput;  
		private var img:Image;  
		
		//File Reference Vars  
		[Bindable]  
		private var file:FileReference;  
		private var request:URLRequest;  
		private var byteArray:ByteArray;  
		private var bitmapData:BitmapData;  
		private var loader:Loader=new Loader();  
		private var _maxFileSize:Number=302400; //bytes  
		//File Filter vars  
		private var imageTypes:FileFilter = new FileFilter("Images (*.jpg; *.jpeg; *.gif; *.png)" ,"*.jpg; *.jpeg; *.gif; *.png");  
		//private var videoTypes:FileFilter = new FileFilter("Flash Video Files (*.flv)","*.flv");  
		//private var documentTypes:FileFilter = new FileFilter("Documents (*.pdf)",("*.pdf"));  
		private var allTypes:Array = new Array(imageTypes);//,videoTypes,documentTypes);  
		
		//config vars  
		private var _url:String;   
		private var _rollBack:String="";  
		
		
		public function PicUpload(browseButton:Button,  
								  imge:Image,  
								  disInput:TextInput,  
								  visInput:TextInput,  
								  uploadButton:Button,  
								  url:String,  
								  rollBack:String){  
			_browsebutton=browseButton;  
			img=imge;  
			picInput=disInput;  
			csmallPic=visInput;  
			_uploadbutton=uploadButton;  
			_url=url;  
			_rollBack=rollBack;  
			init();  
		}  
		
		private function init():void{  
			Security.allowDomain("*");  
			file=new FileReference();  
			file.addEventListener(Event.COMPLETE, fileReferenceCompleteHandler);  
			file.addEventListener(Event.SELECT, fileReferenceSelectHandler);  
			_browsebutton.addEventListener(MouseEvent.CLICK, choose);  
			_uploadbutton.addEventListener(MouseEvent.CLICK, proceedWithUpload);  
			request=new URLRequest  
			request.url=_url;  
		}  
		
		//选择上传的图片  
		private function choose(event:MouseEvent):void  
		{  
			file.browse(allTypes);  
		}  
		//上传图片到服务器  
		private function proceedWithUpload(event:MouseEvent):void  
		{  
			if(csmallPic.text!=""){  
				file.upload(request);  
				file.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);//文件失败上传监听事件   
				file.addEventListener(Event.COMPLETE,doFileUploadComplete);//文件成功上传监听事件     
				file.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);  
				file.addEventListener(HTTPStatusEvent.HTTP_STATUS,httpStatusHandler);  
			}  
		}  
		
		//载入本地图片  
		private function fileReferenceCompleteHandler(e:Event):void  
		{  
			byteArray=file.data;  
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleteHandler);  
			loader.loadBytes(byteArray);  
		}  
		
		//图片载入完成显示在预览框中  
		private function loaderCompleteHandler(e:Event):void  
		{  
			var bitmap:Bitmap=Bitmap(loader.content);  
			bitmapData=bitmap.bitmapData;  
			img.source=bitmap;  
		}  
		
		//选择文件动作监听  
		private function fileReferenceSelectHandler(e:Event):void  
		{  
			var msg:String ="";  
			if (checkFileSize(file.size)){  
				csmallPic.text=file.name;  
				picInput.text=file.name;  
				file.load();  
			}  else {  
				msg += file.name + " 大小超过限制了. \n";  
				Alert.show(msg + "图片最大允许: " + Math.round(_maxFileSize / 1024) + " kb","图片大小超过限制",4,null).clipContent;  
			}  
			
		}  
		
		//验证图片大小  
		private function checkFileSize(filesize:Number):Boolean{  
			var r:Boolean = false;  
			if (filesize > _maxFileSize){  
				r = false;  
				trace("false");  
			}else if (filesize <= _maxFileSize){  
				r = true;  
				trace("true");  
			}  
			if (_maxFileSize == 0){  
				r = true;  
			}  
			return r;  
		}  
		
		//上传失败处理事件  
		private function errorHandler(evt:IOErrorEvent):void{   
			Alert.show(evt.text,"上传失败，检查网络");   
		}   
		//上传成功处理  
		private function doFileUploadComplete(evt:Event):void{   
			if(_rollBack!=""){  
				//this.dispatchEvent(new Event(_rollBack));  
			}  
		}  
		
		private function securityErrorHandler(event:SecurityErrorEvent):void{  
			mx.controls.Alert.show(event.text,"Security Error",0);  
		}  
		
		private function httpStatusHandler(event:HTTPStatusEvent):void {  
			if (event.status != 200){  
				mx.controls.Alert.show(event.toString(),"上传错误",0);  
			}  
		}  
		
	}  
}
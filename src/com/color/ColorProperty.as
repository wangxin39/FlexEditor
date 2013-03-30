 /**
* @Name:ColorProperty(MovieClip颜色属性)
* 色调:_color,亮度:_brightness,灰度:_grayscale,饱和度:_saturation,对比度:_contrast,反相:_invert
* @author:aixia
* @version:1.0
*/
package com.color
{
import flash.filters.ColorMatrixFilter;
import mx.controls.Image;
import mx.core.UIComponent;
public class ColorProperty
{
	//_matrix是ColorMatrixFilter类的默认恒等矩阵
	//_nRed,_nGreen,_nBlue是计算机图形颜色亮度的常量
	//private static var _matrix : Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
	private static var _nRed : Number = 0.3086;
	private static var _nGreen : Number = 0.6094;
	private static var _nBlue : Number = 0.0820;
	
	public var ColorUI:UIComponent = null;
	
	//亮度Brightness
	public function SetBrightness(offset : Number):void{
		var Brightness_Matrix : Array = [1, 0, 0, 0, offset, 0, 1, 0, 0, offset, 0, 0, 1, 0, offset, 0, 0, 0, 1, 0];
		//if(ColorUI）
		//{
			ColorUI.filters = [new ColorMatrixFilter (Brightness_Matrix)];
		//}
	}
	
	//饱和度
	public function SetSaturation(nLevel : Number):void{
		var srcRa : Number = (1 - nLevel) * _nRed + nLevel;
		var srcGa : Number = (1 - nLevel) * _nGreen;
		var srcBa : Number = (1 - nLevel) * _nBlue;
		var srcRb : Number = (1 - nLevel) * _nRed;
		var srcGb : Number = (1 - nLevel) * _nGreen + nLevel;
		var srcBb : Number = (1 - nLevel) * _nBlue;
		var srcRc : Number = (1 - nLevel) * _nRed;
		var srcGc : Number = (1 - nLevel) * _nGreen;
		var srcBc : Number = (1 - nLevel) * _nBlue + nLevel;
		var Saturation_Matrix : Array = [srcRa, srcGa, srcBa, 0, 0, srcRb, srcGb, srcBb, 0, 0, srcRc, srcGc, srcBc, 0, 0, 0, 0, 0, 1, 0];
		//if( ColorUI ）
		//{
			ColorUI.filters = [new ColorMatrixFilter (Saturation_Matrix)];
		//}

	}
	
	//对比度Contrast
	public function SetContrast(nLevel : Number):void{
		var Scale : Number = nLevel * 11;
		var Offset : Number = 63.5 - (nLevel * 698.5);
		var Contrast_Matrix : Array = [Scale, 0, 0, 0, Offset, 0, Scale, 0, 0, Offset, 0, 0, Scale, 0, Offset, 0, 0, 0, 1, 0];
		if( ColorUI )
		ColorUI.filters = [new ColorMatrixFilter (Contrast_Matrix)];
		
	}
	
	//色调Color
	public function SetColor(nColor : Number):void{
		var colorStr : String = nColor.toString (16);
		var nRed : Number = Number ("0x" + colorStr.slice (0, 2));
		var nGreen : Number = Number ("0x" + colorStr.slice (2, 4));
		var nBlue : Number = Number ("0x" + colorStr.slice (4, 6));
		var Color_Matrix : Array = [1, 0, 0, 0, nRed, 0, 1, 0, 0, nGreen, 0, 0, 1, 0, nBlue, 0, 0, 0, 1, 0];
		if( ColorUI )
		ColorUI.filters = [new ColorMatrixFilter (Color_Matrix)];

	}
	
	//public function ColorProperty ()
	//{
	//}
	/*
	public static function init ():void
	{
		setColorProperty ();
	}
	private static function setColorProperty ()
	{
		//色调Color,getter&setter
		MovieClip.prototype.getColor = function () : Number
		{
			return MovieClip.prototype._color;
		}
		MovieClip.prototype.setColor = function (nColor : Number) : Void
		{
			var colorStr : String = nColor.toString (16);
			var nRed : Number = Number ("0x" + colorStr.slice (0, 2));
			var nGreen : Number = Number ("0x" + colorStr.slice (2, 4));
			var nBlue : Number = Number ("0x" + colorStr.slice (4, 6));
			var Color_Matrix : Array = [1, 0, 0, 0, nRed, 0, 1, 0, 0, nGreen, 0, 0, 1, 0, nBlue, 0, 0, 0, 1, 0];
			this.filters = [new ColorMatrixFilter (Color_Matrix)];
			MovieClip.prototype._color = nColor;
		}
		//亮度Brightness,getter&setter
		MovieClip.prototype.getBrightness = function () : Number
		{
			return MovieClip.prototype._brightness;
		}
		MovieClip.prototype.setBrightness = function (offset : Number) : Void
		{
			var Brightness_Matrix : Array = [1, 0, 0, 0, offset, 0, 1, 0, 0, offset, 0, 0, 1, 0, offset, 0, 0, 0, 1, 0];
			this.filters = [new ColorMatrixFilter (Brightness_Matrix)];
			MovieClip.prototype._brightness = offset;
		}
		//灰度Grayscale,getter&setter
		MovieClip.prototype.getGrayscale = function () : Boolean
		{
			return MovieClip.prototype._grayscale;
		}
		MovieClip.prototype.setGrayscale = function (yes : Boolean) : Void
		{
			if (yes)
			{
				var Grayscale_Matrix : Array = [_nRed, _nGreen, _nBlue, 0, 0, _nRed, _nGreen, _nBlue, 0, 0, _nRed, _nGreen, _nBlue, 0, 0, 0, 0, 0, 1, 0];
				this.filters = [new ColorMatrixFilter (Grayscale_Matrix)];
				MovieClip.prototype._grayscale = true;
			} else
			{
				MovieClip.prototype._grayscale = false;
			}
		}
		//饱和度Saturation,getter&setter
		MovieClip.prototype.getSaturation = function () : Number
		{
			return MovieClip.prototype._saturation;
		}
		MovieClip.prototype.setSaturation = function (nLevel : Number) : Void
		{
			var srcRa : Number = (1 - nLevel) * _nRed + nLevel;
			var srcGa : Number = (1 - nLevel) * _nGreen;
			var srcBa : Number = (1 - nLevel) * _nBlue;
			var srcRb : Number = (1 - nLevel) * _nRed;
			var srcGb : Number = (1 - nLevel) * _nGreen + nLevel;
			var srcBb : Number = (1 - nLevel) * _nBlue;
			var srcRc : Number = (1 - nLevel) * _nRed;
			var srcGc : Number = (1 - nLevel) * _nGreen;
			var srcBc : Number = (1 - nLevel) * _nBlue + nLevel;
			var Saturation_Matrix : Array = [srcRa, srcGa, srcBa, 0, 0, srcRb, srcGb, srcBb, 0, 0, srcRc, srcGc, srcBc, 0, 0, 0, 0, 0, 1, 0];
			this.filters = [new ColorMatrixFilter (Saturation_Matrix)];
			MovieClip.prototype._saturation = nLevel;
		}
		//对比度Contrast,getter&setter
		MovieClip.prototype.getContrast = function () : Number
		{
			return MovieClip.prototype._contrast;
		}
		MovieClip.prototype.setContrast = function (nLevel : Number) : Void
		{
			var Scale : Number = nLevel * 11;
			var Offset : Number = 63.5 - (nLevel * 698.5);
			var Contrast_Matrix : Array = [Scale, 0, 0, 0, Offset, 0, Scale, 0, 0, Offset, 0, 0, Scale, 0, Offset, 0, 0, 0, 1, 0];
			this.filters = [new ColorMatrixFilter (Contrast_Matrix)];
			MovieClip.prototype._contrast = nLevel;
		}
		//反相Invert,getter&setter
		MovieClip.prototype.getInvert = function () : Boolean
		{
			return MovieClip.prototype._invert;
		}
		MovieClip.prototype.setInvert = function (yes : Boolean) : Void
		{
			if (yes)
			{
				var Invert_Matrix : Array = [ - 1, 0, 0, 0, 255, 0, - 1, 0, 0, 255, 0, 0, - 1, 0, 255, 0, 0, 0, 1, 0];
				this.filters = [new ColorMatrixFilter (Invert_Matrix)];
				MovieClip.prototype._invert = true;
			} else
			{
				MovieClip.prototype._invert = false;
			}
		}
	}*/
}
}
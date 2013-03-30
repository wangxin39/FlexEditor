package cn.ideasoft.image
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.filters.ShaderFilter;

	public class ImageFilters
	{
		public function ImageFilters()
		{
		}
		
		/**
		 * 浮雕特效处理
		 * */
		public function shader(bmp:Bitmap):Bitmap {
			var shader:Shader =  new Shader();
			shader.data.amount.value = 3;
			shader.data.radius.value = .1;
			var shaderFilter:ShaderFilter = new ShaderFilter( shader );
			bmp.filters = [shaderFilter];
			return bmp;
		}
		
	}
}
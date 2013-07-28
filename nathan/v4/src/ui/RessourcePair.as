package ui 
{
	import feathers.controls.Label;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import starling.display.Image;
	import starling.display.Sprite;
	import utils.Ressource;
	/**
	 * ...
	 * @author 
	 */
	public class RessourcePair extends Sprite
	{
		private var _res:Ressource;
		private var _value:uint;
		
		private var _lbl:Label;
		private var _img:Image;
		
		private var _okFormat:TextFormat;
		private var _noFormat:TextFormat;
		
		public function RessourcePair(res:Ressource, v:uint = 0) 
		{
			_res = res;
			_value = v;
			
			_lbl = new Label();
			addChild(_lbl);
			//_lbl.textRendererProperties = new Object();
			_lbl.text = "0";
			
			_okFormat = new TextFormat( "SourceSansProSemibold", 24, 0xFFFFFF );
			_noFormat = new TextFormat( "SourceSansProSemibold", 24, 0xFF0000 );
			
			_lbl.textRendererProperties.textFormat = _okFormat;
			
			/*
			_lbl.textRendererFactory = function():ITextRenderer
			{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat( "SourceSansProSemibold", 24, 0xFFFFFF );
				textRenderer.embedFonts = true;
				//textRenderer.isHTML = true;
				return textRenderer;
			}*/
			
			_lbl.validate();
			//_lbl.textRendererProperties.textFormat.align = TextFormatAlign.RIGHT;
			
			_img = new Image(Assets.atlas.getTexture(res.nom));
			addChild(_img);
			_img.scaleX = _img.scaleY = 0.7;
			
			value = v;
		}
		
		public function set value(v:uint):void
		{
			_value = v;
			_lbl.text = _value.toString();
			_lbl.validate();
			
			_img.x = _lbl.width;
		}
		
		public function compareTo(v:uint):void
		{
			/*var color:uint = 0xFFFFFF;
			if (v < _value)
				color = 0xFF0000;
				
			//_lbl.textRendererProperties.textFormat.color = color;
			_lbl.textRendererProperties.textFormat*/
			var format:TextFormat = _okFormat;
			if (v < _value)
				format = _noFormat;
				
			_lbl.textRendererProperties.textFormat = format;
			
		}
		
	}

}
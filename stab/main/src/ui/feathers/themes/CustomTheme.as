package ui.feathers.themes 
{
	import feathers.controls.Button;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import ui.Assets;
	/**
	 * ...
	 * @author Stab
	 */
	public class CustomTheme extends MetalWorksMobileTheme 
	{
		
		public function CustomTheme(container:DisplayObjectContainer = null, scaleToDPI:Boolean = true)
		{
			super(container, scaleToDPI);
			
			setInitializerForClass( Button, mainMenuButtonInitializer, "mainMenuButton" );
			setInitializerForClass(Button, smallButtonInitializer, "smallButton");
			
			setInitializerForClass(Button, menuButton, "menuButton");
			
		}
		
		private function menuButton(button:Button):void 
		{
			//var buttonImage:Image = new Image(Assets.atlas.getTexture("button"));
			//var buttonDownImage:Image = new Image(Assets.atlas.getTexture("buttonDown"));
			
			
			button.height = 40;
			button.defaultSkin = new Scale9Image(new Scale9Textures(Assets.atlas.getTexture("menuBackground"), new Rectangle(16, 16, 22, 22)));
			button.downSkin = new Scale9Image(new Scale9Textures(Assets.atlas.getTexture("menuBackgroundLight"), new Rectangle(16, 16, 22, 22)));
		 
			button.defaultLabelProperties.textFormat = new TextFormat( "SourceSansProSemibold", 15, 0xFFFFFF );
		}
		
		
		private function mainMenuButtonInitializer( button:Button ):void
		{
			var buttonImage:Image = new Image(Assets.atlas.getTexture("button"));
			var buttonDownImage:Image = new Image(Assets.atlas.getTexture("buttonDown"));
			
			button.height = 60;
			button.defaultSkin = buttonImage;
			button.downSkin = buttonDownImage;
		 
			button.defaultLabelProperties.textFormat = new TextFormat( "SourceSansProSemibold", 20, 0x433A29 );
		}
		
		private function smallButtonInitializer( button:Button ):void
		{
			button.height = 54;
			button.width = 54;
		}
		
		
	}

}
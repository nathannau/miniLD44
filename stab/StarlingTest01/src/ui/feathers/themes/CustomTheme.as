package ui.feathers.themes 
{
	import feathers.controls.Button;
	import flash.text.TextFormat;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
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
package ui.screens 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.controls.TextArea;
	import feathers.core.ITextRenderer;
	import flash.text.TextFormat;
	import starling.events.Event;

	public class StoryScreen extends BaseScreen 
	{
		
		public function StoryScreen() 
		{
			super();
			screenName = "STORY";
		}
		
		override protected function onInitialize(event:Event):void
		{	
			super.onInitialize(event);
			
			var text:Label = new Label();
			text.text = (
				"The Battle for the Last Continent...\n" +
				"blablabla...\n" +
				"insert epic story stuff here...\n" +
				"\n\n" +
				"Tutorial:\n" +
				"...\n"
			);
			
			text.width = stage.stageWidth;
			text.height = stage.stageHeight;
			
			addChild(text);
			
			//BEGIN
			var beginButton:Button = new Button();
			beginButton.width = 100;
			beginButton.height = 30;
			beginButton.label = "Begin";
			addChild(beginButton);
			
			beginButton.x = stage.stageWidth - beginButton.width - 5;
			beginButton.y = stage.stageHeight - beginButton.height - 5;
			
			beginButton.addEventListener(Event.TRIGGERED, beginTriggered);
		}
		
		private function beginTriggered(event:Event):void
		{
			ScreenManager.instance.showScreen(ScreenManager.instance.gameScreen);
		}
		
	}

}
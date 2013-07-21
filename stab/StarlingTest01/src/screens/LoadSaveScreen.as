package screens 
{
	import feathers.controls.Button;
	import starling.events.Event;

	public class LoadSaveScreen extends BaseScreen 
	{
		
		public function LoadSaveScreen() 
		{
			super();
			screenName = "LOADSAVE";
		}
		
		override protected function onInitialize(event:Event):void
		{	
			super.onInitialize(event);
			
			//BACK
			var backButton:Button = new Button();
			backButton.width = 50;
			backButton.height = 50;
			backButton.label = "<";
			
			backButton.addEventListener(Event.TRIGGERED, backTriggered);
			
			addChild(backButton);
		}
		
		private function backTriggered(event:Event):void
		{
			Main.instance.showScreen(Main.instance.mainMenuScreen);
		}
		
	}

}
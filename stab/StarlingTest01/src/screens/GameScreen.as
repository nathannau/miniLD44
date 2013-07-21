package screens 
{
	import feathers.controls.Screen;
	import feathers.controls.Button;
	import starling.display.Image;
	
	import feathers.events.FeathersEventType;
	
	import starling.events.Event;
	
	public class GameScreen extends BaseScreen 
	{
		//public static const NAME:String = "GAME";
		
		public function GameScreen()
		{
			super();
			screenName = "GAME";
		}
		
		override protected function onInitialize(event:Event):void
		{	
			super.onInitialize(event);
			
			//PAUSE
			//var pauseButton:Image = new Image(Ressource.atlas.getTexture("pause"));
			var pauseButton:Button = new Button();
			pauseButton.defaultSkin = new Image(Ressource.atlas.getTexture("pause"));
			pauseButton.width = 50;
			pauseButton.height = 50;
			//pauseButton.label = "<";
			pauseButton.x = stage.stageWidth - pauseButton.width;
			
			pauseButton.addEventListener(Event.TRIGGERED, pauseTriggered);
			
			addChild(pauseButton);
		}
		
		public function newGame():void
		{
			if (Main.game != null)
			{
				removeChild(Main.game);
			}
			
			Main.game = new Game();
			addChild(Main.game);
		}
		
		private function pauseTriggered(event:Event):void
		{
			Main.instance.showScreen(Main.instance.mainMenuScreen);
		}
		
	}

}
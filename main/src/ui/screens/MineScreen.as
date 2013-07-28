package ui.screens 
{
	import controller.Game;
	import feathers.controls.Button;
	import feathers.controls.ScrollContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import ui.Assets;
	import ui.game.MapUI;
	import ui.mine.MineTile;
	import ui.mine.MineArea;
	import ui.TouchZone;
	import utils.Mine;
	import utils.Ressource;
	
	import Main;
	/**
	 * ...
	 * @author 
	 */
	public class MineScreen extends BaseScreen 
	{
		private var _mineAera:MineArea;
		
		public function MineScreen() 
		{
			super();
			screenName = "MINE";
		}
		
		override protected function onInitialize(event:Event):void
		{	
			super.onInitialize(event);
			
			_mineAera = new MineArea();
			addChild(_mineAera);

			//BEGIN
			var backButton:Button = new Button();
			backButton.width = 54;
			backButton.height = 54;
			backButton.label = "->";
			addChild(backButton);
			
			backButton.x = stage.stageWidth - backButton.width - 5;
			backButton.y = 5;//stage.stageHeight - beginButton.height - 5;
			
			backButton.addEventListener(Event.TRIGGERED, backTriggered);
			
		}

		private function backTriggered(event:Event):void
		{
			ScreenManager.instance.showScreen(ScreenManager.instance.gameScreen);
		}
		
		override public function onEnter():void
		{
			_mineAera.update();
		}
		
	}

}
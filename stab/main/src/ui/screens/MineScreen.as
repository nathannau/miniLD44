package ui.screens 
{
	import controller.Game;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.ScrollContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import ui.Assets;
	import ui.game.MapUI;
	import ui.mine.MineTile;
	import ui.mine.MineArea;
	import ui.SmallButton;
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
		
		private var _timerLbl:Label;
		
		public function MineScreen() 
		{
			super();
			screenName = "MINE";
		}
		
		override protected function onInitialize(event:Event):void
		{	
			super.onInitialize(event);
			
			var background:Quad = new Quad(Main.stageWidth, Main.stageHeight, 0x15120b);
			addChild(background);
			
			_mineAera = new MineArea();
			addChild(_mineAera);

			//BEGIN
			var backButton:SmallButton = new SmallButton("buttonBack", backTriggered);
			addChild(backButton);
			
			backButton.x = stage.stageWidth - 60;
			backButton.y = 5;//stage.stageHeight - beginButton.height - 5;
			
			backButton.addEventListener(Event.TRIGGERED, backTriggered);
			
			//TIMER
			_timerLbl = new Label();
			_timerLbl.nameList.add("mineTimer");
			
			addChild(_timerLbl);
			_timerLbl.x = 10;
			_timerLbl.y = 10;
			
			
		}

		private function backTriggered(event:Event):void
		{
			ScreenManager.instance.showScreen(ScreenManager.instance.gameScreen);
		}
		
		override public function onEnter():void
		{
			_mineAera.update();
		}
		
		override protected function onEnterFrame(e:EnterFrameEvent):void
		{
			var nbUpdate:Number = Game.current.getMine(Game.current.getHumainPlayer()).nbUpdate;
			var nb:Number = Math.floor((Configuration.MINE_TIMELIFE - nbUpdate) / Configuration.FRAMERATE);
			
			_timerLbl.text = nb.toString();
		}
		
	}

}
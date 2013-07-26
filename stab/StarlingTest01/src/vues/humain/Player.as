package vues.humain 
{
	import controller.Game;
	import feathers.controls.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.Assets;
	import ui.game.GameArea;
	import ui.screens.ScreenManager;
	import ui.SmallButton;
	import vues.IPlayer;
	
	/**
	 * Affichage pour un joueur humain
	 * TODO : vues.ia.Player classe non implémentée
	 * @author Stab
	 */
	public class Player extends Sprite implements IPlayer 
	{
		private var _index:uint;
		
		private var _isInit:Boolean = false;
		
		private var _gameAera:GameArea;
		
		public function Player() 
		{			
			addEventListener(Event.ADDED_TO_STAGE, onAddedOnStage);
		}
		
		private function onAddedOnStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedOnStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_gameAera = new GameArea(this);
			addChild(_gameAera);
			
			var pauseButton:Button = addChild(new SmallButton("pause", onPauseTriggered)) as Button;
			pauseButton.x = Main.stageWidth - 55;
			pauseButton.y = 5;
			
			var gotoMineButton:Button = addChild(new SmallButton("pause", onGotoMineTriggered)) as Button;
			gotoMineButton.x = 5;
			gotoMineButton.y = 5;
			
			/*
			var pauseButton:Button = new Button();	
			pauseButton.nameList.add("smallButton");
			pauseButton.defaultIcon = new Image(Assets.atlas.getTexture("pause"));
			
			pauseButton.addEventListener(Event.TRIGGERED, onPauseTriggered);
			
			addChild(pauseButton);
			pauseButton.x = Main.stageWidth - pauseButton.width - 5;
			pauseButton.y = 5;
			
			
			var gotoMineButton:Button = new Button();
			gotoMineButton.nameList.add("smallButton");
			gotoMineButton.defaultIcon = new Image(Assets.atlas.getTexture("pause"));
			
			
			addChild(gotoMineButton);
			gotoMineButton.x = 5;
			gotoMineButton.y = 5;*/
			

		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (!_isInit && Game.current.isStarted) {
				_isInit = true;
				_gameAera.onStart();
			}
		}
		
		
			
		private function onInit():void 
		{
			
		}
		
		public function get index():uint
		{
			return _index;
		}
		public function set index(value:uint):void
		{
			_index = value
		}		
		
		public function update():void
		{
			
		}
		
		public function onPauseTriggered(e:Event):void 
		{ 
			ScreenManager.instance.showScreen(ScreenManager.instance.mainMenuScreen); 
		} 
		
		public function onGotoMineTriggered(e:Event):void 
		{ 
			//ScreenManager.instance.showScreen(ScreenManager.instance.mainMenuScreen); 
			_gameAera.gotoMine();
		} 
		

		
	}

}
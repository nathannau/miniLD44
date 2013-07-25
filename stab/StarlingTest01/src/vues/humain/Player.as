package vues.humain 
{
	import feathers.controls.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.Assets;
	import ui.game.GameArea;
	import ui.screens.ScreenManager;
	import vues.IPlayer;
	
	/**
	 * Affichage pour un joueur humain
	 * TODO : vues.ia.Player classe non implémentée
	 * @author Stab
	 */
	public class Player extends Sprite implements IPlayer 
	{
		private var _gameAera:GameArea;
		
		private var _pauseButton:Button;
		
		public function Player() 
		{			
			_gameAera = new GameArea();
			addChild(_gameAera);
			
			_pauseButton = new Button();
			addChild(_pauseButton);
			
			_pauseButton.nameList.add("smallButton");
			_pauseButton.defaultIcon = new Image(Assets.atlas.getTexture("pause"));
			_pauseButton.width = 54;
			_pauseButton.height = 54;
			_pauseButton.x = Main.stageWidth - _pauseButton.width - 5;
			_pauseButton.y = 5;
			
			trace(_pauseButton.x, _pauseButton.y);
			
			_pauseButton.addEventListener(Event.TRIGGERED, function(e:Event):void { ScreenManager.instance.showScreen(ScreenManager.instance.mainMenuScreen); } );
		}
		
		public function get index():uint
		{
			return 0;
		}
		public function set index(value:uint):void
		{
			
		}
		
		public function update():void
		{
			//_gameAera.update();
		}
		
	}

}
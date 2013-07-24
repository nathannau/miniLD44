package  
{
	import controller.Game;
	import fr.kouma.starling.utils.Stats;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.Map;
	import vues.ia.Player;
	import vues.humain.Player;
	import vues.IPlayer;
	
	import ui.screens.ScreenManager;
	
	public class Main extends Sprite
	{
		/** Instance de Main */
		public static var instance: Main;
		
		// utilisé pour l'optimisation de culling
		public static var stageWidth:uint;
		public static var stageHeight:uint;
		
		public var game:Game;
		
		private var _screenManager:ScreenManager;
		
		public function Main() {
			var g:Game = new Game();
			
			var m:Map = new Map();
			g.map = m;
			
			var iaPlayer:IPlayer = new vues.ia.Player();
			var humanPlayer:IPlayer = new vues.humain.Player();
			
			var array:Array = new Array(iaPlayer, humanPlayer);
			
			g.players = array;// [humanPlayer, iaPlayer];
			
			
			
			instance = this;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
			
			//gestion des screens
			_screenManager = new ScreenManager();
			addChild(_screenManager);
			
			addChild(new Stats());
		}	
		
		
	}
}
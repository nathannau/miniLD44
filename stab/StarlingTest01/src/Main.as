package  
{
	import controller.Game;
	import fr.kouma.starling.utils.Stats;
	import starling.display.Sprite;
	import starling.events.Event;
	
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
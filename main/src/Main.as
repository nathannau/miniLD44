package  
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	import ui.screens.ScreenManager;
	
	public class Main extends Sprite
	{
		/** Instance de Main */
		public static var instance: Main;
		
		private var _screenManager:ScreenManager;
		
		public function Main() {
			instance = this;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//gestion des screens
			_screenManager = new ScreenManager();
			addChild(_screenManager);
		}	
		
		
	}
}
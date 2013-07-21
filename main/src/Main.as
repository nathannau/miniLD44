package  
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenFadeTransitionManager;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	public class Main extends Sprite
	{
		/** Instance de Main */
		public static var instance: Main;
		
		public function Main() {
			instance = this;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}				
	}
}
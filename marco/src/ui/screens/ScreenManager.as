package ui.screens 
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenFadeTransitionManager;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScreenManager extends Sprite 
	{
		public static var instance: ScreenManager;
		
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenFadeTransitionManager;
		
		/*public var mainMenuScreen:MainMenuScreen;
		public var loadSaveScreen:LoadSaveScreen;
		public var storyScreen:StoryScreen;
		public var gameScreen:GameScreen;*/
		
		public var gameScreen:GameScreen;
		
		public function ScreenManager() 
		{
			instance = this;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//THEME
			//theme = new MetalWorksMobileTheme(null, false);
			
			//SCREEN NAVIGATOR
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			
			this._transitionManager = new ScreenFadeTransitionManager(this._navigator);
			this._transitionManager.duration = 0.7;
			
			//SCREENS
			gameScreen = new GameScreen();
			addScreen(gameScreen);
			
			
			showScreen(gameScreen);
			
		}
		
		public function addScreen(screen:BaseScreen):void
		{
			this._navigator.addScreen(screen.screenName, new ScreenNavigatorItem(screen));
		}
		
		public function showScreen(screen:BaseScreen):void
		{			
			if (this._navigator.activeScreen != null)
				(this._navigator.activeScreen as BaseScreen).onExit();
			
			this._navigator.showScreen(screen.screenName);
			screen.onEnter();
		}
		
	}

}
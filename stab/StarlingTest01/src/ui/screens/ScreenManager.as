package ui.screens 
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenFadeTransitionManager;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.Assets;
	import ui.feathers.themes.MetalWorksMobileTheme;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScreenManager extends Sprite 
	{
		public static var instance: ScreenManager;
		
		public var theme:MetalWorksMobileTheme;
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenFadeTransitionManager;
		
		public static var mainMenuScreen:MainMenuScreen;
		public static var storyScreen:StoryScreen;
		public static var gameScreen:GameScreen;
		
		public function ScreenManager() 
		{
			instance = this;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//THEME
			Assets.init();
			theme = new MetalWorksMobileTheme(null, false);
			
			//SCREEN NAVIGATOR
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			
			this._transitionManager = new ScreenFadeTransitionManager(this._navigator);
			this._transitionManager.duration = 0.7;
			
			//SCREENS
			mainMenuScreen = new MainMenuScreen();
			storyScreen = new StoryScreen();
			gameScreen = new GameScreen();
			
			addScreen(mainMenuScreen)
			addScreen(storyScreen);
			addScreen(gameScreen);
			
			//showScreen(mainMenuScreen);
			showScreen(gameScreen);
			
		}
		
		private function addScreen(screen:BaseScreen):void
		{
			this._navigator.addScreen(screen.screenName, new ScreenNavigatorItem(screen));
		}
		
		public static function showScreen(screen:BaseScreen):void
		{			
			if (ScreenManager.instance == null) return;
			
			if (ScreenManager.instance._navigator.activeScreen != null)
				(ScreenManager.instance._navigator.activeScreen as BaseScreen).onExit();
			
			ScreenManager.instance._navigator.showScreen(screen.screenName);
			screen.onEnter();
		}
		
	}

}
package  
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenFadeTransitionManager;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	 
	import screens.*;
	
	
	
	public class Main extends Sprite
	{
		/** Instance de Main */
		public static var instance: Main;
		
		/** Instance de Game */
		public static var game:Game;
		
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenFadeTransitionManager;
		
		public var theme:MetalWorksMobileTheme;
		
		public var mainMenuScreen:MainMenuScreen;
		public var loadSaveScreen:LoadSaveScreen;
		public var storyScreen:StoryScreen;
		public var gameScreen:GameScreen;
		
		public function Main() {
			instance = this;
			
			Ressource.init();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		protected function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//THEME
			theme = new MetalWorksMobileTheme(null, false);
			
			//SCREEN NAVIGATOR
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			
			this._transitionManager = new ScreenFadeTransitionManager(this._navigator);
			this._transitionManager.duration = 0.7;
			
			//SCREENS
			mainMenuScreen = new MainMenuScreen();
			loadSaveScreen = new LoadSaveScreen();
			storyScreen = new StoryScreen();
			gameScreen = new GameScreen();
			
			addScreen(mainMenuScreen);
			addScreen(loadSaveScreen);
			addScreen(storyScreen);
			addScreen(gameScreen);
			
			//SET DEFAULT SCREEN: MAIN MENU
			showScreen(mainMenuScreen);
			
			
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
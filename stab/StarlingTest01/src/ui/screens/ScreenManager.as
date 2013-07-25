package ui.screens 
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.core.DisplayListWatcher;
	import feathers.motion.transitions.ScreenFadeTransitionManager;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.Assets;
	import ui.feathers.themes.CustomTheme;
	import ui.feathers.themes.MetalWorksMobileTheme;
	
	/**
	 * ...
	 * @author 
	 */
	public class ScreenManager extends Sprite 
	{
		public static var instance: ScreenManager;
		
		public var theme:DisplayListWatcher;
		
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenFadeTransitionManager;
		
		/*public var mainMenuScreen:MainMenuScreen;
		public var loadSaveScreen:LoadSaveScreen;
		public var storyScreen:StoryScreen;
		public var gameScreen:GameScreen;*/
		
		public var mainMenuScreen:MainMenuScreen;
		public var storyScreen:StoryScreen;
		public var gameScreen:GameScreen;
		
		public function ScreenManager() 
		{
			instance = this;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//Assets.init();
		}
		
		protected function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//THEME
			theme = new CustomTheme(null, false);
			
			//SCREEN NAVIGATOR
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			
			this._transitionManager = new ScreenFadeTransitionManager(this._navigator);
			this._transitionManager.duration = 0.7;
			
			//SCREENS
			mainMenuScreen = new MainMenuScreen();
			storyScreen = new StoryScreen();
			gameScreen = new GameScreen();
			
			addScreen(mainMenuScreen);
			addScreen(storyScreen);
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
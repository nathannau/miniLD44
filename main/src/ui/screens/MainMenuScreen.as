package ui.screens 
{
	import controller.Game;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	import feathers.layout.VerticalLayout;
	import flash.media.SoundChannel;
	import flash.text.TextFormat;
	import starling.display.Image;
	import starling.display.Quad;
	import ui.Assets;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.EnterFrameEvent;
	
	
	
	public class MainMenuScreen extends BaseScreen
	{		
		private var _back:Image;
		private var _cog:Image;
		
		private var _layout: VerticalLayout;
		private var _container:ScrollContainer;
		
		private var _gameButton:Button;
		
		private var _musicChannel: SoundChannel;
		
		public function MainMenuScreen() {
			super();
			screenName = "MAINMENU";
		}
		
		override protected function onInitialize(event:Event):void
		{			
			trace("onInitialize", this);
			super.onInitialize(event);
			
			ScreenManager.instance.theme.setInitializerForClass( Button, mainMenuButtonInitializer, "mainMenuButton" );
			
			_back = new Image(Assets.atlas.getTexture("back"));
			addChild(_back);
			_back.pivotX = _back.width * 0.5;
			_back.pivotY = _back.height * 0.5;
			_back.x = stage.stageWidth * 0.5;
			_back.y = stage.stageHeight * 0.6;
			
			_cog = new Image(Assets.atlas.getTexture("bigCog"));
			addChild(_cog);
			
			_cog.pivotX = _cog.width / _cog.scaleX * 0.5;
			_cog.pivotY = _cog.height / _cog.scaleY * 0.5;
			_cog.x = stage.stageWidth * 0.5;
			_cog.y = stage.stageHeight * 0.4;
			
			var title:Image = new Image(Assets.atlas.getTexture("title"));
			addChild(title);
			
			title.pivotX = title.width * 0.5;
			title.pivotY = title.height * 0.5;
			title.x = stage.stageWidth * 0.5;
			title.y = stage.stageHeight * 0.3;
			
			
			//BUTTONS CONTAINER
			_layout = new VerticalLayout();
			
			_container = new ScrollContainer();
			_container.layout = _layout;
			addChild(_container);
			
			//NEW GAME
			_gameButton = new Button();	
			_gameButton.label = "New Game";
			_gameButton.nameList.add("mainMenuButton");			
			_gameButton.addEventListener(Event.TRIGGERED, gameButtonTriggered);
			_container.addChild(_gameButton);
			
			//LAYOUT
			_container.validate();
			_container.x = (stage.stageWidth - _container.width) * 0.5;
			_container.y = (stage.stageHeight - _container.height) * 0.5 + 100;
			
			_back.y = _container.y + _container.height - _back.height * 0.5 - 20;
			
			//_musicChannel = new SoundChannel();
			//_musicChannel.
			
			//_musicChannel = Ressource.music.
			
			
		}
		
		/**
		 * Custom theme for main menu buttons
		 * @param	button
		 */
		private function mainMenuButtonInitializer( button:Button ):void
		{
			var buttonImage:Image = new Image(Assets.atlas.getTexture("button"));
			var buttonDownImage:Image = new Image(Assets.atlas.getTexture("buttonDown"));
			
			button.height = 60;
			button.defaultSkin = buttonImage;
			button.downSkin = buttonDownImage;
		 
			button.defaultLabelProperties.textFormat = new TextFormat( "SourceSansProSemibold", 20, 0x433A29 );
		}
		
		/**
		 * 
		 */
		override public function onEnter():void
		{	
			if ( Main.instance.game == null) {
				_gameButton.label = "New Game";
			}
			else {
				_gameButton.label = "Continue";
			}
			
			_musicChannel = Assets.music.play(0, 9999);
			
		}
		
		/**
		 * 
		 */
		override public function onExit():void
		{
			_musicChannel.stop();
		}
		


		/**
		 * new game / continue button callback
		 * @param	event
		 */
		private function gameButtonTriggered(event:Event):void
		{
			if(Main.instance.game == null)
				Main.instance.game = new Game();
				
			ScreenManager.showScreen(ScreenManager.storyScreen);
		}
		
		/**
		 * EnterFrame callback
		 * @param	e
		 */
		override protected function onEnterFrame(e:EnterFrameEvent):void
		{
			_cog.rotation = Starling.juggler.elapsedTime;
			
		}
		
	}

}
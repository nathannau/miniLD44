package screens 
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.events.FeathersEventType;
	import feathers.layout.VerticalLayout;
	import flash.media.SoundChannel;
	import flash.text.TextFormat;
	import starling.display.Image;
	import starling.display.Quad;
	
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
		
		private var _newGameButton:Button;
		private var _continueButton:Button;
		private var _loadGameButton:Button;
		private var _saveGameButton:Button;
		
		private var _musicChannel: SoundChannel;
		
		public function MainMenuScreen() {
			super();
			screenName = "MAINMENU";
		}
		
		override protected function onInitialize(event:Event):void
		{			
			trace("onInitialize", this);
			super.onInitialize(event);
			
			//Main.instance.theme.setInitializerForClass( Button, mainMenuButtonInitializer, "mainMenuButton" );
			
			_back = new Image(Ressource.atlas.getTexture("back"));
			addChild(_back);
			_back.pivotX = _back.width * 0.5;
			_back.pivotY = _back.height * 0.5;
			_back.x = stage.stageWidth * 0.5;
			_back.y = stage.stageHeight * 0.6;
			
			_cog = new Image(Ressource.atlas.getTexture("bigCog"));
			addChild(_cog);
			
			_cog.pivotX = _cog.width / _cog.scaleX * 0.5;
			_cog.pivotY = _cog.height / _cog.scaleY * 0.5;
			_cog.x = stage.stageWidth * 0.5;
			_cog.y = stage.stageHeight * 0.4;
			
			var title:Image = new Image(Ressource.atlas.getTexture("title"));
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
			_newGameButton = new Button();		
			_newGameButton.label = "New Game";
			_newGameButton.nameList.add("mainMenuButton");			
			_newGameButton.addEventListener(Event.TRIGGERED, newGameTriggered);
			_container.addChild(_newGameButton);
			
			//CONTINUE
			_continueButton = new Button();
			_continueButton.label = "Continue";
			_continueButton.nameList.add("mainMenuButton");
			_continueButton.addEventListener(Event.TRIGGERED, continueTriggered);
			//_container.addChild(_continueButton);
			
			//LOAD
			_loadGameButton = new Button();
			_loadGameButton.label = "Load";
			_loadGameButton.nameList.add("mainMenuButton");
			_loadGameButton.addEventListener(Event.TRIGGERED, loadTriggered);
			_container.addChild(_loadGameButton);
			
			//SAVE
			_saveGameButton = new Button();
			_saveGameButton.label = "Save";
			_saveGameButton.nameList.add("mainMenuButton");
			_saveGameButton.addEventListener(Event.TRIGGERED, saveTriggered);
			//_container.addChild(_saveGameButton);
			
			//LAYOUT
			_container.validate();
			_container.x = (stage.stageWidth - _container.width) * 0.5;
			_container.y = (stage.stageHeight - _container.height) * 0.5 + 100;
			
			_back.y = _container.y + _container.height - _back.height * 0.5 - 20;
			
			//_musicChannel = new SoundChannel();
			//_musicChannel.
			
			//_musicChannel = Ressource.music.
			
			
		}
		
		override public function onEnter():void
		{
			var gameExists:Boolean = Main.game != null;
			
			if (gameExists) {
				_container.removeChild(_newGameButton);
				
				_container.addChild(_continueButton);
				_container.addChild(_loadGameButton);
				_container.addChild(_saveGameButton);
			}
			else {
				_container.removeChild(_continueButton);
				_container.removeChild(_saveGameButton);
				
				_container.addChild(_newGameButton);
				_container.addChild(_loadGameButton);
			}
			
			trace(_container.height);
			
			//_container.validate();
			//_container.y = (stage.stageHeight - _container.height) * 0.5 + 90;
			//_back.y = _container.y + _container.height - _back.height * 0.5 - 20;
			

			_musicChannel = Ressource.music.play(0, 9999);
			
		}
		
		override public function onExit():void
		{
			_musicChannel.stop();
		}
		
		/**
		 * Custom theme for main menu buttons
		 * @param	button
		 */
		private function mainMenuButtonInitializer( button:Button ):void
		{
			var buttonImage:Image = new Image(Ressource.atlas.getTexture("button"));
			var buttonDownImage:Image = new Image(Ressource.atlas.getTexture("buttonDown"));
			
			button.height = 60;
			button.defaultSkin = buttonImage;
			button.downSkin = buttonDownImage;
			//button.hoverSkin = new Image( hoverTexture );
		 
			button.defaultLabelProperties.textFormat = new TextFormat( "SourceSansProSemibold", 20, 0x433A29 );
		}

		/**
		 * new gale button callback
		 * @param	event
		 */
		private function newGameTriggered(event:Event):void
		{
			Main.instance.gameScreen.newGame();
			Main.instance.showScreen(Main.instance.storyScreen);
			//Main.instance.showScreen(Main.instance.gameScreen);
		}
		
		/**
		 * continue button callback
		 * @param	e
		 */
		private function continueTriggered(e:Event):void 
		{
			Main.instance.showScreen(Main.instance.gameScreen);
		}
		
		/**
		 * load button callback
		 * @param	e
		 */
		private function loadTriggered(e:Event):void 
		{
			Main.instance.showScreen(Main.instance.loadSaveScreen);
		}
		
		/**
		 * save button callback
		 * @param	e
		 */
		private function saveTriggered(e:Event):void 
		{
			Main.instance.showScreen(Main.instance.loadSaveScreen);
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
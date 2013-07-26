package ui.screens 
{
	import controller.Game;
	import feathers.controls.Button;
	import feathers.controls.ScrollContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.Assets;
	import ui.game.MapUI;
	import utils.Mine;
	import utils.Ressource;
	/**
	 * ...
	 * @author 
	 */
	public class MineScreen extends BaseScreen 
	{
		private var _container:ScrollContainer;
		private var _mineContainer:Sprite;
		private var _mine:Mine;
		
		public function MineScreen() 
		{
			super();
			screenName = "MINE";
		}
		
		override protected function onInitialize(event:Event):void
		{	
			super.onInitialize(event);
			
			_container = new ScrollContainer();
			addChild( _container );
			
			_container.width = Main.stageWidth;
			_container.height = 1024;
			
			_mineContainer = new Sprite();
			_container.addChild(_mineContainer);
			
			
			//BEGIN
			var backButton:Button = new Button();
			backButton.width = 54;
			backButton.height = 54;
			backButton.label = "->";
			addChild(backButton);
			
			backButton.x = stage.stageWidth - backButton.width - 5;
			backButton.y = 5;//stage.stageHeight - beginButton.height - 5;
			
			backButton.addEventListener(Event.TRIGGERED, backTriggered);
			
			
			_mine = Game.current.getMine(Game.current.getHumainPlayer());
			
		}
		
		override public function onEnter():void
		{
			_mineContainer.removeChildren();
			
			for (var i:uint = 0; i < _mine.width; i++)
			{
				for (var j:uint = 0; j < _mine.deep; j++)
				{
					var tile:Sprite = new Sprite();
					_mineContainer.addChild(tile);
					
					//if (_mine.isNowAccessible(i, j))
					if (true)//_mine.isAccessible(i,j))
					{
						var tileBack:Image = new Image(Assets.atlas.getTexture("tile_marais"));
						tile.addChild(tileBack);
						
						var res:Ressource = _mine.getCaseAt(i, j);
						var imgRes:Image = new Image(Assets.atlas.getTexture(res.nom));
						
						tile.addChild(imgRes);
					}
					
					
					
					tile.x = i * MapUI.BASE_SIZE;
					tile.y = j * MapUI.BASE_SIZE;
					
					
				}
			}
			
			_mineContainer.x = (Main.stageWidth - _mineContainer.width) * 0.5;
			
		}
		
		private function backTriggered(event:Event):void
		{
			ScreenManager.instance.showScreen(ScreenManager.instance.gameScreen);
		}
		
	}

}
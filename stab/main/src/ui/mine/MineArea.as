package ui.mine 
{
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import ui.Assets;
	import ui.game.MapUI;
	import ui.TouchZone;
	import utils.Mine;
	import controller.Game;
	
	/**
	 * ...
	 * @author 
	 */
	public class MineArea extends TouchZone 
	{
		private var _mineContainer:Sprite;
		private var _mine:Mine;
		
		private var _tiles:Array;
		
		private var _currentTaskImg:Image;
		
		public function MineArea() 
		{	
			super();
			scrollHorizontal = false;
			scrollMaxY = 900;
			
			_tiles = new Array();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var img:Quad = new Quad(Main.stageWidth, 200, 0x99b6ad);
			addChild(img);
			
			_mineContainer = new Sprite();
			addChild(_mineContainer);
			
			_mineContainer.y = 200;
			
			
			_mine = Game.current.getMine(Game.current.getHumainPlayer());
			
			for (var i:uint = 0; i < _mine.width; i++)
			{
				for (var j:uint = 0; j < _mine.deep; j++)
				{
					_tiles[j * _mine.width + i] = _mineContainer.addChild(new MineTile(_mine, i, j)) as MineTile;
					
					
					
				}
			}
			
			_mineContainer.x = (Main.stageWidth - _mineContainer.width) * 0.5;
			
			_currentTaskImg = new Image(Assets.atlas.getTexture("drill"));
			_currentTaskImg.pivotX = _currentTaskImg.pivotY = 27;
			_currentTaskImg.scaleX = _currentTaskImg.scaleY = 0.6;
			
			_mineContainer.addChild(_currentTaskImg);
			_currentTaskImg.visible = false;
			
		}
		
		private function onEnterFrame(e:Event):void 
		{
			update();
			
			if (_mine.tasks.length > 0) {
				_currentTaskImg.visible = true;
				_currentTaskImg.x = MapUI.BASE_SIZE * (_mine.tasks[0].x + 0.5);
				_currentTaskImg.y = MapUI.BASE_SIZE * (_mine.tasks[0].d + 0.5);
			}
			else {
				_currentTaskImg.visible = false;
			}
		}
		
		public function update():void
		{
			for (var i:uint = 0; i < _tiles.length; i++) 
			{
				_tiles[i].update();
			}
		}
		
		override protected function onTouchTap(p:Point, obj:DisplayObject):void
		{
			if (!obj.parent is MineTile) return;
			
			var tile:MineTile = obj.parent as MineTile;
			if (tile==null) return;
			
			
			trace(tile.tx, tile.ty);
			
			_mine.addTask(tile.tx, tile.ty)
		}
		
	}

}
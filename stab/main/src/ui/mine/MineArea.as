package ui.mine 
{
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
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
		
		public function MineArea() 
		{	
			super();
			scrollHorizontal = false;
			
			_tiles = new Array();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var img:Quad = new Quad(Main.stageWidth, 200, 0xE0F0FF);
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
			
		}
		
		private function onEnterFrame(e:Event):void 
		{
			update();
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
			
			//trace(tile.tx, tile.ty);
			
			if (_mine.addTask(tile.tx, tile.ty))
				tile.setSelected(true);
		}
		
	}

}
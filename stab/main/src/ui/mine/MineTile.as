package ui.mine 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.Mine;
	import utils.Ressource;
	
	import ui.game.MapUI;
	
	import ui.Assets;
	
	/**
	 * ...
	 * @author Stab
	 */
	public class MineTile extends Sprite 
	{
		private var _mine:Mine;
		
		private var _tx:uint;
		public function get tx():uint { return _tx; }
		
		private var _ty:uint;
		public function get ty():uint { return _ty; }
		
		public function MineTile(mine:Mine, x:uint, y:uint) 
		{
			_mine = mine;
			_tx = x;
			_ty = y;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			update();
			
			x = _tx * MapUI.BASE_SIZE;
			y = _ty * MapUI.BASE_SIZE;
		}
		
		public function update():void
		{
			removeChildren();
			if (_mine.isAccessible(_tx,_ty))
			{
				var tileBack:Image = new Image(Assets.atlas.getTexture("tile_marais"));
				addChild(tileBack);
				//tileBack.touchable = false;
				
				var res:Ressource = _mine.getCaseAt(_tx, _ty);
				var imgRes:Image = new Image(Assets.atlas.getTexture(res.nom));
				addChild(imgRes);
				imgRes.touchable = false;

			}
			else {
				var tileBack:Image = new Image(Assets.atlas.getTexture("tile_black"));
				addChild(tileBack);
			}
			
			
		}
		
	}

}
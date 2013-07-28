package ui.mine 
{
	import starling.display.Image;
	import starling.display.Quad;
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
		
		private var _container:Sprite;
		
		private var _selected:Boolean;
		
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
			
			_container = new Sprite();
			addChild(_container);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			update();
			
			//_container = new Sprite();
			//addChild(_container);
			
			var quad:Quad = new Quad(MapUI.BASE_SIZE, MapUI.BASE_SIZE);
			quad.alpha = 0;
			addChild(quad);
			
			x = _tx * MapUI.BASE_SIZE;
			y = _ty * MapUI.BASE_SIZE;
		}
		
		public function update():void
		{
			_container.removeChildren();
			var tileBack:Image;
			if (_mine.isAccessible(_tx,_ty))
			{
				if (_selected)
					tileBack = new Image(Assets.atlas.getTexture("mineTile_selected"));
				else
					tileBack = new Image(Assets.atlas.getTexture("mineTile_available"));
				_container.addChild(tileBack);
				tileBack.touchable = false;
				
				/*
				var res:Ressource = _mine.getCaseAt(_tx, _ty);
				if (res != null) {
					var imgRes:Image = new Image(Assets.atlas.getTexture(res.nom));
					_container.addChild(imgRes);
					imgRes.touchable = false;
				}*/
				
			}
			else {
				tileBack = new Image(Assets.atlas.getTexture("mineTile_normal"));
				_container.addChild(tileBack);
				tileBack.touchable = false;
			}
			
			var res:Ressource = _mine.getCaseAt(_tx, _ty);
			if (res != null) {
				var imgRes:Image = new Image(Assets.atlas.getTexture(res.nom));
				_container.addChild(imgRes);
				imgRes.touchable = false;
				
				//if (res == Ressource.TERRE)
				//	imgRes.alpha = 0.3;
			}
			
			
		}
		
		public function setSelected(value:Boolean):void
		{
			/*var tileBack:Image = new Image(Assets.atlas.getTexture("tile_montagne"));
			_container.addChild(tileBack);
			tileBack.touchable = false;*/
			_selected = value;
		}
		
	}

}
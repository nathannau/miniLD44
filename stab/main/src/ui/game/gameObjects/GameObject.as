package ui.game.gameObjects 
{
	import feathers.display.Scale9Image;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.Assets;
	import ui.CullingSprite;
	import ui.game.MapUI;
	import utils.*;
	
	public class GameObject extends Sprite//CullingSprite 
	{		
		protected var _element:Element;
		public function get element():Element { return _element;}
		
		public var sizeX:int = 1;
		public var sizeY:int = 1;

		protected var _quad:Quad;
		
		protected var _container:Sprite;
		
		private var _selected:Boolean = false;
		protected var _selectImg:Scale9Image;
		
		/*
		private var _state:String = State.IDLE;
		private var _moveTo:Point;
		private var _moveToObject:GameObject;*/
		
		public static function getGameObjectClass(e:Class):Class {
			
			switch(e)
			{
				case ElementCaserne:		return GCaserne;					
				case ElementCentreDeTir:	return GCentreDeTir;
				case ElementElevageWaark:	return GElevageWaark;
				case ElementLaboratoire:	return GBuilding;
				case ElementRelais:			return GBuilding;
					
				case ElementCentreDeForage:	return GMine;
					
				case ElementSoldat:
				case ElementFusilleur:
				case ElementChevaucheur:
					return GUnit;
					
				
				
			}
			
			return null;
		}
		
		public function GameObject(e:Element) 
		{
			_element = e;			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//trace(sizeX, sizeY);
			
			_container = new Sprite();
			_container.x =  -MapUI.BASE_SIZE * 0.5 * (sizeX - 1);
			_container.y =  -MapUI.BASE_SIZE * 0.5 * (sizeY - 1);
			
			addChild(_container);
	
			_quad = new Quad(sizeX * MapUI.BASE_SIZE, sizeY * MapUI.BASE_SIZE, 0xFF8020);
			//_quad.alpha = 0;
			_quad.x =  -MapUI.BASE_SIZE * 0.5 * (sizeX - 1);
			_quad.y =  -MapUI.BASE_SIZE * 0.5 * (sizeY - 1);
			addChild(_quad);
			
			//var mc:MovieClip = new MovieClip(Assets.atlas.getTextures(gfxName));
			//addChild(mc);
			
			_selectImg = new Scale9Image(new Scale9Textures(Assets.atlas.getTexture("selection"), new Rectangle(18, 18, 18, 18)));
			addChild(_selectImg);
			_selectImg.width = sizeX * MapUI.BASE_SIZE;
			_selectImg.height = sizeY * MapUI.BASE_SIZE;
			_selectImg.x =  -MapUI.BASE_SIZE * 0.5 * (sizeX - 1);
			_selectImg.y =  -MapUI.BASE_SIZE * 0.5 * (sizeY - 1);
			
			_selectImg.visible = false;
			
		}
		
		public function setSelected(sel:Boolean):void
		{
			_selected = sel;
			/*
			if (_selected)
			{
				_quad.color = 0xFFA050;
			}
			else
			{
				_quad.color = 0xFF8020;
			}*/
			_selectImg.visible = _selected;
		}
		
		/*
		public function setTarget(p:Point, obj:GameObject):void
		{
			_moveTo = p;
			_moveToObject = obj;
			
			_state = State.MOVING;
		}*/
		
		public function update(delta:Number):void
		{
			//if(_element.animation != null)
			//	trace(_element.animation.nom);
			
			x = _element.x * MapUI.BASE_SIZE;
			y = _element.y * MapUI.BASE_SIZE;
			
			alpha = _element.available ? 1: 0.5;
			
			/*
			switch(_state)
			{
				case State.IDLE:
					break;
					
				case State.MOVING:
					var dir:Point = new Point(_moveTo.x - x, _moveTo.y - y);
					if (dir.length > 54)
					{
						dir.normalize(1);
						
						x += dir.x * delta * 100;
						y += dir.y * delta * 100;
					}
					else
					{
						_state = State.IDLE;
						
					}
					
					
			}*/
		}
		
		public function hasStore():Boolean {
			return false;
		}
		
		public function getStoreItems():Array
		{
			return [];
		}
		
	}

}
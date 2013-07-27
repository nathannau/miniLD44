package ui.game 
{
	import controller.Game;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import ui.game.gameObjects.GameObject;
	import utils.Element;
	import utils.ElementBatiment;
	import utils.ElementCentreDeForage;
	import utils.Mine;
	import utils.TypeElement;
	import vues.humain.Player;
	import vues.IPlayer;
	/**
	 * ...
	 * @author Stab
	 */
	public class GameArea extends Sprite
	{
		//private var _container:Sprite;
		private var _player:Player;
		
		private var _map:MapUI;
		private var _objects: Vector.<GameObject>;
		
		//public var selection:Vector.<GameObject>;
		
		//TOUCH DEBUG
		private var _touchesQuad:Object;
		
		//scroll start point
		private var _touchPos: Point;
		
		private var _touchActive:Boolean = false;
		private var _touchMulti:Boolean = false;
		private var _touchObject:GameObject = null;
		private var _touchTime:Number;
		private var _touchMoved:Boolean;

		private var _touchHolded:Boolean = false;
		
		private const TOUCH_HOLD_TIME:Number = 500;
		
		public function GameArea(player:Player) 

		{			
			_player = player;
			
			_map = new MapUI();
			addChild(_map);
			
			_objects = new Vector.<GameObject>();
			

			//
			_touchesQuad = new Object();
			
			//selection = new Vector.<GameObject>();
			
			//events
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function onStart():void
		{
			var i:uint;
			
			var elements:Array = Game.current.getElements();
			for (i = 0; i < elements.length; i++)
			{
				var element:Element = elements[i];				
				addElement(element);
			}
			
			gotoMine();
		}
		
		public function addElement(element:Element):void
		{
			var cls:Class = GameObject.getGameObjectClass(element.type.className);
			var obj:GameObject = new cls(element);
			addChild(obj);
			
			obj.x = element.x * MapUI.BASE_SIZE;
			obj.y = element.y * MapUI.BASE_SIZE;
			
			_objects.push(obj);
		}
		
		public function getObjectsInRect(r:Rectangle):Vector.<GameObject>
		{
			var res:Vector.<GameObject> = new Vector.<GameObject>();
			for (var i:uint = 0; i < _objects.length; i++)
			{
				var obj:GameObject = _objects[i];
				if (r.x > obj.x + obj.width || r.x + r.width < obj.x || r.y > obj.y + obj.height || r.y + r.height < obj.y) continue;
				
				res.push(obj);
			}
			return res;
		}
		
		public function centerXY(cx:Number, cy:Number):void 
		{
			trace(cx, cy);
			
			cx -= Main.stageWidth * 0.5;
			cy -= Main.stageHeight * 0.5;
			
			x = Math.min(0, Math.max(-MapUI.BASE_SIZE * Game.current.map.width + stage.stageWidth, -cx));
			y = Math.min(0, Math.max( -MapUI.BASE_SIZE * Game.current.map.height + stage.stageHeight, -cy));
			
			trace(x, y);
		}
		
		
		public function gotoMine():void
		{
			var mine:Element = Game.current.getElementsV2( { player:_player, types: [TypeElement.CENTRE_DE_FORAGE] })[0];
			centerXY(mine.x * MapUI.BASE_SIZE, mine.y * MapUI.BASE_SIZE);
			
			/*
			trace(Game.current.getElements(_player, [TypeElement.CENTRE_DE_FORAGE]));
			trace(Game.current.getElements(TypeElement.CENTRE_DE_FORAGE));
			
			var a:Array = Game.current.getElements(TypeElement.CENTRE_DE_FORAGE);
			trace(a);
			
			trace(Game.current.getElements());*/
		}
		
		//==================================================================================================
		protected function onEnterFrame(e:EnterFrameEvent):void
		{
			var delta:Number = e.passedTime;
			
			for (var i:uint = 0; i < _objects.length; i++)
			{
				var obj:GameObject = _objects[i];
				obj.update(delta);
			}
			
			if (_touchActive && !_touchMoved && !_touchMulti) 
			{
				var totalTime:Number = new Date().getTime() - _touchTime;
				if (totalTime > TOUCH_HOLD_TIME)
				{
					onTouchHold(_touchPos, _touchObject);
				}
			}
		}
		
		
		
		//==================================================================================================
		//TOUCH FUNCTIONS
		protected function onTouch(e:TouchEvent):void
		{
			//trace(e);
			var touches:Vector.<Touch> = e.getTouches(this);
			
			debugTouches(touches);
			
			if (touches.length == 1)
			{
				onTouchSolo(touches[0]);
			}
			else
			{
				onTouchMulti(touches);
			}
			
			//trace(touches);
		}
		
		private function onTouchSolo(touch:Touch):void 
		{
			var p:Point;
			
			//trace(touch);
			
			
			switch(touch.phase)
			{
				case "began":
					p = touch.getLocation(this.parent);
					_touchPos = new Point(p.x - x, p.y - y);
					
					_touchObject = null;
					if(touch.target.parent is GameObject)
						_touchObject = touch.target.parent as GameObject;
					
					_touchTime = new Date().getTime();
					_touchActive = true;
					_touchMoved = false;
					
					break;
					
				case "moved":
					p = touch.getLocation(this.parent);
					
					x = Math.min(0, Math.max(-MapUI.BASE_SIZE * Game.current.map.width + stage.stageWidth, p.x - _touchPos.x));
					y = Math.min(0, Math.max( -MapUI.BASE_SIZE * Game.current.map.height + stage.stageHeight, p.y - _touchPos.y));
					
					_touchMoved = true;
					break;
					
				case "ended":
					_touchActive = false;
					_touchHolded = false;
					
					if (!_touchMoved)
					{
						var totalTime:Number = new Date().getTime() - _touchTime;
						if (totalTime < TOUCH_HOLD_TIME)
							onTouchTap(_touchPos, _touchObject);
						
						//_touchObject = null;	
					}
					
						
					break;
			}
		}
		
		private function onTouchMulti(touches:Vector.<Touch>):void 
		{
			if (touches.length == 2) 
			{
				_touchMulti = true;
				
				if (touches[0].phase == "ended" || touches[1].phase == "ended")
				{
					var posA:Point = touches[0].getLocation(this);
					var posB:Point = touches[1].getLocation(this);
					
					var minX:Number = Math.min(posA.x, posB.x);
					var maxX:Number = Math.max(posA.x, posB.x);
					var minY:Number = Math.min(posA.y, posB.y);
					var maxY:Number = Math.max(posA.y, posB.y);
					
					var r:Rectangle = new Rectangle(minX, minY, maxX - minX, maxY - minY);
					
					onTouchZone(r);
					_touchMulti = false;
				}
				
				
			}
		}
		
		//-----------------------------------------------------------------------------
		private function onTouchTap(p:Point, obj:GameObject):void
		{
			trace("TAP", p, obj);
			
			if (_player.placeBuildingMode)
			{
				placeBuildingTouchTap(p);
				return;
			}
			
			if (obj != null)
			{
				var objIndex:int = _player.selection.indexOf(obj);
				if (objIndex != -1)
				{
					_player.selection.splice(objIndex, 1);
					obj.setSelected(false);
				}
				else
				{
					_player.selection.push(obj);
					obj.setSelected(true);
				}
			}
			else
			{
				for (var i:uint = 0; i < _player.selection.length; i++ )
				{
					_player.selection[i].setSelected(false);
				}
				_player.selection.length = 0;
			}
			
			_player.updateSelection();
		}
		
		private function onTouchHold(p:Point, obj:GameObject):void 
		{
			if (_touchHolded) return;
			_touchHolded = true;
			
			if (_player.placeBuildingMode)
			{
				return;
			}
			
			trace("HOLD", p, obj);
			
			for (var i:uint = 0; i < _player.selection.length; i++ )
			{
				if(_player.selection[i].element.player == _player)
					Game.current.moveElement(_player.selection[i].element, p.x / MapUI.BASE_SIZE, p.y / MapUI.BASE_SIZE);
			}
			
			_player.updateSelection();
		}
		
		private function onTouchZone(r:Rectangle):void
		{
			trace("ZONE", r);
			
			if (_player.placeBuildingMode)
			{
				return;
			}
			
			
			
			var i:uint;
			
			for (i = 0; i < _player.selection.length; i++ )
			{
				_player.selection[i].setSelected(false);
			}
			_player.selection = getObjectsInRect(r);
			_player.updateSelection();
			for (i = 0; i < _player.selection.length; i++ )
			{
				_player.selection[i].setSelected(true);
			}
		}
		
		//-----------------------------------------------------------------------------
		private function debugTouches(touches:Vector.<Touch>):void 
		{
			var quad:Quad;
			var p:Point;
			
			for (var i:int = 0; i < touches.length; i++)
			{
				var touch:Touch = touches[i];
				switch(touch.phase)
				{
					case "began":
					quad = new Quad(27, 27, 0xFF0000);
					quad.pivotX = quad.width * 0.5;
					quad.pivotY = quad.height * 0.5;
					addChild(quad);
					
					p = touch.getLocation(this);
					
					quad.x = p.x;
					quad.y = p.y;
					
					_touchesQuad[touch.id] = quad;
					break;
					
				case "moved":
					quad = _touchesQuad[touch.id];
					p = touch.getLocation(this);
					quad.x = p.x;
					quad.y = p.y;
					break;
					
				case "ended":
					removeChild(_touchesQuad[touch.id]);
					delete _touchesQuad[touch.id];
					
					break;
				}
			}
		}
		
		private var _buildingPos:Point;
		private var _buildingGhost:Quad;
		private function placeBuildingTouchTap(p:Point):void
		{
			var tx:uint = Math.floor(p.x / MapUI.BASE_SIZE);
			var ty:uint = Math.floor(p.y / MapUI.BASE_SIZE);
			
			trace(tx, ty);
			
			var size:uint = 2;
			
			if (_buildingPos != null && _buildingPos.x == tx && _buildingPos.y == ty)
			{
				//BUILD
				_buildingPos = null;
				removeChild(_buildingGhost);
				_buildingGhost = null;
				
				if (Game.current.getElementsV2( { rectangle: { minX:tx, minY:ty, maxX:tx + size-1, maxY:ty + size-1 }} ).length == 0)
					_player.validateBuild(tx, ty);
				
			}
			else
			{
				//PLACE GHOST
				_buildingPos = new Point(tx, ty);
				
				if (_buildingGhost == null)
				{
					//var size:uint = (_player.placeBuidingType as ElementBatiment).size;
					
					
					_buildingGhost = new Quad(MapUI.BASE_SIZE * size, MapUI.BASE_SIZE * size, 0xA0FFFF);
					_buildingGhost.alpha = 0.5;
					addChild(_buildingGhost);
					
					
				}
				
				_buildingGhost.x = tx * MapUI.BASE_SIZE;
				_buildingGhost.y = ty * MapUI.BASE_SIZE;
				
				if (Game.current.getElementsV2({rectangle: { minX:tx, minY:ty, maxX:tx+size-1, maxY:ty+size-1 }}).length)
				{
					_buildingGhost.color = 0xFF0000
				}
				else
				{
					_buildingGhost.color = 0xA0FFFF;
				}
				
				
				
			}
		}
		
		public function closePlaceBuilding():void
		{
			if (_buildingGhost != null) 
			{
				removeChild(_buildingGhost);
				_buildingGhost = null;
				_buildingPos = null;
			}
		}
		
	}

}
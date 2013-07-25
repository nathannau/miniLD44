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
	/**
	 * ...
	 * @author Stab
	 */
	public class GameArea extends Sprite
	{
		//private var _container:Sprite;
		
		private var _map:Map;
		private var _objects: Vector.<GameObject>;
		
		public var selection:Vector.<GameObject>;
		
		//TOUCH DEBUG
		private var _touchesQuad:Object;
		
		//scroll start point
		private var _touchPos: Point;
		
		private var _touchActive:Boolean = false;
		private var _touchMulti:Boolean = false;
		private var _touchObject:GameObject = null;
		private var _touchTime:Number;
		private var _touchMoved:Boolean;
		
		private const TOUCH_HOLD_TIME:Number = 500;
		
		public function GameArea() 
		{
			//_container = new Sprite();
			//addChild(_container);
			
			_map = new Map();
			addChild(_map);
			
			_objects = new Vector.<GameObject>();
			
			for (var i:uint = 0; i < 100; i++)
			{
				var obj:GameObject = new GameObject();
				addChild(obj);
				
				obj.x = Math.random() * 60 * 54;
				obj.y = Math.random() * 60 * 54;
				
				_objects.push(obj);
			}
			
			
			_touchesQuad = new Object();
			
			selection = new Vector.<GameObject>();
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(TouchEvent.TOUCH, onTouch);
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
					
					x = Math.min(0, Math.max(-Map.BASE_SIZE * Game.current.map.width + stage.stageWidth, p.x - _touchPos.x));
					y = Math.min(0, Math.max( -Map.BASE_SIZE * Game.current.map.height + stage.stageHeight, p.y - _touchPos.y));
					
					_touchMoved = true;
					break;
					
				case "ended":
					_touchActive = false;
					
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
			
			if (obj != null)
			{
				var objIndex:int = selection.indexOf(obj);
				if (objIndex != -1)
				{
					selection.splice(objIndex, 1);
					obj.setSelected(false);
				}
				else
				{
					selection.push(obj);
					obj.setSelected(true);
				}
			}
			else
			{
				for (var i:uint = 0; i < selection.length; i++ )
				{
					selection[i].setSelected(false);
				}
				selection = new Vector.<GameObject>();
			}
		}
		
		private function onTouchHold(p:Point, obj:GameObject):void 
		{
			trace("HOLD", p, obj);
			
			for (var i:uint = 0; i < selection.length; i++ )
			{
				selection[i].setTarget(p, null);
			}
		}
		
		private function onTouchZone(r:Rectangle):void
		{
			trace("ZONE", r);
			
			
			
			var i:uint;
			
			for (i = 0; i < selection.length; i++ )
			{
				selection[i].setSelected(false);
			}
			selection = getObjectsInRect(r);
			for (i = 0; i < selection.length; i++ )
			{
				selection[i].setSelected(true);
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
		
	}

}
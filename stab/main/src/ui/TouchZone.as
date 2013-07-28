package ui 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class TouchZone extends Sprite 
	{
		public var scrollHorizontal:Boolean = true;
		public var scrollVertical:Boolean = true;
		
		public var scrollMaxY:Number = -1;
		
		private var _touchesQuad:Object;
		
		private var _touchPos: Point;
			
		private var _touchActive:Boolean = false;
		private var _touchMulti:Boolean = false;
		private var _touchObject:DisplayObject = null;
		private var _touchTime:Number;
		private var _touchMoved:Boolean;

		private var _touchHolded:Boolean = false;
		
		private const TOUCH_HOLD_TIME:Number = 500;
		
		public function TouchZone() 
		{
			_touchesQuad = new Object();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (_touchActive && !_touchMoved && !_touchMulti) 
			{
				var totalTime:Number = new Date().getTime() - _touchTime;
				if (totalTime > TOUCH_HOLD_TIME)
				{
					onTouchHold(_touchPos, _touchObject);
				}
			}
		}
		
		private function onTouch(e:TouchEvent):void 
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
		
		protected function getTouchObject(touch:Touch):DisplayObject
		{
			return touch.target;
		}
		
		protected function onTouchSolo(touch:Touch):void 
		{
			var p:Point;
			
			//trace(touch);
			
			
			switch(touch.phase)
			{
				case "began":
					p = touch.getLocation(this.parent);
					_touchPos = new Point(p.x - x, p.y - y);
					
					_touchObject = getTouchObject(touch);
					
					_touchTime = new Date().getTime();
					_touchActive = true;
					_touchMoved = false;
					
					break;
					
				case "moved":
					p = touch.getLocation(this.parent);
					
					if(scrollHorizontal) x = Math.min(0, Math.max(-this.width, p.x - _touchPos.x));
					if (scrollVertical)
					{
<<<<<<< HEAD
						var scrollMax:Number = -this.height;
=======
						var scrollMax = -this.height;
>>>>>>> origin/Nathan
						if (scrollMaxY != -1) scrollMax = -scrollMaxY;
						
						y = Math.min(0, Math.max(scrollMax, p.y - _touchPos.y));
					}
					
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
		
		protected function onTouchMulti(touches:Vector.<Touch>):void 
		{
			/*
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
				
				
			}*/
		}
		
		//-----------------------------------------------------------------------------
		protected function onTouchTap(p:Point, obj:DisplayObject):void
		{
			trace("TAP", p, obj);
			
			/*
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
			}*/
		}
		
		protected function onTouchHold(p:Point, obj:DisplayObject):void 
		{
			if (_touchHolded) return;
			_touchHolded = true;
			
			trace("HOLD", p, obj);
			
			/*
			for (var i:uint = 0; i < selection.length; i++ )
			{
				if(selection[i].element.player == _player)
					Game.current.moveElement(selection[i].element, p.x / MapUI.BASE_SIZE, p.y / MapUI.BASE_SIZE);
			}*/
		}
		
		protected function onTouchZone(r:Rectangle):void
		{
			trace("ZONE", r);
			
			
			/*
			var i:uint;
			
			for (i = 0; i < selection.length; i++ )
			{
				selection[i].setSelected(false);
			}
			selection = getObjectsInRect(r);
			for (i = 0; i < selection.length; i++ )
			{
				selection[i].setSelected(true);
			}*/
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
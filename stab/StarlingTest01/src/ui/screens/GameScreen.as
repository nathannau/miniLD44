package ui.screens 
{
	import controller.Game;
	import feathers.controls.Button;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import ui.Assets;
	import ui.game.gameObjects.GameObject;
	import ui.game.GameUI;
	import ui.game.Map;
	import vues.humain.Player;

	public class GameScreen extends BaseScreen 
	{
		public var container:Sprite;
		public var gameUI:GameUI;
		//public var view:Player;
		
		public var selection:Vector.<GameObject>;
		
		//TOUCH DEBUG
		private var _touchesQuad:Object;
		
		//scroll start point
		private var _touchPos: Point;
		
		//touch start time
		private var _touchActive:Boolean = false;
		private var _touchMulti:Boolean = false;
		private var _touchObject:GameObject = null;
		private var _touchTime:Number;
		private var _touchMoved:Boolean;
		
		private const TOUCH_HOLD_TIME:Number = 500;
		
		
		
		public function GameScreen() 
		{
			super();
			screenName = "GAME";
			
			_touchesQuad = new Object();
			
			selection = new Vector.<GameObject>();
		}
		
		
		override protected function onInitialize(event:Event):void
		{	
			
			//map = new Map();
			//addChild(map);
			
			container = new Sprite();
			addChild(container);
			
			
			var butPause:Button = new Button();
			butPause.defaultIcon = new Image(Assets.atlas.getTexture("pause"));
			butPause.nameList.add("smallButton");
			addChild(butPause);
			butPause.x = Main.stageWidth - butPause.width - 5;
			butPause.y = 5;
			butPause.addEventListener(Event.TRIGGERED, function(e:Event):void { ScreenManager.instance.showScreen(ScreenManager.instance.mainMenuScreen); } );
			
			
			/*
			var butPause: Image = new Image(Assets.atlas.getTexture("pause"));
			butPause.x = Main.stageWidth - butPause.width - 5;
			butPause.y = 5;
			butPause.addEventListener(Event.TRIGGERED, function(e:Event):void { ScreenManager.instance.showScreen(ScreenManager.instance.mainMenuScreen); } );
			addChild(butPause);*/
		}
		
		private function initUI():void
		{
			gameUI = new GameUI(Main.instance.game);
			container.addChild(gameUI);
			//view = new
			
			/*var quad:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x202020);
			quad.alpha = 0;
			addChild(quad);*/
			
			container.addEventListener(TouchEvent.TOUCH, onTouch);
			
		}
		
		override public function onEnter():void
		{
			
			if (gameUI == null)
				initUI();
				
			/*
			if (!Game.current.isStarted)
				Game.current.start();
			else
				Game.current.resume();
			*/
		}
		
		override public function onExit():void
		{
			//Game.current.pause();
		}
		
		override protected function onEnterFrame(e:EnterFrameEvent):void
		{
			gameUI.update(e.passedTime);
			
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
				//for (var touch:Touch in touches)
				/*
				for (var i:int = 0; i < touches.length; i++)
				{
					onTouchSolo(touches[i]);
				}*/
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
					p = touch.getLocation(this);
					_touchPos = new Point(p.x - gameUI.x, p.y - gameUI.y);
					
					_touchObject = null;
					if(touch.target.parent is GameObject)
						_touchObject = touch.target.parent as GameObject;
					
					_touchTime = new Date().getTime();
					_touchActive = true;
					_touchMoved = false;
					
					break;
					
				case "moved":
					p = touch.getLocation(this);
					
					gameUI.x = Math.min(0, Math.max(-Map.BASE_SIZE * Game.current.map.width + stage.stageWidth, p.x - _touchPos.x));
					gameUI.y = Math.min(0, Math.max( -Map.BASE_SIZE * Game.current.map.height + stage.stageHeight, p.y - _touchPos.y));
					
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
					var posA:Point = touches[0].getLocation(gameUI);
					var posB:Point = touches[1].getLocation(gameUI);
					
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
			selection = gameUI.getObjectsInRect(r);
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
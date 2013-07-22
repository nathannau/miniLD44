package ui.screens 
{
	import flash.geom.Point;
	import starling.display.Quad;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import ui.game.GameUI;
	import ui.game.Map;

	public class GameScreen extends BaseScreen 
	{
		public var gameUI:GameUI;
		
		private var _dragPos: Point;
		private var _touchesQuad:Object;
		
		
		
		public function GameScreen() 
		{
			super();
			screenName = "GAME";
			
			_touchesQuad = new Object();
		}
		
		
		override protected function onInitialize(event:Event):void
		{	
			
			//map = new Map();
			//addChild(map);
		}
		
		private function initUI():void
		{
			gameUI = new GameUI(Main.instance.game);
			addChild(gameUI);
			
			var quad:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x202020);
			quad.alpha = 0;
			addChild(quad);
			
			quad.addEventListener(TouchEvent.TOUCH, onTouch);
			
		}
		
		override public function onEnter():void
		{
			if (gameUI == null)
				initUI();
		}
		
		override public function onExit():void
		{
			
		}
		
		override protected function onEnterFrame(e:EnterFrameEvent):void
		{
			
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
					quad = new Quad(54, 54, 0xFF0000);
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
		
		private function onTouchSolo(touch:Touch):void 
		{
			var p:Point;
			
			switch(touch.phase)
			{
				case "began":
					p = touch.getLocation(this);
					_dragPos = new Point(p.x - gameUI.x, p.y - gameUI.y);					
					break;
					
				case "moved":
					p = touch.getLocation(this);
					
					gameUI.x = Math.min(0, Math.max(-Map.BASE_SIZE * 60 + stage.stageWidth, p.x - _dragPos.x));
					gameUI.y = Math.min(0, Math.max(-Map.BASE_SIZE * 60 + stage.stageHeight, p.y - _dragPos.y));
					break;
					
				case "ended":

					break;
			}
		}
		
		private function onTouchMulti(touches:Vector.<Touch>):void 
		{

		}
		
	}

}
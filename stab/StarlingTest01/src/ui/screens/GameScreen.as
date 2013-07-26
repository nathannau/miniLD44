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
	import ui.game.MapUI;
	import vues.humain.Player;

	public class GameScreen extends BaseScreen 
	{
		public var container:Sprite;
		//public var gameUI:GameUI;
		public var view:Player;
		
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
			addChild(Game.current.getHumainPlayer());
		}
		

		
		override public function onEnter():void
		{
			if (Game.current.isPaused) Game.current.resume();
		}
		
		override public function onExit():void
		{
			Game.current.pause();
		}
	}

}
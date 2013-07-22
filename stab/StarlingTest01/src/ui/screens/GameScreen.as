package ui.screens 
{
	import starling.display.Quad;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import ui.game.Game;

	public class GameScreen extends BaseScreen 
	{
		public var game:Game;
		public function GameScreen() 
		{
			super();
			screenName = "GAME";
		}
		
		override protected function onInitialize(event:Event):void
		{	
			//var quad:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x202020);
			//addChild(quad);
			game = new Game();
			addChild(game);
		}
		
		override protected function onEnterFrame(e:EnterFrameEvent):void
		{
			
		}
		
		override public function onEnter():void
		{
			
		}
		
		override public function onExit():void
		{
			
		}
		
	}

}
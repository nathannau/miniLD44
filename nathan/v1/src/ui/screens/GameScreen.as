package ui.screens 
{
	import starling.display.Quad;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	/**
	 * ...
	 * @author 
	 */
	public class GameScreen extends BaseScreen 
	{
		
		public function GameScreen() 
		{
			super();
			screenName = "GAME";
		}
		
		override protected function onInitialize(event:Event):void
		{	
			var quad:Quad = new Quad(stage.stageWidth, stage.stageHeight, 0x202020);
			addChild(quad);
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
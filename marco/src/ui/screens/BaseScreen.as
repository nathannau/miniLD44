package ui.screens 
{
	import feathers.controls.Screen;
	
	import feathers.events.FeathersEventType;
	import starling.events.Event;
	import starling.events.EnterFrameEvent;
	
	public class BaseScreen extends Screen 
	{
		public var screenName:String = "BASE";
		
		public function BaseScreen() 
		{			
			this.addEventListener(FeathersEventType.INITIALIZE, onInitialize);
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onInitialize(event:Event):void
		{
			
		}
		
		protected function onEnterFrame(e:EnterFrameEvent):void
		{
			
		}
		
		public function onEnter():void
		{
			
		}
		
		public function onExit():void
		{
			
		}
		
	}
	

}
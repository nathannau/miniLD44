package ui.game.gameObjects 
{
	import starling.events.Event;
	import utils.Element;
	/**
	 * ...
	 * @author Stab
	 */
	public class GUnit extends GameObject 
	{
		
		public function GUnit(e:Element) 
		{
			super(e);
			
			
		}
		
		override public function onAddedToStage(e:Event):void 
		{
			super.onAddedToStage(e);
			_quad.alpha = 1;
		}
		
	}

}
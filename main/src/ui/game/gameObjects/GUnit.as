package ui.game.gameObjects 
{
	import starling.display.MovieClip;
	import starling.events.Event;
	import ui.Assets;
	import utils.Element;
	import utils.TypeElement;
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
			
			//_quad.alpha = 1;
			
			var name:String;
			
			switch(_element.type)
			{
				case TypeElement.SOLDAT:
					name = "soldier";
					break;
					
				case TypeElement.FUSILLEUR:
					name = "gunman";
					break;
					
				case TypeElement.CHEVAUCHEUR:
					name = "rider";
					break;
			}
			
			var mc:MovieClip =  new MovieClip(Assets.atlas.getTextures(name));
			mc.pivotX = 54 * 2;
			mc.pivotY = 54 * 2;
			_container.addChild(mc);
			mc.touchable = false;
		}
		
	}

}
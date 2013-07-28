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
	public class GCaserne extends GBuilding 
	{
		
		public function GCaserne(e:Element) 
		{
			super(e);
		}
		
		override public function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);
			
			var mc:MovieClip =  new MovieClip(Assets.atlas.getTextures("melee"));
			mc.pivotX = 54 * 2;
			mc.pivotY = 54 * 2;
			_container.addChild(mc);
			mc.touchable = false;
		}
		
		override public function getStoreItems():Array
		{
			return [TypeElement.SOLDAT];
		}
		
	}

}
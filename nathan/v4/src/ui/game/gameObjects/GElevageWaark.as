package ui.game.gameObjects 
{
	import starling.events.Event;
	import utils.Element;
	import utils.TypeElement;
	/**
	 * ...
	 * @author 
	 */
	public class GElevageWaark extends GBuilding 
	{
		
		public function GElevageWaark(e:Element) 
		{
			super(e);
		}
		
		override public function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);
			
			_quad.alpha = 1;
			
			/*var mc:MovieClip =  new MovieClip(Assets.atlas.getTextures("melee"));
			mc.pivotX = 54 * 2;
			mc.pivotY = 54 * 2;
			_container.addChild(mc);
			mc.touchable = false;
			*/
		}
		
		override public function getStoreItems():Array
		{
			return [TypeElement.CHEVAUCHEUR];
		}
		
	}

}
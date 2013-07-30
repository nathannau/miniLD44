package ui.game.gameObjects 
{
	import starling.display.MovieClip;
	import starling.events.Event;
	import ui.Assets;
	import utils.Element;
	import utils.ElementCentreDeForage;
	import utils.TypeElement;
	/**
	 * ...
	 * @author 
	 */
	public class GMine extends GBuilding 
	{
		
		public function GMine(e:Element) 
		{
			super(e);
			sizeX = sizeY = 3;
			
			
		}
		
		override public function onAddedToStage(e:Event):void {
			super.onAddedToStage(e);
			
			_quad.alpha = 0;
			
			var mc:MovieClip =  new MovieClip(Assets.atlas.getTextures("townmine"));
			mc.pivotX = 54;
			mc.pivotY = 54;
			//mc.width = 54 * 3;
			//mc.height = 54 * 3
			//mc.pivotX = 
			_container.addChild(mc);
			mc.touchable = false;
		}
		
		override public function hasStore():Boolean {
			return (_element as ElementCentreDeForage).isDown;
		}
		
		override public function getStoreItems():Array
		{
			return [TypeElement.CASERNE, TypeElement.CENTRE_DE_TIR, TypeElement.ELEVAGE_WAARK, TypeElement.LABORATOIRE, TypeElement.RELAIS];
		}
		
	}

}
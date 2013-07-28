package ui.game.gameObjects 
{
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
		
		override public function getStoreItems():Array
		{
			return [TypeElement.CHEVAUCHEUR];
		}
		
	}

}
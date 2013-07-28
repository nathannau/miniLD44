package ui.game.gameObjects 
{
	import utils.Element;
	import utils.TypeElement;
	/**
	 * ...
	 * @author 
	 */
	public class GCentreDeTir extends GBuilding 
	{
		
		public function GCentreDeTir(e:Element) 
		{
			super(e);
		}
		
		override public function getStoreItems():Array
		{
			return [TypeElement.FUSILLEUR];
		}
		
	}

}
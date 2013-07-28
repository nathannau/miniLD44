package ui.game.gameObjects 
{
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
		
		override public function getStoreItems():Array
		{
			return [TypeElement.SOLDAT];
		}
		
	}

}
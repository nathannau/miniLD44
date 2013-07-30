package ui.game.gameObjects 
{
	import utils.Element;
	/**
	 * ...
	 * @author 
	 */
	public class GBuilding extends GameObject 
	{
		
		public function GBuilding(e:Element) 
		{
			super(e);
			
			sizeX = sizeY = 2;
			
		}
		
		override public function hasStore():Boolean {
			return true;
		}
		
	}

}
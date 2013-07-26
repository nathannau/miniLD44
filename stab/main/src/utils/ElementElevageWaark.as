package utils 
{
	import vues.IPlayer;
	/**
	 * Elevage de Waark
	 * @author Nathan
	 */
	public class ElementElevageWaark extends ElementBatiment 
	{
		override public function get type():TypeElement  { return TypeElement.ELEVAGE_WAARK; }
		
		public function ElementElevageWaark(player:IPlayer) 
		{
			_player = player;
		}
		
		override public function get canMove():Boolean { return false; }
		override public function get canAttack():Boolean { return false; }
		
		override public function get rayon():Number { return 1; }
		
	}

}
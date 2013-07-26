package utils 
{
	import vues.IPlayer;
	/**
	 * Laboratoire
	 * @author Nathan
	 */
	public class ElementLaboratoire extends Element 
	{
		override public function get type():TypeElement  { return TypeElement.LABORATOIRE; }
		
		public function ElementLaboratoire(player:IPlayer) 
		{
			_player = player;
		}
		
		override public function get canMove():Boolean { return false; }
		override public function get canAttack():Boolean { return false; }
		
		override public function get rayon():Number { return 1; }
		
	}

}
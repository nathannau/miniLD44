package utils 
{
	import vues.IPlayer;
	/**
	 * Caserne
	 * @author Nathan
	 */
	public class ElementCaserne extends ElementBatiment 
	{
		override public function get type():TypeElement  { return TypeElement.CASERNE; }	
		
		public function ElementCaserne(player:IPlayer) 
		{
			_player = player;
		}

		override public function get canMove():Boolean { return false; }
		override public function get canAttack():Boolean { return false; }

		override public function get rayon():Number { return 1; }
		
	}

}
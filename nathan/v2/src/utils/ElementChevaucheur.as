package utils 
{
	import vues.IPlayer;
	/**
	 * Chevaucheur
	 * @author Nathan
	 */
	public class ElementChevaucheur extends ElementUnite 
	{
		override public function get type():TypeElement  { return TypeElement.CHEVAUCHEUR; }
		
		public function ElementChevaucheur(player:IPlayer) 
		{
			_player = player;
		}
		
		override public function get canMove():Boolean { return true; }
		override public function get canAttack():Boolean { return true; }
		
		override public function get rayon():Number { return .5; }
		
	}

}
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
		
	}

}
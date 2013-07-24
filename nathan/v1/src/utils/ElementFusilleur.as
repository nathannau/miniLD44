package utils 
{
	import vues.IPlayer;
	/**
	 * Fusilleur
	 * @author Nathan
	 */
	public class ElementFusilleur extends ElementUnite 
	{
		override public function get type():TypeElement  { return TypeElement.FUSILLEUR; }	
		
		public function ElementFusilleur(player:IPlayer) 
		{
			_player = player;
		}
		
	}

}
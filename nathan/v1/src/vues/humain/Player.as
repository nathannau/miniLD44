package vues.humain 
{
	import vues.IPlayer;
	
	/**
	 * Affichage pour un joueur humain
	 * TODO : vues.ia.Player classe non implémentée
	 * @author Stab
	 */
	public class Player implements IPlayer 
	{
		public function Player() 
		{
			if (Configuration.THROW_NOT_IMPLEMENTED) throw new Error("Fonction non implementé : Priorité très haute");
		}
		
	}

}
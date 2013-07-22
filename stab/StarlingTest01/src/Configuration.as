package  
{
	/**
	 * Classe static pour la configuration du jeu.
	 * Tous les parametres doit être géné ici.
	 * @author Marco, Nathan, Stab
	 */
	public final class Configuration 
	{
		private static var _me:Configuration = new Configuration();
		
		public function get me():Configuration { return _me; }
		public function Configuration() 
		{
			if (me != null) throw new Error("classe Abstraite");
		}
		
		
	}

}
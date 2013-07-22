package  
{
	import utils.Ressource;
	import utils.Terrain;
	/**
	 * Classe static pour la configuration du jeu.
	 * Tous les parametres doit être géné ici.
	 * @author Marco, Nathan, Stab
	 */
	public final class Configuration 
	{
		private static var _me:Configuration = new Configuration();
		
		public static function get me():Configuration { return _me; }
		public function Configuration() 
		{
			if (me != null) throw new Error("classe Abstraite");
			
			initMineRessourcesProb();
		}
		
		///// GAME
		public const FRAMERATE:uint = 60;
		
		
		
		
		
		///// MINE
		public const MINE_WIDTH:uint = 10;
		public const MINE_DEEP:uint = 20;
		
		public const MINE_RESSOURCES_PROB:Array;
		private function initMineRessourcesProb():void
		{
			var ret:Array = new Array();
			ret[Terrain.PLAINE.index] = new Array(
				{ start:0, stop:19, prob:100, type:Ressource.TERRE },
				{ start:0, stop:0, prob:5, type:Ressource.NOURITURE },
				{ start:2, stop:19, prob:10, type:Ressource.PIERRE },
				{ start:4, stop:7, prob:10, type:Ressource.FER },
				{ start:5, stop:6, prob:5, type:Ressource.OR },
			//	{ start:7, stop:9, prob:15, type:Ressource.PETROLE },
			 	{ start:2, stop:5, prob:10, type:Ressource.CHARBON }
			//	{ start:12, stop:15, prob:5, type:Ressource.DIAMANT },
			//	{ start:17, stop:18, prob:50, type:Ressource.URANIUM },
			);
			
			ret[Terrain.MONTAGNE.index] = new Array(
				{ start:0, stop:19, prob:100, type:Ressource.TERRE },
			//	{ start:0, stop:0, prob:5, type:Ressource.NOURITURE },
				{ start:0, stop:19, prob:60, type:Ressource.PIERRE },
				{ start:2, stop:6, prob:5, type:Ressource.FER },
				{ start:4, stop:8, prob:5, type:Ressource.OR },
			//	{ start:7, stop:9, prob:15, type:Ressource.PETROLE },
			//	{ start:2, stop:5, prob:10, type:Ressource.CHARBON },
				{ start:12, stop:15, prob:5, type:Ressource.DIAMANT },
				{ start:17, stop:18, prob:50, type:Ressource.URANIUM }
			);
			
			ret[Terrain.MARAIS.index] = new Array(
				{ start:0, stop:19, prob:100, type:Ressource.TERRE },
				{ start:0, stop:0, prob:20, type:Ressource.NOURITURE },
			//	{ start:0, stop:19, prob:60, type:Ressource.PIERRE },
			//	{ start:2, stop:6, prob:5, type:Ressource.FER },
			//	{ start:4, stop:8, prob:5, type:Ressource.OR },
				{ start:4, stop:9, prob:15, type:Ressource.PETROLE },
				{ start:2, stop:6, prob:10, type:Ressource.CHARBON },
			//	{ start:12, stop:15, prob:5, type:Ressource.DIAMANT },
				{ start:12, stop:18, prob:5, type:Ressource.URANIUM }
			);

			this.MINE_RESSOURCES_PROB = ret;
		}

		
	}

}
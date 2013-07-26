package  
{
	import utils.Ressource;
	import utils.RessourcesSet;
	import utils.Terrain;
	import utils.TypeElement;
	/**
	 * Classe static pour la configuration du jeu.
	 * Tous les parametres doit être géné ici.
	 * @author Marco, Nathan, Stab
	 */
	public final class Configuration 
	{
		/*
		private static var _me:Configuration = new Configuration();
		
		public static function get me():Configuration { return _me; }
		*/
		public function Configuration() 
		{
			//if (me != null) throw new Error("classe Abstraite");
			throw new Error("classe Abstraite");
		}
		
		///// GAME
		/**
		 * Frequence d'appel de la method "game.update"
		 */
		public static const FRAMERATE:uint = 30;
		
		/**
		 * Ressources disponible en début de partie
		 */
		public static const RESSOURCES_AT_START:RessourcesSet = new RessourcesSet(
			Ressource.NOURITURE, 10,
			Ressource.PIERRE, 5
		);

		/**
		 * Prix d'achat des unités
		 * RessourcesSet[TypeElement][uint Niveau]
		 */
		public static const ELEMENTS_COST:Array = initElementsCost();
		private static function initElementsCost():Array
		{
			var ret:Array = new Array();
			ret[TypeElement.CASERNE.index] = [
				new RessourcesSet(
					Ressource.FER, 10,
					Ressource.PIERRE, 10
				)
			];
			ret[TypeElement.CENTRE_DE_TIR.index] = [
				new RessourcesSet(
					Ressource.FER, 10,
					Ressource.PIERRE, 10
				)
			];
			ret[TypeElement.ELEVAGE_WAARK.index] = [
				new RessourcesSet(
					Ressource.FER, 10,
					Ressource.PIERRE, 10
				)
			];
			ret[TypeElement.LABORATOIRE.index] = [
				new RessourcesSet(
					Ressource.FER, 10,
					Ressource.PIERRE, 10
				)
			];
			ret[TypeElement.RELAIS.index] = [
				new RessourcesSet(
					Ressource.FER, 10,
					Ressource.PIERRE, 10
				),
				new RessourcesSet(
					Ressource.FER, 10,
					Ressource.PIERRE, 10
				),
				new RessourcesSet(
					Ressource.FER, 10,
					Ressource.PIERRE, 10
				)
				
			];

			ret[TypeElement.CHEVAUCHEUR.index] = [
				new RessourcesSet(
					Ressource.FER, 10,
					Ressource.PIERRE, 10
				),
				new RessourcesSet(
					Ressource.FER, 15,
					Ressource.PIERRE, 15
				),
				new RessourcesSet(
					Ressource.FER, 25,
					Ressource.PIERRE, 25
				)
			];
			ret[TypeElement.FUSILLEUR.index] = [
				new RessourcesSet(
					Ressource.FER, 10,
					Ressource.PIERRE, 10
				),
				new RessourcesSet(
					Ressource.FER, 15,
					Ressource.PIERRE, 15
				),
				new RessourcesSet(
					Ressource.FER, 25,
					Ressource.PIERRE, 25
				)
			];
			ret[TypeElement.SOLDAT.index] = [
				new RessourcesSet(
					Ressource.FER, 10,
					Ressource.PIERRE, 10
				),
				new RessourcesSet(
					Ressource.FER, 15,
					Ressource.PIERRE, 15
				),
				new RessourcesSet(
					Ressource.FER, 25,
					Ressource.PIERRE, 25
				)
			];
			
			return ret;
		}
		/**
		 * Prix d'achat des unités
		 * RessourcesSet[TypeElement][uint Niveau]
		 */
		public static const ELEMENTS_PV_INITIAL:Array = initElementsPvInitial();
		private static function initElementsPvInitial():Array
		{
			var ret:Array = new Array();
			ret[TypeElement.CENTRE_DE_FORAGE.index] = [500];
			ret[TypeElement.CASERNE.index] = [100];
			ret[TypeElement.CENTRE_DE_TIR.index] = [100];
			ret[TypeElement.ELEVAGE_WAARK.index] = [100];
			ret[TypeElement.LABORATOIRE.index] = [100];
			ret[TypeElement.RELAIS.index] = [75,100,150];

			ret[TypeElement.CHEVAUCHEUR.index] = [10,20,40];
			ret[TypeElement.FUSILLEUR.index] = [10,20,40];
			ret[TypeElement.SOLDAT.index] = [10,20,40];
			
			return ret;
		}
		
		/**
		 * Distance de vision des unités (Carré du rayon en careau)
		 */
		public static const DISTANCE_VISION_UNITE:uint = 12;
		/**
		 * Distance à laquelle une unité va se foutre sur la gueule
		 */
		public static const DISTANCE_GO_ATTACK:uint = 9;
		/**
		 * Porte des attaques
		 */
		public static const PORTE_ATACK:uint = 3;
		/**
		 * Nombre de tour entre deux attaque
		 */
		public static const CYCLE_BETWEEN_ATTACK:uint = 15;
		/**
		 * Bonus pour le triangle des unités en combat
		 */
		public static const BONUS_BETWEEN_UNITE:Number = 1.5;
		/**
		 * Bonus de terrain pour les unités en combat
		 */
		public static const BONUS_FROM_TERRAIN:Number = 1.5;
		/**
		 * Degats infligés par niveau
		 */
		public static const DEGATS_BY_LEVEL:Array = [2,4,8];

		
		///// RAFINAGE
		/**
		 * Qualité du rafinage en %
		 */
		public static const QUALITE_RAFINAGE:Array = [25, 50, 75, 100];
		/**
		 * Couts des upgrade "Forage"
		 */
		public static const UPGRADES_FORAGES_COST:Array = [
			new RessourcesSet(
				Ressource.FER, 10,
				Ressource.PIERRE, 10
			),
			new RessourcesSet(
				Ressource.FER, 20,
				Ressource.PIERRE, 40,
				Ressource.CHARBON, 10
			),
			new RessourcesSet(
				Ressource.FER, 50,
				Ressource.PIERRE, 80,
				Ressource.DIAMANT, 5
			)
		];
		
		
		///// MINE
		/**
		 * Largeur de la mine
		 */
		public static const MINE_WIDTH:uint = 10;
		/**
		 * Profondeur de la mine
		 */
		public static const MINE_DEEP:uint = 20;
		
		/**
		 * Probabilité d'obtenir une ressources en fonction de la nature du terrain.
		 * { 
		 * 	   start: premiere strate où la ressource apparait, 
		 *     stop: derniere strate où la ressource apparait, 
		 *     prob: % de chance de trouver cette ressource, 
		 *     type: type de ressource trouvable
		 * } [ressource.index]
		 */
		public static const MINE_RESSOURCES_PROB:Array = initMineRessourcesProb();
		private static function initMineRessourcesProb():Array
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

			return ret;
			//this.MINE_RESSOURCES_PROB = ret;
		}
		
		/**
		 * Détail des propriétés des ressources
		 * { 
		 *    cycle : Nombre de cycles pour creuser entierement une case,
		 *    quantite : Quantité maximum de ressources dans une case
		 * }[ressource.index]
		 */
		public static const MINE_RESSOURCES_DETAIL:Array = initMineRessourcesDetail();
		private static function initMineRessourcesDetail():Array
		{
			var ret:Array = new Array();
			ret[Ressource.NOURITURE.index] = { cycle:60, quantite:100 };
			ret[Ressource.TERRE.index] = { cycle:40, quantite:0 };
			ret[Ressource.PIERRE.index] = { cycle:100, quantite:40 };
			ret[Ressource.FER.index] = { cycle:80, quantite:40 };
			ret[Ressource.OR.index] = { cycle:70, quantite:30 };
			ret[Ressource.PETROLE.index] = { cycle:50, quantite:100 };
			ret[Ressource.CHARBON.index] = { cycle:50, quantite:50 };
			ret[Ressource.DIAMANT.index] = { cycle:120, quantite:20 };
			ret[Ressource.URANIUM.index] = { cycle:100, quantite:20 };
			return ret;
		};

		/**
		 * Couts des upgrade "Rafinage"
		 */
		public static const UPGRADES_RAFINAGE_COST:Array = [
			new RessourcesSet(
				Ressource.FER, 10,
				Ressource.PIERRE, 10
			),
			new RessourcesSet(
				Ressource.FER, 20,
				Ressource.PIERRE, 40,
				Ressource.CHARBON, 10
			),
			new RessourcesSet(
				Ressource.FER, 50,
				Ressource.PIERRE, 80,
				Ressource.DIAMANT, 5
			)
		];
		/**
		 * Nombre de cycle de forage par mise à jour.
		 */
		public static const MINE_NB_CYCLE_BY_FORAGE_LEVEL:Array = [1, 2, 4, 8];
		
		
		///// Relais
		
		/**
		 * Couts des upgrade "Relais"
		 */
		public static const UPGRADES_RELAIS_COST:Array = [
			new RessourcesSet(
				Ressource.FER, 10,
				Ressource.PIERRE, 10,
				Ressource.CHARBON, 10
			),
			new RessourcesSet(
				Ressource.FER, 20,
				Ressource.PIERRE, 40,
				Ressource.DIAMANT, 10
			),
			new RessourcesSet(
				Ressource.FER, 50,
				Ressource.PIERRE, 80,
				Ressource.URANIUM, 20
			)
		];
		/**
		 * Distance de vision des tours de relais est du centre de forage (Carré du rayon en careau)
		 */
		public static const DISTANCE_VISION:Array = [100, 400, 900, 2500];
		
		
		
		///// Divers
		public static const THROW_NOT_IMPLEMENTED:Boolean = false;
	}

}
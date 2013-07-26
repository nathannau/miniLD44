package utils 
{
	import controller.Game;
	import vues.IPlayer;
	/**
	 * Mine d'un joueur
	 * @author Nathan
	 */
	public class Mine 
	{
		/**
		 * Largeur de la mine
		 */
		public function get width():uint { return _width; }
		private var _width:uint;
		/**
		 * Profondeur de la mine
		 */
		public function get deep():uint { return _deep; }
		private var _deep:uint;
		/**
		 * Nombre d'update depuis la creation de la mine
		 */
		public function get nbUpdate():uint { return _nbUpdate; }
		private var _nbUpdate:uint;
		
		/**
		 * Terrain actuel où est la mine
		 */
		public function get currentTerrain():Terrain{ return _currentTerrain; }
		public function set currentTerrain(value:Terrain):void { _currentTerrain = value; reinit(); }
		private var _currentTerrain:Terrain;
		/**
		 * La mine est disponible
		 */
		public function get isActif():Boolean { return _currentTerrain != null; }
		
		/**
		 * Propriétaire de la mine
		 */
		public function get player():IPlayer{ return _player; }
		private var _player:IPlayer;
		
		/**
		 * Ajoute une case dans la liste des cases à creuser
		 * TODO : vérifier que les recherches fonctionne bien.
		 * @param	x Coordonnée horizontale
		 * @param	d Coordonnée de profondeur
		 * @return false si la cases n'est pas accéssible ou déjà dans la liste de tache, sinon true.
		 */
		public function addTask(x:uint, d:uint):Boolean
		{
			if (x >= _width || d >= _width) throw new Error("Case en dehors de la mine");
			var i:int;
			
			var p:Object = { x:x, d:d };
			if (_casesAccessibles.indexOf(p)<0) return false;
			_tasks.push(p);
			_casesAccessibles.splice(_casesAccessibles.indexOf(p), 1);
			
			if (x > 0 && 		isNowAccessible(x - 1, d)) _casesAccessibles.push( { x:x - 1, d:d } );
			if (x < _width-1 && isNowAccessible(x + 1, d)) _casesAccessibles.push( { x:x + 1, d:d } );
			if (d > 0 && 		isNowAccessible(x, d - 1)) _casesAccessibles.push( { x:x, d:d - 1 } );
			if (d < _deep - 1  && isNowAccessible(x, d + 1)) _casesAccessibles.push( { x:x, d:d + 1 } );
			
			return true;
		}
		/**
		 * Permet de savoir si un case est a ajouter dans la liste des cases accéssible
		 * @param	x Coordonnée horizontale
		 * @param	d Coordonnée de profondeur
		 * @return	true si la case est à ajouter, sinon false
		 */
		private function isNowAccessible(x:uint, d:uint):Boolean
		{
			if (_cases[d * _width + x] == null) return false;
			var p:Object = { x:x, d:d };
			if (_tasks.indexOf(p) >= 0) return false;
			if (_casesAccessibles.indexOf(p) >= 0) return false;
			return true;
		}
		/**
		 * Liste des cases qui vont être creusées
		 */
		public function get tasks():Array { return _tasks; }
		private var _tasks:Array = new Array(); // {x ; d}[]
		/**
		 * Liste des cases accéssible
		 */
		public function get casesAccessibles():Array { return _casesAccessibles; }
		public function isAccessible(x:uint, y:uint):Boolean
		{
			for (var i:uint = 0; i < _casesAccessibles.length; i++)
				if (_casesAccessibles[i].x == x && _casesAccessibles[i].d == y) return true;
			return false;
		}
		private var _casesAccessibles:Array = new Array();
				
		/**
		 * Ressource disponible à une position donnée
		 * @param	x Coordonnée horizontal
		 * @param	d Coordonnée de profondeur
		 * @return	Type de ressource. Ou Null si la case est vide
		 */
		public function getCaseAt(x:uint, d:uint):Ressource
		{
			return _cases[d * _width + x];
		}
		private var _cases:Array;
		
		public function Mine(width:uint, deep:uint, player:IPlayer)
		{
			_width = width;
			_deep = deep;
			_cases = new Array(width*deep);
			//_currentTerrain = currentTerrain;
			_player = player;
			
			//Reinit();
		}
		
		/**
		 * Reinitialise la mine
		 */
		public function reinit():void
		{
			var probs:Array = Configuration.MINE_RESSOURCES_PROB[_currentTerrain.index];
			var i:uint;
			
			for (var d:uint = 0; d < _deep; d++)
				for (var x:uint = 0; x < _width; x++)
				{
					var r:Ressource = null;
					while (r == null)
						for (i = 0; i < probs.length; i++)
							if (d >= probs[i].start && 
								d <= probs[i].stop && 
								Math.random()*100<probs[i].prob) 
								r = probs[i].type;
					_cases[d * _width + x] = r;
				}
				
			_casesAccessibles = new Array();
			for (i = 0; i < _width; i++)
				_casesAccessibles.push( { x:i, d:0 } );
			
			_tasks = new Array();
			_nbCycle = 0;
			_nbUpdate = 0;
		}
		
		private var _nbCycle:uint = 0;
		
		/**
		 * % de l'avancement de l'extraction de la case en cours.
		 */
		public function get avancementForage():uint { return _avancementForage; }
		private var _avancementForage:uint = 0;
		
		
		public function update():void
		{
			if (!isActif) return;
			_nbUpdate ++;
			
			if (_tasks.length == 0) return;
			var upgrade:Upgrades = Game.current.getUpgrades(_player);
			
			var nbCycleSup:uint = Configuration.MINE_NB_CYCLE_BY_FORAGE_LEVEL[upgrade.forage];
			_nbCycle += nbCycleSup;
			var currentRessource:Ressource = _cases[_tasks[0].d * _width + _tasks[0].x] as Ressource;
			
			//	cycle : Nombre de cycles pour creuser entierement une case,
			//	quantite : Quantité maximum de ressources dans une case 
			var ressourceDetail:Object = Configuration.MINE_RESSOURCES_DETAIL[currentRessource.index];
			
			var playerRessources:RessourcesSet = Game.current.getRessources(_player);
			playerRessources.addRessource(
				currentRessource, 
				Configuration.QUALITE_RAFINAGE[upgrade.rafinage] *
				ressourceDetail.quantite * nbCycleSup / (ressourceDetail.cycle * 100)
			);
			if (_nbCycle > ressourceDetail.cycle)
			{
				_cases[_tasks[0].d * _width + _tasks[0].x] = null;
				_tasks.shift();
				_nbCycle = 0;
				_avancementForage = 0;
			}
			else
			{
				_avancementForage = _nbCycle * 100 / ressourceDetail.cycle;
			}
		}
		
		
		
	}

}
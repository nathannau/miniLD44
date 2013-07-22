package utils 
{
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
		public function set currentTerrain(value:Terrain):void { _currentTerrain = value; }
		private var _currentTerrain:Terrain;
		
		/**
		 * Ressource disponible à une position donnée
		 * @param	x Coordonnée horizontal
		 * @param	d Coordonnée de profondeur
		 * @return	Type de ressource. Ou Null si la case est vide
		 */
		private function getCaseAt(x:uint, d:uint):Ressource
		{
			return _cases[d * _width + x];
		}
		private var _cases:Array;
		
		public function Mine(width:uint, deep:uint, currentTerrain:Terrain)
		{
			_width = width;
			_deep = deep;
			_cases = new Array(width*deep);
			_currentTerrain = currentTerrain;
		}
		
		/**
		 * Reinitialise la mine
		 */
		public function Reinit():void
		{
			var probs:Array = Configuration.me.MINE_RESSOURCES_PROB[_currentTerrain.index];
			
			for (var d:uint = 0; d < _deep; d++)
				for (var x:uint = 0; x < _width; x++)
				{
					var r:Ressource = null;
					while (r == null)
						for (var i:uint = 0; i < probs.length; i++)
							if (d >= probs[i].start && 
								d <= probs[i].stop && 
								Math.random()*100<prods[i].prob) 
								r = prods[i].type;
					_cases[d * _width + x] = r;
				}
		}
		
		
		public function update()
		{
			_nbUpdate ++;
			
		}
		
		
		
	}

}
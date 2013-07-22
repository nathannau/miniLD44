package utils 
{
	import utils.*;
	import utils.Ressource;
	/**
	 * Lots de ressources (pour gérer les couts d'achat ou les ressources possédé par un joueur
	 * @author Nathan
	 */
	public class RessourcesSet 
	{
		private var _ressources:Array = new Array(); // :[]int 
		
		public function RessourcesSet() 
		{
			this.clear();
		}
		
		/**
		 * Vide le ressourcesSet
		 */
		public function clear():void
		{
			for (var i:uint = 0; i < Ressource.NB_TYPE_RESSOURCE; i++)
				_ressources[i] = 0;
		}
		
		/**
		 * Retourne le nombre de ressource d'un type donné
		 * @param	res type de ressource
		 * @return	nombre de ressource
		 */
		public function getRessource(res:Ressource):int
		{
			//if (_ressources[res.index] == undefined) _ressources[res.index] = 0;
			return _ressources[res.index];
		}
		/**
		 * Deffini le nombre de ressource d'un type donné
		 * @param	res type de ressource
		 * @param	nb nombre de ressource
		 */
		public function setRessource(res:Ressource, nb:int):void
		{
			_ressources[res.index] = nb;
		}
		/**
		 * Ajoute des ressources
		 * @param	res type de ressource
		 * @param	nb nombre de ressource à ajouter
		 */
		public function addRessource(res:Ressource, nb:int):void
		{
//			if (_ressources[res.index] == undefined) _ressources[res.index] = 0;
			_ressources[res.index] += nb;
		}
		
		/**
		 * Ajoute un ressourcesSet
		 * @param	res ressourcesSet à ajouter
		 */
		public function addRessourcesSet(res:RessourcesSet):void
		{
			for (var i:int = 0; i < Ressource.NB_TYPE_RESSOURCE;  i++)
				this._ressources[i] += res._ressources[i];
		}
		/**
		 * Ajoute deux ressourcesSet
		 * @param	res 1er ressourcesSet à ajouter
		 * @param	res 2er ressourcesSet à ajouter
		 * @return  somme des ressourcesSet
		 */
		public static function addRessourcesSet(res1:RessourcesSet, res2:RessourcesSet):RessourcesSet
		{
			var ret:RessourcesSet = new RessourcesSet();
			for (var i:int = 0; i < Ressource.NB_TYPE_RESSOURCE;  i++)
				ret._ressources[i] = res1._ressources[i] + res2._ressources[i];
			return ret;
		}
		/**
		 * Retranche un ressourcesSet
		 * @param	res ressourcesSet à retrancher
		 */
		public function subRessourcesSet(res:RessourcesSet):void
		{
			for (var i:int = 0; i < Ressource.NB_TYPE_RESSOURCE;  i++)
				this._ressources[i] -= res._ressources[i];
		}
		/**
		 * Retourne la différence entre deux ressourcesSet
		 * @param	res ressourcesSet de base
		 * @param	res ressourcesSet à retrancher
		 * @return  difference entre les deux ressourcesSet
		 */
		public static function subRessourcesSet(res1:RessourcesSet, res2:RessourcesSet):RessourcesSet
		{
			var ret:RessourcesSet = new RessourcesSet();
			for (var i:int = 0; i < Ressource.NB_TYPE_RESSOURCE;  i++)
				ret._ressources[i] = res1._ressources[i] - res2._ressources[i];
			return ret;
		}
		
		/**
		 * Copie le ressourcesSet dans un autre
		 * @param	res ressourcesSet de destination
		 */
		public function copyTo(res:RessourcesSet):void
		{
			for (var i:int = 0; i < Ressource.NB_TYPE_RESSOURCE;  i++)
				res._ressources[i] = this._ressources[i];
		}
		/**
		 * Clone le ressourcesSet
		 * @return Copie du ressourcesSet
		 */
		public function clone():RessourcesSet
		{
			var ret:RessourcesSet = new RessourcesSet();
			this.copyTo(ret);
			return ret;
		}
		
		/**
		 * Compare si le ressourcesSet est egal à un autre
		 * @param	res ressourcesSet avec lequel comparer
		 */
		public function estEgalA(res:RessourcesSet):Boolean
		{
			for (var i:int = 0; i < Ressource.NB_TYPE_RESSOURCE;  i++)
				if (this._ressources[i] != res._ressources[i]) return false;
			return true;
		}
		/**
		 * Compare si le ressourcesSet est plus grand ou egal qu'un autre
		 * @param	res ressourcesSet avec lequel comparer
		 */
		public function estPlusGrandOuEgalQue(res:RessourcesSet):Boolean
		{
			for (var i:int = 0; i < Ressource.NB_TYPE_RESSOURCE;  i++)
				if (this._ressources[i] < res._ressources[i]) return false;
			return true;
		}
		/**
		 * Compare si le ressourcesSet est plus grand qu'un autre
		 * @param	res ressourcesSet avec lequel comparer
		 */
		public function estPlusGrandQue(res:RessourcesSet):Boolean
		{
			for (var i:int = 0; i < Ressource.NB_TYPE_RESSOURCE;  i++)
				if (this._ressources[i] <= res._ressources[i]) return false;
			return true;
		}
		/**
		 * Compare si le ressourcesSet est plus petit ou egal qu'un autre
		 * @param	res ressourcesSet avec lequel comparer
		 */
		public function estPlusPetitOuEgalQue(res:RessourcesSet):Boolean
		{
			for (var i:int = 0; i < Ressource.NB_TYPE_RESSOURCE;  i++)
				if (this._ressources[i] > res._ressources[i]) return false;
			return true;
		}
		/**
		 * Compare si le ressourcesSet est plus petit qu'un autre
		 * @param	res ressourcesSet avec lequel comparer
		 */
		public function estPlusPetitQue(res:RessourcesSet):Boolean
		{
			for (var i:int = 0; i < Ressource.NB_TYPE_RESSOURCE;  i++)
				if (this._ressources[i] >= res._ressources[i]) return false;
			return true;
		}
		
	}

}
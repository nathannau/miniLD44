package utils 
{
	import controller.Game;
	import flash.utils.getQualifiedClassName;
	/**
	 * Class abstraite pour l'ensemble des unités
	 * @author Nathan
	 */
	public class ElementUnite extends Element implements IElementVision 
	{
		public function ElementUnite() 
		{
			if (getQualifiedClassName(this)=="utils::ElementUnite")
				throw new Error("Classe abstraite"); 
		}
		
		public function get distanceVision():uint
		{
			return Configuration.DISTANCE_VISION_UNITE;
		}
		
		public function get isAffamer():Boolean { return _isAffamer; }
		private var _isAffamer:Boolean = false;

		override public function get canMove():Boolean { return !_isAffamer; }
		override public function get canAttack():Boolean { return !_isAffamer; }
		
		private var _lastEat:uint = 0
		override public function update():void 
		{
			super.update();
			if (!available) return ;
			if (_lastEat > Configuration.UNITE_EAT_EVERY)
			{
				var rs:RessourcesSet = Game.current.getRessources(this._player);
				if (rs.getRessource(Ressource.NOURITURE) > 0)
				{
					_isAffamer = false;
					rs.addRessource(Ressource.NOURITURE, -1);
					_lastEat = 0;
				}
				else
				{
					_isAffamer = true;
				}
			}
			else
				_lastEat++;
		}
		
	}

}
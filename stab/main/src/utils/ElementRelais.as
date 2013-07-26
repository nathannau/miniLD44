package utils 
{
	import controller.Game;
	import vues.IPlayer;
	/**
	 * Relais
	 * @author Nathan
	 */
	public class ElementRelais extends Element implements IElementVision 
	{
		override public function get type():TypeElement  { return TypeElement.RELAIS; }
		
		public function ElementRelais(player:IPlayer) 
		{
			_player = player;
		}
		
		public function get distanceVision():uint
		{
			return Configuration.DISTANCE_VISION[Game.current.getUpgrades(player).relais];
		}

		override public function get canMove():Boolean { return false; }
		override public function get canAttack():Boolean { return _canAttack; }
		public function set canAttack(value:Boolean):void { _canAttack = value; }
		private var _canAttack:Boolean = false;
		
		override public function get rayon():Number { return 1; }
		
	}

}
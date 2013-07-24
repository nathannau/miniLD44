package utils 
{
	import controller.Game;
	import vues.IPlayer;
	/**
	 * Centre de forage
	 * @author Nathan
	 */
	public class ElementCentreDeForage extends Element implements IElementVision
	{
		override public function get type():TypeElement  { return TypeElement.CENTRE_DE_FORAGE; }
	
		public function ElementCentreDeForage(player:IPlayer) 
		{
			_player = player;
		}
		
		public function get distanceVision():uint
		{
			return Configuration.DISTANCE_VISION[Game.current.getUpgrades(player).relais];
		}
		
	}

}
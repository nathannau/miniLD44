package utils 
{
	import vues.IPlayer;
	/**
	 * Elevage de Waark
	 * @author Nathan
	 */
	public class ElementElevageWaark extends Element 
	{
		override public function get type():TypeElement  { return TypeElement.ELEVAGE_WAARK; }
		
		public function ElementElevageWaark(player:IPlayer) 
		{
			_player = player;
		}
		
	}

}
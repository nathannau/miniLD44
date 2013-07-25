package utils 
{
	import vues.IPlayer;
	/**
	 * Laboratoire
	 * @author Nathan
	 */
	public class ElementLaboratoire extends Element 
	{
		override public function get type():TypeElement  { return TypeElement.LABORATOIRE; }
		
		public function ElementLaboratoire(player:IPlayer) 
		{
			_player = player;
		}
		
	}

}
package utils 
{
	import vues.IPlayer;
	/**
	 * Caserne
	 * @author Nathan
	 */
	public class ElementCaserne extends Element 
	{
		override public function get type():TypeElement  { return TypeElement.CASERNE; }	
		
		public function ElementCaserne(player:IPlayer) 
		{
			_player = player;
		}
		
	}

}
package utils 
{
	import vues.IPlayer;
	/**
	 * Soldat
	 * @author Nathan
	 */
	public class ElementSoldat extends ElementUnite 
	{
		override public function get type():TypeElement  { return TypeElement.SOLDAT; }
	
		public function ElementSoldat(player:IPlayer) 
		{
			_player = player;
		}
		
	}

}
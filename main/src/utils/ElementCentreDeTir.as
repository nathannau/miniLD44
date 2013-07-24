package utils 
{
	import vues.IPlayer;
	/**
	 * Centre de Tir
	 * @author Nathan
	 */
	public class ElementCentreDeTir extends Element 
	{
		override public function get type():TypeElement  { return TypeElement.CENTRE_DE_TIR; }
		
		public function ElementCentreDeTir(player:IPlayer) 
		{
			_player = player;
		}
		
	}

}
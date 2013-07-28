package utils 
{
	import vues.IPlayer;
	/**
	 * Centre de Tir
	 * @author Nathan
	 */
	public class ElementCentreDeTir extends ElementBatiment 
	{
		override public function get type():TypeElement  { return TypeElement.CENTRE_DE_TIR; }
		
		public function ElementCentreDeTir(player:IPlayer) 
		{
			_player = player;
		}
		
		override public function get canMove():Boolean { return false; }
		override public function get canAttack():Boolean { return false; }
		
		override public function get rayon():Number { return 1; }
		
	}

}
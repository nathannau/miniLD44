package vues.ia 
{
	import vues.IPlayer;
	
	/**
	 * Logique de l'IA adverse.
	 * TODO : vues.ia.Player classe non implémentée
	 * @author Marco
	 */
	public class Player implements IPlayer 
	{
		
		public function Player() 
		{
			if (Configuration.THROW_NOT_IMPLEMENTED) throw new Error("Fonction non implementé : Priorité très haute");
		}
		
		public function get index():uint
		{
			return 0;
		}
		public function set index(value:uint):void
		{
			
		}
		
		public function update():void
		{
			
		}
		
	}

}
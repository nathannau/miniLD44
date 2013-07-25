package vues.humain 
{
	import starling.display.Sprite;
	import vues.IPlayer;
	
	/**
	 * Affichage pour un joueur humain
	 * TODO : vues.ia.Player classe non implémentée
	 * @author Stab
	 */
	public class Player extends Sprite implements IPlayer 
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
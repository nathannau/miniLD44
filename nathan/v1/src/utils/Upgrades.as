package utils 
{
	/**
	 * Niveau de chaque update d'un joueur
	 * @author Nathan
	 */
	public class Upgrades 
	{
		public function get forage():uint { return _forage; }
		internal function set forage(value:uint):void { _forage = value; }
		private var _forage:uint = 0;

		public function get rafinage():uint { return _rafinage; }
		internal function set rafinage(value:uint):void { _rafinage = value; }
		private var _rafinage:uint = 0;
		
		public function Upgrades() 
		{
			
		}
		
	}

}
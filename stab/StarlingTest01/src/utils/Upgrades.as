package utils 
{
	/**
	 * Niveau de chaque update d'un joueur
	 * @author Nathan
	 */
	public class Upgrades 
	{
		public function get forage():uint { return _forage; }
		public function set forage(value:uint):void { _forage = value; }
		private var _forage:uint = 0;

		public function get rafinage():uint { return _rafinage; }
		public function set rafinage(value:uint):void { _rafinage = value; }
		private var _rafinage:uint = 0;
		
		public function get relais():uint { return _relais; }
		public function set relais(value:uint):void { _relais = value; }
		private var _relais:uint = 0;
		
		public function get uniteGlobal():uint { return _uniteGlobal; }
		public function set uniteGlobal(value:uint):void { _uniteGlobal = value; }
		private var _uniteGlobal:uint = 0;
		
		public function get soldat():uint { return _soldat; }
		public function set soldat(value:uint):void { _soldat = value; }
		private var _soldat:uint = 0;
		
		public function get fusilleur():uint { return _fusilleur; }
		public function set fusilleur(value:uint):void { _fusilleur = value; }
		private var _fusilleur:uint = 0;

		public function get chevaucheur():uint { return _chevaucheur; }
		public function set chevaucheur(value:uint):void { _chevaucheur = value; }
		private var _chevaucheur:uint = 0;

		public function get defense():uint { return _defense; }
		public function set defense(value:uint):void { _defense = value; }
		private var _defense:uint = 0;
		
		public function Upgrades() 
		{
			
		}
		
	}

}
package utils 
{
	/**
	 * Enumeration des ressources disponibles
	 * @author Nathan
	 */
	public final class Ressource 
	{
//		private static var _nbInitConst:uint = 0;

		
		private var _nom:String;
		private var _index:uint;
		public function get nom():String { return this._nom; }
		public function get index():uint { return this._index; }
				
		public static const NOURITURE:Ressource = new Ressource("NOURITURE", 0);
		public static const TERRE:Ressource = new Ressource("TERRE", 1);
		public static const PIERRE:Ressource = new Ressource("PIERRE", 2);
		public static const FER:Ressource = new Ressource("FER", 3);
		public static const OR:Ressource = new Ressource("OR", 4);
		public static const PETROLE:Ressource = new Ressource("PETROLE", 5);
		public static const CHARBON:Ressource = new Ressource("CHARBON", 6);
		public static const DIAMANT:Ressource = new Ressource("DIAMANT", 7);
		public static const URANIUM:Ressource = new Ressource("URANIUM", 8);

		public static const NB_TYPE_RESSOURCE:uint = 9;
		//public static var ressources:Vector.<Ressource> = new Vector.<Ressource>();
		
		public function Ressource(nom:String, index:uint) 
		{
//			if (_nbInitConst == NB_TYPE_RESSOURCE) throw new Error("classe abtraite");
			
			this._nom = nom;
			this._index = index;
//			Ressource._nbInitConst++;

			//ressources.push(this);
		}
		
	}

}
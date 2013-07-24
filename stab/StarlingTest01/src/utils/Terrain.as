package utils 
{
	/**
	 * Enumeration des types de terrain disponibles
	 * @author Nathan
	 */
	public class Terrain 
	{
		private var _nom:String;
		private var _index:uint;
		public function get nom():String { return this._nom; }
		public function get index():uint { return this._index; }

		public static const PLAINE:Terrain = new Terrain("PLAINE", 0);
		public static const MONTAGNE:Terrain = new Terrain("MONTAGNE", 1);
		public static const MARAIS:Terrain = new Terrain("MARAIS", 2);

		public static const NB_TYPE_TERRAIN:uint = 3;
		
		private static var _nbInitConst:uint = 0;

		public function Terrain(nom:String, index:uint) 
		{
			if (_nbInitConst == NB_TYPE_TERRAIN) throw new Error("classe abtraite");
			
			this._nom = nom;
			this._index = index;
			Terrain._nbInitConst++;
		}
		
	}

}
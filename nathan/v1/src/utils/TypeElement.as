package utils 
{
	/**
	 * Type d'unité
	 * @author Nathan
	 */
	public class TypeElement 
	{
		private var _nom:String;
		private var _index:uint;
		public function get nom():String { return this._nom; }
		public function get index():uint { return this._index; }
		
		public static const MECANO:TypeElement 				= new TypeElement("MECANO", 			0);
		public static const SOLDAT:TypeElement 				= new TypeElement("SOLDAT", 			1);
		public static const FUSILLEUR:TypeElement 			= new TypeElement("FUSILLEUR", 			2);
		public static const CHEVAUCHEUR:TypeElement 		= new TypeElement("CHEVAUCHEUR", 		3);

		public static const CENTRE_DE_FORAGE:TypeElement 	= new TypeElement("CENTRE_DE_FORAGE", 	4);
		public static const CASERNE:TypeElement 			= new TypeElement("CASERNE", 			5);
		public static const CENTRE_DE_TIR:TypeElement 		= new TypeElement("CENTRE_DE_TIR", 		6);
		public static const ELEVAGE_WAARK:TypeElement 		= new TypeElement("ELEVAGE_WAARK", 		7);
		public static const RELAIS:TypeElement 				= new TypeElement("RELAIS", 			8);
		public static const LABO:TypeElement 				= new TypeElement("LABO", 				9);
		
		public function TypeElement(nom:String, index:uint) 
		{
			this._nom = nom;
			this._index = index;
		}
		
	}

}
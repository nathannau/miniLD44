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
		private var _className:Class;
		public function get nom():String { return this._nom; }
		public function get index():uint { return this._index; }
		public function get className():Class { return this._className; }
		
		public static const MECANO:TypeElement 				= new TypeElement("MECANO", 			0,	null);
		public static const SOLDAT:TypeElement 				= new TypeElement("SOLDAT", 			1,	ElementSoldat);
		public static const FUSILLEUR:TypeElement 			= new TypeElement("FUSILLEUR", 			2,	ElementFusilleur);
		public static const CHEVAUCHEUR:TypeElement 		= new TypeElement("CHEVAUCHEUR", 		3,	ElementChevaucheur);

		public static const CENTRE_DE_FORAGE:TypeElement 	= new TypeElement("CENTRE_DE_FORAGE", 	4,	ElementCentreDeForage);
		public static const CASERNE:TypeElement 			= new TypeElement("CASERNE", 			5,	ElementCaserne);
		public static const CENTRE_DE_TIR:TypeElement 		= new TypeElement("CENTRE_DE_TIR", 		6,	ElementCentreDeTir);
		public static const ELEVAGE_WAARK:TypeElement 		= new TypeElement("ELEVAGE_WAARK", 		7,	ElementElevageWaark);
		public static const RELAIS:TypeElement 				= new TypeElement("RELAIS", 			8,	ElementRelais);
		public static const LABORATOIRE:TypeElement 		= new TypeElement("LABORATOIRE", 		9,	ElementLaboratoire);
		
		public function TypeElement(nom:String, index:uint, className:Class) 
		{
			this._nom = nom;
			this._index = index;
			this._className = className;
		}
		
	}

}
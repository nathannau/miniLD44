package utils 
{
	/**
	 * Animation des éléments
	 * @author Nathan
	 */
	public class Animation 
	{
		private var _nom:String;
		private var _index:uint;
		public function get nom():String { return this._nom; }
		public function get index():uint { return this._index; }
		
		public static const REPOS:Animation 		= new Animation("REPOS", 		0);
		public static const MOUVEMENT:Animation 	= new Animation("MOUVEMENT", 	1);
		public static const COMBAT:Animation 		= new Animation("COMBAT", 		2);
		public static const MAL_EN_POINT:Animation 	= new Animation("MAL_EN_POINT", 3);
		public static const MORT:Animation 			= new Animation("MORT", 		4);
		public static const CONSTRUCTION:Animation 	= new Animation("CONSTRUCTION", 5);
		public static const UP:Animation 			= new Animation("UP", 			5);
		public static const DOWN:Animation 			= new Animation("DOWN", 		5);
		
		public function Animation(nom:String, index:uint) 
		{
			this._nom = nom;
			this._index = index;
		}
		
	}

}
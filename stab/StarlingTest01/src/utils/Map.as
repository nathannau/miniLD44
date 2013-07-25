package utils 
{
	import mx.core.ByteArrayAsset;
	/**
	 * Map
	 * @author Nathan
	 */
	public class Map 
	{
		[Embed(source = "/../assets/map.txt", mimeType="application/octet-stream")]
		protected static const DATAMAP:Class;
		
		/**
		 * Listes des positions de departs 
		 * return {x:uint, y:uint}[]
		 */
		public function get startPositions():Array { return _startPos; }
		private var _startPos:Array;
		
		/**
		 * Listes des cases 
		 * return uint[]
		 */
		public function get cases():Array { return _cases; }
		public function getCase(x:uint, y:uint):uint { return _cases[y*_width+x]; }
		
		private var _cases:Array;
		
		/**
		 * Largeur de la map
		 */
		public function get width():uint { return _width;}
		private var _width:uint;
		/**
		 * Hauteur de la map
		 */
		public function get height():uint { return _height;}
		private var _height:uint
		
		public function Map() 
		{
		}
		
		public static function generate(nbJoueur:uint, width:uint, height:uint):Map
		{
			return new Map();
		}

		public static function load():Map
		{
			var ret:Map = new Map();
			var data:Object = JSON.parse(new DATAMAP());
			ret._startPos = data.startPositions;
			ret._cases = data.cases;
			ret._width = data.width;
			ret._height = data.height;
			return ret;
		}

		
		
		
		
		
	}

}
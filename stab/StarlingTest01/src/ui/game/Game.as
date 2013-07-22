package ui.game 
{
	import starling.display.Sprite;
	import ui.game.map.Map;
	
	public class Game extends Sprite 
	{
		public var map:Map;
		
		public function Game() 
		{
			map = new Map();
			addChild(map);
			
			
		}
		
	}

}
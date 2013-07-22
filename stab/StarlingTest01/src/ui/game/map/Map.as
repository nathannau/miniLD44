package ui.game.map 
{
	import starling.display.Quad;
	import starling.display.Sprite;

	
	public class Map extends Sprite 
	{
		public static const BASE_SIZE:int = 54;
		
		public function Map() 
		{
			for (var tx:int = 0; tx < 60; tx++)
			{
				for (var ty:int = 0; ty < 60; ty++)
				{
					var color:int = 0x505050;
					if ((tx + ty) % 2 == 0)
						color = 0x707070;
					
					var tile:Quad = new Quad(BASE_SIZE, BASE_SIZE, color);
					addChild(tile);
					tile.x = tx * BASE_SIZE;
					tile.y = ty * BASE_SIZE;
					
				}
			}
		}
		
	}

}
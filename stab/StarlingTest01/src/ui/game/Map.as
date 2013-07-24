package ui.game 
{
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import ui.Assets;

	
	public class Map extends Sprite 
	{
		public static const BASE_SIZE:int = 54;
		
		public static const MAP_SIZE_X:int = 60;
		public static const MAP_SIZE_Y:int = 60;
		
		public function Map() 
		{
			for (var tx:int = 0; tx < MAP_SIZE_X; tx++)
			{
				for (var ty:int = 0; ty < MAP_SIZE_Y; ty++)
				{
					var color:int = 0x505050;
					if ((tx + ty) % 2 == 0)
						color = 0x707070;
						
					if (tx == 0 || tx == MAP_SIZE_X - 1 || ty == 0 || ty == MAP_SIZE_Y - 1)
					{
						color = 0x905050;
						if ((tx + ty) % 2 == 0)
							color = 0xD07070;
					}
					
					//var tile:Quad = new Quad(BASE_SIZE, BASE_SIZE, color);
					var tile:Image = new Image(Assets.atlas.getTexture("tile_plaine"));
					tile.color = color;
					
					//tile.touchable = false;
					addChild(tile);
					tile.x = tx * BASE_SIZE;
					tile.y = ty * BASE_SIZE;
					
				}
			}
			
			this.flatten();
		}
		
	}

}
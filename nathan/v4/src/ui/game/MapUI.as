package ui.game 
{
	import controller.Game;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import ui.Assets;
	
	import utils.Map;

	
	public class MapUI extends Sprite 
	{
		public static const BASE_SIZE:int = 54;
		
		//public static const MAP_SIZE_X:int = 60;
		//public static const MAP_SIZE_Y:int = 60;
		
		public function MapUI() 
		{
			var map:Map = Game.current.map;
			
			for (var tx:int = 0; tx < map.width; tx++)
			{
				for (var ty:int = 0; ty < map.height; ty++)
				{
					var c:uint = map.getCase(tx, ty);
					
					var name:String;
					switch(c) {
						case 0:
							name = "tile_plaine";
							break;
						case 1:
							name = "tile_montagne";
							break;
						case 2:
							name = "tile_marais";
							break;
					}
					
					//var tile:Quad = new Quad(BASE_SIZE, BASE_SIZE, color);
					var tile:Image = new Image(Assets.atlas.getTexture(name));
					//tile.color = color;
					
					if (tx == 0 || tx == map.width - 1 || ty == 0 || ty == map.height - 1)
						tile.color = 0xB0B0B0;
					
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
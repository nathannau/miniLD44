package ui.game.gameObjects 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import ui.CullingSprite;
	import ui.game.Map;
	
	public class GameObject extends Sprite//CullingSprite 
	{		
		public function GameObject() 
		{
			var quad:Quad = new Quad(Map.BASE_SIZE, Map.BASE_SIZE, 0xFF8020);
			//quad.pivotX = quad.width * 0.5;
			//quad.pivotY = quad.height;
			
			addChild(quad);
			
			
		}
		
	}

}
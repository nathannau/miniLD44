package ui.game 
{
	import controller.Game;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import ui.game.gameObjects.GameObject;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameUI extends Sprite 
	{
		private var _game:Game;
		
		private var _map:Map;
		
		private var _objects: Vector.<GameObject>;
		
		public function GameUI(game:Game) 
		{
			_game = game;
			
			_map = new Map();
			addChild(_map);
			
			_objects = new Vector.<GameObject>();
			
			for (var i:uint = 0; i < 100; i++)
			{
				var obj:GameObject = new GameObject();
				addChild(obj);
				
				obj.x = Math.random() * 60 * 54;
				obj.y = Math.random() * 60 * 54;
				
				_objects.push(obj);
			}
		}
		
		public function update(delta:Number):void
		{
			for (var i:uint = 0; i < _objects.length; i++)
			{
				var obj:GameObject = _objects[i];
				obj.update(delta);
			}
		}
		
		public function getObjectsInRect(r:Rectangle):Vector.<GameObject>
		{
			var res:Vector.<GameObject> = new Vector.<GameObject>();
			for (var i:uint = 0; i < _objects.length; i++)
			{
				var obj:GameObject = _objects[i];
				if (r.x > obj.x + obj.width || r.x + r.width < obj.x || r.y > obj.y + obj.height || r.y + r.height < obj.y) continue;
				
				res.push(obj);
			}
			return res;
		}
		
	}

}
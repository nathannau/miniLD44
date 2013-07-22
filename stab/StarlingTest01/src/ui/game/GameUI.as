package ui.game 
{
	import controller.Game;
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
			
			for (var i:uint = 0; i < 500; i++)
			{
				var obj:GameObject = new GameObject();
				addChild(obj);
				
				//Starling.juggler.add(obj);
				
				obj.x = Math.random() * 60 * 54;
				obj.y = Math.random() * 60 * 54;
				
				_objects.push(obj);
			}
			
			//addEventListener(TouchEvent.TOUCH, onTouch);
			
			//flatten();
		}
		
		/*
		protected function onTouch(e:TouchEvent):void
		{
			//trace(e);
			var touches:Vector.<Touch> = e.getTouches(this);
			
			trace(touches);
		}*/
		
		public function update(delta:Number):void
		{
			//trace("update", delta);
			for (var i:uint = 0; i < _objects.length; i++)
			{
				var obj:GameObject = _objects[i];
				obj.x += (100.0 - Math.random() * 200.0) * delta;
				obj.y += (100.0 - Math.random() * 200.0) * delta;
				//obj.x += 1000.0 * delta;
				
				//trace(obj.x);
			}
		}
		
	}

}
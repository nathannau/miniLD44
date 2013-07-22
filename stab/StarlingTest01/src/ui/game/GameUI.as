package ui.game 
{
	import controller.Game;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameUI extends Sprite 
	{
		private var _game:Game;
		
		private var _map:Map;
		
		public function GameUI(game:Game) 
		{
			_game = game;
			
			_map = new Map();
			addChild(_map);
			
			//addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		/*
		protected function onTouch(e:TouchEvent):void
		{
			//trace(e);
			var touches:Vector.<Touch> = e.getTouches(this);
			
			trace(touches);
		}*/
		
	}

}
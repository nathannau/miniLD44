package ui.game.gameObjects 
{
	import flash.geom.Point;
	import starling.display.Quad;
	import starling.display.Sprite;
	import ui.CullingSprite;
	import ui.game.Map;
	
	public class GameObject extends Sprite//CullingSprite 
	{		
		private var _quad:Quad;
		
		private var _selected:Boolean = false;
		
		private var _state:String = State.IDLE;
		private var _moveTo:Point;
		private var _moveToObject:GameObject;
		
		public function GameObject() 
		{
			_quad = new Quad(Map.BASE_SIZE, Map.BASE_SIZE, 0xFF8020);
			//quad.pivotX = quad.width * 0.5;
			//quad.pivotY = quad.height;
			
			addChild(_quad);
		}
		
		public function setSelected(sel:Boolean):void
		{
			_selected = sel;
			if (_selected)
			{
				_quad.color = 0xFFA050;
			}
			else
			{
				_quad.color = 0xFF8020;
			}
		}
		
		public function setTarget(p:Point, obj:GameObject):void
		{
			_moveTo = p;
			_moveToObject = obj;
			
			_state = State.MOVING;
		}
		
		public function update(delta:Number):void
		{
			switch(_state)
			{
				case State.IDLE:
					break;
					
				case State.MOVING:
					var dir:Point = new Point(_moveTo.x - x, _moveTo.y - y);
					if (dir.length > 54)
					{
						dir.normalize(1);
						
						x += dir.x * delta * 100;
						y += dir.y * delta * 100;
					}
					else
					{
						_state = State.IDLE;
						
					}
					
					
			}
		}
		
	}

}
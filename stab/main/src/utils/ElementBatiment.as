package utils 
{
	import controller.Game;
	import controller.GameEvent;
	import flash.utils.getQualifiedClassName;
	/**
	 * Class abstraite pour l'ensemble des batiments
	 * @author Nathan
	 */
	public class ElementBatiment extends Element
	{
		
		public function ElementBatiment() 
		{
			if (getQualifiedClassName(this)=="utils::ElementBatiment")
				throw new Error("Classe abstraite"); 
		}
		
		public function get tasks():Array { return _tasks; }
		private var _tasks:Array = new Array();
		private var _taskBuildTime:uint = 0;
		
		override public function update():void 
		{
			super.update();
			if (pointDeVie <= 0) return ;
			if (_tasks.length == 0) return;
			
			if (_tasks[0] is Element)
			{
				var e: Element = _tasks[0];
				if (_taskBuildTime > Configuration.ELEMENTS_BUILD_TIME[e.type.index][e.level])
				{
					_taskBuildTime = 0;
					//Game.current.getElementsV2({rectangle:{minX:x-rayon-3, maxX:x+rayon+3,minY:y-rayon-3, maxY:y+rayon+3}});
					e.x = x;
					e.y = y - 2;
					Game.current.getElements().push(e);
					trace("add", e, e.x, e.y, x, y);
					//e.animation = Animation.REPOS;
					
					Game.current.dispatchEvent(new GameEvent(GameEvent.ADD_ELEMENT, e));
					
					
					_tasks.shift();
				}
				else
					_taskBuildTime ++;
			}
			else
				_tasks.shift();
		}
	}

}
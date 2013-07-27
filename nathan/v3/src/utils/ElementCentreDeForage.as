package utils 
{
	import controller.Game;
	import vues.IPlayer;
	/**
	 * Centre de forage
	 * @author Nathan
	 */
	public class ElementCentreDeForage extends Element implements IElementVision
	{
		override public function get type():TypeElement  { return TypeElement.CENTRE_DE_FORAGE; }
	
		public function ElementCentreDeForage(player:IPlayer) 
		{
			_player = player;
		}
		
		public function get distanceVision():uint
		{
			return Configuration.DISTANCE_VISION[Game.current.getUpgrades(player).relais];
		}
		
		override public function get canMove():Boolean { return true; }
		override public function get canAttack():Boolean { return false; }
		
		override public function get rayon():Number { return 1; }
		
		
		public function get isChangingState():Boolean { return _endChangingStateIn > 0; }
		public function get isUp():Boolean { return _endChangingStateIn == 0 && pathDest!=null; }
		public function get isDown():Boolean { return _endChangingStateIn == 0 && pathDest==null; }
		private var _endChangingStateIn:uint = 0;
		
		public function up():void
		{
			_endChangingStateIn = Configuration.MINE_UP_TIME;
			animation = Animation.UP;
		}
		public function down():void
		{
			_endChangingStateIn = Configuration.MINE_DOWN_TIME;
			animation = Animation.DOWN;
			Game.current.getMine(_player).currentTerrain = Game.current.map.getTerrain(this.x, this.y);
		}
		
		
		override public function update():void 
		{
			super.update();
			if (_endChangingStateIn > 0) 
			{
				_endChangingStateIn--;
				if (_endChangingStateIn == 0)
				if (pathDest != null)
					animation = Animation.MOUVEMENT;
				else
				{
					animation = Animation.REPOS;
					Game.current.getMine(_player).reinit();
				}
				
			}
		}
		
		
	}

}
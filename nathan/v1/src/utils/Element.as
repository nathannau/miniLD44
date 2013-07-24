package utils 
{
	import vues.IPlayer;
	/**
	 * Unité
	 * @author Nathan
	 */
	public class Element 
	{
		/**
		 * Proprietaire de l'unité
		 */
		public function get player():IPlayer { return _player; }
		private var _player:IPlayer;
		/**
		 * Position horizontale
		 */
		public function get x():Number { return _x; }
		public function set x(value:Number) { _x=value; }
		private var _x:Number;
		/**
		 * Position verticale
		 */
		public function get y():Number { return _y; }
		public function set y(value:Number) { _y=value; }
		private var _y:Number;
		/**
		 * Type de l'unité
		 */
		public function get type():TypeUnite { return _type; }
		private var _type:TypeUnite;
		/**
		 * Niveau de l'unité
		 */
		public function get level():uint { return _level; }
		public function set level(value:uint) { _level = value; }
		private var _level:uint = 0;
		/**
		 * Nombre de point de vie
		 */
		public function get pointDeVie():int { return _pointDeVie; }
		public function set pointDeVie(value:int) { _pointDeVie=value; }
		private var _pointDeVie:int;
		/** 
		 * Animation en cours
		 */
		public function get animation():Animation { return _animation; }
		public function set animation(value:Animation) { _animation = value; }
		private var _animation:Animation;
		/** 
		 * Direction de l'animation 
		 * -1 : regarde vers la gauche; 1 : regarde vers la droite
		 */
		public function get dirAnimation():int { return _dirAnimation; }
		public function set dirAnimation(value:int) { _dirAnimation = value; }
		private var _dirAnimation:int;
		
		
		public function Element(player:IPlayer, type:TypeElement) 
		{
				_player = player;
				_type = type;
		}
		
	}

}
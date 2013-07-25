package utils 
{
	import flash.utils.getQualifiedClassName;
	import vues.IPlayer;
	/**
	 * Class abstraite pour l'ensemble des elements
	 * @author Nathan
	 */
	public class Element 
	{
		/**
		 * Proprietaire de l'unité
		 */
		public function get player():IPlayer { return _player; }
		//protected function set player(value:IPlayer):void { _player = value; }
		protected var _player:IPlayer;
		/**
		 * Position horizontale
		 */
		public function get x():Number { return _x; }
		public function set x(value:Number):void { _x=value; }
		private var _x:Number;
		/**
		 * Position verticale
		 */
		public function get y():Number { return _y; }
		public function set y(value:Number):void { _y=value; }
		private var _y:Number;
		/**
		 * Type de l'unité
		 */
		public function get type():TypeElement { throw new Error("Fonction abstraite"); /*return _type;*/ }
		//private var _type:TypeElement;
		/**
		 * Niveau de l'unité
		 */
		public function get level():uint { return _level; }
		public function set level(value:uint):void { _level = value; }
		private var _level:uint = 0;
		/**
		 * Nombre de point de vie
		 */
		public function get pointDeVie():int { return _pointDeVie; }
		public function set pointDeVie(value:int):void { _pointDeVie=value; }
		private var _pointDeVie:int;
		/** 
		 * Animation en cours
		 */
		public function get animation():Animation { return _animation; }
		public function set animation(value:Animation):void { _animation = value; }
		private var _animation:Animation;
		/** 
		 * Direction de l'animation 
		 * -1 : regarde vers la gauche; 1 : regarde vers la droite
		 */
		public function get dirAnimation():int { return _dirAnimation; }
		public function set dirAnimation(value:int):void { _dirAnimation = value; }
		private var _dirAnimation:int;
		
		/** 
		 * Disponibilité d'un élément (Est dans le rayon de vision du centre de forage ou d'un relais disponible)
		 */
		public function get available():Boolean { return _available; }
		public function set available(value:Boolean):void { _available = value; }
		private var _available:Boolean;
		
		public function Element() //player:IPlayer, type:TypeElement) 
		{
			if (getQualifiedClassName(this)=="utils::Element")
				throw new Error("Fonction abstraite"); 
		}
		
		public static function createElement(player:IPlayer, type:TypeElement):Element
		{
			return new type.className(player);
		}
		
		public function update():void
		{
			
		}
		
	}

}
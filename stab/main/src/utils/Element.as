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
		/**
		 * Si l'element peut se déplacer
		 */
		public function get canMove():Boolean { throw new Error("Fonction abstraite"); /*return _type;*/ }
		/**
		 * Si l'element peut attaquer
		 */
		public function get canAttack():Boolean { throw new Error("Fonction abstraite"); /*return _type;*/ }
		
		public function get rayon():Number { throw new Error("Fonction abstraite"); /*return _type;*/ }
		public function get size():Number { return rayon*2;}
		
		public function get pathDest():Object { return _pathDest; }
		public function set pathDest(value:Object):void { _pathDest = value; _pathStep = null; }
		protected var _pathDest:Object = null;
		public function get pathStep():Object { return (_pathStep != null)?_pathStep:_pathDest; }
		public function set pathStep(value:Object):void { _pathStep=value; }
		protected var _pathStep:Object = null;
		
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
		public function get available():Boolean { return _visibleBy.indexOf(_player) >= 0; }
		//public function set available(value:Boolean):void { _available = value; }
		//private var _available:Boolean;
		public function clearVisible():void { _visibleBy = []; }
		public function isVisibleBy(player:IPlayer):Boolean { return _visibleBy.indexOf(player) >= 0; }
		public function visibleBy(player:IPlayer):void { _visibleBy.push(player); }
		private var _visibleBy:Array = [];

		/** 
		 * A attaqué
		 */
		public function get hasAttacked():Boolean { return _hasAttacked; }
		public function set hasAttacked(value:Boolean):void 
		{ 
			_hasAttacked = value; 
			if (value) animation = Animation.COMBAT;
		}
		private var _hasAttacked:Boolean;
		/**
		 * Nombre de cycle depuis la derniere attaque;
		 */
		public function get lastAttack():uint { return _lastAttack; }
		public function set lastAttack(value:uint):void { _lastAttack = value; }
		private var _lastAttack:uint=0;
		
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
			if (canAttack) _lastAttack++;
		}
		
	}

}
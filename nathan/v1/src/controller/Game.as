package controller 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import utils.Map;
	import vues.IPlayer;
	/**
	 * Noyau du jeu
	 * @author Nathan
	 */
	public class Game //extends EventDispatcher
	{
		/**
		 * Indique si la partie est démarée
		 */
		public function get isStarted():Boolean { return _isStarted; }
		private var _isStarted:Boolean = false;
		/**
		 * Indique si la partie est fini
		 */
		public function get isStoped():Boolean { return _isStoped; }
		private var _isStoped:Boolean = false;
		/**
		 * Indique si la partie est en pause
		 */
		public function get isPaused():Boolean { return _isPaused; }
		private var _isPaused:Boolean = false;

		/**
		 * Carte de jeu
		 * Writable avant le démarage de la partie
		 */
		public function get map():Map
		{ return _map; }
		public function set map(value:Map):void 
		{
			if (_isStarted) throw new Error("La map ne peut etre modifié quand la partie est démarée");
			_map = value;
		}
		private var _map:Map = null;
		
		/**
		 * Liste des joueurs :IPlayer[]
		 */
		public function get players():Array
		{
			return _players;
		}
		public function set players(values:Array):void
		{
			for (var i:uint; i < values.length; i++)
				if (!(values is IPlayer)) throw new ArgumentError("Un tableau de IPlayer est attendu");
			_players = values;
		}
		private var _players:Array = null;
		
		private var idTick:uint;
		
		public function Game() 
		{ 
			this.idTick = setInterval(this.update, 1000 / Configuration.me.FRAMERATE);
		}
		
		/**
		 * Démarre la partie
		 */
		public function start():void
		{
			if (_map == null) throw new UninitializedError("Map non initialisée");
			if (_players == null) throw new UninitializedError("Liste des joueurs non initialisée");
			if (_players.length<2) throw new UninitializedError("Liste des joueurs incompléte");
			
			//addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			_isStarted = true;
		}
		/**
		 * Fini la partie
		 */
		public function stop():void
		{
			if (!_isStarted) throw new Error("La partie n'est pas encore démarrée");
			_isStoped = true;
			
			if (this.idTick != 0)
				clearInterval(this.idTick);
		}
		/**
		 * Suspend la partie
		 */
		public function pause():void
		{
			if (!_isStarted) throw new Error("La partie n'est pas encore démarrée");
			if (_isStoped) throw new Error("La partie est déja terminée");
			_isPaused = true;
		}
		/**
		 * Reprend la partie
		 */
		public function resume():void
		{
			if (!_isStarted) throw new Error("La partie n'est pas encore démarrée");
			if (_isStoped) throw new Error("La partie est déja terminée");
			_isPaused = false;
		}
		
		/**
		 * Cette function gére la mise à jour du monde dans le temps.
		 */
		protected function update():void
		{
			if (!isStarted || isPaused) return;
			
			throw new Error("TODO : niveau haut")
			// TODO
		}
		
	}

}
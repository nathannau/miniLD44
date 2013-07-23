package controller 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import utils.Map;
	import utils.Mine;
	import utils.RessourcesSet;
	import utils.Upgrades;
	import vues.IPlayer;
	/**
	 * Noyau du jeu
	 * @author Nathan
	 */
	public class Game //extends EventDispatcher
	{
		public static var current:Game = null;
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
		public function get map():Map { return _map; }
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
		private var _playersInfos:Array;
		
		public function getUpgrades(player: IPlayer):Upgrades 
		{ return _playersInfos[player.index].upgrades as Upgrades; }
		public function getRessources(player: IPlayer):RessourcesSet
		{ return _playersInfos[player.index].ressources as RessourcesSet; }

				
		private var idTimer:uint;
		
		public function Game(forceStopLast:Boolean=false) 
		{ 
			if (Game.current != null) 
			{
				if (forceStopLast)
					Game.current.stop();
				else
					throw new Error("La derniere partie n'est pas terminé");
			}
			this.idTimer = setInterval(this.update, 1000 / Configuration.FRAMERATE);
			Game.current = this;
		}
		
		/**
		 * Démarre la partie
		 */
		public function start():void
		{
			if (_map == null) throw new UninitializedError("Map non initialisée");
			if (_players == null) throw new UninitializedError("Liste des joueurs non initialisée");
			if (_players.length<2) throw new UninitializedError("Liste des joueurs incompléte");
			
			_playersInfos = new Array(_players.length);
			for (var i:int = 0; i < _players.length; i++)
			{
				var p:IPlayer = _players[i] as IPlayer;
				p.index = i;
				_playersInfos[i] = 
				{ 
					upgrades:new Upgrades(), 
					ressources: Configuration.RESSOURCES_AT_START.clone(),
					mine: new Mine(Configuration.MINE_WIDTH, Configuration.MINE_DEEP, p)
				};
			}
			
			
			_isStarted = true;
		}
		/**
		 * Fini la partie
		 */
		public function stop():void
		{
			if (!_isStarted) throw new Error("La partie n'est pas encore démarrée");
			_isStoped = true;
			
			if (this.idTimer != 0)
				clearInterval(this.idTimer);
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
			
			var i:uint;
			for (i = 0; i < _playersInfos.length; i++)
				(_playersInfos[i].mine as Mine).update();
				
				
			for (i = 0; i < _players.length; i++)
				(_players[i] as IPlayer).update();
				
				
				
			throw new Error("TODO : niveau haut")
			// TODO
		}
		
	}

}
package controller 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import utils.Element;
	import utils.IElementVision;
	import utils.Map;
	import utils.Mine;
	import utils.RessourcesSet;
	import utils.TypeElement;
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
			{
				if (!(values[i] is IPlayer)) throw new ArgumentError("Un tableau de IPlayer est attendu");
			}
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
			
			var startPositions:Array = _map.getStartPositions();
			
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
				
				var centreForage:Element = Element.createElement(p, TypeElement.CENTRE_DE_FORAGE);
				centreForage.x = startPositions[i].x;
				centreForage.y = startPositions[i].y;
				
				_elements.push(centreForage);
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
		 * TODO : update fonction incomplete
		 */
		protected function update():void
		{
			if (!isStarted || isPaused) return;
			
			var i:uint;
			for (i = 0; i < _playersInfos.length; i++)
				(_playersInfos[i].mine as Mine).update();
			
			updateVisiblity();
			
			
			for (i = 0; i < _elements.length; i++) (_elements[i] as Element).update();
				
				
			for (i = 0; i < _players.length; i++)
				(_players[i] as IPlayer).update();
				
			
				
			throw new Error("TODO : niveau haut")
			// TODO
		}
		
		private function updateVisiblity(lastAvailable:Array=null):void
		{
			var i:uint, j:uint;
			if (lastAvailable == null)
			{
				for (i = 0; i < _elements.length; i++) (_elements[i] as Element).available = false;
				lastAvailable = getElements(TypeElement.CENTRE_DE_FORAGE)
				for (i = 0; i < lastAvailable.length; i++) (lastAvailable[i] as Element).available = true;
			}
			if (lastAvailable.length == 0) return;
			
			var nextAvaible:Array = new Array();
			for (i = 0; i < _elements.length; i++)
			{
				var e1:Element = _elements[i];
				if (!e1.available) for (j = 0; j < lastAvailable.length; j++)
				{
					var e2:Element = lastAvailable[j];
					var delta:uint = (e1.x - e2.x) * (e1.x - e2.x) + (e1.y - e2.y) * (e1.y - e2.y);
					if (delta <= (e2 as IElementVision).distanceVision)
					{
						nextAvaible.push(e1);
						e1.available = true;
						break;
					}
				}
			}
			updateVisiblity(nextAvaible);
		}
		
		
		/**
		 * Fournit la liste des elements présents dans une zone
		 * @param	filters Filtre des l'éléments renvoyés :
		 * Rectangle : zone où rechercher les elements
		 * IPlayer : Proprietaire des elements recherchés
		 * TypeElement* : Types des elements recherché
		 * @return Element[]
		 */
		public function getElements(... filters):Array
		{
			if (filters.length == 0) return _elements;
			var f:Object = { rectangle:null, player:null, types:[] };
			for (var i:uint = 0; i < filters.length; i++)
			{
				if (filters[i] is Rectangle)
				{
					var rect:Rectangle = filters[i];
					f.rectangle = { minX:rect.x, minY:rect.y, maxX:rect.right, maxY:rect.bottom };
				}
				else if (filters[i] is IPlayer) 
					f.player = filters[i];
				else if (filters[i] is TypeElement) 
					f.types.push(filters[i]);
			}
			
			var callback:Function = function getElementsCallback(e:Element):Boolean
			{
				if (this.rectangle != null && (e.x<this.rectangle.minX || e.x>this.rectangle.maxX || 
					e.y<this.rectangle.minY || e.y>this.rectangle.maxY)) return false;
				if (this.player != null && e.player != players) return false;
				
				if (this.types.length == 0) return true;
				for (var i:uint = 0; i < this.types; i++)
					if (e.type == this.types[i]) return true;
				
				return false;
			}
			
			return _elements.filter(callback, f);
		}
		private var _elements:Array;
		
		
		
		////////// Liste des actions disponibles
		/**
		 * Achete une mise a jour. /!\ Voir si on passe le nom de l'upgrade en param ou si on fait X fonction
		 * TODO : buyUpgrade fonction non implémentée
		 * @param	player joueur qui achete l'upgrade
		 * @param	upgrade nom de la mise a jour
		 * @return	true si la transaction à réussi.
		 */
		public function buyUpgrade(player:IPlayer, upgrade:String):Boolean
		{ throw new Error("fonction non implémentée : priorité basse"); }
		
		/**
		 * Achete un element.
		 * @param	player	propriétaire du futur l'élément
		 * @param	type	type d'element 
		 * @param	from	Element qui produit l'unité, ou position {x:uint, y:uint} où sera construit le batiment
		 * @return	true si la transaction à réussi.
		 */
		public function buyElement(player:IPlayer, type:TypeElement, from:*):Boolean
		{ throw new Error("fonction non implémentée : priorité basse"); }
		
	}

}
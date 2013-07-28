package controller 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	import flash.utils.clearInterval;
	import flash.utils.getQualifiedClassName;
	import flash.utils.setInterval;
	import utils.Animation;
	import utils.Element;
	import utils.ElementBatiment;
	import utils.ElementCentreDeForage;
	import utils.ElementUnite;
	import utils.IElementVision;
	import utils.Map;
	import utils.Mine;
	import utils.RessourcesSet;
	import utils.TypeElement;
	import utils.Upgrades;
	import vues.humain.Player;
	import vues.ia.Player;
	import vues.IPlayer;
	/**
	 * Noyau du jeu
	 * @author Nathan
	 */
	public class Game extends EventDispatcher
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
				if (!(values[i] is IPlayer)) throw new ArgumentError("Un tableau de IPlayer est attendu");
			_players = values;
		}
		public function getHumainPlayer():vues.humain.Player
		{
			for (var i:uint; i < _players.length; i++)
				if (_players[i] is vues.humain.Player) return _players[i]
			return null
		}
		private var _players:Array = null;
		private var _playersInfos:Array;
		
		public function getUpgrades(player: IPlayer):Upgrades 
		{ return _playersInfos[player.index].upgrades as Upgrades; }
		public function getRessources(player: IPlayer):RessourcesSet
		{ return _playersInfos[player.index].ressources as RessourcesSet; }
		public function getMine(player: IPlayer):Mine
		{ return _playersInfos[player.index].mine as Mine; }

				
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
			_elements = new Array();
			
			var startPositions:Array = _map.startPositions;
			
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
				centreForage.animation = Animation.REPOS;
				Mine(_playersInfos[i].mine).currentTerrain = map.getTerrain(centreForage.x, centreForage.y);
				centreForage.pointDeVie = Configuration.ELEMENTS_PV_INITIAL[TypeElement.CENTRE_DE_FORAGE.index];
				
				_elements.push(centreForage);
				dispatchEvent(new GameEvent(GameEvent.ADD_ELEMENT, centreForage));
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
			
			//var toto:Array = getElements(_players[0], TypeElement.CENTRE_DE_FORAGE);
			
			var i:uint;
			for (i = 0; i < _playersInfos.length; i++)
				(_playersInfos[i].mine as Mine).update();
			
			updateVisiblity();
			
			for (i = 0; i < _elements.length; i++) (_elements[i] as Element).update();
			
			for (i = 0; i < _elements.length; i++) (_elements[i] as Element).hasAttacked = attack(_elements[i]);
			
			var deads:Array = _elements.filter(function isAlive(e:Element, index:int, array:Array):Boolean { return e.pointDeVie <= 0 } );
			if (deads.length > 0)
			{
				_elements = _elements.filter(function isAlive(e:Element, index:int, array:Array):Boolean { return e.pointDeVie > 0 } );
				for (i = 0; i < deads.length; i++)
					dispatchEvent(new GameEvent(GameEvent.REMOVE_ELEMENT, deads[i]));
			}
			
			for (i = 0; i < _elements.length; i++) move(_elements[i]);
			
			for (i = 0; i < _players.length; i++) (_players[i] as IPlayer).update();

			for (i = 0; i < _playersInfos.length; i++) 
			{
				var mine:Mine = _playersInfos[i].mine;
				if (mine.nbUpdate > Configuration.MINE_TIMELIFE) mine.reinit();
			}
			
			if (Configuration.THROW_NOT_IMPLEMENTED) throw new Error("TODO : niveau haut");
		}
		
		/**
		 * auto attaque des element adverse à proximité
		 * @param	e
		 */
		private function attack(e:Element):Boolean
		{
			if (!e.canAttack) return false;
			var elements:Array = getElementsV2( 
				{ 
					player:e.player, 
					otherPlayer:true, 
					cercle: { x:e.x, y:e.y, r2:Configuration.PORTE_ATACK, c2:e.rayon*e.rayon }
				} 
			);
			if (elements.length == 0) return false;
			if (e.lastAttack < Configuration.CYCLE_BETWEEN_ATTACK) return true;
			
			e.lastAttack=0;
			
			var callback:Function = function callbackSortAttack(a:Element, b:Element):Number {
				var pa:int = (a is ElementUnite)?1:0;
				var pb:int = (b is ElementUnite)?1:0;
				return pb-pa;
			}
			elements.sort(callback);
			
			var bonus:Number = getBonusAttack(e, elements[0]);
			
			Element(elements[0]).pointDeVie -= Configuration.DEGATS_BY_LEVEL[e.level] * bonus;
			
			return true;
		}

		private function getBonusAttack(att:Element, def:Element):Number
		{
			var bonus:Number = 1;
			var ta:int = 0;
			switch(att.type)
			{
				case TypeElement.SOLDAT: ta = 0; break;
				case TypeElement.FUSILLEUR: ta = 1; break;
				case TypeElement.CHEVAUCHEUR: ta = 2; break;
			}
			var td:int = 0;
			switch(def.type)
			{
				case TypeElement.SOLDAT: ta = 0; break;
				case TypeElement.FUSILLEUR: ta = 1; break;
				case TypeElement.CHEVAUCHEUR: ta = 2; break;
			}
			var tt:int = map.getCase(att.x + 0.5, att.y + 0.5); // 0:Plaine, 1:montagne, 2:marais
			/*
			ta-td [-2;2] :
				-2 : malus
				-1 : bonus
				0 : neutre
				1 : malus
				2 : bonus
			*/
			switch(ta - tt)
			{
				case -2: case 1: bonus *= Configuration.BONUS_BETWEEN_UNITE; break;
				case 2: case -1: bonus /= Configuration.BONUS_BETWEEN_UNITE; break;
			}
			/*
			ta-tt [-2;2] :
				-2 : malus
				-1 : neutre
				0 : bonus
				1 : malus
				2 : neutre
			*/
			switch(ta - td)
			{
				case 0: 		 bonus *= Configuration.BONUS_FROM_TERRAIN; break;
				case -2: case 1: bonus /= Configuration.BONUS_BETWEEN_UNITE; break;
			}
			
			return bonus;
		}
		
		
		/**
		 * deplace une unité vers sa destination
		 * TODO : function non implementé
		 * @param	e
		 */
		private function move(e:Element):void
		{
			if (!e.canMove || e.hasAttacked || e.pathDest == null) return;
			if (e.type == TypeElement.CENTRE_DE_FORAGE && !ElementCentreDeForage(e).isUp) return;
			
			var dx:Number = e.pathStep.x - e.x, dy:Number = e.pathStep.y - e.y;
			var dLen2:Number = dx * dx + dy * dy;
			var dLen:Number = Math.sqrt(dLen2);
			var dirX:Number = dx / dLen, dirY:Number = dy / dLen;
			
			var obstacles:Array = getElementsV2( 
				{ cercle: { x:e.x, y:e.y, r2:Math.min(Configuration.DISTANCE_VISION_UNITE, dLen2), c2:e.rayon }}
			);
			obstacles.sort(function sortByDistance(a:Element, b:Element):Number
			{
				trace(this);
				trace(a, b);
				trace(e);
				var da:Number = (a.x - e.x) * (a.x - e.x) + (a.y - e.y) * (a.y - e.y);
				var db:Number = (b.x - e.x) * (b.x - e.x) + (b.y - e.y) * (b.y - e.y);
				if (da < db) 
					return -1;
				else if (da > db) 
					return 1;
				else 
					return 0;
			});
			
			for (var i:uint = 0; i < obstacles.length; i++)
			{
				var o:Element = obstacles[i];
				var ox:Number = o.x - e.x, oy:Number = o.y - e.y;
				var oLen: Number = Math.sqrt(ox * ox + oy * oy);
				var cx:Number = dirX * oLen + e.x, cy:Number = dirY * oLen + e.y;
				var ocx:Number = cx - o.x, ocy:Number = cy - o.y;
				var ocLen2:Number = ocx * ocx + ocy * ocy;
				if (ocLen2 <= o.rayon)
				{
					var olLen:Number = Math.sqrt(ocLen2);
					var psl:Number = Math.sqrt(o.rayon)+1;
					e.pathStep = { x: ocx * psl / olLen + o.x, y:ocy * psl / olLen + o.y };
					move(e);
					return;
				}
			}
			
			var vitesse:Number;
			if (e.type == TypeElement.CENTRE_DE_FORAGE)
				vitesse = Configuration.ELEMENTS_VITESSE[0][0];
			else
				vitesse = Configuration.ELEMENTS_VITESSE[1][e.level];
			
			var v2:Number = vitesse * vitesse;
			if (v2 > dLen2)
			{
				e.x = e.pathStep.x;
				e.y = e.pathStep.y;
				if (e.pathStep == e.pathDest)
				{
					e.pathDest = null;
					e.animation = Animation.REPOS;
					if (e.type == TypeElement.CENTRE_DE_FORAGE)
					{
						(e as ElementCentreDeForage).down();
					}
				}
				else 
					e.pathStep = null;
			}
			else
			{
				e.x += dirX * vitesse;
				e.y += dirY * vitesse;
				//d = Math.sqrt(d2);
				
				/*r = v2 / d2;
				e.x += dx * r;
				e.y += dy * r;* /
				e.x += dx / d * vitesse;
				e.y += dy / d * vitesse;
				/**/
			}
		}
		
		
		private function updateVisiblity(lastAvailable:Array=null):void
		{
			var i:uint, j:uint;
			if (lastAvailable == null)
			{
				for (i = 0; i < _elements.length; i++) (_elements[i] as Element).clearVisible();
				var forages:Array = getElements(TypeElement.CENTRE_DE_FORAGE)
				for (i = 0; i < forages.length; i++) updateVisiblity([forages[i]]);
				//return;
			}
			if (lastAvailable.length == 0) return;
			var player:IPlayer = Element(lastAvailable[0]).player;
			
			var nextAvaible:Array = new Array();
			for (i = 0; i < _elements.length; i++)
			{
				var e1:Element = _elements[i];
				if (!e1.isVisibleBy(player)) for (j = 0; j < lastAvailable.length; j++)
				{
					var e2:Element = lastAvailable[j];
					var delta:uint = (e1.x - e2.x) * (e1.x - e2.x) + (e1.y - e2.y) * (e1.y - e2.y);
					if (delta <= (e2 as IElementVision).distanceVision)
					{
						e1.visibleBy(player);
						if (e1 is IElementVision && e1.player == player)
						{
							nextAvaible.push(e1);
							break;
						}
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
		 * {x:uint, y:uint, r2:uint, c2:uint} : perimetre ou rechercher les elements
		 * @return Element[]
		 */
		public function getElements(... filters):Array
		{
			if (filters.length == 0) return _elements;
			//var f:Object = { rectangle:null, player:null, types:[], cercle:null, otherPlayer:false };
			var f:Object = { /*rectangle:null, player:null,*/ types:[], /*cercle:null, */otherPlayer:false };
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
				else if (getQualifiedClassName(this) == "Object" && filters[i].x != undefined  && filters[i].y != undefined  && filters[i].r2 != undefined)
				{
					f.cercle = filters[i];
					if (f.cercle.c2 == undefined) f.cercle.c2 = 0;
				}
			}
			
			return getElementsV2(f);
		}
		/**
		 * Fournit la liste des elements présents dans une zone
		 * @param	filters Filtre des l'éléments renvoyés :
		 * { rectangle: { minX:uint, minY:uint, maxX:uint, maxY:uint }, player:IPlayer, types:TypeElement[], cercle:{x:uint, y:uint, r2:uint, c2:uint}, contain: {x, y}, otherPlayer:Boolean }
		 * @return Element[]
		 */
		public function getElementsV2(filters:Object, elements:Array = null):Array
		{
			var e:Element;
			if (elements == null) elements = _elements;
			if (filters.otherPlayer == undefined) filters.otherPlayer = false;
			var callback:Function = function getElementsCallback(e:Element, index:int, array:Array):Boolean
			{
				//if (this.rectangle != undefined && (e.x<this.rectangle.minX || e.x>this.rectangle.maxX || 
				//	e.y<this.rectangle.minY || e.y>this.rectangle.maxY)) return false;
				if (this.rectangle != undefined && (e.x+e.rayon<this.rectangle.minX || e.x-e.rayon>this.rectangle.maxX || 
					e.y+e.rayon<this.rectangle.minY || e.y-e.rayon>this.rectangle.maxY)) return false;
				
				if (this.contain != undefined &&
					(e.x - this.contain.x) * (e.x - this.contain.x) +
					(e.y - this.contain.y) * (e.y - this.contain.y) > 
					e.rayon * e.rayon) return false;
				if (this.cercle != undefined)
				{
					var d2:Number = (e.x - this.cercle.x) * (e.x - this.cercle.x) + (e.y - this.cercle.y) * (e.y - this.cercle.y);
					if (d2<this.cercle.c2 || d2>this.cercle.r2) return false; 
				}
				/*
				if (this.cercle != undefined && 
					(e.x - this.cercle.x) * (e.x - this.cercle.x) + 
					(e.y - this.cercle.y) * (e.y - this.cercle.y) -
					(e.rayon*e.rayon + this.c2) // La formule est biaisé mais doit fonctionner...
					> this.cercle.r2) return false;
				*/
				if (this.player != undefined && ((e.player != this.player) != this.otherPlayer) ) return false;
				
				if (this.types == undefined || this.types.length == 0) return true;
				for (var i:uint = 0; i < this.types.length; i++)
					if (e.type == this.types[i]) return true;
				return false;
			}
			
			return elements.filter(callback, filters);
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
		{ 
			if (Configuration.THROW_NOT_IMPLEMENTED) throw new Error("fonction non implémentée : priorité basse"); 
			return false;
		}
		
		/**
		 * Indique le type d'unité produit par un batiment
		 * @param	bat	Batiment qui genere l'unité
		 * @return	TypeElement de l'unité
		 */
		public function getUniteForBatiment(bat:Element):TypeElement
		{
			switch (bat.type)
			{
				case TypeElement.CASERNE: return TypeElement.SOLDAT;
				case TypeElement.CENTRE_DE_TIR : return TypeElement.FUSILLEUR;
				case TypeElement.ELEVAGE_WAARK : return TypeElement.CHEVAUCHEUR;
				//case TypeElement.CENTRE_DE_FORAGE : return TypeElement.MECANO;
				default : return null;
			}
		}
		/**
		 * Calcul le niveau de creation d'un unité
		 * @param	player propriétaire du futur l'élément
		 * @param	type TypeElement de l'unité
		 */
		public function getNiveauForUnite(player:IPlayer ,type:TypeElement):uint
		{
			var upgrade:Upgrades = getUpgrades(player);
			var niveau:uint = 0;
			var delta:int;
//			var fromElement:Element = from as Element;
			
			switch(type)
			{
				case TypeElement.SOLDAT:
//					if (fromElement == null || fromElement.type != TypeElement.CASERNE) return false;
					niveau = upgrade.uniteGlobal + upgrade.soldat;
					delta = upgrade.soldat - upgrade.uniteGlobal;
					if (delta < -1) niveau += delta + 1;
					break;
				case TypeElement.FUSILLEUR:
//					if (fromElement == null || fromElement.type != TypeElement.CENTRE_DE_TIR) return false;
					niveau = upgrade.uniteGlobal + upgrade.fusilleur;
					delta = upgrade.fusilleur - upgrade.uniteGlobal;
					if (delta < -1) niveau += delta + 1;
					break;
				case TypeElement.CHEVAUCHEUR:
//					if (fromElement == null || fromElement.type != TypeElement.ELEVAGE_WAARK) return false;
					niveau = upgrade.uniteGlobal + upgrade.chevaucheur;
					delta = upgrade.chevaucheur - upgrade.uniteGlobal;
					if (delta < -1) niveau += delta + 1;
					break;
				case TypeElement.RELAIS:
					niveau = upgrade.relais;
			}
			return niveau;
		}
		/**
		 * Calcul le cout d'achat d'un element
		 * @param	player
		 * @param	type
		 * @return
		 */
		public function getUniteCost(player:IPlayer ,type:TypeElement):RessourcesSet
		{
			var niveau:uint = getNiveauForUnite(player, type);
			return Configuration.ELEMENTS_COST[type.index][niveau];
		}
		
		public function canBuy(player:IPlayer, type:TypeElement):Boolean
		{
			var niveau:uint = getNiveauForUnite(player, type);
			var cost:RessourcesSet = Configuration.ELEMENTS_COST[type.index][niveau];
			//var upgrade:Upgrades = getUpgrades(player);
			var pr:RessourcesSet = getRessources(player);

			return pr.estPlusGrandOuEgalQue(cost);
			//if (!pr.estPlusGrandOuEgalQue(cost)) return false;
			//return true;
		}
		
		/**
		 * Achete un element.
		 * @param	player	propriétaire du futur l'élément
		 * @param	type	type d'element 
		 * @param	from	Element qui produit l'unité, ou position {x:uint, y:uint} où sera construit le batiment
		 * @return	true si la transaction à réussi.
		 */
		public function buyElement(player:IPlayer, type:TypeElement, from:*):Boolean
		{
			var niveau:uint = getNiveauForUnite(player, type);
			var cost:RessourcesSet = Configuration.ELEMENTS_COST[type.index][niveau];
			//var upgrade:Upgrades = getUpgrades(player);
			var pr:RessourcesSet = getRessources(player);
			if (!pr.estPlusGrandOuEgalQue(cost)) return false;
			
			switch(type)
			{
				case TypeElement.CENTRE_DE_FORAGE:
					throw new Error("Impossible d'acheter un centre de forage");
					break;
				case TypeElement.CASERNE:
				case TypeElement.CENTRE_DE_TIR:
				case TypeElement.ELEVAGE_WAARK:
				case TypeElement.LABORATOIRE:
				case TypeElement.RELAIS:
					if (getQualifiedClassName(from) != "Object" || from.x == undefined || from == undefined)
						throw new Error("Destination incoherente"); // return false;
					//if (!canBuildBatimentAt(from.x, from.y)) return false;
					var bat:Element = new type.className(player);
					bat.x = from.x;
					bat.y = from.y;
					bat.level = niveau;
					bat.animation = Animation.CONSTRUCTION;
					bat.pointDeVie = Configuration.ELEMENTS_PV_INITIAL[type.index][niveau];
					pr.subRessourcesSet(cost);
					
					_elements.push(bat);
					dispatchEvent(new GameEvent(GameEvent.ADD_ELEMENT, bat));
					
					break;
				case TypeElement.MECANO:
					if (Configuration.THROW_NOT_IMPLEMENTED) throw new Error("Unité non implémentée : priorité basse"); 
				case TypeElement.SOLDAT:
				case TypeElement.FUSILLEUR:
				case TypeElement.CHEVAUCHEUR:
					var fromElement:ElementBatiment = from as ElementBatiment;
					if (fromElement == null || type != getUniteForBatiment(fromElement)) 
						throw new Error("Type d'unité incompatible avec le type d'origine"); //return false;
					//if (!fromElement.animation) return false;
<<<<<<< HEAD
					if (!fromElement.isBuilded || fromElement.player!=player) return false;
=======
					if (!fromElement.isBuilded || fromElement.player!=player || !fromElement.available) return false;
>>>>>>> origin/Nathan
					
					var unit:Element = new type.className(player);
					
					// TODO : Tmp
					//unit.x = from.x;
					//unit.y = from.y + 2;
					
					unit.level = niveau;
					unit.pointDeVie = Configuration.ELEMENTS_PV_INITIAL[type.index][niveau];
					//bat.animation = Animation.CONSTRUCTION;
					fromElement.tasks.push(unit);
					pr.subRessourcesSet(cost);
					
					// TODO : Tmp
					//_elements.push(unit);
			}
			
			return true;
		}
		
		/**
		 * Déplace un element
		 * @param	e Element à déplacer
		 * @param	x Coordonne de destination
		 * @param	y Coordonne de destination
		 * @return	est déplacable.
		 */
		public function moveElement(e:Element, x:uint, y:uint):Boolean
		{
			if (!e.canMove || !e.available) return false;
			//while (e.path.length > 0) e.path.pop();
			e.pathDest = null;
			e.pathStep = null
			;
			if (uint(e.x) == x && uint(e.y) == y) return false;
			if (e.type == TypeElement.CENTRE_DE_FORAGE)
			{
				if (ElementCentreDeForage(e).isDown) 
				{
					ElementCentreDeForage(e).up();
					getMine(e.player).currentTerrain = null;
				}
			}
			else
				e.animation = Animation.MOUVEMENT;
				
			//e.path.push( { x:x, y:y } );
			e.pathDest = { x:x, y:y };
			return true;
		}
		
		public function canBuildBatimentAt(x:uint, y:uint):Boolean
		{
			var es:Array = getElementsV2( { cercle: { x:x, y:y, r2:Configuration.DISTANCE_BETWEEN_BATIMENTS, c2: 0 } } );
			
			return es.length==0;
		}
		
		
		
		
	}

}
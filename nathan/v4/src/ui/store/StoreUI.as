package ui.store 
{
	import controller.Game;
	import feathers.controls.Button;
	import feathers.core.FeathersControl;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.Assets;
	import ui.game.gameObjects.GameObject;
	import ui.HUDRessource;
	import ui.SmallButton;
	import utils.Element;
	import utils.ElementBatiment;
	import utils.ElementUnite;
	import utils.RessourcesSet;
	import utils.TypeElement;
	import vues.humain.Player;
	
	/**
	 * ...
	 * @author Stab
	 */
	public class StoreUI extends Sprite 
	{
		private var _player:Player;
		private var _gameObject:GameObject;
		
		private var _opened:Boolean = false;
		
		private var _storeButton:Button;
		
		private var _storeSprite:Sprite;
		private var _storeBackground:Scale9Image;
		private var _storeContainer:Sprite;
		private var _storeCloseButton:Button;
		
		
		public function StoreUI(player:Player) 
		{
			_player = player;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_storeButton = new SmallButton("hammer", storeButtonTriggered);
			addChild(_storeButton);
			_storeButton.x = 5;
			_storeButton.y = -60;
			
			_storeSprite = new Sprite();
			addChild(_storeSprite);
			
			_storeBackground = new Scale9Image(new Scale9Textures(Assets.atlas.getTexture("menuBackground"), new Rectangle(16, 16, 22, 22)));
			_storeSprite.addChild(_storeBackground);
			
			_storeContainer = new Sprite();
			_storeSprite.addChild(_storeContainer);
			_storeContainer.x = 5;
			_storeContainer.y = 5;
			
			_storeCloseButton = new SmallButton("redCross", storeCloseButtonTriggered);
			_storeSprite.addChild(_storeCloseButton);
			_storeCloseButton.scaleX = _storeCloseButton.scaleY = 0.5;
			_storeCloseButton.pivotX = _storeCloseButton.pivotY = 17;
			
			setStoreSize(200, 100);
			
			_storeSprite.visible = false;
		}
		
		public function setAvailable(val:Boolean):void
		{
			
		}
		
		private function setStoreSize(w:uint, h:uint):void
		{
			_storeBackground.width = w;
			_storeBackground.height = h;
			_storeSprite.y = -h;
			
			_storeCloseButton.x = w - 10;
			
		}
		
		private function storeButtonTriggered(e:Event):void
		{
			open();
		}
		
		private function storeCloseButtonTriggered(e:Event):void
		{
			close();
		}
		
		public function open():void
		{
			_opened = true;
			updateOpen();
		}
		
		public function close():void
		{
			_opened = false;
			updateOpen();
		}
		
		private function updateOpen():void 
		{
			_storeButton.visible = !_opened;
			_storeSprite.visible = _opened;

		}
		
		private function menuButtonCallbackCreator(type:TypeElement):Function
		{
			return function(e:Event):void
			{
				buyButtonTriggered(type);
			}
		}
		
		public function set gameObject(g:GameObject):void
		{
			_gameObject = g;
			
			_storeContainer.removeChildren();
			var storeTypes:Array = g.getStoreItems();
			var maxResSize:uint = 0;
			for (var i:uint = 0; i < storeTypes.length; i++)
			{
				var type:TypeElement = storeTypes[i] as TypeElement;
				
				var but:Button = new Button();
				but.nameList.add("menuButton");
				but.label = type.nom;
				but.width = 160;
				but.addEventListener(Event.TRIGGERED, menuButtonCallbackCreator(type));
				
				var res:HUDRessource = new HUDRessource(Game.current.getUniteCost(Game.current.getHumainPlayer(), type));
				res.scaleX = res.scaleY = 0.6;
				res.compareTo(Game.current.getRessources(Game.current.getHumainPlayer()));

				_storeContainer.addChild(but);
				_storeContainer.addChild(res);
				
				but.y = i * 35;
				res.y = i * 35 + 8;
				res.x = 170;
				
				maxResSize = Math.max(maxResSize, res.realWidth());
			}
			//_storeContainer.y = -storeTypes.length * 35;
			
			//trace(maxResSize);
			
			setStoreSize(160 + maxResSize * 0.6 + 30, Math.max(32, _storeContainer.height + 10));
			
		}
		
		private function buyButtonTriggered(t:TypeElement):void 
		{
			if (!Game.current.canBuy(Game.current.getHumainPlayer(), t)) return;
			
			//selectedType = t;
			switch(t)
			{
				case TypeElement.CASERNE:
				case TypeElement.CENTRE_DE_TIR:
				case TypeElement.ELEVAGE_WAARK:
				case TypeElement.LABORATOIRE:
				case TypeElement.RELAIS:
					_player.placeBuilding(t);
					break;
					
				case TypeElement.MECANO:
				case TypeElement.SOLDAT:
				case TypeElement.FUSILLEUR:
				case TypeElement.CHEVAUCHEUR:
					_player.placeUnite(t, _gameObject.element);
					break;
			}

			
			//var cost:RessourcesSet = Game.current.getUniteCost(Game.current.getHumainPlayer(), t);
		}
		
		
		
	}

}
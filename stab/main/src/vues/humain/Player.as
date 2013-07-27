package vues.humain 
{
	import controller.Game;
	import feathers.controls.Button;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.Assets;
	import ui.game.GameArea;
	import ui.game.gameObjects.GameObject;
	import ui.store.PlaceBuildingUI;
	import ui.store.StoreUI;
	import utils.Element;

	import ui.HUDRessource;
	import ui.screens.ScreenManager;
	import ui.SmallButton;
	import utils.Animation;
	import utils.ElementCentreDeForage;
	import utils.TypeElement;

	import vues.IPlayer;
	
	/**
	 * Affichage pour un joueur humain
	 * TODO : vues.ia.Player classe non implémentée
	 * @author Stab
	 */
	public class Player extends Sprite implements IPlayer 
	{
		private var _index:uint;
		
		private var _isInit:Boolean = false;
		
		private var _gameAera:GameArea;
		
		public var selection:Vector.<GameObject>;
		

		private var _hudRessource:HUDRessource;
		
		private var _mineButton:Button;
		private var _eMine:ElementCentreDeForage;
		
		private var _store:StoreUI;
		
		private var _placeBuildingMode:Boolean = false;
		public function get placeBuildingMode():Boolean { return _placeBuildingMode; }
		
		private var _placeBuilding:TypeElement;
		public function get placeBuidingType():TypeElement { return _placeBuilding; }
		
		private var _placeBuildingUI:PlaceBuildingUI;
		

		public function Player() 
		{			
			selection = new Vector.<GameObject>();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedOnStage);
		}
		
		private function onAddedOnStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedOnStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			_gameAera = new GameArea(this);
			addChild(_gameAera);
			
			var pauseButton:Button = addChild(new SmallButton("pause", onPauseTriggered)) as Button;
			pauseButton.x = Main.stageWidth - 55;
			pauseButton.y = 5;
			
			var gotoMineButton:Button = addChild(new SmallButton("gotoMine", onGotoMineTriggered)) as Button;
			gotoMineButton.x = 5;
			gotoMineButton.y = 5;
			
			_mineButton = addChild(new SmallButton("drill", onMineTriggered)) as Button;
			_mineButton.x = 5;
			_mineButton.y = 60;
			
			_hudRessource = new HUDRessource(Game.current.getRessources(Game.current.getHumainPlayer()));
			_hudRessource.showOwnedOnly = false;
			addChild(_hudRessource);
			
			_hudRessource.y = 5;
			_hudRessource.x = (Main.stageWidth - _hudRessource.width) * 0.5;
			
			_store = new StoreUI(this);
			_store.visible = false;
			addChild(_store);
			
			_store.y = Main.stageHeight;
			
			_placeBuildingUI = new PlaceBuildingUI(this);
			_placeBuildingUI.visible = false;
			addChild(_placeBuildingUI);
			
			
			/*
			var pauseButton:Button = new Button();	
			pauseButton.nameList.add("smallButton");
			pauseButton.defaultIcon = new Image(Assets.atlas.getTexture("pause"));
			
			pauseButton.addEventListener(Event.TRIGGERED, onPauseTriggered);
			
			addChild(pauseButton);
			pauseButton.x = Main.stageWidth - pauseButton.width - 5;
			pauseButton.y = 5;
			
			
			var gotoMineButton:Button = new Button();
			gotoMineButton.nameList.add("smallButton");
			gotoMineButton.defaultIcon = new Image(Assets.atlas.getTexture("pause"));
			
			
			addChild(gotoMineButton);
			gotoMineButton.x = 5;
			gotoMineButton.y = 5;*/
			

		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (!_isInit && Game.current.isStarted) {
				_isInit = true;
				_gameAera.onStart();
				onInit();
			}
			
			_mineButton.visible = _eMine.isDown;
		}
		
		
			
		private function onInit():void 
		{
			_eMine = Game.current.getElements(this, [TypeElement.CENTRE_DE_FORAGE])[0];

		}
		
		public function get index():uint
		{
			return _index;
		}
		public function set index(value:uint):void
		{
			_index = value
		}		
		
		public function update():void
		{
			
		}
		
		public function onPauseTriggered(e:Event):void 
		{ 
			closeAll();
			ScreenManager.instance.showScreen(ScreenManager.instance.mainMenuScreen); 
		} 
		
		public function onGotoMineTriggered(e:Event):void 
		{ 
			
			//ScreenManager.instance.showScreen(ScreenManager.instance.mainMenuScreen); 
			_gameAera.gotoMine();
		} 
		
		public function onMineTriggered(e:Event):void
		{
			closeAll();
			ScreenManager.instance.showScreen(ScreenManager.instance.mineScreen);
		}
		
		//public function changeSelection(sel:Vector.<GameObject>):void
		public function updateSelection():void
		{
			//selection = sel;
			
			if (selection.length == 1 && selection[0].hasStore()) {
				_store.visible = true;
				_store.gameObject = selection[0];
			}
			else
			{
				_store.visible = false;
				_store.close();
			}
		}
		
		public function clearSelection():void
		{
			for (var i:uint = 0; i < selection.length; i++)
				selection[i].setSelected(false);
			
			selection.length = 0;	
		}
		
		public function placeBuilding(t:TypeElement):void
		{
			trace("place building", t);
			
			_store.close();
			
			_placeBuilding = t;
			_placeBuildingMode = true;
			//_placeBuildingUI.visible = true;
			_placeBuildingUI.open(t);
			
			clearSelection();
		}
		
		public function closePlaceBuildingMode():void
		{
			_placeBuildingUI.visible = false;
			_placeBuildingMode = false;
			
			_gameAera.closePlaceBuilding();
		}
		
		public function validateBuild(tx:uint, ty:uint):void
		{
			if (Game.current.buyElement(this, _placeBuilding, { x:tx, y:ty } ))
			{
				var elements:Array = Game.current.getElements();
				_gameAera.addElement(elements[elements.length - 1]);
			
				closePlaceBuildingMode();
			}
			else trace("can't build o_O");
			
		}
		
		public function placeUnite(t:TypeElement, from:Element):void
		{
			if (Game.current.buyElement(this, t, from))
			{
				var elements:Array = Game.current.getElements();
				_gameAera.addElement(elements[elements.length - 1]);
				
			}
			else trace("can't build o_O");
		}
		
		public function closeAll():void
		{
			closePlaceBuildingMode();
			_store.close();
		}
		
	}

}
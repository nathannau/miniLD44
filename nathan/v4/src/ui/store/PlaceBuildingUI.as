package ui.store 
{
	import feathers.controls.Label;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	import starling.events.Event;
	import ui.Assets;
	import ui.SmallButton;
	import utils.TypeElement;
	import vues.humain.Player;
	
	/**
	 * ...
	 * @author 
	 */
	public class PlaceBuildingUI extends Sprite 
	{
		private var _player:Player;
		
		private var _lbl:Label;
		
		public function PlaceBuildingUI(player:Player) 
		{
			_player = player;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var background:Scale9Image = new Scale9Image(new Scale9Textures(Assets.atlas.getTexture("menuBackground"), new Rectangle(16, 16, 22, 22)));
			background.width = 300;
			background.height = 70;
			addChild(background);
			
			y = Main.stageHeight - background.height;
			
			_lbl = new Label();
			addChild(_lbl);
			_lbl.x = 10;
			_lbl.y = 15;
			
			var closeButton:SmallButton = new SmallButton("redCross", closeButtonTriggred);
			addChild(closeButton);
			closeButton.x = width - 65;
			closeButton.y = 7;
		}
		
		public function open(type:TypeElement):void 
		{
			_lbl.text = type.nom;
			visible = true;
		}
		
		private function closeButtonTriggred(e:Event):void 
		{
			_player.closePlaceBuildingMode();
		}
		
	}

}
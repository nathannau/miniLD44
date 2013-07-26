package ui 
{
	import controller.Game;
	import feathers.controls.Label;
	import flash.text.TextFormatAlign;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import utils.Ressource;
	import utils.RessourcesSet;
	
	/**
	 * ...
	 * @author 
	 */
	public class HUDRessource extends Sprite 
	{
		
		public function HUDRessource() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var resList:Array = new Array(
				Ressource.NOURITURE, 
				Ressource.TERRE, 
				Ressource.PIERRE, 
				Ressource.FER, 
				Ressource.OR, 
				Ressource.PETROLE, 
				Ressource.CHARBON,
				Ressource.DIAMANT,
				Ressource.URANIUM
			);
			
			var resSet:RessourcesSet = Game.current.getRessources(Game.current.getHumainPlayer());
			
			for (var i:uint = 0; i < resList.length; i++)
			{
				var res:Ressource = resList[i];
				
				var img:Image = new Image(Assets.atlas.getTexture(res.nom));
				addChild(img);
			
				img.scaleX = img.scaleY = 0.7;
				
				img.x = i * 55;
				
				var value:uint = resSet.getRessource(res);
				var lbl:Label = new Label();
				lbl.text = value.toString();
				lbl.width = 55;
				
				addChild(lbl);
				lbl.textRendererProperties.textFormat.align = TextFormatAlign.CENTER;
				lbl.textRendererProperties.textFormat.bold = true;
				
				lbl.x = i * 55 - 10;
				lbl.y = 30;
				
			}
			
			
			
			
			
		}
		
	}

}
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
		private var resList:Array = new Array(
			Ressource.NOURITURE, 
			//Ressource.TERRE, 
			Ressource.PIERRE, 
			Ressource.CHARBON,
			Ressource.FER, 
			Ressource.OR, 
			Ressource.PETROLE, 
			Ressource.DIAMANT,
			Ressource.URANIUM
		);
		
		private var _resSet:RessourcesSet;
		
		private var resLbl:Object = new Object();
		
		public var showOwnedOnly:Boolean = true;
		private var _offset:uint;
		
		private var _compareTo:RessourcesSet = null;
		
		public function HUDRessource(resSet:RessourcesSet) 
		{
			_resSet = resSet;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			for (var i:uint = 0; i < resList.length; i++)
			{
				var res:Ressource = resList[i];
				var value:uint = _resSet.getRessource(res);
				
				var rp:RessourcePair = new RessourcePair(res, value);
				addChild(rp);
				
				rp.x = i * 55;
				
				resLbl[res.index] = rp;
			}
			
			updateSize();
			
			/*
			
			//var resSet:RessourcesSet = Game.current.getRessources(Game.current.getHumainPlayer());
			
			for (var i:uint = 0; i < resList.length; i++)
			{
				var res:Ressource = resList[i];
				
				var img:Image = new Image(Assets.atlas.getTexture(res.nom));
				addChild(img);
			
				img.scaleX = img.scaleY = 0.7;
				
				img.x = i * 55;
				
				var value:uint = _resSet.getRessource(res);
				var lbl:Label = new Label();
				lbl.text = value.toString();
				//lbl.width = 55;
				//lbl.width = lbl.
				lbl.validate();
				
				
				addChild(lbl);
				lbl.textRendererProperties.textFormat.align = TextFormatAlign.CENTER;
				lbl.textRendererProperties.textFormat.bold = true;
				
				lbl.x = i * 55 - 10;
				lbl.y = 30;
				
				resLbl[res.index] = lbl;
				
			}
			*/
			
			
			
			
		}
		
		private function onEnterFrame(e:Event):void 
		{
			//var resSet:RessourcesSet = Game.current.getRessources(Game.current.getHumainPlayer());
			updateSize();
			
		}
		
		private function updateSize():void
		{
			
			var offset:uint = 0;
			for (var i:uint = 0; i < resList.length; i++)
			{				
				var res:Ressource = resList[i];
				var value:uint = _resSet.getRessource(res);
				
				var rp:RessourcePair = resLbl[res.index] as RessourcePair;
				if (showOwnedOnly && value == 0)
				{
					
					rp.visible = false;
					//rp.width = 0;
					rp.x = 0;
				}
				else
				{
					rp.visible = true;
					rp.value = value;
					
					rp.x = offset;
					offset += rp.width;
					
					if (_compareTo != null) {
						rp.compareTo(_compareTo.getRessource(res));
					}
				}

			}
			_offset = offset;
		}
		
		public function realWidth():uint
		{
			return _offset;
		}
		
		public function compareTo(rs:RessourcesSet):void
		{
			_compareTo = rs;
		}
		
	}

}
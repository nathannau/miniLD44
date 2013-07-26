package ui 
{
	import feathers.controls.Button;
	import starling.display.Image;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class SmallButton extends Button 
	{
		
		public function SmallButton(textureName:String, callback:Function) 
		{
			super();
			nameList.add("smallButton");
			defaultIcon = new Image(Assets.atlas.getTexture(textureName));
			
			addEventListener(Event.TRIGGERED, callback);
		}
		
	}

}
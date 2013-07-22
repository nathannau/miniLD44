package ui
{
	import flash.media.Sound;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Assets 
	{		
		[Embed(source="/../assets/images/atlas.png")]
		protected static const ATLAS_IMAGE:Class;

		[Embed(source="/../assets/images/atlas.xml",mimeType="application/octet-stream")]
		protected static const ATLAS_XML:Class;
		
		[Embed(source = "/../assets/sounds/miniLD44_03.mp3")]
		protected static const MUSIC:Class;

		
		public static var texture:Texture;
		public static var xml:XML;
		public static var atlas:TextureAtlas;
		
		public static var music:Sound;
		
		public static function init():void
		{
			
			// create atlas
			texture = Texture.fromBitmap(new ATLAS_IMAGE());
			xml = XML(new ATLAS_XML());
			atlas = new TextureAtlas(texture, xml);
			
			music = new MUSIC();
			
		}
		
		
	}

}
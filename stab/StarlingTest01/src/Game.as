package  
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author 
	 */
	public class Game extends Sprite 
	{
		
		public function Game() 
		{
			var quad:Quad = new Quad(1024, 1024, 0x889B3C);
			addChild(quad);
			
			
			var mecano:MovieClip = new MovieClip(Ressource.atlas.getTextures("mecano"));
			addChild(mecano);
			mecano.x = 100;
			mecano.y = 300;
			mecano.pivotX = 128;
			mecano.pivotY = 196;
			
			
			Starling.juggler.add(mecano);
			mecano.play();
			
			
			var soldier:MovieClip = new MovieClip(Ressource.atlas.getTextures("soldier"));
			addChild(soldier);
			
			soldier.x = 200;
			soldier.y = 300;
			soldier.pivotX = 128;
			soldier.pivotY = 196;
			
			var gunman:MovieClip = new MovieClip(Ressource.atlas.getTextures("gunman"));
			addChild(gunman);
			
			gunman.x = 300;
			gunman.y = 300;
			gunman.pivotX = 128;
			gunman.pivotY = 196;
			
			var rider:MovieClip = new MovieClip(Ressource.atlas.getTextures("rider"));
			addChild(rider);
			
			rider.x = 200;
			rider.y = 450;
			rider.pivotX = 128;
			rider.pivotY = 196;
			
			var townmine:MovieClip = new MovieClip(Ressource.atlas.getTextures("townmine"));
			addChild(townmine);
			
			townmine.x = 600;
			townmine.y = 300;
			townmine.pivotX = 128;
			townmine.pivotY = 228;
			
			var melee:MovieClip = new MovieClip(Ressource.atlas.getTextures("melee"));
			addChild(melee);
			
			melee.x = 400;
			melee.y = 450;
			
			melee.pivotX = 128;
			melee.pivotY = 228;
		}
		
	}

}
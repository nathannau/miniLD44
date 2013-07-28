package utils 
{
	import flash.utils.getQualifiedClassName;
	/**
	 * Class abstraite pour l'ensemble des unit�s
	 * @author Nathan
	 */
	public class ElementUnite extends Element implements IElementVision 
	{
		public function ElementUnite() 
		{
			if (getQualifiedClassName(this)=="utils::ElementUnite")
				throw new Error("Classe abstraite"); 
		}
		
		public function get distanceVision():uint
		{
			return Configuration.DISTANCE_VISION_UNITE;
		}
		
		
	}

}
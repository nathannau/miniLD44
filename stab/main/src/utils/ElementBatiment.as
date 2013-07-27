package utils 
{
	import flash.utils.getQualifiedClassName;
	/**
	 * Class abstraite pour l'ensemble des batiments
	 * @author Nathan
	 */
	public class ElementBatiment extends Element
	{
		
		public function ElementBatiment() 
		{
			if (getQualifiedClassName(this)=="utils::ElementBatiment")
				throw new Error("Classe abstraite"); 
		}
		
		public function get tasks():Array { return _tasks; }
		private var _tasks:Array = new Array();
		
		override public function get size():uint { return 2;}
		
	}

}
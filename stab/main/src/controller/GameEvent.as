package controller 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameEvent extends Event 
	{
		public static const ADD_ELEMENT:String = "ADD_ELEMENT";
		public static const REMOVE_ELEMENT:String = "REMOVE_ELEMENT";
		
		private var _data:Object;
		public function get data():Object { return _data; }
		
		public function GameEvent(type:String, data:Object = null) 
		{
			super(type, true);
			_data = data;
		}
		
	}

}
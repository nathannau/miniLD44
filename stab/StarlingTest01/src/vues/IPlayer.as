package vues 
{
	import utils.RessourcesSet;
	
	/**
	 * Interface de tous les joueurs (Humain, IA, ou autre ?)
	 * @author Marco, Nathan, Stab
	 */
	public interface IPlayer 
	{
		function get index():uint;
		function set index(value:uint):void;

		function update():void;
	}
	
}
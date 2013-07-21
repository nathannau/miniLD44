package {
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
 
	import starling.core.*;
	import starling.events.ResizeEvent;
 
	public class App extends Sprite {
		private var _starling:Starling;
 
		public function App() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_starling = new Starling(Main,stage);
			_starling.enableErrorChecking = false;
			_starling.start();
			stage.addEventListener(ResizeEvent.RESIZE, resizeStage);
			stage.addEventListener(Event.DEACTIVATE, deactivateHandler);
			
			//evite la mise en veille auto
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		private function resizeStage(e:Event):void {
			/**
			 * resize event handler
			 * permet d'être sur que la stage fait bien la taille de l'écran fullscreen
			 */
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = stage.stageWidth;
			viewPortRectangle.height = stage.stageHeight;
			Starling.current.viewPort = viewPortRectangle;
 
			_starling.stage.stageWidth = stage.stageWidth;
			_starling.stage.stageHeight = stage.stageHeight;
		}
		
		
		private function deactivateHandler(event:Event):void
		{
			/**
			 * permet de vraiment quitter l'appli quand on la desactive
			 */
			NativeApplication.nativeApplication.exit();
		}
	}
}
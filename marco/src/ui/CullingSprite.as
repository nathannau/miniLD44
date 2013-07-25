package ui
{
    import flash.geom.Point;
    import starling.core.RenderSupport;
    import starling.core.Starling;
    import starling.display.DisplayObject;
	import starling.display.Sprite;
 
	/**
     * Automatically culls this sprite if it's off screen.
     * @author Ryan Andonian
     */
    public class CullingSprite extends Sprite
    {
        private static var ZEROPOINT:Point = new Point(0, 0);
        private var _globalPos:Point;
        private var _rendering:Boolean;
 
        // Implemented this because height and width are super slow
        private var _fastHeight:int;
        private var _fastWidth:int;
 
        public function CullingSprite()
        {
            super();
            _globalPos = new Point();
        }
 
        override public function render(support:RenderSupport, parentAlpha:Number):void
        {
            localToGlobal(ZEROPOINT, _globalPos);
 
            // Test if it's outside the view
            if ((_globalPos.x < -_fastWidth ||
                Main.stageWidth < (_globalPos.x)) ||
                ((_globalPos.y) < -_fastHeight ||
                Main.stageHeight < (_globalPos.y)))
                {
                    _rendering = false;
                }
                else
                {
                    _rendering = true;
                }
            if(_rendering) super.render(support, parentAlpha);
        }
 
        public function updateFastDimensions():void
        {
            _fastHeight = height;
            _fastWidth = width;
        }
 
        override public function addChildAt(child:DisplayObject, index:int):DisplayObject
        {
            super.addChildAt(child, index);
            updateFastDimensions();
            return child;
        }
 
        override public function removeChildAt(index:int, dispose:Boolean = false):DisplayObject
        {
            var child:DisplayObject = super.removeChildAt(index, dispose);
            updateFastDimensions();
            return child;
        }
    }
 
}
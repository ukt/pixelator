package app.ui.drawer {
	import flash.geom.Rectangle;

	public class RectangleToDraw extends Rectangle {
		public var color:uint = 0;
		public function RectangleToDraw(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0, color:uint = 0) {
			super(x, y, width, height);
			this.color = color;
		}
	}
}

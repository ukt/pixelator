package app.matrix {
	public class WorldPoint {
		private var _positionX:uint;
		public var b:WorldPoint;
		public var br:WorldPoint;
		public var bl:WorldPoint;
		public var t:WorldPoint;
		public var tr:WorldPoint;
		public var tl:WorldPoint;
		public var r:WorldPoint;
		public var l:WorldPoint;
		public var updated:Boolean = true;

		public function get positionX():uint {
			return _positionX;
		}

		public function get positionY():uint {
			return _positionY;
		}

		private var _positionY:uint;
		private var _pointType:PointType;

		public function WorldPoint(positionX:uint, positionY:uint, pointType:PointType) {
			this._positionX = positionX;
			this._positionY = positionY;
			_pointType = pointType;
		}

		public function update():void {

		}

		public function get pointType():PointType {
			return _pointType;
		}

		public function set pointType(value:PointType):void {
			if(_pointType != value) {
				updated = true;
				_pointType = value;
			}
		}
	}
}

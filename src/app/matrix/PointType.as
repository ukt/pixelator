package app.matrix {
	public class PointType {
		private var _color:int;
		private var _mask:int;
		private var _typeName:String;
		public function PointType(color:int, mask:int, typeName:String) {
			this._color = color;
			this._mask = mask;
			this._typeName = typeName;
		}

		public function get color():int {
			return _color;
		}

		public function get mask():int {
			return _mask;
		}

		public function get typeName():String {
			return _typeName;
		}
	}
}

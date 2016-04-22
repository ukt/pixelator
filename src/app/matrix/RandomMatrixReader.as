package app.matrix {
	public class RandomMatrixReader implements MatrixReader{
		private var _stageWidth:int;
		private var _stageHeight:int;
		private var _width:int;
		private var _height:int;
		public function RandomMatrixReader(stageWidth:int, stageHeight:int, width:int, height:int) {
			this._stageWidth = stageWidth;
			this._stageHeight = stageHeight;
			this._width = width;
			this._height = height;
		}

		public function read():Vector.<Vector.<WorldPoint>> {
			var _matrix:Vector.<Vector.<WorldPoint>> = new <Vector.<WorldPoint>>[];
			var xCount:uint = _stageWidth / _width;
			var yCount:uint = _stageHeight / _height;
			for (var y:int = 0; y < yCount; y++) {
				var worldPointsLine:Vector.<WorldPoint> = new <WorldPoint>[];
				_matrix.push(worldPointsLine);
				for (var x:int = 0; x < xCount; x++) {
					var pointTypes:Vector.<PointType> = PointTypeEnum.values;
					var index:Number = Math.round(Math.random()*(pointTypes.length-1));
					var pointType:PointType = pointTypes[index];
					worldPointsLine.push(new WorldPoint(x, y, pointType));
				}
			}
			return _matrix;
		}

		public function get pointW():Number {
			return _width;
		}

		public function get pointH():Number {
			return _height;
		}
	}
}

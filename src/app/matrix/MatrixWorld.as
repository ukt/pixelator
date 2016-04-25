package app.matrix {
	import app.matrix.point.WorldPointUpdater;

	public class MatrixWorld {
		private var _matrix:Vector.<Vector.<WorldPoint>>;
		private var _pointW:int;
		private var _pointH:int;
		private var itemUpdaters:Vector.<WorldPointUpdater>;
		private var matrixReader:MatrixReader;

		public function MatrixWorld() {

		}

		public function run():void {
			//			setInterval(update, 50);
		}

		public function update():void {
			//			var timeOut:Number = 0;
			//			var timer:int = getTimer();
			for (var worldPointLineIndex:uint = 0; worldPointLineIndex < worldPointsColumnSize; worldPointLineIndex++) {
//			for each (var worldPointsLine:Vector.<WorldPoint> in _matrix) {
				//				setTimeout(updateLine, timeOut, worldPointsLine);
				//				timeOut += 2;

				updateLine(_matrix[worldPointLineIndex]);
			}
			//			trace("timeOut", timeOut);
			//			trace("timer", getTimer() - timer)
		}

		private function updateLine(worldPointsLine:Vector.<WorldPoint>) {
			for (var worldPointIndex:uint = 0; worldPointIndex < worldPointsLineSize; worldPointIndex++) {
//			for each (var worldPoint:WorldPoint in worldPointsLine) {
				var worldPoint:WorldPoint = worldPointsLine[worldPointIndex];
				if (worldPoint.updated) {
					continue;
				}
				for (var index:uint = 0; index < itemUpdatersSize; index++) {
					itemUpdaters[index].update(worldPoint);
				}

				/*for each (var itemUpdater:WorldPointUpdater in itemUpdaters) {
				 itemUpdater.update(worldPoint);
				 }*/

			}
		}

		private var itemUpdatersSize:uint;
		private var worldPointsLineSize:uint;
		private var worldPointsColumnSize:uint;

		public function initialize(matrixReader:MatrixReader, itemUpdaters:Vector.<WorldPointUpdater>):void {
			this.matrixReader = matrixReader;
			this.itemUpdaters = itemUpdaters;
			itemUpdatersSize = itemUpdaters.length;

			updateMatrix();
		}

		public function updateMatrix():void {
			_matrix = matrixReader.read();
			initializeDependencies();
			this._pointW = matrixReader.pointW;
			this._pointH = matrixReader.pointH;
			worldPointsColumnSize = _matrix.length;
			worldPointsLineSize = _matrix[0].length;
		}

		private function initializeDependencies():void {
			for (var y:int = 0; y < _matrix.length; y++) {
				var worldPointsLine:Vector.<WorldPoint> = _matrix[y];
				for (var x:int = 0; x < worldPointsLine.length; x++) {
					var worldPoint:WorldPoint = worldPointsLine[x];
					worldPoint.b = getWorldPoint(x, y + 1);
					worldPoint.br = getWorldPoint(x + 1, y + 1);
					worldPoint.bl = getWorldPoint(x - 1, y + 1);
					worldPoint.t = getWorldPoint(x, y - 1);
					worldPoint.tr = getWorldPoint(x + 1, y - 1);
					worldPoint.tl = getWorldPoint(x - 1, y - 1);
					worldPoint.r = getWorldPoint(x + 1, y);
					worldPoint.l = getWorldPoint(x - 1, y);
				}
			}
		}

		private function getWorldPoint(x:int, y:int):WorldPoint {
			try {
				return _matrix[y][x];
			} catch (e:Error) {
			}
			return new WorldPoint(0, 0, PointTypeEnum.EMPTY);
		}

		public function get matrix():Vector.<Vector.<WorldPoint>> {
			return _matrix;
		}

		public function get pointW():int {
			return _pointW;
		}

		public function get pointH():int {
			return _pointH;
		}

	}
}

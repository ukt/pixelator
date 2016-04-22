package app.matrix {
	import app.matrix.point.WorldPointUpdater;

	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;

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
			for each (var worldPointsLine:Vector.<WorldPoint> in _matrix) {
//				setTimeout(updateLine, timeOut, worldPointsLine);
//				timeOut += 2;

				updateLine(worldPointsLine);
			}
//			trace("timeOut", timeOut);
//			trace("timer", getTimer() - timer)
		}

		private function updateLine(worldPointsLine:Vector.<WorldPoint>) {
			for each (var worldPoint:WorldPoint in worldPointsLine) {
				for each (var itemUpdater:WorldPointUpdater in itemUpdaters) {
					itemUpdater.update(worldPoint);
				}

			}
		}

		public function initialize(matrixReader:MatrixReader, itemUpdaters:Vector.<WorldPointUpdater>):void {
			this.matrixReader = matrixReader;
			this.itemUpdaters = itemUpdaters;
			updateMatrix();
		}

		public function updateMatrix():void {
			_matrix = matrixReader.read();
			initializeDependencies();
			this._pointW = matrixReader.pointW;
			this._pointH = matrixReader.pointH;
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

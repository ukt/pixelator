package app.matrix.point {
	import app.matrix.PointTypeEnum;
	import app.matrix.WorldPoint;

	public class PointSpawnerWorldPointUpdater implements WorldPointUpdater {
		public function PointSpawnerWorldPointUpdater() {
		}

		private var i:uint = 0;
		private var splitter:int = 1400;
		public function update(worldPoint:WorldPoint):void {
			if ((i++ % splitter)>0) {
				return;
			}
			splitter = Math.round(Math.random() * 1500) + 1000;
			i = 1;

			switch (worldPoint.pointType) {
				case PointTypeEnum.IRON:
					switch (worldPoint.t.pointType) {
						case PointTypeEnum.WATER:
							switch (worldPoint.r.pointType) {
								case PointTypeEnum.WATER:
								case PointTypeEnum.IRON:
									worldPoint.pointType = PointTypeEnum.VACUUM;
									break;
							}
					}
			}

		}
	}
}

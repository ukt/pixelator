package app.matrix.point {
	import app.matrix.PointTypeEnum;
	import app.matrix.WorldPoint;
	import app.matrix.point.PointUtils;

	public class PointSpawnerWorldPointUpdater implements WorldPointUpdater {
		private var mask:int = PointTypeEnum.WATER.mask&PointTypeEnum.IRON.mask;

		public function PointSpawnerWorldPointUpdater() {
			var waterMask:int = PointTypeEnum.WATER.mask;
			var ironMask:int = PointTypeEnum.IRON.mask;
			mask = waterMask | ironMask;
		}

		private var i:uint = 0;
		private var splitter:int = 1400;

		public function update(worldPoint:WorldPoint):void {
			/*if ((i++ % splitter) > 0) {
				return;
			}
			splitter = Math.round(Math.random() * 1500) + 1000;
			i = 1;*/
//			var mask:int = worldPoint.pointType.mask&PointTypeEnum.WATER.mask|PointTypeEnum.IRON.mask;
//			return;
			if (PointUtils.isPointTypeAsMask(worldPoint, PointTypeEnum.IRON.mask)) {
				if (PointUtils.isPointTypeAsMask(worldPoint.t, PointTypeEnum.WATER.mask)) {
					if (PointUtils.isPointTypeAsMask(worldPoint.r, mask)) {
						worldPoint.pointType = PointTypeEnum.VACUUM;
					}
					/*if (PointUtils.isPointTypeAsMask(worldPoint.r, PointTypeEnum.WATER.mask)) {
						worldPoint.pointType = PointTypeEnum.VACUUM;
					} else if (PointUtils.isPointTypeAsMask(worldPoint.r, PointTypeEnum.IRON.mask)) {
						worldPoint.pointType = PointTypeEnum.VACUUM;
					}*/
				}
			}
			/*switch (worldPoint.pointType) {
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
			}*/

		}
	}
}

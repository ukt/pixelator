package app.matrix.point {
	import app.matrix.PointTypeEnum;
	import app.matrix.WorldPoint;

	public class IronPointUpdater implements WorldPointUpdater{
		private var waterAndVacuumMask:int = PointTypeEnum.WATER.mask|PointTypeEnum.VACUUM.mask;
		private var ironMask:int = PointTypeEnum.IRON.mask;
		public function IronPointUpdater() {
		}

		public function update(worldPoint:WorldPoint):void {
			if(PointUtils.isPointTypeAsMask(worldPoint, ironMask) && PointUtils.isPointTypeAsMask(worldPoint.b, waterAndVacuumMask)){
				PointUtils.swapPointsType(worldPoint, worldPoint.b);
			}
			/*switch (worldPoint.t.pointType) {
				case PointTypeEnum.IRON:
				case PointTypeEnum.WATER:
					swapPointsType(worldPoint, worldPoint.t);
					break;
			}*/
		}
	}
}

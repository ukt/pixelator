package app.matrix.point {
	import app.matrix.PointTypeEnum;
	import app.matrix.WorldPoint;

	public class VacuumPointUpdater implements WorldPointUpdater{
		private var waterAndIronMask:int = PointTypeEnum.WATER.mask|PointTypeEnum.IRON.mask;
		private var vacuumMask:int = PointTypeEnum.VACUUM.mask;
		public function VacuumPointUpdater() {
		}

		public function update(worldPoint:WorldPoint):void {
			if(PointUtils.isPointTypeAsMask(worldPoint, vacuumMask) && PointUtils.isPointTypeAsMask(worldPoint.t, waterAndIronMask)){
				PointUtils.swapPointsType(worldPoint, worldPoint.t);
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

package app.matrix.point {
	import app.matrix.PointTypeEnum;
	import app.matrix.WorldPoint;

	public class DensityPointUpdater implements WorldPointUpdater{
		private var currentMask:int = PointTypeEnum.WATER.mask|PointTypeEnum.VACUUM.mask|PointTypeEnum.IRON.mask;
		public function DensityPointUpdater() {
		}

		public function update(worldPoint:WorldPoint):void {
//			if(isReadyToSwap(worldPoint))
			if(worldPoint.b.pointType!=PointTypeEnum.EMPTY){
				if (worldPoint.density > worldPoint.b.density) {
					swapPointsType(worldPoint, worldPoint.b);
					return;
				}
			}
			if(worldPoint.r.pointType!=PointTypeEnum.EMPTY){
				if (worldPoint.density > worldPoint.r.density && worldPoint.density <= worldPoint.l.density) {
					swapPointsType(worldPoint, worldPoint.r);
					return;
				}
			}

			if(worldPoint.l.pointType!=PointTypeEnum.EMPTY){
				if (worldPoint.density > worldPoint.l.density) {
					swapPointsType(worldPoint, worldPoint.l);
				}
			}
		}

		private function swapPointsType(worldPoint:WorldPoint, worldPoint2:WorldPoint):void {
			PointUtils.swapPointsType(worldPoint, worldPoint2)
		}
	}
}

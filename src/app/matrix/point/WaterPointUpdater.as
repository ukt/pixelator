package app.matrix.point {
	import app.matrix.PointTypeEnum;
	import app.matrix.WorldPoint;

	public class WaterPointUpdater implements WorldPointUpdater{
		private var waterAndIronMask:int = PointTypeEnum.WATER.mask|PointTypeEnum.IRON.mask;
		private var vacuumMask:int = PointTypeEnum.VACUUM.mask;
		private var currentMask:int = PointTypeEnum.WATER.mask;
		public function WaterPointUpdater() {
		}

		public function update(worldPoint:WorldPoint):void {
//			if(isReadyToSwap(worldPoint))
			if(((worldPoint.pointType.mask&currentMask)&worldPoint.b.pointType.mask&(waterAndIronMask))>0){
				if((worldPoint.r.pointType.mask&worldPoint.l.pointType.mask&vacuumMask)>0){
					if((worldPoint.r.r.pointType.mask&vacuumMask)>0){
						swapPointsType(worldPoint, worldPoint.r);
					} else if((worldPoint.l.l.pointType.mask&vacuumMask)>0){
						swapPointsType(worldPoint, worldPoint.l);
					} else if (Math.random() >= .5) {
						swapPointsType(worldPoint, worldPoint.r);
					} else {
						swapPointsType(worldPoint, worldPoint.l);
					}
					return;
				} else if((worldPoint.r.pointType.mask&vacuumMask)>0){
					swapPointsType(worldPoint, worldPoint.r);
					return;
				} else if((worldPoint.l.pointType.mask&vacuumMask)>0){
					swapPointsType(worldPoint, worldPoint.l);
					return;
				}
				var vacuumAtBottomRight:Boolean = (worldPoint.br.pointType.mask&vacuumMask)>0;
				var vacuumAtBottomLeft:Boolean = (worldPoint.bl.pointType.mask&vacuumMask)>0;
				if(vacuumAtBottomRight && vacuumAtBottomLeft){
					if (Math.random() >= .5) {
						swapPointsType(worldPoint, worldPoint.br);
					} else {
						swapPointsType(worldPoint, worldPoint.bl);
					}
				}else if(vacuumAtBottomRight){
					swapPointsType(worldPoint, worldPoint.br);
				} else if(vacuumAtBottomLeft){
					swapPointsType(worldPoint, worldPoint.bl);
				}
			}
			return;
			if(PointUtils.isPointTypeAsMask(worldPoint, currentMask) && PointUtils.isPointTypeAsMask(worldPoint.b, currentMask)){
				if(PointUtils.isPointTypeAsMask(worldPoint, currentMask))

				return;


				var vacuumAtRight:Boolean = worldPoint.r.pointType == PointTypeEnum.VACUUM;
				var vacuumAtLeft:Boolean = worldPoint.l.pointType == PointTypeEnum.VACUUM;
				var vacuumAtBottomRight:Boolean = vacuumAtRight && !worldPoint.br.updated && worldPoint.br.pointType == PointTypeEnum.VACUUM;
				var vacuumAtBottomLeft:Boolean = vacuumAtLeft && !worldPoint.bl.updated && worldPoint.bl.pointType == PointTypeEnum.VACUUM;
				if (vacuumAtBottomRight && vacuumAtBottomLeft) {
					if (Math.random() >= .5) {
						swapPointsType(worldPoint, worldPoint.br);
					} else {
						swapPointsType(worldPoint, worldPoint.bl);
					}
				} else if (vacuumAtBottomRight) {
					var leftWorldPointWater:WorldPoint =  PointUtils.getLastLeftWithPointType(worldPoint, PointTypeEnum.WATER);
					swapPointsType(leftWorldPointWater, worldPoint.br);
				} else if (vacuumAtBottomLeft) {
					var rightWorldPointWater:WorldPoint =  PointUtils.getLastRightWithPointType(worldPoint, PointTypeEnum.WATER);
					swapPointsType(rightWorldPointWater, worldPoint.bl);
				} else if(vacuumAtRight && !vacuumAtLeft){
					swapPointsType(worldPoint, worldPoint.r);
				} else if(!vacuumAtRight && vacuumAtLeft){
					swapPointsType(worldPoint, worldPoint.l);
				}
			}
			/*switch (worldPoint.t.pointType) {
				case PointTypeEnum.IRON:
				case PointTypeEnum.WATER:
					swapPointsType(worldPoint, worldPoint.t);
					break;
			}*/
		}

		private function swapPointsType(worldPoint:WorldPoint, worldPoint2:WorldPoint):void {
			PointUtils.swapPointsType(worldPoint, worldPoint2)
		}
	}
}

package app.matrix.point {
	import app.matrix.PointType;
	import app.matrix.PointTypeEnum;
	import app.matrix.WorldPoint;

	public class DemoWorldPointUpdater implements WorldPointUpdater {
		public function DemoWorldPointUpdater() {
		}

		public function update(worldPoint:WorldPoint):void {
			if (worldPoint.updated) {
				return;
			}
			switch (worldPoint.pointType) {
				case PointTypeEnum.WATER:
					switch (worldPoint.b.pointType) {
						case PointTypeEnum.VACUUM:
							swapPointsType(worldPoint, worldPoint.b);
							return;
						case PointTypeEnum.IRON:
						case PointTypeEnum.WATER:
							var vacuumAtRight:Boolean = !worldPoint.r.updated && worldPoint.r.pointType == PointTypeEnum.VACUUM;
							var vacuumAtLeft:Boolean = !worldPoint.l.updated && worldPoint.l.pointType == PointTypeEnum.VACUUM;
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
							} /*else if(vacuumAtRight && vacuumAtLeft){
								if (Math.random() >= .5) {
									swapPointsType(worldPoint, worldPoint.l);
								} else {
									swapPointsType(worldPoint, worldPoint.r);
								}
							}*/
							break;
					}
					switch (worldPoint.t.pointType) {
						case PointTypeEnum.IRON:
							swapPointsType(worldPoint, worldPoint.t);
							break;
					}
					break;
				case PointTypeEnum.IRON:
					switch (worldPoint.b.pointType) {
						case PointTypeEnum.VACUUM:
						case PointTypeEnum.WATER:
							swapPointsType(worldPoint, worldPoint.b);
							break;
					}
					break;
				case PointTypeEnum.VACUUM:
					switch (worldPoint.t.pointType) {
						case PointTypeEnum.IRON:
						case PointTypeEnum.WATER:
							swapPointsType(worldPoint, worldPoint.t);
							break;
					}
					break;

			}
		}

		private function swapPointsType(worldPoint:WorldPoint, worldPoint2:WorldPoint):void {
			if(!worldPoint2.updated) {
				var savedPointType:PointType = worldPoint.pointType;
				worldPoint.pointType = worldPoint2.pointType;
				worldPoint2.pointType = savedPointType;
				//			worldPoint.updated = true;
				//			worldPoint2.updated = true;
				if (worldPoint2.b) {
					//				update(worldPoint2.b)
				}
			}
		}
	}
}

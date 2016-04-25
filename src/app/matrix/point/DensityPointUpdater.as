package app.matrix.point {
	import app.matrix.PointType;
	import app.matrix.PointTypeEnum;
	import app.matrix.WorldPoint;

	import flash.geom.ColorTransform;

	public class DensityPointUpdater implements WorldPointUpdater {
		private var currentMask:int = PointTypeEnum.WATER.mask | PointTypeEnum.VACUUM.mask | PointTypeEnum.IRON.mask;

		public function DensityPointUpdater() {
		}

		public function update(worldPoint:WorldPoint):void {
			//			if(isReadyToSwap(worldPoint))
			if (worldPoint.b.pointType != PointTypeEnum.EMPTY && !worldPoint.b.updated) {
				if (worldPoint.density > worldPoint.b.density) {
					swapPointsType(worldPoint, worldPoint.b);
					return;
				}
			}


			if (worldPoint.r.pointType != PointTypeEnum.EMPTY && !worldPoint.r.updated) {
				if (worldPoint.l.updated && worldPoint.l.pointType != PointTypeEnum.EMPTY) {
					if (worldPoint.density > worldPoint.r.density && worldPoint.density <= worldPoint.l.density) {
						swapPointsType(worldPoint, worldPoint.r);
						return;
					}
				} else if (worldPoint.density > worldPoint.r.density) {
					swapPointsType(worldPoint, worldPoint.r);
					return;
				}
			}

			if (worldPoint.l.pointType != PointTypeEnum.EMPTY && !worldPoint.l.updated) {
				if (worldPoint.r.updated&& worldPoint.r.pointType != PointTypeEnum.EMPTY) {
					if (worldPoint.density > worldPoint.l.density && worldPoint.density <= worldPoint.r.density) {
						swapPointsType(worldPoint, worldPoint.l);
						return;
					}
				} else if (worldPoint.density > worldPoint.l.density) {
					swapPointsType(worldPoint, worldPoint.l);
					return;
				}
			}
			if (worldPoint.pointType == worldPoint.b.pointType && !worldPoint.b.updated && worldPoint.pointType != worldPoint.r.pointType && worldPoint.pointType != worldPoint.l.pointType&& worldPoint.pointType != worldPoint.t.pointType) {
				var my_color:ColorTransform = new ColorTransform();
				my_color.color = worldPoint.pointType.color;
				my_color.redOffset -= 30;
				my_color.greenOffset -= 30;
				my_color.blueOffset -= 30;
				worldPoint.pointType = new PointType(my_color.color, worldPoint.pointType.mask, worldPoint.pointType.densityMultiplier+.01, worldPoint.pointType.typeName);
				worldPoint.updated = true;
				return;
			}
		}

		private function swapPointsType(worldPoint:WorldPoint, worldPoint2:WorldPoint):void {
			PointUtils.swapPointsType(worldPoint, worldPoint2)
		}
	}
}

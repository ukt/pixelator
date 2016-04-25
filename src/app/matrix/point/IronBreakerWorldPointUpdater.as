package app.matrix.point {
	import app.matrix.PointType;
	import app.matrix.PointTypeEnum;
	import app.matrix.WorldPoint;

	public class IronBreakerWorldPointUpdater implements WorldPointUpdater {

		public function IronBreakerWorldPointUpdater() {
		}

		private var i:uint = 1;

		private var splitter:int = 5000000;

		public function update(worldPoint:WorldPoint):void {
			if ((i++ % splitter)>0) {
				return;
			}
			if(splitter>1){
				trace("Start IronBreakerWorldPointUpdater")
			}
//			splitter = Math.round(Math.random() * 50) + 50;
			splitter = 1;
			i = 1;
			/*if (PointUtils.isPointTypeAsMask(worldPoint, PointTypeEnum.IRON.mask)) {
				if (PointUtils.isPointTypeAsMask(worldPoint.t, PointTypeEnum.WATER.mask)) {
					if (!PointUtils.isPointTypeAsMask(worldPoint.br, PointTypeEnum.IRON.mask) && !PointUtils.isPointTypeAsMask(worldPoint.br, PointTypeEnum.IRON.mask)) {
						if (isBottomItemAnyTimesIs(worldPoint.b, PointTypeEnum.IRON, 2)) {
							if (worldPoint.r.pointType == PointTypeEnum.WATER) {
								swapPointsType(worldPoint, worldPoint.r);
							} else if (worldPoint.l.pointType == PointTypeEnum.WATER) {
								swapPointsType(worldPoint, worldPoint.l);
							}
						}
					}
				}
			}*/
			switch (worldPoint.pointType) {
				case PointTypeEnum.IRON:
					switch (worldPoint.t.pointType) {
						case PointTypeEnum.WATER:
							if (worldPoint.br.pointType != PointTypeEnum.IRON && worldPoint.bl.pointType != PointTypeEnum.IRON) {
								if (isBottomItemAnyTimesIs(worldPoint.b, PointTypeEnum.IRON, 2)) {
									if (worldPoint.r.pointType == PointTypeEnum.WATER) {
										swapPointsType(worldPoint, worldPoint.r);
									} else if (worldPoint.l.pointType == PointTypeEnum.WATER) {
										swapPointsType(worldPoint, worldPoint.l);
									}

								}
							}
					}
			}

		}

		private function isBottomItemAnyTimesIs(b:WorldPoint, pointType:PointType, times:int):Boolean {
			if(!b || !b.b) return false;
			if (!PointUtils.isPointTypeAsMask(b.r, PointTypeEnum.WATER.mask)){
				return false;
			}
			if (!PointUtils.isPointTypeAsMask(b.l, PointTypeEnum.WATER.mask)){
				return false;
			}/*
			if (b.r.pointType != PointTypeEnum.WATER || b.l.pointType != PointTypeEnum.WATER) {
				return false;
			}*/
			if (times <= 0) {
				return PointUtils.isPointTypeAsMask(b, pointType.mask);
			}
			return isBottomItemAnyTimesIs(b.b, pointType, --times);
		}

		private function swapPointsType(worldPoint:WorldPoint, worldPoint2:WorldPoint):void {
//			if (!worldPoint2.updated) {
				var savedPointType:PointType = worldPoint.pointType;
				worldPoint.pointType = worldPoint2.pointType;
				worldPoint2.pointType = savedPointType;
				//			worldPoint.updated = true;
				//			worldPoint2.updated = true;
				if (worldPoint2.b) {
					//				update(worldPoint2.b)
				}
//			}
		}
	}
}

package app.matrix.point {
	import app.matrix.PointType;
	import app.matrix.WorldPoint;

	public class PointUtils {
		public function PointUtils() {
		}

		public static function getLastLeftWithPointType(worldPoint:WorldPoint, pointType:PointType):WorldPoint {
			if(worldPoint.l.pointType == pointType){
				return getLastLeftWithPointType(worldPoint.l, pointType);
			}
			return worldPoint;
		}

		public static function getLastRightWithPointType(worldPoint:WorldPoint, pointType:PointType):WorldPoint {
			if(worldPoint.r.pointType == pointType){
				return getLastRightWithPointType(worldPoint.r, pointType);
			}
			return worldPoint;
		}

		public static function isPointTypeAsMask(worldPoint:WorldPoint, mask:uint):Boolean {
			return !worldPoint.updated && (worldPoint.pointType.mask & mask) > 0;
		}
		public static function swapPointsType(worldPoint:WorldPoint, worldPoint2:WorldPoint):void {
			if(!worldPoint.updated && !worldPoint2.updated) {
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

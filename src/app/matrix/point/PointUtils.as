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
	}
}

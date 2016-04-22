package app.matrix {
	public class PointTypeEnum {
		private static var mask:uint = 2;
		public static const EMPTY:PointType = new PointType(0x000, mask *= 2, "EMPTY");
		public static const WATER:PointType = new PointType(0x32B1DB, mask *= 2, "WATER");
		public static const IRON:PointType = new PointType(0x54737D, mask *= 2, "IRON");
		public static const VACUUM:PointType = new PointType(0xffffff, mask *= 2, "VACUUM");
		public static const values:Vector.<PointType> = new <PointType>[];
		private static const pointTypeEnum:PointTypeEnum = new PointTypeEnum();

		public function PointTypeEnum() {
			values.push(IRON);
			values.push(WATER);
			values.push(VACUUM);
		}
	}
}

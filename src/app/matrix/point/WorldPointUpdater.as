package app.matrix.point {
	import app.matrix.WorldPoint;

	public interface WorldPointUpdater {
		function update(worldPoint:WorldPoint):void;
	}
}

package app.matrix {
	public interface MatrixReader {
		function read():Vector.<Vector.<WorldPoint>>;
		function get pointW():Number;
		function get pointH():Number;
	}
}

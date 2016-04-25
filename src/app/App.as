package app {
	import app.App;
	import app.matrix.MatrixWorld;
	import app.matrix.RandomMatrixReader;
	import app.matrix.point.DemoWorldPointUpdater;
	import app.matrix.point.DensityPointUpdater;
	import app.matrix.point.IronBreakerWorldPointUpdater;
	import app.matrix.point.IronPointUpdater;
	import app.matrix.point.PointSpawnerWorldPointUpdater;
	import app.matrix.point.VacuumPointUpdater;
	import app.matrix.point.WaterPointUpdater;
	import app.matrix.point.WorldPointUpdater;
	import app.ui.drawer.AreaDrawer;

	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	import loka.button.Buttones;
	import loka.console.Console;

	public class App {
		public static var main:DisplayObjectContainer;
		private var matrixWorld:MatrixWorld = new MatrixWorld();

		private var _areaDrawer:AreaDrawer;

		public function App(main:Main) {
			App.main = main;
			Console.init(main);
			_areaDrawer = new AreaDrawer(main, matrixWorld);
			var width:int = 4;
			var randomMatrixReader:RandomMatrixReader = new RandomMatrixReader(main.stage.stageWidth, main.stage.stageHeight, width, width);
			var pointUpdaters:Vector.<WorldPointUpdater> = new <WorldPointUpdater>[];
//			pointUpdaters.push(new DemoWorldPointUpdater());
			pointUpdaters.push(new DensityPointUpdater());
//			pointUpdaters.push(new WaterPointUpdater());
//			pointUpdaters.push(new IronPointUpdater());
//			pointUpdaters.push(new VacuumPointUpdater());
//			pointUpdaters.push(new PointSpawnerWorldPointUpdater());
//			pointUpdaters.push(new IronBreakerWorldPointUpdater());
			matrixWorld.initialize(randomMatrixReader, pointUpdaters);
			matrixWorld.run();

			main.addChild(Buttones.createRectBtn(10, 10, 100, "update")).addEventListener(MouseEvent.CLICK, updateArea);
			main.addChild(Buttones.createRectBtn(120, 10, 100, "start")).addEventListener(MouseEvent.CLICK, startArea);
			main.addChild(Buttones.createRectBtn(240, 10, 100, "stop")).addEventListener(MouseEvent.CLICK, stopArea);
		}

		private function stopArea(event:MouseEvent):void {
			_areaDrawer.stopDrawing();
		}

		private function startArea(event:MouseEvent):void {
			_areaDrawer.startDrawing();
		}

		private function updateArea(event:MouseEvent):void {
			matrixWorld.updateMatrix();
		}
	}
}


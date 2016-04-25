package app.ui.drawer {
	import app.matrix.MatrixWorld;
	import app.matrix.WorldPoint;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	import loka.asUtils.TimeDoing;

	import loka.asUtils.TimeDoing;
	import loka.console.ConsoleCommand;

	public class AreaDrawer {
		private var main:Main;
		private var bitmap:Bitmap;
		private var matrixWorld:MatrixWorld;
		private var setPointWidthF:Function;

		public function AreaDrawer(main:Main, matrixWorld:MatrixWorld) {
			this.main = main;
			this.matrixWorld = matrixWorld;
			main.cacheAsBitmap = true;
			ConsoleCommand.registerCommand("setPointWidth", setPointWidth, "need to set point width");
			ConsoleCommand.registerCommand("resetTimeDoing", TimeDoing.resetAll, "need to reset time collector");
			ConsoleCommand.registerCommand("redraw", onEnterFrame, "need to execute on enter frame", ConsoleCommand.getHotKey(78));
		}

		private function setPointWidth(data:*):void {
			setPointWidthF = function():void {
				pointW = data;
				var bitmapData:BitmapData = new BitmapData(main.stage.stageWidth, main.stage.stageHeight, false, 0xffffff);
				bitmap.bitmapData = bitmapData;
				inputVector = new Vector.<uint>(matrixWorld.matrix[0].length * pointW * matrixWorld.matrix.length * pointW + 1);
			};
			//			bitmapData.floodFill()
		}

		public function stopDrawing():void {
			main.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function startDrawing():void {
			if (main.hasEventListener(Event.ENTER_FRAME)) {
				return;
			}
			if (bitmap == null) {
				var bitmapData:BitmapData = new BitmapData(main.stage.stageWidth, main.stage.stageHeight, false, 0xffffff);
				bitmap = new Bitmap(bitmapData);
				bitmap.cacheAsBitmap = true;
				main.addChildAt(bitmap, 0);
				inputVector = new Vector.<uint>(matrixWorld.matrix[0].length * pointW * matrixWorld.matrix.length * pointW + 1);
			}
			main.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private var i:uint = 0;
		private var pointW:int = 4;
		private var inputVector:Vector.<uint> = new <uint>[];
		private var bytes:ByteArray = new ByteArray();

		private function onEnterFrame(event:Event = null):void {
			TimeDoing.setTime("onEnterFrame");
			if(setPointWidthF){
				setPointWidthF();
				setPointWidthF = null;
			}
			var bitmapData:BitmapData = bitmap.bitmapData;

			collectVector();
//			collectByteArray();
			TimeDoing.setTime("bitmapData.set");

			bytes.position = 0;
			bitmapData.setVector(new Rectangle(0, 50, matrixWorld.matrix[0].length * pointW, matrixWorld.matrix.length * pointW), inputVector);
//			bitmapData.setPixels(new Rectangle(matrixWorld.matrix[0].length * pointW, 50, matrixWorld.matrix[0].length * pointW, matrixWorld.matrix.length * pointW), bytes);
			TimeDoing.traceIfIncreased("bitmapData.set");
			//			trace("timeOut", getTimer() - timer);
			TimeDoing.setTime("matrixWorld.update()");
			matrixWorld.update();
			TimeDoing.traceIfIncreased("matrixWorld.update()");
			TimeDoing.traceIfIncreased("onEnterFrame");

		}

		private function collectByteArray():void {
			bytes = new ByteArray();
			TimeDoing.setTime("collectPixelsInByteArray");
			for each (var worldPointsLine:Vector.<WorldPoint> in matrixWorld.matrix) {
				//				TimeDoing.setTime("collectLinePixels");
				for (var i:uint = 0; i < pointW; i++)
					for each (var worldPoint:WorldPoint in worldPointsLine) {
						worldPoint.updated = false;
						var color:uint = worldPoint.pointType.color;
						for (var t:uint = 0; t < pointW; t++) {
							bytes.writeInt(color);
							//						inputVector.push(color);
						}
					}
				//				trace(TimeDoing.getTime("collectLinePixels"));
			}
			TimeDoing.traceIfIncreased("collectPixelsInByteArray");
		}

		private function collectVector():void {
			TimeDoing.setTime("collectPixelsInVector");
			var vectorIndex:uint = 0;
			var matrixLineWidthInPoints:int = matrixWorld.matrix[0].length  * pointW;
			var pointSquareWithoutFirstLine:int = (pointW*(pointW-1));
			for (var y:uint = 0; y < matrixWorld.matrix.length; y++) {
				var matrixLine:Vector.<WorldPoint> = matrixWorld.matrix[y];
				for (var x:uint = 0; x < matrixLine.length; x++) {
					var worldPoint:WorldPoint = matrixLine[x];
					if(!worldPoint.updated){
						vectorIndex+=pointW;
						continue;
					}
					var color2:uint = worldPoint.pointType.color;
					for (var j:uint = 0; j < pointW; j++) {
						inputVector[++vectorIndex] = color2;
						for (var i:uint = 1; i < pointW; i++) {
							inputVector[vectorIndex + matrixLineWidthInPoints * i] = color2;
						}
					}
					worldPoint.updated = false;
				}
				vectorIndex += matrixLine.length * pointSquareWithoutFirstLine;
			}
			TimeDoing.traceIfIncreased("collectPixelsInVector");
		}
	}
}
package {

	import app.App;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextField;
	[SWF(width='800', height='650', frameRate='25', backgroundColor='#000000')]
	public class Main extends Sprite {

		public function Main() {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			new App(this);
//			var textField:TextField = new TextField();
//			textField.text = "Hello, World";
//			addChild(textField);
		}
	}
}

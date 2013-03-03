package elements 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import util.TextUtils;

	

	public class TextButton extends Sprite 
	{
		//-- private properties --//
		private var backgroundColor: 			Number;
		private var format: 					TextFormat;
		private var text: 						String;
		private var field: 						TextField;
		private var container: 					Sprite;
		
		//-- public methods --//
		public function TextButton(text: String, format: TextFormat = null,
									backgroundColor: Number = 0xd0d0d0) 
		{
			this.text = text;
			//if (!format) format = new TextFormat(Lib.helveticaNeueMediumFont.fontName, 25, 0x222222);
			//this.format = format;
			this.backgroundColor = backgroundColor;
			this.init();
		}
		
		//-- private methods --//
		private function init() : void
		{
			this.field = TextUtils.makeOneLine(text, this.format);
			
			this.container = new Sprite();
			
			var bw: Number = this.field.width + 25;
			var bh: Number = this.field.height + 8;
			
			this.container.graphics.beginFill(this.backgroundColor, 1);
			this.container.graphics.drawRoundRect(0, 0, bw, bh, 10, 10);
			this.container.graphics.endFill();
			
			this.container.addChild(this.field);
			
			this.field.x = bw * 0.5 - this.field.width * 0.5;
			this.field.y = bh * 0.5 - this.field.height * 0.5;
			
			this.addChild(this.container);
			
			this.container.buttonMode = true;
			this.field.mouseEnabled = false;
		}
	}
}
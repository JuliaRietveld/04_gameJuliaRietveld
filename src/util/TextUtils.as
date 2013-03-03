package util
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	

	public class TextUtils 
	{
		//-- private properties --//
		private var body: Sprite
		private var text: TextField;
		private var format: TextFormat;
		private var str: String;
		
		//-- public methods --//
		static public function makeOneLine(str: String, 
										  // format: TextFormat, 
										   embedFont: Boolean = true) : TextField
		{
			var tf: TextField = new TextField();
			//tf.defaultTextFormat = format;
			tf.htmlText = str;
			tf.selectable = false;
			tf.embedFonts = embedFont;
			tf.autoSize = TextFieldAutoSize.LEFT;
			
			return tf;
		}
		
		static public function makeMultiLine(str: String, 
											// format: TextFormat, 
											 width: Number = 200, 
											 height: Number = 100, 
											 embedFont: Boolean = true) : TextField
		{
			var tf: TextField = new TextField();
			//tf.defaultTextFormat = format;
			tf.width = width;
			tf.height = height;
			tf.htmlText = str;
			tf.selectable = false;
			tf.multiline = true;
			tf.wordWrap = true;
			tf.embedFonts = embedFont;
			
			return tf;
		}
	
		static public function makeTitle(str: String, format: TextFormat) : TextField
		{
			var tf: TextField = new TextField();
			tf.defaultTextFormat = format;
			tf.htmlText = str;
			tf.selectable = false;
			tf.embedFonts = true;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			tf.thickness += 40;
			tf.sharpness += 10;
			
			return tf;
		}
		
		static public function solveDoubleLineBug(field: TextField) : void 
		{
			var lineStr: String = String.fromCharCode(13);
			field.text = field.text.split(lineStr).join('\n');
		}
		
		//-- private methods --//
		private function init() : void 
		{
		}
	}
	
}
package
{ 
	import fl.controls.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	
	public class QuizQuestion extends Sprite
	{
		private var _question: String;
		private var _questionField: TextField;
		private var _theCorrectAnswer: int;
		private var _choices: Array;
		private var _theUserAnswer:int;
		
		//variables for positioning:
		private var _questionX:int = 25;
		private var _questionY:int = 25;
		private var _answerX:int = 60;
		private var _answerY:int = 55;
		private var _spacing:int = 25;
	
		public function QuizQuestion(data: XML)
		{ //store the supplied arguments in the private variables
			this._question = data.question;
			this._theCorrectAnswer = data.answer;
			this._choices = new Array;
			
			for each(var string:String in data.choice) 
			{
				_choices.push(string);
			}
			
			//create and position the textfield (question):
			this._questionField = new TextField();
			this._questionField.text = _question;
			this._questionField.autoSize = TextFieldAutoSize.LEFT;
			this._questionField.x = _questionX;
			this._questionField.y = _questionY;
			this.addChild(this._questionField);
			
			//create and position the radio buttons (answers):
			var myGroup:RadioButtonGroup = new RadioButtonGroup("group1");
			myGroup.addEventListener(Event.CHANGE, changeHandler);
			
			for(var i:int = 0; i < _choices.length; i++) 
			{
				var rb:RadioButton = new RadioButton();
				rb.textField.autoSize = TextFieldAutoSize.LEFT;
				rb.label = _choices[i];
				rb.group = myGroup;
				rb.value = i + 1;
				rb.x = _answerX;
				rb.y = _answerY + (i * _spacing);
				addChild(rb);
			}
		}
		private function changeHandler(event:Event): void 
		{
			_theUserAnswer = event.target.selectedData;
		}
		public function get correctAnswer():int 
		{
			return _theCorrectAnswer;
		}
		public function get userAnswer():int 
		{
			return _theUserAnswer;
		}
	}
}
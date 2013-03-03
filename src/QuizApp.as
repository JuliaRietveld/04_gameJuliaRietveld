package
{
	//import fl.controls.Button;
	import elements.TextButton;
	import util.TextUtils;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.text.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class QuizApp extends Sprite
	{
		//managing questions
		private var quizQuestions: Array;
		private var currentQuestion: QuizQuestion;
		private var currentIndex:int = 0;
		//the buttons
		private var prevButton: TextButton;
		private var nextButton: TextButton;
		private var finishButton: TextButton;
		//scoring and messages
		private var status: TextField;
		private var score:int = 0;
		
		private var xml:XML;
		
		public function QuizApp() 
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(Event.COMPLETE, xmlLoaded);
			urlLoader.load(new URLRequest("../assets/quiz.xml"));     
		}
		private function xmlLoaded(event:Event):void 
		{
			this.xml = XML(event.target.data);
			trace(this.xml);
			
			quizQuestions = new Array();
			createQuestions();
			createButtons();
			createStatusBox();
			addAllQuestions();
			hideAllQuestions();
			firstQuestion();
		}
		
		private function createQuestions():void
		{
			for each(var i:XML in xml.item) 
			{
				quizQuestions.push(new QuizQuestion(i));
			}
		}
		private function createButtons():void
		{
			var yPosition:Number = stage.stageHeight - 40;
			
			this.prevButton = new TextButton('Previous');
			this.prevButton.x = 30;
			this.prevButton.y = yPosition;
			this.prevButton.addEventListener(MouseEvent.CLICK, this.prevHandler);
			this.addChild(this.prevButton);
			
			this.nextButton = new TextButton('Next');
			this.nextButton.x = prevButton.x + prevButton.width + 40;
			this.nextButton.y = yPosition;
			this.nextButton.addEventListener(MouseEvent.CLICK, this.nextHandler);
			this.addChild(this.nextButton);
			
			this.finishButton = new TextButton('Finished');
			//this.finishButton.label = "Finish";
			this.finishButton.x = nextButton.x + nextButton.width + 40;
			this.finishButton.y = yPosition;
			this.finishButton.addEventListener(MouseEvent.CLICK, this.finishHandler);
			this.addChild(this.finishButton);
		}
		private function createStatusBox(): void
		{
			this.status = new TextField();
			this.status.autoSize = TextFieldAutoSize.LEFT;
			this.status.y = stage.stageHeight - 80;
			this.addChild(this.status);
		}
			
		private function showMessage(theMessage:String): void
		{
			this.status.text = theMessage;
			this.status.x = (stage.stageWidth / 2) - (status.width / 2);
		}
		private function addAllQuestions(): void 
		{
			for(var i:int = 0; i < quizQuestions.length; i++) 
			{
				addChild(quizQuestions[i]);
			}
		}
		private function hideAllQuestions(): void 
		{
			for(var i:int = 0; i < quizQuestions.length; i++) 
			{
				quizQuestions[i].visible = false;
			}
		}
		private function firstQuestion():void
		{
			this.currentQuestion = quizQuestions[0];
			this.currentQuestion.visible = true;
		}
		protected function finishHandler(event:MouseEvent):void
		{
			showMessage("");
			var finished:Boolean = true;
			for (var i:int = 0; i < quizQuestions.length; i++) 
			{
				if (quizQuestions[i].userAnswer == 0) 
				{
					finished = false;
					break;
				}
			}
			if (finished) 
			{
				prevButton.visible = false;
				nextButton.visible = false;
				finishButton.visible = false;
				hideAllQuestions();
				computeScore();
			} else 
			{
				showMessage("You haven't answered all of the questions");
			}
			
		}
		
		protected function nextHandler(event:MouseEvent):void
		{
			showMessage("");
			//check if the user had answerd a question in front of him
			if (currentQuestion.userAnswer == 0) 
			{
				showMessage("Please answer the current question before continuing");
				return;
			}
			if (currentIndex < (quizQuestions.length - 1)) {
				currentQuestion.visible = false;
				currentIndex++;
				currentQuestion = quizQuestions[currentIndex];
				currentQuestion.visible = true;
			} else 
			{
				showMessage("That's all the questions! Click Finish to Score, or Previous to go back");
			}
			
		}
		
		protected function prevHandler(event:MouseEvent):void
		{   //clear status text box
			showMessage("");
			if(currentIndex > 0) 
			{
				currentQuestion.visible = false;
				currentIndex--;
				currentQuestion = quizQuestions[currentIndex];
				currentQuestion.visible = true;
			} else 
			{
				showMessage("This is the first question, there are no previous ones");
			}
			
		}
		
		private function computeScore(): void 
		{
			for (var i:int = 0; i < quizQuestions.length; i++) 
			{
				if (quizQuestions[i].userAnswer == quizQuestions[i].correctAnswer) 
				{
					score++;
				}
			}
			showMessage("You answered " + score + " correct out of " + quizQuestions.length + " questions.");
		}
		
	}
}
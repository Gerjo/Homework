package {
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.events.*;
	
	public class Main extends Sprite {
		private var clock:Clock;
		
		// Variables used by the FPS functionality:
		private var currentFPS:Number	= 0;
		private var lastFPStime:Number  = 0;
		private var frameCounter:Number = 0;
		private var fpsBox:FPSTextField = new FPSTextField();
		private var increaseFPSbutton:Sprite = new Sprite();
		private var decreaseFPSbutton:Sprite = new Sprite();
		
		public function Main():void {
			init();
			stage.frameRate = 50;
		}
		
		private function init(e:Event = null):void {
			clock = new Clock(new Vector2D(200, 200));
			
			addChild(fpsBox);
			
			drawDecreaseFPSbutton();
			drawincreaseFPSbutton();
            increaseFPSbutton.addEventListener(MouseEvent.MOUSE_DOWN, onIncreaseClick);
			decreaseFPSbutton.addEventListener(MouseEvent.MOUSE_DOWN, onDecreaseClick);
            addChild(increaseFPSbutton);
			addChild(decreaseFPSbutton);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			drawSomeText();
		}
		
		public function onEnterFrame(event:Event) : void {
			framesPerSecond();
			clock.drawObject(graphics);
		}
		
				
		public function framesPerSecond() : void {
			frameCounter++;
			if (new Date().getTime() - lastFPStime > 1000) {
				currentFPS 		= frameCounter;
				frameCounter 	= 0;
				lastFPStime     = new Date().getTime();
			}
			fpsBox.setValue("Realtime FPS: " + currentFPS + "\nAttempted FPS: " + stage.frameRate);
		}
		
		private function drawincreaseFPSbutton():void {
              var textLabel:TextField = new TextField();
              increaseFPSbutton.graphics.clear();
              increaseFPSbutton.graphics.beginFill(0xD4D4D4); // grey color
              increaseFPSbutton.graphics.drawRoundRect(0, 0, 140, 25, 10, 10); // x, y, width, height, ellipseW, ellipseH
              increaseFPSbutton.graphics.endFill();
              textLabel.text = "Click to increase FPS";
              textLabel.x = 5;
              textLabel.y = 2;
			  textLabel.width = 140;
              textLabel.selectable = false;
			  increaseFPSbutton.x = 300;
              increaseFPSbutton.addChild(textLabel)
        }
		
		private function drawDecreaseFPSbutton():void {
              var textLabel:TextField = new TextField();
              decreaseFPSbutton.graphics.clear();
              decreaseFPSbutton.graphics.beginFill(0xD4D4D4); // grey color
              decreaseFPSbutton.graphics.drawRoundRect(0,0, 140, 25, 10, 10); // x, y, width, height, ellipseW, ellipseH
              decreaseFPSbutton.graphics.endFill();
              textLabel.text = "Click to decrease FPS";
              textLabel.x = 5;
              textLabel.y = 2;
              textLabel.selectable = false;
			  textLabel.width = 140;
			  decreaseFPSbutton.x = 300;
			  decreaseFPSbutton.y = 30;
              decreaseFPSbutton.addChild(textLabel);
        }
		
		private function drawSomeText() : void {
			var textLabel:TextField = new TextField();
			
			textLabel.text = "Please note that when the FPS changes, the clock will keep running \nat the same speed, albeit a bit laggy.\n\nThe realtime FPS counter in the top left corner is calculated every second.";
            textLabel.x = 10;
            textLabel.y = 360;
            textLabel.selectable = false;
			textLabel.width = 400;
			textLabel.height = 100;
			addChild(textLabel);
		}
		
		private function onIncreaseClick(event:MouseEvent):void {
			stage.frameRate += (stage.frameRate < 11) ? 1:10;
        }
		
		private function onDecreaseClick(event:MouseEvent):void {
			stage.frameRate -= (stage.frameRate < 11) ? 1:10;
        }
	}
}
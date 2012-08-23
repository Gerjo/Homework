package {
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class Clock extends Sprite implements IDrawObject {
		private var clockTranslate:Vector2D;	// Offset position for the clock on screen.
		
		private var secondDial:Dial;			
		private var milliSecondDial:Dial;	
		private var minuteDial:Dial;
		private var hourDial:Dial;
		
		public function Clock(clockTranslate:Vector2D) {
			this.clockTranslate = clockTranslate;
			
			var now:Date           = new Date();
			var secondSpeed:Number = 360 / (60) / 1000;
			var minuteSpeed:Number = 360 / (60 * 60) / 1000;
			var hourSpeed:Number   = 360 / (60 * 60 * 12) / 1000;
			
			secondDial    = new Dial(now.getSeconds() * 6 + 270, clockTranslate, new Matrix2D(0, 0, 170, 0, 0, 0), secondSpeed);
			minuteDial    = new Dial(now.getMinutes() * 6 + 270, clockTranslate, new Matrix2D(0, 0, 150, 0, 0, 0), minuteSpeed);
			hourDial      = new Dial((now.getHours() > 11 ? now.getHours()-12:now.getHours()) * 30 + 270, clockTranslate, new Matrix2D(0, 0, 50, 0, 0, 0), hourSpeed);
		}
		
		public function drawObject(graphics:Graphics) : void {
			graphics.clear();
			drawBasicClock(graphics);

			secondDial.drawObject(graphics);
			minuteDial.drawObject(graphics);
			hourDial.drawObject(graphics);
		}
		
		public function drawBasicClock(graphics:Graphics) : void {
			graphics.lineStyle(2, 0x000000);
			// Clock outline:
			graphics.drawCircle(clockTranslate.x, clockTranslate.y, 150);
			
			var baseNotch:Matrix2D 	= new Matrix2D(100, 100, 110, 110, 0, 0);
			
			// Draw a "notch" per second:
			for (var i:int = 270; i < 630; i += 6) {
				var copy:Matrix2D = baseNotch.clone();
				copy.rotate(i * Math.PI / 180);
				copy.translate(clockTranslate);
				
				graphics.moveTo(copy.a + copy.tx, copy.b + copy.ty);
				graphics.lineTo(copy.c + copy.tx, copy.d + copy.ty);
			}
			
		}
	}
}
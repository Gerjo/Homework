package  {
	import flash.display.Graphics;
	
	public class Dial implements IDrawObject {
		private var baseMatrix:Matrix2D 	= null;
		private var rotatedMatrix:Matrix2D	= null;
		private var clockTranslate:Vector2D = null;
		private var angle:Number			= 0; // Angle start position.
		private var angleSpeed:Number		= 0; // Angle increment per milli second:
		private var lastRun:Number			= new Date().getTime(); // Used to calculate the time difference per update()
				
		public function Dial(angle:Number, clockTranslate:Vector2D, baseMatrix:Matrix2D, angleSpeed:Number) {
			this.clockTranslate = clockTranslate;
			this.angleSpeed     = angleSpeed;
			this.baseMatrix		= baseMatrix;
			this.angle			= angle;
		}
		
		// The update function is called just before drawing the object.
		public function update() : void {
			var now:Number   = new Date().getTime();
			
			// Calculates the time difference between now and the last run, then multiplies it by the speed of this dial.
			var increment:Number = (now - lastRun) * angleSpeed;
			
			lastRun = now;
			
			// Yeah, I am quite sure this is how they do it at Greenwich, too.
			angle   = angle + increment;
			
			// We work with a cloned matrix as we don't want to rotate an already rotated matrix.
			rotatedMatrix = baseMatrix.clone();
			
			// Rotate accordingly to our newly generated radian angle.
			rotatedMatrix.rotate(angle * Math.PI / 180);
			
			// Apply the translation so it won't be stuck in the top left corner. Et voila, rotating was never this easy :D
			rotatedMatrix.translate(clockTranslate);
			
			if (angle % 360 == 0) angle = 0;
		}
		
		public function drawObject(graphics:Graphics) : void {
			update();
			
			graphics.lineStyle(3, 0x600000);
			// Pull the newly rotated coordinated from the matrix and draw a line depicting a dial.
			graphics.moveTo(rotatedMatrix.a + rotatedMatrix.tx, rotatedMatrix.b + rotatedMatrix.ty);
			graphics.lineTo(rotatedMatrix.c + rotatedMatrix.tx, rotatedMatrix.d + rotatedMatrix.ty);
		}
	}
}
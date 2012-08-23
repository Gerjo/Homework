package {
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Transform;

	public class Polygon2D implements IDrawObject {
		private var vectors:Array       = null;
		private var translate:Vector2D  = new Vector2D(0, 0);
		private var fillColor:uint	    = 0x600000;
		private var lineColor:uint	    = 0x000000;
		private var thickness:int	    = 1;
		private var angle:Number	    = 0; // Stored as radians!
		private var lastAngle:Number	= 0;
		
		public function Polygon2D(... args:Array) {
			vectors = (args.length > 0) ? args:new Array();
		}
		
		public function add(vector:Vector2D) : void {
			vectors.push(vector);
		}
		
		public function rotate(vector:Vector2D) : Vector2D {
			var matrix:Matrix2D = new Matrix2D(vector.x, vector.y, 0, 0, 0, 0);
			matrix.rotate(angle);
			return new Vector2D(matrix.a, matrix.b);
		}
		
		public function drawObject(graphics:Graphics) : void {
			graphics.beginFill(fillColor);
			graphics.lineStyle(thickness, lineColor);
			
			var lines:Array = getLines2D();
			for (var i:int = 0; i < lines.length; ++i) {
				(lines[i] as Line2D).drawObject(graphics);
			}
			
			graphics.endFill();
		}

		public function getLines2D() : Array {
			var lines:Array = new Array();
			for (var i:int = 0; i < vectors.length-1; ++i) {
				lines.push(new Line2D(rotate(vectors[i]).add(translate), rotate(vectors[i+1]).add(translate)));
			}
			return lines;
		}
		
		public function closedPolygon() : void {
			vectors.push(vectors[0]);
		}
				
		public function setTranslate(translate:Vector2D) : void {
			this.translate = translate
		}
		
		public function setFillColor(fillColor:uint) : void {
			this.fillColor = fillColor;
		}
		
		public function setLineStyle(thickness:int, lineColor:uint) : void{
			this.thickness = thickness;
			this.lineColor = lineColor;
		}
		
		/**
		 * 
		 * @param	degrees Degrees NOT radians indicating this polygon2D rotation angle.
		 */
		public function setAngle(degrees:Number) :void {
			lastAngle  = angle;
			this.angle = degrees * Math.PI / 180;
		}
		public function getAngle() : Number {
			return this.angle * 180 /  Math.PI;
		}
		
		public function incrementAngle(amount:Number = 1) : void {
			this.angle += Math.random()*amount;
		}
	}
}
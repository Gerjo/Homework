package  {
	import flash.display.Graphics;
	
	public class Line2D implements IDrawObject {
		private var placeVector:Vector2D;
		private var endVector:Vector2D;
		
		public function Line2D(placeVector:Vector2D, endVector:Vector2D) : void {
			this.placeVector = placeVector;
			this.endVector = endVector;
		}
		
		public function testWith(lineB:Line2D) : Vector2D {
			var lambdaA:Number = this.getLambda(lineB);
			var lambdaB:Number = lineB.getLambda(this);
			//trace("la: " + lambdaA + " lb: " + lambdaB);
			
			if ((lambdaA >= 0 && lambdaA <= 1) && (lambdaB >= 0 && lambdaB <= 1)) {
				return lineB.getDirectionVector().multiply(lambdaA).add(placeVector);
			}
			
			return null;
		}
		
		public function incrementBy(amount:Vector2D) : void {
			placeVector.incrementBy(amount);
			endVector.incrementBy(amount);
		}
		
		public function drawObject(graphics:Graphics) : void {
			graphics.beginFill(0xff00ff);
			graphics.moveTo(placeVector.x, placeVector.y);
			graphics.lineTo(endVector.x, endVector.y);
			graphics.endFill();
		}
		
		// Getters:		
		public function getLambda(lineB:Line2D) : Number {
				var rn:Number = getDirectionVector().dotProd(lineB.getNormalized());
				var sn:Number = placeVector.dotProd(lineB.getNormalized());
				//trace("rn: " + rn);
				//trace("sn: " + sn);
				//trace("con: " + getConstante());
				return (lineB.getConstante() - sn) / rn;
		}
		public function getNormalized() : Vector2D {
			// perp was being explained during class as "Add a minus sign"(and -- is still +).
			return getDirectionVector().perp.normalize();
		}
		public function getDirectionVector() : Vector2D {
			// Explained during class as "From B to A means B - A".
			return placeVector.connection(endVector);
		}
		public function getConstante() : Number {
			return placeVector.dotProd(getNormalized());
		}	
		public function getPlaceVector() : Vector2D {
			return placeVector;
		}
		public function getEndVector() : Vector2D {
			return endVector;
		}
	}

}
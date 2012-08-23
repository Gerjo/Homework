package  {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * One big messy file!
	 * By Gerjo Meier (around June 15, 2010).
	 * 
	 */
	public class Pit extends Sprite {
		private var ballArray:Array = new Array();
		private var pitHeight:int 	= 400;
		private var pitWidth:int	= 600;
		private var polyArray:Array	= new Array();
		
		public function Pit() {
			var translate:Vector2D = new Vector2D(300, 200);
			var radius:Number = 140;
			var len:int = 20;
			for (var i:int = 0; i < len; ++i) {
				var radians:Number = i * (360 / len) * Math.PI / 180;
				ballArray[i] = new BaseBall(new Vector2D(Math.cos(radians) * radius, Math.sin(radians) * radius).incrementBy(translate));
				ballArray[i].mass = 2+Math.random() * 10;
				ballArray[i].hasGravity   = true;
			}
			
			// This is the outlining box that holds all the balls together.
			polyArray[0] = new Polygon2D(new Vector2D(40, 20), new Vector2D(560, 0), new Vector2D(500, 380), new Vector2D(100, 390), new Vector2D(30, 380));
			polyArray[0].closedPolygon();
			polyArray[0].setTranslate(new Vector2D(5, 5));
			
			polyArray[1] = new Polygon2D(new Vector2D( -50, -50), new Vector2D(50, 50));
			polyArray[1].setTranslate(new Vector2D(200, 200));
			
			
			polyArray[2] = new Polygon2D(new Vector2D(0, 0), new Vector2D(500, 0), new Vector2D(500, 100), new Vector2D(0, 100));
			polyArray[2].closedPolygon();
			polyArray[2].setTranslate(new Vector2D(5, 400));	
			
			var tempBall:BaseBall;
			for (var j:int = 0; j < 5; ++j) {
				tempBall = new BaseBall(new Vector2D(60 + j * 82, 450));			
				tempBall.velocity 	  = new Vector2D((j == 4)?.05:0, 0); // Give the last ball some velocity.
				tempBall.mass         = 40;
				tempBall.useGravity   = false;
				tempBall.isMoveable   = true;
				ballArray.push(tempBall);
			}
			
			// Line to test "bounce on edge" with:
			polyArray[3] = new Polygon2D(new Vector2D(0, 0), new Vector2D(100, 0));
			polyArray[3].setTranslate(new Vector2D(600, 200));
			
			// Used for bounce on edge demonstration:
			tempBall			  = new BaseBall(new Vector2D(739, 0));			
			tempBall.velocity 	  = new Vector2D(0, 0.1); // Give the last ball some velocity.
			tempBall.mass         = 40;
			tempBall.useGravity   = false;
			tempBall.isMoveable   = true;
			ballArray.push(tempBall);
		}
		
		public function onEnterFrame(event:Event) : void {
			graphics.clear();
			
						
			for (var h:int = 0; h < polyArray.length; ++h) {
				polyArray[h].drawObject(graphics);
				var lines:Array = polyArray[h].getLines2D();
				for (var j:int = 0; j < lines.length; ++j) {
					for (var k:int = 0; k < ballArray.length; ++k) {
						testBetweenBallAndLine(lines[j], ballArray[k]);
					}
				}
			}
			
			for (var i:int = 0, len:int = ballArray.length; i < len; ++i) {
				ballArray[i].drawObject(graphics);
				//if (ballArray[i].collideWithStage) testBetweenStageAndBall(ballArray[i]);				
				for (var l:int = i + 1; l < len; ++l) {
					
					if (ballArray[l].hasGravity == true || ballArray[i].hasGravity == true) {
						gravitate(ballArray[i], ballArray[l]);
					}
					if (!ballArray[i].collideWithOther) continue;
					testBetweenBalls(ballArray[i], ballArray[l]);
				}
			}
			polyArray[1].setAngle(polyArray[1].getAngle()+.1);

			graphics.endFill();
		}
			
		private function gravitate(partA:BaseBall, partB:BaseBall):void{
			var ab : Vector2D 	= partA.position.connection(partB.position);
			var distSQ:Number 	= ab.lengthSQ;
			var dist:Number 	= ab.length;
			var force:Number 	= partA.mass * partB.mass / distSQ;
			var accelTotal:Vector2D = ab.multiply(force / dist);
			
			if(partA.useGravity) partA.velocity.incrementBy(accelTotal.divide(partA.mass*20));
			if(partB.useGravity) partB.velocity.decrementBy(accelTotal.divide(partB.mass*20));
		}

		
		public function testBetweenBalls(a:BaseBall, b:BaseBall) : Boolean {
			var connection:Vector2D = a.position.connection(b.position);
			
			if (connection.length <= a.radius + b.radius) {
				var newVelocityA:Vector2D = new Vector2D(0, 0);
				var newVelocityB:Vector2D = new Vector2D(0, 0);
				var totalMass:int = a.mass + b.mass;
				
				newVelocityA.x = ((a.mass - b.mass) * a.velocity.x + 2 * b.mass * b.velocity.x) / totalMass;
				newVelocityB.x = ((b.mass - a.mass) * b.velocity.x + 2 * a.mass * a.velocity.x) / totalMass;
				
				newVelocityA.y = ((a.mass - b.mass) * a.velocity.y + 2 * b.mass * b.velocity.y) / totalMass;
				newVelocityB.y = ((b.mass - a.mass) * b.velocity.y + 2 * a.mass * a.velocity.y) / totalMass;
				
				a.velocity = newVelocityA;
				b.velocity = newVelocityB;
				return true;
			}
			return false;
		}
		
		public function testBetweenStageAndBall(a:BaseBall) : void {
			if (a.position.x - a.radius < 0) {
				a.velocity.x *= -1;
				a.position.x = a.radius;
			} else if (a.position.y - a.radius < 0) {
				a.velocity.y *= -1;
				a.position.y = a.radius;
			} else if (a.position.x + a.radius > pitWidth) {
				a.velocity.x *= -1;
				a.position.x = pitWidth-a.radius;
			} else if (a.position.y + a.radius > pitHeight) {
				a.velocity.y *= -1;
				a.position.y = pitHeight-a.radius;
			}
		}
		
		public function testBetweenBallandVector(vector:Vector2D, ball:BaseBall) : Boolean {
			// This would've worked for a bounding box:
			// var min:Vector2D = new Vector2D(ball.position.x - ball.mass, ball.position.y - ball.mass);
			// var max:Vector2D = new Vector2D(ball.position.x + ball.mass, ball.position.y + ball.mass);
			
			// Pretty much the same as ball on ball, except that there is only one radius: 
			if (vector.connection(ball.position).length < ball.radius) {
				return true;
			}
			return false;
		}
		
		public function testBetweenBallAndLine(line:Line2D, ball:BaseBall) : void {
			
			
			
			// De radiusperp is van het midden naar de bal naar de rand waar de lijn m verschoven een raaklijn aan zou zijn
			// als de hoek tussen de snelheid en de line kleiner dan 90graden is
			var dotvm:Number = ball.velocity.dotProd(line.getNormalized());
			//trace(dotvm);
			if (dotvm > 0) {
				var radiusperp:Vector2D = line.getNormalized().multiply(ball.mass);
			} else { // Als de hoek groter dan 90 graden is
				radiusperp = line.getNormalized().multiply(ball.mass).reverse();
			}
			
			// Create a line from the center towards lineB.
			var ballToLineVelocity:Line2D = new Line2D(ball.position.subtract(radiusperp).subtract(ball.velocity), ball.position.add(radiusperp).add(ball.velocity));
			
			// Option to draw debug information:
			//ballToLineVelocity.drawObject(graphics);

			// Assuming AS3 works just like ansi C, placing the easy "statements" first will save some load.
			if (testBetweenBallandVector(line.getPlaceVector(), ball) || testBetweenBallandVector(line.getEndVector(), ball) || 
				(ballToLineVelocity.testWith(line) != null && line.testWith(ballToLineVelocity) != null)) {

				ball.velocity = ball.velocity.subtract(line.getNormalized().multiply(2).multiply(dotvm));
			}
		}
	}
}
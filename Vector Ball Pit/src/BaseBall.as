package  {
	import flash.display.Graphics;
	
	public class BaseBall implements IDrawObject {
		private var _position:Vector2D  = null;
		private var _velocity:Vector2D  = new Vector2D(0, 0); // Pixels per millisecond!
		private var lastRun:Number      = new Date().getTime(); 
		private var _mass:Number        = 0;
		private var _hasGravity:Boolean = false;
		private var _useGravity:Boolean = true;
		private var _isMoveable:Boolean = true;
		private var _collideWithStage:Boolean = true;
		private var _collideWithOther:Boolean = true;
		
		public function BaseBall(position:Vector2D) {
			this.position = position;
		}
		
		public function update() : void {
			if (!isMoveable) return;
			var now:Number         = new Date().getTime();
			
			var increment:Vector2D = new Vector2D((now - lastRun) * _velocity.x, (now - lastRun) * _velocity.y);
			lastRun 			   = now;
			position.incrementBy(increment);
		}
		
		public function drawObject(graphics:Graphics) : void {
			update();
			graphics.beginFill(0x600000, 0.5);
			graphics.drawCircle(_position.x, _position.y, _mass);
			graphics.endFill();
		}
		public function set useGravity(_useGravity:Boolean) : void {
			this._useGravity = _useGravity;
		}
		public function get useGravity() : Boolean {
			return _useGravity;
		}		
		public function set collideWithOther(_collideWithOther:Boolean) : void {
			this._collideWithOther = _collideWithOther;
		}
		public function get collideWithOther() : Boolean {
			return _collideWithOther;
		}
		public function set collideWithStage(_collideWithStage:Boolean) : void {
			this._collideWithStage = _collideWithStage;
		}
		public function get collideWithStage() : Boolean {
			return _collideWithStage;
		}
		public function set isMoveable(_isMoveable:Boolean) : void {
			this._isMoveable = _isMoveable;
		}
		public function get isMoveable() : Boolean {
			return _isMoveable;
		}
		public function set hasGravity(_hasGravity:Boolean) : void {
			this._hasGravity = _hasGravity;
		}
		public function get hasGravity() : Boolean {
			return _hasGravity;
		}
		public function set mass(_mass:Number) : void {
			this._mass = _mass;
		}
		public function get mass() :Number {
			return this._mass;
		}
		public function get radius() : Number {
			return _mass;
		}
		public function get position() : Vector2D{
			return _position;
		}
		public function get velocity() : Vector2D{
			return _velocity;
		}
		public function set position(_position:Vector2D) : void{
			this._position = _position;
		}
		public function set velocity(_velocity:Vector2D) : void{
			this._velocity = _velocity;
		}
	}
}
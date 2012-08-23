package  
{
	import flash.text.*;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
	public class FPSTextField extends TextField {
		public function FPSTextField() : void {
			this.border = true;
			this.width  = 140;
			this.height = 40;
			this.type 	= TextFieldType.INPUT;
			this.x		= 0;
			this.y      = 0;
			this.border = false;
			this.selectable = false;
		}
		
		public function getValue() : String {
			return this.text;
		}
		
		public function addValue(text:String) : void {
			this.text = text + this.text;
		}
		
		public function setValue(text:String = "") : void {
			this.text = text;
		}
	}
}
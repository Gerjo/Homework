package {
	import flash.display.Sprite;
	import flash.events.Event;

	public class Main extends Sprite {
		private var pit:Pit 		= new Pit();
		
		public function Main():void {
			init();
		}
		
		private function init(e:Event = null):void {
			addEventListener(Event.ENTER_FRAME, pit.onEnterFrame);
			addChild(pit);
			
			stage.frameRate = 100;
		}
		
	}
	
}
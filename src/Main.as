package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import game.GameMain;
	import game.StateControl;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	[Frame(factoryClass="Preloader")]
	
	public class Main extends Sprite
	{
		public static const SCENE_WIDTH:Number = 800;
		public static const SCENE_HEIGHT:Number = 300;
		public static const VIEWPORT:Rectangle = new Rectangle(0, 0, SCENE_WIDTH, SCENE_HEIGHT);
		
		private var _starling:Starling;
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_starling = new Starling(StateControl, stage);
			_starling.start();
		}
	
	}

}
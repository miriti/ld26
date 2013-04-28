package game.common
{
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameObject extends Sprite
	{
		
		public function GameObject()
		{
			super();
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void
		{
			update(e.passedTime);
		}
		
		public function update(deltaTime:Number):void
		{
		
		}
	}

}
package game
{
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class StateControl extends Sprite
	{
		private var _currentState:Sprite;
		
		private static var _instance:StateControl;
		
		public function StateControl()
		{
			_instance = this;
			super();
			
			setState(new Intro());
		}
		
		public function setState(state:Sprite):void
		{
			if (_currentState != null)
			{
				removeChild(_currentState);
			}
			
			_currentState = state;
			addChild(_currentState);
		}
		
		static public function get instance():StateControl
		{
			return _instance;
		}
	
	}

}
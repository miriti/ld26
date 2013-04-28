package game
{
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameInput
	{
		private var _keys:Vector.<Boolean> = new Vector.<Boolean>(256);
		private var _keyDownCallbacks:Vector.<Function> = new Vector.<Function>();
		private var _keyUpCallbacks:Vector.<Function> = new Vector.<Function>();
		
		public function GameInput()
		{
		
		}
		
		public function removeCallback(callback:Function):void
		{
			var i:int;
			
			i = _keyDownCallbacks.indexOf(callback);
			if (i != -1)
			{
				_keyDownCallbacks.splice(i, 1);
			}
			else
			{
				i = _keyUpCallbacks.indexOf(callback);
				if (i != -1)
				{
					_keyUpCallbacks.indexOf(callback);
				}
			}
		}
		
		public function addKeyDownCallback(keyDownCallback:Function):void
		{
			_keyDownCallbacks.push(keyDownCallback);
		}
		
		public function addKeyUpCallback(keyUpCallback:Function):void
		{
			_keyUpCallbacks.push(keyUpCallback);
		}
		
		public function isLeft():Boolean
		{
			return ((_keys[Keyboard.LEFT]) || (_keys[Keyboard.A]));
		}
		
		public function isRight():Boolean
		{
			return ((_keys[Keyboard.RIGHT]) || (_keys[Keyboard.D]));
		}
		
		public function keyDown(code:uint):void
		{
			for (var i:int = 0; i < _keyDownCallbacks.length; i++)
			{
				_keyDownCallbacks[i].call(this, code);
			}
			
			_keys[code] = true;
		}
		
		public function keyUp(code:uint):void
		{
			for (var i:int = 0; i < _keyUpCallbacks.length; i++)
			{
				_keyUpCallbacks[i].call(this, code);
			}
			_keys[code] = false;
		}
	}

}
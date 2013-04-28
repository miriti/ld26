package game.mobs
{
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import game.common.Blood;
	import game.common.GameObject;
	import game.common.Mut;
	import game.common.Palette;
	import game.GameMain;
	import game.levels.Level;
	import game.levels.Level0;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Player extends Mob
	{
		private var _q:Quad;
		
		private static var _instance:Player;
		private var onLevel:Level;
		static private const SPEED:Number = 2;
		static private const NORMAL_SPEED:Number = 3;
		static private const MAX_SPEED:Number = 8;
		static private const ACC_TIME:Number = 0.3;
		
		private var _moveSpeedTarget:Point = new Point();
		private var _moveSpeed:Point = new Point();
		
		private var _lastKeyStrokeTime:Number;
		private var _keyHold:Boolean = false;
		private var _win:Boolean = false;
		private var _control:Boolean = true;
		private var _playerSpeed:Number = 0;		
	
		private var _lable:TextField;
		
		public function Player()
		{
			super();
			
			_instance = this;
			
			_q = new Quad(40, 80, Palette.C[4]);
			_q.x = -_q.width / 2;
			_q.y = -_q.height;
			
			addChild(_q);
			
			_lable = new TextField(40, 40, "U", "Verdana", 20, Palette.C[7], true);
			_lable.y = -_q.height;
			_lable.x = -_q.width / 2;
			addChild(_lable);			
			
			GameMain.input.addKeyDownCallback(keyDown);
			GameMain.input.addKeyUpCallback(keyUp);
		}
		
		override public function isKillable():Boolean
		{
			return ((!_dead) && (!_win));
		}
	
		
		public function controllOff():void
		{
			_control = false;
		}
		
		override public function kill():void
		{
			super.kill();
			
			_control = false;
			
			GameMain.instance.fadeIn(3, 1, function():void
				{
					GameMain.instance.initLevel();
				});
		}
		
		private function keyUp(code:uint):void
		{
			_keyHold = false;
		}
		
		private function keyDown(code:uint):void
		{
			if (!_keyHold)
			{
				_playerSpeed = NORMAL_SPEED;
				
				var currentTime:Number = new Date().getTime();
				var delta:Number = (currentTime - _lastKeyStrokeTime);
				
				if ((delta > 100) && (delta < 300))
				{
					_playerSpeed = MAX_SPEED;
				}
				
				_lastKeyStrokeTime = currentTime;
				
				_keyHold = true;
			}
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			x += _moveSpeed.x;
			
			var _accStep:Number = _playerSpeed / (ACC_TIME * 60);
			
			if (_control)
			{
				if (GameMain.input.isLeft())
				{
					_moveSpeed.x = Mut.aspire(-_playerSpeed, _moveSpeedTarget.x, _accStep);
				}
				else if (GameMain.input.isRight())
				{
					_moveSpeed.x = Mut.aspire(_playerSpeed, 0, _accStep);
				}
				else
				{
					_moveSpeed.x = Mut.aspire(_moveSpeed.x, 0, _accStep);
				}
			}
			else
			{
				_moveSpeed.x = Mut.aspire(_moveSpeed.x, 0, _accStep);
			}
		}
		
		static public function produceNew():void
		{
			_instance = new Player();
		}
		
		static public function get instance():Player
		{
			if (_instance == null)
				return new Player();
			return _instance;
		}
		
		static public function getInstance():Player
		{
			return instance;
		}		
		
		public function get dead():Boolean
		{
			return _dead;
		}
		
		public function get win():Boolean
		{
			return _win;
		}
		
		public function set win(value:Boolean):void
		{
			_win = value;
		}
	
	}

}
package game
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import game.common.Palette;
	import game.common.PlaySound;
	import game.levels.Level;
	import game.levels.Level0;
	import game.levels.Level1;
	import game.levels.Level2;
	import game.levels.Level3;
	import game.levels.Tutorial;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameMain extends Sprite
	{
		private var _levels:Array = [Tutorial, Level0, Level1, Level2, Level3];
		private var _currentLevelIndex:int = 0;
		private var _currentLevel:Level;
		private var _shaking:Boolean = false;
		private var _shakingAmp:Point = new Point();
		private var _shakingPhase:Number = 0;
		
		private var _gameLayer:Sprite = new Sprite();
		private var _dieLayer:Sprite = new Sprite();
		private var _fadeQuad:Quad = new Quad(Main.SCENE_WIDTH, Main.SCENE_HEIGHT, Palette.C[0]);
		
		private var _die:TextField = new TextField(Main.SCENE_WIDTH, 100, "", "Verdana", 40, Palette.C[7]);
		
		private static var _instance:GameMain;
		private var _music:PlaySound;
		private var _dieTween:TweenLite;
		
		public static var input:GameInput = new GameInput();
		
		public function GameMain()
		{
			_instance = this;
			
			super();
			
			addChild(_gameLayer);
			addChild(_dieLayer);
			_dieLayer.addChild(_die);
			addChild(_fadeQuad);
			initLevel();
			
			_fadeQuad.alpha = 1;
			fadeOut();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			
			_music = new PlaySound(Assets.getSound(Assets.sndOst));
			_music.volume = 0;
			_music.loop = true;
			_music.play();
			TweenLite.to(_music, 5, {volume: 0.7, ease: Linear.easeNone});
		}
		
		public function shake(time:Number, amp:Number):void
		{
			_shakingPhase = 0;
			_shakingAmp.setTo(amp, amp);
			_shaking = true;
			TweenLite.to(_shakingAmp, time, {x: 0, y: 0, onComplete: function():void
				{
					x = y = 0;
					_shaking = false;
				}});
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void
		{
			if (_shaking)
			{
				y = Math.sin(_shakingPhase) * _shakingAmp.y;
				
				_shakingPhase += Math.PI / 8;
			}
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			input.keyUp(e.keyCode);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			input.keyDown(e.keyCode);
		}
		
		/**
		 * Fade in
		 *
		 * @param	time
		 * @param	delay		Delay before start fade
		 * @param	callback
		 */
		public function fadeIn(time:Number = 3, delay:Number = 0, callback:Function = null):void
		{
			_fadeQuad.alpha = 0;
			TweenLite.to(_fadeQuad, time, {alpha: 1, delay: delay, onComplete: callback});
		}
		
		/**
		 * Fade out
		 *
		 * @param	time
		 * @param	delay		Delay before start fade
		 * @param	callback
		 */
		public function fadeOut(time:Number = 3, delay:Number = 0, callback:Function = null):void
		{
			TweenLite.to(_fadeQuad, time, {alpha: 0, delay: delay, onComplete: callback});
		}
		
		/**
		 * Init current level
		 *
		 */
		public function initLevel():void
		{
			_fadeQuad.alpha = 0;
			
			if (_currentLevel != null)
			{
				_gameLayer.removeChild(_currentLevel);
			}
			
			if (_currentLevelIndex < _levels.length)
			{
				_currentLevel = new _levels[_currentLevelIndex]() as Level;
				_currentLevel.x = 0;
				_currentLevel.y = Main.SCENE_HEIGHT / 2;
				
				_gameLayer.addChild(_currentLevel);
				_die.text = _currentLevel.levelName;
				_dieLayer.alpha = 1;
				
				if (_dieTween != null)
					_dieTween.kill();
				_dieTween = TweenLite.to(_dieLayer, 3, {alpha: 0, delay: 3});
			}
			else
			{
				StateControl.instance.setState(new GameFin());
			}
		}
		
		public function finishLevel():void
		{
			fadeIn(2, 0, function():void
				{
					_currentLevelIndex++;
					initLevel();
				});
		}
		
		static public function get instance():GameMain
		{
			return _instance;
		}
		
		public function get gameLayer():Sprite
		{
			return _gameLayer;
		}
	
	}

}
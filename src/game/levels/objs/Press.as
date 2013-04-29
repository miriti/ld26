package game.levels.objs
{
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import game.Assets;
	import game.common.Blood;
	import game.common.Palette;
	import game.GameMain;
	import game.levels.Level;
	import game.mobs.Mob;
	import game.mobs.Player;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Press extends LevelObject
	{
		static public const BLOOD_NUM:int = 40;
		private var _press:Quad;
		private var _pressContainer:Sprite = new Sprite();
		
		private var _timePassed:Number = 0;
		
		private var _shutInterval:Number = 3.3;
		private var _repeat:Boolean = true;
		
		private var _killedMob:Mob;
		private var _block:Boolean = false;
		
		public function Press(initTime:Number = 0, pressWidth:Number = 80)
		{
			super();
			_press = new Quad(pressWidth, Level.LANE_HEIGHT, Palette.C[0]);
			_press.x = -pressWidth / 2;
			_press.y = -pressWidth / 2;
			_pressContainer.addChild(_press);
			
			_pressContainer.y = -_pressContainer.height - 1;
			addChild(_pressContainer);
			
			_timePassed = initTime;
		}
		
		override public function mobCollide(mob:Mob):void
		{
			super.mobCollide(mob);
			
			if (_block)
			{
				if (mob.isKillable())
				{
					if (mob.x < x)
					{
						mob.x = x - width / 2 - mob.width / 2;
					}
					else
					{
						mob.x = x + width / 2 + mob.width / 2;
					}
				}
			}
		}
		
		override public function update(deltaTime:Number):void
		{
			_timePassed += deltaTime;
			
			if (_killedMob != null)
			{
				if (_killedMob.height > 0)
					_killedMob.height = -_pressContainer.y;
			}
			
			if (_timePassed >= (_shutInterval - 0.3))
			{
				_timePassed = 0;
				
				for (var j:int = 0; j < _level.mobs.length; j++)
				{
					var someMob:Mob = _level.mobs[j];
					
					if (someMob.isKillable())
					{
						if ((someMob.x + someMob.width / 2 > x - width / 2) && (someMob.x - someMob.width / 2 < x + width / 2))
						{
							_killedMob = someMob;
							someMob.kill();
						}
					}
				}
				
				_block = true;
				
				TweenLite.to(_pressContainer, 0.3, {y: 0, ease: Expo.easeIn, onComplete: function():void
					{
						try
						{
							var b:Rectangle = _pressContainer.getBounds(GameMain.instance.gameLayer);
							if (Main.VIEWPORT.intersects(b))
							{
								GameMain.instance.shake(0.2, 20);
								var pan:Number = -1 + ((b.x + b.width / 2) / Main.SCENE_WIDTH) * 2;
								Assets.playSound(Assets.sndPressHit, 0, 0.3, pan, false);
							}
						}
						catch (e:Error)
						{
							trace('oops:', e.message);
						}
						
						if (_killedMob != null)
						{
							for (var i:int = 0; i < BLOOD_NUM; i++)
							{
								var randLeng:Number = 4 + Math.random() * 4;
								var randAngle:Number = Math.random() * (Math.PI * 2);
								var bloodVector:Point = new Point(Math.cos(randAngle) * 10, Math.sin(randAngle) * 10);
								var newBlood:Blood = new Blood(bloodVector);
								newBlood.x = _killedMob.x - _killedMob.width / 2 + Math.random() * _killedMob.width;
								newBlood.y = Level.LANE_HEIGHT / 2 - 2;
								parent.addChild(newBlood);
							}
						}
						
						if (_repeat)
						{
							TweenLite.to(_pressContainer, 1.5, {y: -_pressContainer.height - 1, delay: 0.5, onComplete: function():void
								{
									_block = false;
								}});
						}
					}});
			}
		}
		
		public function get shutInterval():Number
		{
			return _shutInterval;
		}
		
		public function set shutInterval(value:Number):void
		{
			_shutInterval = value;
		}
		
		public function get repeat():Boolean
		{
			return _repeat;
		}
		
		public function set repeat(value:Boolean):void
		{
			_repeat = value;
		}
	}

}
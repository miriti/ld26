package game.levels.objs
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import flash.geom.Rectangle;
	import game.Assets;
	import game.common.Palette;
	import game.common.PlaySound;
	import game.GameMain;
	import game.levels.Level;
	import game.mobs.Mob;
	import game.mobs.Player;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class SawConvair extends LevelObject
	{
		private var _saws:Vector.<Saw> = new Vector.<Saw>();
		private var _length:Number;
		private var _timePassed:Number = 0;
		private var sawInterval:Number = 2;
		
		public function SawConvair(len:Number, interval:Number = 2)
		{
			super();
			_length = len;
			
			var _rail0:Quad = new Quad(3, Level.LANE_HEIGHT / 2, Palette.C[0]);
			_rail0.y = -_rail0.height;
			addChild(_rail0);
			
			var _rail1:Quad = new Quad(len, 3, Palette.C[0]);
			addChild(_rail1);
			
			var _rail2:Quad = new Quad(3, Level.LANE_HEIGHT / 2, Palette.C[0]);
			_rail2.x = len - 3;
			_rail2.y = -_rail2.height;
			addChild(_rail2);
			
			sawInterval = interval;
			
			produceSaw();
		}
		
		override public function mobCollide(mob:Mob):void
		{
			super.mobCollide(mob);
			
			if (mob.isKillable())
			{
				for (var i:int = _saws.length - 1; i >= 0; i--)
				{
					if (mob.getBounds(parent).intersects(_saws[i].getBounds(parent)))
					{
						Assets.playSound(Assets.sndSawHit, 0, 0.3, 0, false);
						mob.kill();
						mob.bleed();
						mob.fallDown(mob.x < _saws[i].x ? -Math.PI / 2 : Math.PI / 2, mob.x);
						break;
					}
				}
			}
		}
		
		override public function update(deltaTime:Number):void
		{
			_timePassed += deltaTime;
			
			if (_timePassed >= sawInterval)
			{
				produceSaw();
				_timePassed = 0;
			}
		}
		
		private function produceSaw():void
		{
			try
			{
				var b:Rectangle = getBounds(GameMain.instance.gameLayer);
				
				if (b.intersects(Main.VIEWPORT))
				{
					var snd:PlaySound = new PlaySound(Assets.getSound(Assets.sndSaw));
					snd.volume = 0.1;
					snd.pan = -1 + ((b.x + b.width / 2) / Main.SCENE_WIDTH) * 2;
					snd.play();
				}
			}
			catch (e:Error)
			{
				trace(e.message);
			}
			
			var newSaw:Saw = new Saw();
			var sawSeedDiv:Number = 200;
			newSaw.y = -Level.LANE_HEIGHT;
			TweenLite.to(newSaw, Level.LANE_HEIGHT / sawSeedDiv, {y: 0, ease: Linear.easeNone, onComplete: function():void
				{
					TweenLite.to(newSaw, _length / sawSeedDiv, {x: _length, ease: Linear.easeNone, onComplete: function():void
						{
							TweenLite.to(newSaw, Level.LANE_HEIGHT / sawSeedDiv, {y: -Level.LANE_HEIGHT, ease: Linear.easeNone, onComplete: function():void
								{
									removeChild(newSaw);
									_saws.splice(_saws.indexOf(newSaw), 1);
								}});
						}});
				}});
			_saws.push(newSaw);
			addChild(newSaw);
		}
	
	}

}
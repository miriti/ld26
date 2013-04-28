package game.mobs
{
	import game.Assets;
	import game.common.Palette;
	import game.levels.objs.Saw;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Maniac extends Mob
	{
		private var _saw:Saw = new Saw();
		private var _q:Quad;
		private var _speed:Number = 0;
		static private const MAX_SPEED:Number = 3;
		static private const PLAYER_DISTANCE:Number = 300;
		
		public function Maniac()
		{
			_q = new Quad(40, 80, Palette.C[4]);
			_q.x = -_q.width / 2;
			_q.y = -_q.height;
			
			addChild(_q);
			
			_saw.x = -_q.width / 2;
			_saw.y = -_q.height / 2;
			addChild(_saw);
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			x -= _speed;
			
			if (!_dead)
			{
				if (Player.instance.isKillable())
				{
					if (_saw.getBounds(parent).intersects(Player.instance.getBounds(parent)))
					{
						Assets.playSound(Assets.sndSawHit, 0, 0.3, 0, false);
						Player.instance.kill();
						Player.instance.bleed();
						Player.instance.fallDown(-Math.PI / 2, Player.instance.x);
					}
					
					if (x - Player.instance.x < PLAYER_DISTANCE)
					{
						_speed += 0.1;
						if (_speed > MAX_SPEED)
							_speed = MAX_SPEED;
					}
					else
					{
						_speed *= 0.8;
					}
				}
				else
				{
					_speed *= 0.5;
				}
			}
			else
			{
				_speed *= 0.5;
			}
		}
	
	}

}
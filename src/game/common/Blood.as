package game.common
{
	import flash.geom.Point;
	import game.levels.Level;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Blood extends Particle
	{
		private var _activeHold:Number = -1;
		
		public function Blood(v:Point)
		{
			super(v);
			var sz:Number = 5 + Math.random() * 3;
			var q:Quad = new Quad(sz, sz, Palette.C[3]);
			q.x = q.y = -sz / 2;
			addChild(q);
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			if ((!_active) && (_activeHold != -1))
			{
				_activeHold -= deltaTime;
				if (_activeHold <= 0)
				{
					_active = true;
					_vector.y = 0.1;
				}
			}
			
			if (y < -Level.LANE_HEIGHT / 2)
			{
				y = -Level.LANE_HEIGHT / 2;
				_active = false;
				_activeHold = Math.random() * 3;
			}
			
			if (y > Level.LANE_HEIGHT / 2)
			{
				y = Level.LANE_HEIGHT / 2;
				_vector.y = -_vector.y * 0.3;
			}
			
			_vector.x = _vector.x * 0.9;
		}
	
	}

}
package game.common
{
	import flash.geom.Point;
	import game.levels.Level;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Particle extends GameObject
	{
		static public const GRAVITY:Number = 0.3;
		
		protected var _active:Boolean = true;
		protected var _vector:Point;
		protected var _lifeTime:Number = 3;
		
		public function Particle(v:Point)
		{
			super();
			
			_vector = v;
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			if (_lifeTime <= 0)
			{
				parent.removeChild(this);
			}
			else
			{
				_lifeTime -= deltaTime;
			}
			
			if (_active)
			{
				x += _vector.x;
				y += _vector.y;
				
				_vector.y += GRAVITY;
			}
		}
		
		public function get active():Boolean
		{
			return _active;
		}
		
		public function set active(value:Boolean):void
		{
			_active = value;
		}
	
	}

}
package game.levels.objs
{
	import game.common.GameObject;
	import game.levels.Level;
	import game.mobs.Mob;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class LevelObject extends GameObject
	{
		protected var _level:Level;
		
		public function LevelObject()
		{
			super();
		
		}		
		
		public function mobCollide(mob:Mob):void
		{
		
		}
		
		public function get level():Level 
		{
			return _level;
		}
		
		public function set level(value:Level):void 
		{
			_level = value;
		}
	
	}

}
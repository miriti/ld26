package game.levels.objs
{
	import com.greensock.TweenLite;
	import game.common.Palette;
	import game.GameMain;
	import game.levels.Level;
	import game.mobs.Mob;
	import game.mobs.Player;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Exit extends LevelObject
	{
		private var _triggered:Boolean = false;
		
		public function Exit()
		{
			super();
			var q:Quad = new Quad(60, Level.LANE_HEIGHT, Palette.C[4]);
			q.x = -q.width / 2;
			q.y = -q.height / 2;
			
			addChild(q);
		}
		
		override public function mobCollide(mob:Mob):void
		{
			super.mobCollide(mob);
			
			if ((mob is Player) && (!_triggered))
			{
				TweenLite.to(Player.instance, 1, {alpha: 0});
				Player.instance.controllOff();
				Player.instance.win = true;
				GameMain.instance.finishLevel();
				_triggered = true;
			}
		}
	
	}

}
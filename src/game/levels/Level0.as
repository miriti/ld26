package game.levels
{
	import flash.geom.Point;
	import game.levels.objs.Exit;
	import game.levels.objs.Press;
	import game.levels.objs.Saw;
	import game.levels.objs.SawBarrier;
	import game.mobs.Player;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Level0 extends Level
	{
		public function Level0()
		{
			super();
			
			_levelName = "Saw";
			
			initLane(1200);
			
			addObject(new Exit(), new Point(1200 - 30));
			
			putPlayer(new Point(20, LANE_HEIGHT / 2));
			
			addObject(new Press(2.5), new Point(300));
			addObject(new SawBarrier(), new Point(525));
			addObject(new Press(), new Point(750));
			addObject(new SawBarrier(Math.PI), new Point(975));
		}
	
	}

}
package game.levels
{
	import flash.geom.Point;
	import game.levels.objs.Exit;
	import game.levels.objs.Press;
	import game.levels.objs.SawBarrier;
	import game.levels.objs.SawConvair;
	import game.mobs.Maniac;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Level3 extends Level
	{
		
		public function Level3()
		{
			super();
			
			_levelName = "Maniac";
			var laneW:Number = Main.SCENE_WIDTH * 2;
			initLane(laneW);
			
			addObject(new Exit(), new Point(laneW - 30));
			putPlayer(_defaultPlayerPosition);
			
			addObject(new SawConvair(300), new Point(100));
			addObject(new SawBarrier(), new Point(laneW / 2));
			addObject(new Maniac(), new Point(laneW - 200, LANE_HEIGHT / 2));
		}
	
	}

}
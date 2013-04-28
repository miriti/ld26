package game.levels
{
	import flash.geom.Point;
	import game.levels.Level;
	import game.levels.objs.Exit;
	import game.levels.objs.SawConvair;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Level1 extends Level
	{
		
		public function Level1()
		{
			super();
			
			_levelName = "Convair";
			
			initLane(Main.SCENE_WIDTH);
			addObject(new Exit(), new Point(Main.SCENE_WIDTH - 30));
			putPlayer(_defaultPlayerPosition);
			addObject(new SawConvair(500, 1.5), new Point(150));
		}
	
	}

}
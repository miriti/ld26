package game.levels
{
	import flash.geom.Point;
	import game.levels.objs.Exit;
	import game.levels.objs.Press;
	import game.levels.objs.SawBarrier;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Level2 extends Level
	{
		static private const PRESS_COUNT:Number = 20;
		
		public function Level2()
		{
			_levelName = "Hurry";
			
			var laneWidth:Number = 80 * PRESS_COUNT;
			
			initLane(laneWidth);
			
			addObject(new Exit(), new Point(laneWidth - 30));
			
			putPlayer(new Point(280, 40));
			
			for (var i:int = 0; i < PRESS_COUNT; i++)
			{
				var newPress:Press = new Press(PRESS_COUNT - i * 0.7);
				newPress.shutInterval = PRESS_COUNT;
				newPress.repeat = false;
				addObject(newPress, new Point(40 + i * 80));
			}
			
			for (var j:int = 0; j < 4; j++)
			{
				addObject(new SawBarrier(j % 2 == 0 ? 0 : Math.PI), new Point(laneWidth / 2 + (j * 200)));
			}
		}
	
	}

}
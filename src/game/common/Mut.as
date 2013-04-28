package game.common
{
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Mut
	{
		public static function aspire(val:Number, to:Number, step:Number):Number
		{
			if (val > to)
			{
				val -= step;
				if (val < to)
					val = to;
			}
			else if (val < to)
			{
				val += step;
				if (val > to)
					val = to;
			}
			
			return val;
		}
	}

}
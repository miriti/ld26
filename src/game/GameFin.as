package game
{
	import com.greensock.TweenLite;
	import game.common.Palette;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class GameFin extends Sprite
	{
		private var _f1:TextField;
		private var _f2:TextField;
		
		public function GameFin()
		{
			super();
			
			_f1 = new TextField(Main.SCENE_WIDTH, 100, "And then U woke up...", "Verdana", 36, Palette.C[7]);
			_f1.alpha = 0;
			addChild(_f1);
			
			TweenLite.to(_f1, 3, {alpha: 1, onComplete: function():void
				{
					_f2 = new TextField(Main.SCENE_WIDTH, 100, "Thank you for playing!", "Verdana", 24, Palette.C[7]);
					_f2.alpha = 0;
					_f2.y = 100;
					addChild(_f2);
					
					TweenLite.to(_f2, 3, {alpha: 1, onComplete: function():void
						{							
						}});
				}});
		}
	
	}

}
package game
{
	import game.common.Palette;
	import game.levels.Level;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Intro extends Sprite
	{
		
		public function Intro()
		{
			var bg:Quad = new Quad(Main.SCENE_WIDTH, Main.SCENE_HEIGHT, Palette.C[0]);
			addChild(bg);
			
			var l:Quad = new Quad(Main.SCENE_WIDTH, Level.LANE_HEIGHT, Palette.C[6]);
			l.y = Main.SCENE_HEIGHT / 2 - Level.LANE_HEIGHT / 2;
			addChild(l);			
			
			var title:TextField = new TextField(Main.SCENE_WIDTH, Level.LANE_HEIGHT, "U", "Verdana", 72, Palette.C[0], true);
			title.y = l.y;
			addChild(title);
			
			var clc:TextField = new TextField(Main.SCENE_WIDTH, 50, "Click anywhere to play", "Verdana", 24, Palette.C[7]);
			clc.y = l.y + l.height;
			addChild(clc);
			
			var cred:TextField = new TextField(Main.SCENE_WIDTH, 50, "Michael <KEFIR> Miriti\nSpecial for Ludum Dare #26 (Apr. 27-29, 2013)", "Verdana", 16, Palette.C[4]);
			cred.y = clc.y + clc.height;
			addChild(cred);
			
			addEventListener(TouchEvent.TOUCH, onTouch);		
		}
		
		private function onTouch(e:TouchEvent):void
		{
			if (e.touches[0].phase == TouchPhase.BEGAN)
			{
				StateControl.instance.setState(new GameMain());
			}
		}
	
	}

}
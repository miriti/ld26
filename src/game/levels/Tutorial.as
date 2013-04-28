package game.levels
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.events.PressAndTapGestureEvent;
	import flash.geom.Point;
	import game.Assets;
	import game.common.Palette;
	import game.levels.objs.Exit;
	import game.levels.objs.Press;
	import starling.display.Image;
	import starling.text.TextField;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Tutorial extends Level
	{
		private var _exit:Exit;
		
		public function Tutorial()
		{
			super();
			var laneLen:Number = Main.SCENE_WIDTH * 2;
			_levelName = "How";
			
			initLane(laneLen);
			addObject(new Exit(), new Point(laneLen - 30));
			
			putPlayer(_defaultPlayerPosition);
			
			addObject(new Press(2), new Point(400));
			
			addObject(new Press(), new Point(1000));
			addObject(new Press(), new Point(1100));
			
			var _key0:KeyForAnim = new KeyForAnim();
			_key0.x = 50;
			_key0.y = 100;
			
			var _key0Title:TextField = new TextField(100, 50, "MOVE", "Verdana", 30, Palette.C[7]);
			_key0Title.x = 75;
			_key0Title.y = 75;
			
			addChild(_key0Title);
			addChild(_key0);
			
			var pressKey0:Function = function():void
			{
				TweenMax.to(_key0, 0.05, {scaleX: 0.8, scaleY: 0.8, yoyo: true, repeat: -1, repeatDelay: 1});
			};
			
			pressKey0();
			
			var _key1:KeyForAnim = new KeyForAnim();
			_key1.x = Main.SCENE_WIDTH + 50;
			_key1.y = 100;
			
			var _key1Title:TextField = new TextField(100, 50, "RUN", "Verdana", 30, Palette.C[7]);
			_key1Title.x = Main.SCENE_WIDTH + 75;
			_key1Title.y = 75;
			
			addChild(_key1);
			addChild(_key1Title);
			
			var pressKey1:Function = function():void
			{
				TweenMax.to(_key1, 0.05, {scaleX: 0.8, scaleY: 0.8, yoyo: true, repeat: 3, repeatDelay: 0.075, delay: 1, onComplete: pressKey1});
			};
			
			pressKey1();
			
			var exitTitle:TextField = new TextField(100, 50, "EXIT", "Verdana", 30, Palette.C[7]);
			exitTitle.x = laneLen - exitTitle.width;
			exitTitle.y = 75;
			addChild(exitTitle);
		}
	
	}

}
import game.Assets;
import starling.display.Image;
import starling.display.Sprite;

class KeyForAnim extends Sprite
{
	public function KeyForAnim():void
	{
		super();
		
		var img:Image = new Image(Assets.getTexture(Assets.bmpKeyRight));
		img.x = -img.width / 2;
		img.y = -img.height / 2;
		addChild(img);
	}
}
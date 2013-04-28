package game.levels.objs
{
	import flash.geom.Rectangle;
	import game.Assets;
	import game.common.GameObject;
	import game.common.Palette;
	import game.common.PlaySound;
	import game.GameMain;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Saw extends GameObject
	{
		static public const RTOATION_SPEED:Number = Math.PI / 16;
		static private const SAW_SIZE:Number = 40;
		private var _containerFull:Sprite = new Sprite();
		
		private var _sawComponents:Vector.<Sprite> = new Vector.<Sprite>(2);
		
		private var _diameter:Number = Math.sqrt(SAW_SIZE * SAW_SIZE + SAW_SIZE * SAW_SIZE);
		private var _sound:PlaySound;
		
		public function Saw()
		{
			super();		
			
			for (var i:int = 0; i < _sawComponents.length; i++)
			{
				var q:Quad = new Quad(SAW_SIZE, SAW_SIZE, Palette.C[0]);
				q.x = q.y = -SAW_SIZE / 2;
				
				_sawComponents[i] = new Sprite();
				_sawComponents[i].addChild(q);
				
				if (i == 1)
				{
					_sawComponents[i].rotation = Math.PI / 4;
				}
				
				_containerFull.addChild(_sawComponents[i]);
			}
			
			addChild(_containerFull);
		
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			_containerFull.rotation += RTOATION_SPEED;
		}
		
		public function get diameter():Number
		{
			return _diameter;
		}
	
	}

}
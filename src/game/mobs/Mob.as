package game.mobs
{
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import game.common.Blood;
	import game.common.GameObject;
	import game.common.Palette;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Mob extends GameObject
	{
		private var _bleed:Boolean = false;
		private var _bleedTime:Number = 0;
		private var _bleedCnt:Number = 100;
		private var _hart:Quad;
		
		protected var _dead:Boolean;
		
		public function Mob()
		{
			super();
		
			_hart = new Quad(40, 10, Palette.C[4]);
			_hart.x = -20;
			_hart.y = -40;
			addChild(_hart);
		}
		
		public function fallDown(fallRotation:Number, newX:Number):void
		{
			TweenLite.to(this, 0.8, {y: y - 20, x: newX, rotation: fallRotation});
		}
		
		override public function update(deltaTime:Number):void 
		{
			super.update(deltaTime);
			
			if (_bleed)
			{
				if ((_bleedTime <= 0) && (_bleedCnt > 0))
				{
					_bleedTime = 0.07;
					
					var cnt:int = Math.floor(Math.random() * 15);
					_bleedCnt -= cnt;
					
					for (var i:int = 0; i < cnt; i++)
					{
						var randLeng:Number = 4 + Math.random() * 4;
						var randAngle:Number = Math.random() * (Math.PI * 2);
						var bloodVector:Point = new Point(Math.cos(randAngle) * 10, Math.sin(randAngle) * 10);
						var newBlood:Blood = new Blood(bloodVector);
						var bb:Rectangle = _hart.getBounds(parent);
						newBlood.x = bb.x + Math.random() * bb.width;
						newBlood.y = bb.y + Math.random() * bb.height;
						parent.addChild(newBlood);
					}
				}
				else
				{
					_bleedTime -= deltaTime;
				}
			}
		}
		
		public function kill():void
		{
			_dead = true;
		}
		
		public function isKillable():Boolean
		{
			return !_dead;
		}
		
		public function bleed():void
		{
			_bleed = true;
		}
	
	}

}
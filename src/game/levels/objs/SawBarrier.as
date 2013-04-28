package game.levels.objs
{
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import flash.display.NativeMenuItem;
	import flash.geom.Rectangle;
	import game.Assets;
	import game.common.Palette;
	import game.common.PlaySound;
	import game.GameMain;
	import game.levels.Level;
	import game.mobs.Mob;
	import game.mobs.Player;
	import starling.display.Quad;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class SawBarrier extends LevelObject
	{
		static public const AMP:Number = 100;
		private var _saw:Saw = new Saw();
		private var _phase:Number = 0;
		private var _sound:PlaySound;
		
		public function SawBarrier(initPhase:Number = 0)
		{
			super();
			_sound = new PlaySound(Assets.getSound(Assets.sndSaw));
			_sound.volume = 0.1;
			_sound.loop = true;
			_sound.play();
			
			var _rail:Quad = new Quad(3, 80, Palette.C[0]);
			_rail.y = -_rail.height / 2;
			_rail.x = -1.5;
			addChild(_rail);
			addChild(_saw);
			
			_phase = initPhase;
			
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			_sound.stop();
		}
		
		override public function mobCollide(mob:Mob):void
		{
			super.mobCollide(mob);
			
			if ((mob.isKillable()) && (mob.getBounds(parent).intersects(_saw.getBounds(parent))))
			{
				mob.kill();
				mob.bleed();
				Assets.playSound(Assets.sndSawHit, 0, 0.3, 0, false);
				
				var fallRotation:Number = mob.x < x ? -Math.PI / 2 : Math.PI / 2;
				var newX:Number = mob.x < x ? x - 30 : x + 30;
				
				mob.fallDown(fallRotation, newX);
			}
		}
		
		override public function update(deltaTime:Number):void
		{
			super.update(deltaTime);
			
			_saw.y = Math.sin(_phase) * AMP;
			_phase += Math.PI / 120;
			
			var b:Rectangle = getBounds(GameMain.instance.gameLayer);
			
			_sound.pan = -1 + ((b.x + b.width / 2) / Main.SCENE_WIDTH) * 2;
			
			if (b.intersects(Main.VIEWPORT))
			{
				if (_sound.volume == 0)
					_sound.volume = 0.1 * (1 - Math.abs(_sound.pan));
			}
			else
			{
				if (_sound.volume != 0)
					_sound.volume = 0;
			}
		}
	
	}

}
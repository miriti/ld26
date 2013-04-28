package game.levels
{
	import flash.geom.Point;
	import game.common.GameObject;
	import game.common.Palette;
	import game.levels.objs.LevelObject;
	import game.mobs.Mob;
	import game.mobs.Player;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Level extends GameObject
	{
		static public const LANE_HEIGHT:Number = 80;
		
		private var _objects:Vector.<LevelObject> = new Vector.<LevelObject>();
		private var _mobs:Vector.<Mob> = new Vector.<Mob>();
		private var _lane:Quad;
		private var _laneWidth:Number;
		
		protected var _levelName:String = "Untitled Level";
		
		protected var _defaultPlayerPosition:Point = new Point(30, LANE_HEIGHT / 2);
		
		public function Level()
		{
			super();
		}
		
		public function initLane(lw:Number):void
		{
			_lane = new Quad(lw, LANE_HEIGHT, Palette.C[6]);
			_lane.y = -_lane.height / 2;
			
			_laneWidth = lw;
			
			addChild(_lane);
		}
		
		public function putPlayer(at:Point):void
		{
			Player.produceNew();
			Player.instance.x = at.x;
			Player.instance.y = at.y;
			
			addChild(Player.instance);
			_mobs.push(Player.instance);
		}
		
		public function addObject(obj:GameObject, at:Point):void
		{
			obj.x = at.x;
			obj.y = at.y;
			addChild(obj);
			
			if (obj is Mob)
			{
				_mobs.push(obj as Mob);
			}
			
			if (obj is LevelObject)
			{
				_objects.push(obj);
				(obj as LevelObject).level = this;
			}
		}
		
		override public function update(deltaTime:Number):void
		{
			for (var i:int = 0; i < _objects.length; i++)
			{
				for (var j:int = 0; j < _mobs.length; j++)
				{
					var m:Mob = _mobs[j];
					
					if (m.getBounds(this).intersects(_objects[i].getBounds(this)))
					{
						_objects[i].mobCollide(m);
					}
				}
				
				super.update(deltaTime);
				x = (Main.SCENE_WIDTH / 2) - Player.instance.width / 2 - Player.instance.x;
				if (x > 0)
					x = 0;
				if (x + _laneWidth < Main.SCENE_WIDTH)
				{
					x = -_laneWidth + Main.SCENE_WIDTH;
				}
			}
		}
				
		public function get levelName():String
		{
			return _levelName;
		}
		
		public function get mobs():Vector.<Mob>
		{
			return _mobs;
		}
	
	}

}
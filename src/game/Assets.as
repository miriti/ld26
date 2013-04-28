package game
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import starling.display.Image;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class Assets
	{
		/******************
		 * BITMAPS
		 * ****************/
		
		[Embed(source="../../assets/bmp/key-right.png")]
		public static var bmpKeyRight:Class;
		
		/*****************
		 *  SOUNDS
		 * ***************/
		[Embed(source="../../assets/snd/press-hit.mp3")]
		public static var sndPressHit:Class;
		
		[Embed(source="../../assets/snd/ost.mp3")]
		public static var sndOst:Class;
		
		[Embed(source="../../assets/snd/saw.mp3")]
		public static var sndSaw:Class;
		
		[Embed(source="../../assets/snd/saw-hit.mp3")]
		public static var sndSawHit:Class;
		
		private static var _textures:Dictionary = new Dictionary();
		private static var _sounds:Dictionary = new Dictionary();
		
		public static function getTexture(bmpClass:Class):Texture
		{
			if (_textures[bmpClass] == undefined)
			{
				_textures[bmpClass] = Texture.fromBitmap(new bmpClass());
			}
			
			return _textures[bmpClass];
		}
		
		public static function produceImage(texture:Texture):Image
		{
			return new Image(texture);
		}
		
		public static function playSound(sndClass:Class, startTime:Number, vol:Number, pan:Number, loop:Boolean):void
		{
			var snd:Sound = getSound(sndClass);
			var sndTransfrom:SoundTransform = new SoundTransform(vol, pan);
			var sndChannel:SoundChannel = snd.play(startTime, loop ? int.MAX_VALUE : 0, sndTransfrom);
		}
		
		public static function getSound(sndClass:Class):Sound
		{
			if (_sounds[sndClass] == undefined)
			{
				_sounds[sndClass] = new sndClass() as Sound;
			}
			
			return _sounds[sndClass];
		}
	}

}
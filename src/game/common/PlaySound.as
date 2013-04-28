package game.common
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author Michael Miriti
	 */
	public class PlaySound
	{
		private var _soundTransform:SoundTransform = new SoundTransform();
		private var _soundChannel:SoundChannel;
		private var _sound:Sound;
		private var _loop:Boolean = false;
		private var _startTime:Number = 0;
		
		private var _pan:Number = 0;
		private var _volume:Number = 1;
		
		private static var _soundChannels:Vector.<SoundChannel> = new Vector.<SoundChannel>();
		
		public function PlaySound(snd:Sound)
		{
			_sound = snd;
		}
		
		public static function stopAll():void
		{
			for (var i:int = _soundChannels.length; i >= 0; i--)
			{
				_soundChannels[i].stop();
			}
			
			_soundChannels = new Vector.<SoundChannel>();
		}
		
		public function play():void
		{
			_soundChannel = _sound.play(_startTime, _loop ? int.MAX_VALUE : 0, _soundTransform);
			_soundChannels.push(_soundChannel);
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, function():void
				{
					var i:int = _soundChannels.indexOf(_soundChannel);
					if (i != -1)
					{
						_soundChannels.splice(i, 1);
					}
				});
		}
		
		public function stop():void
		{
			_soundChannel.stop();
		}
		
		public function get volume():Number
		{
			return _volume;
		}
		
		public function set volume(value:Number):void
		{
			_volume = value;
			_soundTransform.volume = _volume;
			if (_soundChannel != null)
			{
				_soundChannel.soundTransform = _soundTransform;
			}
		}
		
		public function get loop():Boolean
		{
			return _loop;
		}
		
		public function set loop(value:Boolean):void
		{
			_loop = value;
		}
		
		public function get pan():Number
		{
			return _pan;
		}
		
		public function set pan(value:Number):void
		{
			_pan = value;
			
			_soundTransform.pan = _pan;
			if (_soundChannel != null)
			{
				_soundChannel.soundTransform = _soundTransform;
			}
		}
	
	}

}
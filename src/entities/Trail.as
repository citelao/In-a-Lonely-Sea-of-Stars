package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Draw;
	
	public class Trail extends Entity
	{
		private var _src_x:Number;
		private var _src_y:Number;
		private var _dest:Entity;
		private var _time:Number; //in seconds
		private var _counter:Number = 0;
		private var _percent:Number = 0;
		private var _spawned:Number;
		private var _power:Number;
		
		public function Trail(dest:Entity, power:Number, time:Number = 5, src_x:Number = 0, src_y:Number = 0)
		{
			if(!src_x || !src_y) {
				src_x = Main.game.earth.x;
				src_y = Main.game.earth.y;
			}
			
			layer = 2;
			
			_src_x = src_x;
			_src_y = src_y;
			_dest = dest;
			_time = time;
			_spawned = 0;
			_power = power;
			
			Main.game.transports += 10;
			
			super();
		}
		
		override public function update():void
		{
			if( _counter <= _time )
				_counter += FP.elapsed;
			
			_percent = _counter / _time;
				
			var _i:Number = 0;			
			while(_i < Math.floor(_percent * 10) - _spawned)
			{
				trace("spawning new transport", _i, _spawned, _percent);
				_i++;
				_spawned++;
				Main.game.add(new Transport(Main.game.earth, _dest, _power, "supplies"));
			}
		}
		
		override public function render():void
		{
			Draw.line(_src_x, _src_y, (_dest.centerX - _src_x) * _percent + _src_x, (_dest.centerY - _src_y) * _percent + _src_y, 0xff00dbff);
			
			super.render();
		}
	}
}
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
		
		public function Trail(dest:Entity = null, time:Number = 5, src_x:Number = 0, src_y:Number = 0)
		{
			if(!src_x || !src_y) {
				src_x = Main.game.earth.x + 11;
				src_y = Main.game.earth.y + 11;
			}
			
			layer = 1;
			
			_src_x = src_x;
			_src_y = src_y;
			_dest = dest;
			_time = time;
			
			super();
		}
		
		override public function update():void
		{
			if( _counter <= _time )
				_counter += FP.elapsed;
			
			_percent = _counter / _time;
		}
		
		override public function render():void
		{
			Draw.line(_src_x, _src_y, (_dest.centerX - _src_x) * _percent + _src_x, (_dest.centerY - _src_y) * _percent + _src_y);
			
			super.render();
		}
	}
}
package entities
{
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.VarTween;
	
	public class Transport extends Entity
	{
		private var _ship:Spritemap = new Spritemap(Assets.TRANSPORT_SHIP, 4, 1);
		private var _dest:Entity;
		private var _start:Entity;
		private var angle_rad:Number;
		private var _cargo:String;
		private var _randomer:Number;
		private var _completion:Number = 0.0;
		
		public var velocity:Number = 40;
		
		public function Transport(start:Entity, dest:Entity, cargo:String = "cash")
		{
			_ship.add("normal", [0], 4);
			_ship.play("normal");
			_ship.originX = 4;
			
			super(start.centerX - 4, start.centerY, _ship);
			
			_dest = dest;
			_start = start;
			
			_cargo = cargo;
			
			layer = 1;
		}
		
		override public function update():void
		{
			_randomer = 20 * Math.cos(_completion * Math.PI);
			
			if( _completion <= 1.1 )
				_completion += FP.elapsed * 0.1;
			
			_ship.angle = 90 + 180 * Math.atan2(_dest.centerY - y, _dest.centerX - x) / Math.PI;
			
			x = (_dest.centerX - _start.centerX) * _completion + _start.centerX;
			y = (_dest.centerY - _start.centerY) * _completion + _start.centerY;
			
//			trace(x, _dest.centerX, y, _dest.centerY);
			
			if( Math.abs(_dest.centerX - x) < 20 && Math.abs(_dest.centerY - y) < 20 )
				unload();
		}
		
		public function unload():void
		{
			trace("unloading cargo...");
			
			var opposite_cargo:String;
			
			if(_cargo == "cash")
			{
				opposite_cargo = "juice";
				Main.game.pay(10);
			} else { 
				opposite_cargo = "cash";
			}
			
			FP.world.add(new Transport(_dest, _start, opposite_cargo));
			
			destroy();
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
	}
}
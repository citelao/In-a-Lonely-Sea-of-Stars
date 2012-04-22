package entities
{
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Input;
	
	public class Transport extends Entity
	{
		private var _ship:Spritemap = new Spritemap(Assets.TRANSPORT_SHIP, 4, 1);
		private var _power:Number;
		
		private var _dest:Entity;
		private var _start:Entity;
		private var _random:Number;
		private var _completion:Number = 0.0;
		
		private var _cargo:String;
		
		
		public function Transport(start:Entity, dest:Entity, power:Number, cargo:String = "cash")
		{
			_ship.add("normal", [0], 4);
			_ship.play("normal");
			_ship.originX = 4;
			_ship.alpha = 0;
			
			super(start.centerX - 4, start.centerY, _ship);
			
			_dest = dest;
			_start = start;
			_power = power;
			_cargo = cargo;
			
			_random = Math.random() * 100 - 50;
			
			layer = 1;
		}
		
		override public function update():void
		{			
			_ship.alpha = 1;
			
			var power_dif:Number = _power / (Main.game.power + 1);
			
			if( _completion <= 1.1 )
				_completion += FP.elapsed * 0.1;
			
			x = (_dest.centerX - _start.centerX) * _completion + _start.centerX - _random * _completion * (_completion - 1) * power_dif;
			y = (_dest.centerY - _start.centerY) * _completion + _start.centerY - _random * _completion * (_completion - 1) * power_dif;
			
			_ship.angle = 180 - 180 * Math.atan2(y - _dest.centerY, x - _dest.centerX) / Math.PI;
			
			if( _completion >= 1 )
				unload();
		}
		
		public function unload():void
		{
			trace("unloading " + _cargo);
			
			var opposite_cargo:String;
			
			if(_cargo == "cash")
			{
				opposite_cargo = "supplies";
				Main.game.pay(10);
				Main.game.emitter.emit("dollar", x, y);
			} else { 
				opposite_cargo = "cash";
			}
			
			FP.world.add(new Transport(_dest, _start, _power, opposite_cargo));
			
			destroy();
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
	}
}
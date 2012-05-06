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
			// Originally planned to be an animation 
			_ship.add("normal", [0], 4);
			_ship.play("normal");
//			_ship.originX = -4;
			
			super(start.x, start.y, _ship);
			
			// Substantially bigger collision box for fun.
			height = 3;
			width = 7;
			type = "transport";
			
			_dest = dest;
			_start = start;
			_power = power;
			_cargo = cargo;
			
			_random = Math.random() * 200 - 100;
			
			layer = 1;
			
			pos();
		}
		
		override public function update():void
		{		
			pos();
			
			if( _completion >= 1 )
				unload();
		}
		
		private function pos():void
		{
			var power_dif:Number = _power / (Main.game.power + 1);
			
			_ship.angle = 180 - 180 * Math.atan2(y - _dest.y, x - _dest.x) / Math.PI;
			
			if( _completion <= 1.1 )
				_completion += FP.elapsed * 0.1;
			
			x = (_dest.x - _start.x) * _completion + _start.x - _random * _completion * (_completion - 1) * power_dif;
			y = (_dest.y - _start.y) * _completion + _start.y - _random * _completion * (_completion - 1) * power_dif;
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
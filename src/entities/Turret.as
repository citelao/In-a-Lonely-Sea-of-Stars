package entities
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Turret extends Entity
	{
		
		private var turret:Spritemap = new Spritemap(Assets.TURRET, 100, 100);
		private var _power:Number;
		private var _scale:Number;
		private var _angle:Number;
		
		public function Turret(scale:Number=5, power:Number=2, angle:Number = 0.5)
		{
			graphic = turret;
			turret.frame = 4;
			
			_power = power;
			_scale = scale;
			_angle = angle;
			
			pos();
		}
		
		override public function update():void
		{
			var frame:int = Main.game.power - _power;
			
			trace(frame);
			
			if(frame < 4)
				turret.frame = frame;
			else
				turret.frame = 4;
			
			pos();
		}
		
		private function pos():void
		{
			var su:Point = Main.game.pixel_pos(_scale, _power);
			
			x = Main.game.earth.x - 39 + su.x * Math.cos(_angle);
			y = Main.game.earth.y - 39 + su.y * Math.sin(_angle);
		}
	}
}
package entities
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	
	public class Turret extends Entity
	{
		
		private var turret:Spritemap = new Spritemap(Assets.TURRET, 100, 100);
		private var _power:Number;
		private var _zoom:Number;
		private var _angle:Number = 0;
		
		public function Turret(x:Number=0, y:Number=0)
		{
			graphic = turret;
			turret.frame = 4;
			
			_angle = Math.atan2(y, x);	
			_zoom = Main.game.scale_pos(x, y, _angle);
			_power = Math.floor(_zoom);
			
			pos();
		}
		
		override public function update():void
		{
			var frame:int = Main.game.power - _power;
			
			if(frame < 4)
				turret.frame = frame;
			else
				turret.frame = 4;
			
			pos();
		}
		
		private function pos():void
		{
			var su:Point = Main.game.pixel_pos(_zoom, _angle);
			
			x = Main.game.earth.x - 39 + su.x;
			y = Main.game.earth.y - 39 + su.y;
		}
	}
}
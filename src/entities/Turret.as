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
		private var _scale:Number;
		private var _angle:Number = 0;
		
		public function Turret(x:Number=0, y:Number=0)
		{
			graphic = turret;
			turret.frame = 4;
			
			var pt:Object = Main.game.scale_pos(x, y);
			
			_power = pt.power;
			_scale = pt.scale;
//			_angle = Math.atan2(y - Main.game.earth.centerY, x - Main.game.earth.centerX);
			_angle = Math.PI / 2;
			
//			trace(_power, _scale);
			
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
			var su:Point = Main.game.pixel_pos(_scale, _power);
			
			x = Main.game.earth.x - 39 + su.x;
			y = Main.game.earth.y - 39 + su.y;
		}
	}
}
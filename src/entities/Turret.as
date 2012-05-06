package entities
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	
	public class Turret extends Entity
	{
		
		private var turret:Spritemap = new Spritemap(Assets.TURRET, 100, 100);
		private var _power:Number;
		private var _zoom:Number;
		private var _angle:Number = 0;
		
		private var sn_shoot:Sfx = new Sfx(Assets.SN_SHOOT);
		private var _hitboxSizes:Array = new Array(90, 82, 64, 58, 40, 30, 24, 10, 2);
		
		public function Turret(x:Number=0, y:Number=0)
		{
			super(0, 0, turret);
			
			turret.frame = 4;
			turret.centerOO();		
			
			_angle = Math.atan2(y, x);
			_zoom = Main.game.scale_pos(x, y, _angle);
			_power = Math.floor(_zoom);
			
			pos();
		}
		
		override public function update():void
		{
			var frame:int = Main.game.power - _power;
						
			if(frame < 8)
				turret.frame = frame + 1;
			else
				turret.frame = 8;
			
			var s:Pirate = collide("pirate", x, y) as Pirate;
			
			if(s && Math.random() >= .99)
				fire(s);

			setHitbox(_hitboxSizes[turret.frame], _hitboxSizes[turret.frame], _hitboxSizes[turret.frame] / 2, _hitboxSizes[turret.frame] / 2);
			
			pos();
		}
		
		private function pos():void
		{
			var su:Point = Main.game.pixel_pos(_zoom, _angle);
			
			x = Main.game.earth.x + su.x;
			y = Main.game.earth.y + su.y;
		}
		
		private function fire(s:Pirate):void
		{
			sn_shoot.play();
			
			Main.game.add(new Rocket(_zoom, s._fzoom, _angle, 2));
		}
	}
}
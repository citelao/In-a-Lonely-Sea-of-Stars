package entities
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Spritemap;

	public class Pirate extends Entity
	{
		
		private var image:Spritemap = new Spritemap(Assets.PIRATE, 10, 4);
		
		private var _completion:Number = 0;
		private var _random:Number;
		
		private var _szoom:Number;
		public var _fzoom:Number;
		private var _angle:Number;
		
		private var sn_shoot:Sfx = new Sfx(Assets.SN_SHOOT);
		private var sn_teleport:Sfx = new Sfx(Assets.SN_TELEPORT);
		
		public function Pirate(start_zoom:Number = 2.5, final_zoom:Number = 2, angle:Number=0)
		{
			super(700, 600, image);
			
			_random = Math.random() * 100 - 50;
			
			height = 10;
			width = 20;
			
			_angle = angle;
			_szoom = start_zoom;
			_fzoom = final_zoom;
			
			image.angle = 180 - 180 * _angle / Math.PI;
			
			sn_teleport.play();
			
			type="pirate";
			
		}
		
		override public function update():void
		{
//			var power_dif:Number = _power / (Main.game.power + 1);
			
			if( _completion <= 1.1 )
				_completion += FP.elapsed * 0.1;
			
			if( _completion >= 1 && Math.random() >= 0.99 )
				fire();
			
			var _zoom:Number = _szoom - (_szoom - _fzoom) * _completion;
			
			var su:Point = Main.game.pixel_pos(_zoom, _angle);
			
			x = Main.game.earth.centerX + su.x - _random * _completion * (_completion - 1);
			y = Main.game.earth.centerY + su.y - _random * _completion * (_completion - 1);
			
//			x = (_dest.x - _start.x) * _completion + _start.x - _random * _completion * (_completion - 1) * power_dif;
//			y = (_dest.y - _start.y) * _completion + _start.y - _random * _completion * (_completion - 1) * power_dif;
		}
		
		public function fire():void
		{
			trace("pirate firing!");
			
			sn_shoot.play();
			
			Main.game.add(new Rocket(_fzoom, _fzoom - Math.random() * 0.6 - 0.3, _angle));
		}
	}
}
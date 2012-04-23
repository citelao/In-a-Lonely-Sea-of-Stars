package entities
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Spritemap;
	
	public class Rocket extends Entity
	{
		private var image:Spritemap = new Spritemap(Assets.PIRATE, 10, 4);
		
		private var _completion:Number = 0;
		private var _random:Number;
		
		private var _szoom:Number;
		private var _fzoom:Number;
		private var _angle:Number;
		
		private var sn_explode:Sfx = new Sfx(Assets.SN_EXPLODE);
		
		public function Rocket(start_zoom:Number = 2.5, final_zoom:Number = 2, angle:Number=0, frame:int = 1)
		{
			_angle = angle;
			_szoom = start_zoom;
			_fzoom = final_zoom;
			
			graphic = image;
			image.frame = frame;
			image.angle = 180 - 180 * _angle / Math.PI;
			
			height = 4;
			width = 10;
			
			type="rocket";
		}
		
		override public function update():void
		{
			if( _completion <= 1.1 )
				_completion += FP.elapsed * 0.7;
			
			if( _completion >= 1)
				explode();
			
			var _zoom:Number = _szoom - (_szoom - _fzoom) * _completion;
			
			var su:Point = Main.game.pixel_pos(_zoom, _angle);
			
			x = Main.game.earth.centerX + su.x;
			y = Main.game.earth.centerY + su.y;
			
			if(image.frame == 1) {
				var t:Transport = collide("transport", x, y) as Transport;
				
				if( t ) {
					Main.game.remove(t);
					trace("tam");
					Main.game.transports--;
					explode();
				}
			} else {
				var p:Pirate = collide("pirate", x, y) as Pirate;
				
				if( p ) {
					Main.game.remove(p);
					trace("pew");
					explode();
				}
			}
		}
		
		public function explode():void 
		{
			Main.game.emitter.emit("explode", x, y);
			Main.game.emitter.emit("explode", x, y);
			Main.game.emitter.emit("explode", x, y);
			Main.game.emitter.emit("explode", x, y);
			Main.game.emitter.emit("explode", x, y);
			Main.game.emitter.emit("explode", x, y);
			Main.game.emitter.emit("explode", x, y);
			Main.game.emitter.emit("explode", x, y);
			
			
			sn_explode.play();
			
			Main.game.remove(this);
		}
	}
}
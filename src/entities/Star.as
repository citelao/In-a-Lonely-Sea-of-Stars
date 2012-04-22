package entities
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Star extends Entity
	{
		private var _image:Spritemap = new Spritemap(Assets.STAR, 100, 100);
		private var _size:int;
		public var harvested:Boolean = false;
		
		private var _hitboxSizes:Array = new Array(80, 70, 60, 50, 40, 30, 20, 10, 5, 3, 1);
		
		public var _angle:Number;
		public var _zoom:Number;
		public var _power:int;

		private var su:Point = new Point();
		
		public function Star(zoom:Number = 2.5, angle:Number=0, size:int = 0)
		{			
			super(x - 50, y - 50, _image);
			
			if(!size)
				_size = _image.frame = Math.floor(Math.random() * 10);
			else
				_size = _image.frame = size;
			
			type = "star";
			setHitbox(80,80);
			
			_zoom = zoom;
			_power = Math.floor(_zoom / 10);
			_angle = angle;
		}
		
		override public function update():void
		{
			var power_dif:int = Main.game.power - _power + 1;
			
			su = Main.game.pixel_pos(_zoom, _angle);
				
			x = Main.game.earth.x - 39 + su.x;
			y = Main.game.earth.y - 39 + su.y;
			
			_image.frame = _size + power_dif + 2;
			
//			trace(image.frame - Main.game.power + power);
			
			if(_image.frame - Main.game.power + _power <= 0)
				_image.alpha = 0;
			else
				_image.alpha = 1;
			
			setHitbox(_hitboxSizes[_image.frame], _hitboxSizes[_image.frame], -50 + _hitboxSizes[_image.frame] / 2, -50 + _hitboxSizes[_image.frame] / 2);
		}
	}
}
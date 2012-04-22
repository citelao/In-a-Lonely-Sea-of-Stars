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
		private var image:Spritemap = new Spritemap(Assets.STAR, 100, 100);
		private var size:int;
		public var harvested:Boolean = false;
		
		private var hitboxSizes:Array = new Array(80, 70, 60, 50, 40, 30, 20, 10, 5, 3, 1);
		
		public var angle:Number;
		public var scale:Number;
		public var power:int;
		
		private var su:Point = new Point();
		
		public function Star(scale_temp:Number = 5, power_temp:int = 2, angle_temp:Number=0, size_temp:int = 0)
		{			
			super(x - 50, y - 50, image);
			
			if(!size_temp)
				size = image.frame = Math.floor(Math.random() * 10);
			else
				size = image.frame = size_temp;
			
			type = "star";
			setHitbox(80,80);
			collidable = true;
			
			scale = scale_temp;
			power = power_temp;
			angle = angle_temp;
		}
		
		override public function update():void
		{
			var power_dif:int = Main.game.power - power + 1;
			
			su = Main.game.pixel_pos(scale, power);
				
			x = Main.game.earth.x - 39 + su.x * Math.cos(angle);
			y = Main.game.earth.y - 39 + su.y * Math.sin(angle);
			
			image.frame = size + power_dif + 2;
			
//			trace(image.frame - Main.game.power + power);
			
			if(image.frame - Main.game.power + power <= 0)
				image.alpha = 0;
			else
				image.alpha = 1;
			
			setHitbox(hitboxSizes[image.frame], hitboxSizes[image.frame], -50 + hitboxSizes[image.frame] / 2, -50 + hitboxSizes[image.frame] / 2);
		}
	}
}
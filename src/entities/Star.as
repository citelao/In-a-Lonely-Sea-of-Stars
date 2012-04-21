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
		private var image:Spritemap = new Spritemap(Assets.STAR, 80, 80);
		private var size:int;
		private var angle:Number;
		private var scale:Number;
		private var power:int;
		
		private var su:Point = new Point();
		private var last_su:Point = new Point();
		
		public function Star(scale_temp:Number = 5, power_temp:int = 2, angle_temp:Number=0, mask:Mask=null)
		{
			image.randFrame();
			
			size = image.frame;
			
			scale = scale_temp;
			power = power_temp;
			angle = angle_temp;
			
			super(x - 40, y - 40, image, mask);
		}
		
		override public function update():void
		{
			var power_dif:int = Main.game.power - power + 1;
			
			if( power_dif == 1 ) {
				su.x = FP.width * scale / 2 / 10 / 10;
				su.y = FP.height * scale / 2 / 10 / 10;
			} else if( power_dif == 0 ) {
				su.x = FP.width * ((2 * scale + 1) / 10 - 1) / 20;
				su.y = FP.height * ((2 * scale + 1) / 10 - 1) / 20;
			} else if( power_dif == 2 ) {
				su.x = FP.width * (10 - scale) / 2 / 10 / 10;
				su.y = FP.height * (10 - scale) / 2 / 10 / 10;
			} else {
				image.alpha = 0
			}
			
			x = Main.game.earth.x - 33 + (su.x * scale * Math.cos(angle) / Main.game.scale);
			y = Main.game.earth.y - 33 + (su.y * scale * Math.sin(angle) / Main.game.scale);
		}
	}
}
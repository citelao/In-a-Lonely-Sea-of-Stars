package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Star extends Entity
	{
		private var image:Spritemap = new Spritemap(Assets.STAR, 80, 80);
		private var size:int;
		private var angle:Number;
		private var dist:Number;
		
		public function Star(dist_temp:Number=20, angle_temp:Number=0, mask:Mask=null)
		{
			image.randFrame();
			
			size = image.frame;
			
			angle = angle_temp;
			dist = dist_temp;
			
			x = Main.game.earth.x + dist * Math.cos(angle) - 40;
			y = Main.game.earth.y + dist * Math.sin(angle) - 40;
			
			super(x - 40, y - 40, image, mask);
		}
		
		override public function update():void
		{
			
			if(size + Main.game.zoom / 10 < 10.5)
			{
				image.frame = size + Main.game.zoom / 10;
				image.alpha = 1;
			} else {
				image.alpha = 0;
			}
			
			x = Main.game.earth.x + (dist * Math.cos(angle) / Main.game.zoom) - 33;
			y = Main.game.earth.y + (dist * Math.sin(angle) / Main.game.zoom) - 33;
		}
	}
}
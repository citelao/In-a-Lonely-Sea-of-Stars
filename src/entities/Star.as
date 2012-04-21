package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Star extends Entity
	{
		private var image:Spritemap = new Spritemap(Assets.STAR, 80, 80);
		
		public function Star(x:Number=0, y:Number=0, mask:Mask=null)
		{
			image.randFrame();
			
			super(x - 40, y - 40, image, mask);
		}
	}
}
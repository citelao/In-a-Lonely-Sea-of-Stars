package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Planet extends Entity
	{
		private var image:Spritemap = new Spritemap(Assets.PLANET, 20, 20);
		
		public function Planet(x:Number=0, y:Number=0, mask:Mask=null)
		{
			image.add("moon", [2], 0);
			image.play("moon");
			
			super(x, y, image, mask);
		}
	}
}
package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Earth extends Entity
	{
		private var image:Spritemap = new Spritemap(Assets.EARTH, 22, 22);
		
		public function Earth(x:Number=0, y:Number=0,mask:Mask=null)
		{
			image.add("spin", [0, 1, 2, 3, 4, 5, 6, 7], 12);
			image.play("spin");
			
			super(x, y, image, mask);
		}
	}
}
package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Asteroid extends Entity
	{
		private var asteroid:Spritemap = new Spritemap(Assets.ASTEROID, 6, 2);
		private var _dest:Entity;
		
		public function Asteroid(dest:Entity, x:Number=0, y:Number=0)
		{
			graphic = asteroid;
			
			_dest = dest;
			
			super(x, y);
		}
	}
}
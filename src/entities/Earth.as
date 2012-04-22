package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Earth extends Entity
	{
		private var image:Spritemap = new Spritemap(Assets.EARTH, 22, 22);
		private var atmosphere:Spritemap = new Spritemap(Assets.EARTH, 22, 22);
		
		public function Earth(x:Number=0, y:Number=0)
		{			
			image.add("spin", [0, 1, 2, 3, 4, 5, 6, 7], 12);
			image.add("small spin", [10, 9, 23, 22, 21, 20, 19, 18, 17, 16], 12);
			image.play("spin");
			
			atmosphere.setFrame(0, 1);
			
			super(x, y, image);
			
			setHitbox(22, 22);
		}
		
		override public function added():void
		{
			Main.game.addGraphic(atmosphere, 1, FP.width / 2 - 11, FP.height / 2 - 11);
			
			super.added();
		}
		
		override public function update():void
		{
			if( Main.game.power >= 3 )
			{
				image.setFrame(7, 1);
			} else if ( Main.game.power >= 2 ) {
				image.play("small spin");
			} else {
				image.play("spin");
			}
		}
	}
}
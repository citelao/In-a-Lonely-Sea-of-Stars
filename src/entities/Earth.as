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
			image.play("spin");
//			image.alpha = 0.2;
			
			atmosphere.setFrame(0, 1);
			
			super(x, y, image);
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
				image.setFrame(2, 1);
			} else if ( Main.game.power >= 2 ) {
				image.setFrame(1, 1);
			} else {
				image.play("spin");
			}
		}
	}
}
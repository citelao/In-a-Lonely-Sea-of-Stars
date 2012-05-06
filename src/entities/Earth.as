package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Earth extends Entity
	{
		private var _image:Spritemap = new Spritemap(Assets.EARTH, 22, 22);
		private var _atmosphere:Spritemap = new Spritemap(Assets.EARTH, 22, 22);
		
		public function Earth(x:Number=0, y:Number=0)
		{			
			_image.add("spin", [0, 1, 2, 3, 4, 5, 6, 7], 12);
			_image.add("small spin", [10, 9, 23, 22, 21, 20, 19, 18, 17, 16], 12);
			_image.play("spin");
			_image.centerOO();
			
			_atmosphere.setFrame(0, 1);
			_atmosphere.centerOO();
			
			super(x, y, _image);
			
			setHitbox(22, 22, 11, 11);
		}
		
		override public function added():void
		{
			Main.game.addGraphic(_atmosphere, 1, x, y);
			
			super.added();
		}
		
		override public function update():void
		{			
			if( Main.game.power >= 3 )
				_image.setFrame(7, 1);
			else if ( Main.game.power >= 2 )
				_image.play("small spin");
			else
				_image.play("spin");
		}
	}
}
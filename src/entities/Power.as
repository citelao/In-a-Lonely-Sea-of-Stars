package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Power extends Entity
	{
		
		private var power:Spritemap = new Spritemap(Assets.POWER, 640, 480);
		
		public function Power(x:Number=0, y:Number=0)
		{
			power.frame = 0;
			
			graphic = power;
			
			super(x, y);
		}
		
		override public function update():void
		{
			power.frame = Main.game.scale - 1;
			power.alpha = 0.7 * (1 - Main.game.scale / 10);
		}
	}
}
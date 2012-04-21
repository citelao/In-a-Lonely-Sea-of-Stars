package
{
	import entities.*;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	public class Game extends World
	{
		public var earth:Earth = new Earth(FP.width/2-11, FP.height/2-11);
		public var money:int = 100;
		
		private var zoom:int = 1;
		public var scale:Number = 0.1;
		public var power:int = 1;
		
		private var zoom_snd:Sfx = new Sfx(Assets.SN_ZOOM);
		private var money_disp:Text = new Text("$" + money.toString(), 0, 0, 50, 20);
		
		public function Game()
		{
			Main.game = this;
			
			add(earth);
			
			add(new Power());
			
			var i:int;
//			for (i=1; i<11; i++)
//			{
//				add(new Star(Math.random() * 10 + 4, Math.ceil(Math.random() * 10), Math.random() * 2 * Math.PI));
//			}
//			
			add(new Star(10, 2, 0.5));
			
			add(new Transport(FP.width/2, FP.height/2, 200, 30, "cash"));
			
			add(new Entity(FP.width - 90, FP.height - 20, money_disp));			
		}
		
		override public function update():void
		{
			/* Zooming
			 * zoom is stored in scientific notation as (scale) x 10 ^ (power) lightyears
			 * every 50 clicks the order of magnitude changes, while between clicks simply
			   the magnitude changes between 0 and 10
			 */
			
			// Raw mouse wheel data is stored as zoom.
			zoom -= Input.mouseWheelDelta;
			if(zoom < 1)
				zoom = 1;
			
			// The power is calculated by 50. ie every 50 scroll-wheel clicks registered by Flashpunk is one power
			var old_power:int = power;
			power = Math.floor(zoom / 50) + 1;
			
			// Play a sound if the power has changed
			if( power != old_power )
				zoom_snd.play();
			
			// Calculate the scale (magnitude) from 1 - 10 by
			// 1. figuring out the difference (out of 50) since the last power
			// 2. dividing that number by 5 to get a number out of 10
			// 3. subtracting that number from 11 to flip the number from loss to gain
			scale = 11 - (50 * power - zoom) / 5;
			
			// Debug
//			trace(scale.toString() + " x 10^" + power + " ly");
			
			super.update();
		}
		
		public function pay(amt:int):void
		{
			money += amt;
			
			money_disp.text = "$" + money.toString();			
			money_disp.updateBuffer();
		}
	}
}
package
{
	import entities.*;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	public class Game extends World
	{
		public var earth:Earth = new Earth(FP.width/2-11, FP.height/2-11);
		public var zoom:int = 0;
		public var money:int = 100;
		
		private var money_disp:Text = new Text("$" + money.toString(), 0, 0, 50, 20);
		
		public function Game()
		{
			Main.game = this;
			
			add(earth);
			
			add(new Star(200, 30));
			
			add(new Transport(FP.width/2, FP.height/2, 200, 30, "cash"));
			
			add(new Entity(200, 200, money_disp));			
		}
		
		override public function update():void
		{
			zoom -= Input.mouseWheelDelta;
						
			if(zoom < 0)
				zoom = 0;
			
			//TODO make zoom do stuff.
			
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
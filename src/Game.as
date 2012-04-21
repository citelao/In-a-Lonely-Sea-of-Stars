package
{
	import entities.*;
	
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	
	public class Game extends World
	{
		public var earth:Earth = new Earth(FP.width/2-11, FP.height/2-11);
		
		public function Game()
		{
			add(earth);
			
			add(new Planet(0, 0));
			
			add(new Transport(70, 120, 0, 0));
		}
	}
}
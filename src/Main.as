package
{	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.Screen;
	
	[SWF(width="1280", height="960")]
	
	public class Main extends Engine
	{
		public static var game:Game;
		
		public function Main()
		{			
			super(640, 480);
			
			FP.screen.scale = 2;
			FP.screen.color = 0x0024273d;
			
			trace("good work, everyone");
			
			FP.world = new Game();
		}
	}
}
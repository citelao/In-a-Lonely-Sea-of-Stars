package
{	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.Screen;
	
	[SWF(width="640", height="480")]
	
	public class Main extends Engine
	{
		public static var game:Game;
		
		public function Main()
		{			
			super(320, 240);
			
//			FP.console.enable();
			
			FP.screen.scale = 2;
			FP.screen.color = 0x0024273d;
			
			trace("good work, everyone");
			trace("");
			
			FP.world = new Game();
		}
	}
}
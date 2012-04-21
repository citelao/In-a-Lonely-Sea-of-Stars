package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.Screen;
	
	public class Main extends Engine
	{
		public function Main()
		{
			super(320, 240);
			
			FP.screen.scale = 2;
			
			FP.screen.color = 0x0024273d;
			
			trace("good work, everyone");
		}
	}
}
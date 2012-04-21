package
{
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	
	import entities.*;
	
	public class Game extends World
	{
		public function Game()
		{
			add(new Transport(40, 40));
		}
	}
}
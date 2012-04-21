package entities
{
	import flash.ui.Mouse;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	
	public class Cursor extends Entity
	{
		private var turrets:Spritemap = new Spritemap(Assets.TURRET, 100, 100);
		private var mines:Spritemap = new Spritemap(Assets.MINE, 13, 7);
		private var square:Image = Image.createRect(1,1,0xff000000);
		
		private var gx:int;
		private var gy:int;
		
		public function Cursor(x:Number=0, y:Number=0)
		{
			type = "cursor";
			
			square.alpha = 0;
			graphic = square;
			
			gx = 0;
			gy = 0;
		}
		
		override public function update():void
		{
			x = Input.mouseX - gx;
			y = Input.mouseY - gy;
		}
		
		public function build(object:String = "mine"):void
		{
			if(object == "mine") 
			{	
				graphic = mines;
				Mouse.hide();
				
				gx = 6;
				gy = 3;
			} else {
				graphic = turrets;
				Mouse.hide();
				
				gx = 50;
				gy = 50;
			}
		}
		
		public function reset_cursor():void
		{
			graphic = square;
			Mouse.show();
		}
	}
}
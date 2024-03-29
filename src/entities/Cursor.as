package entities
{
	import flash.ui.Mouse;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	
	public class Cursor extends Entity
	{
		private var turrets:Spritemap = new Spritemap(Assets.TURRET, 100, 100);
		private var mines:Spritemap = new Spritemap(Assets.MINE, 13, 7);
		private var square:Image = Image.createRect(1,1,0xff000000);
		
		public var cursor:String = "";
		
		private var _place:Sfx = new Sfx(Assets.SN_PLACE);
		private var _cancel:Sfx = new Sfx(Assets.SN_CANCEL);

		private var gx:int;
		private var gy:int;
		
		public function Cursor()
		{			
			graphic = square;
			
			type = "cursor";
			
			square.alpha = 0;
			turrets.frame = 1;
			
			gx = 0;
			gy = 0;
			
			height = 5;
			width = 5;
		}
		
		override public function update():void
		{			
			x = Input.mouseX - gx;
			y = Input.mouseY - gy;		
			
			var star:Star = collide("star", x, y) as Star;
			
			if( star && !star.harvested && Main.game.money >= 200 )
				mines.frame = 0;
			else
				mines.frame = 1;
			
			if(Input.mouseReleased)
			{
				switch(graphic)
				{
					case mines:						
						if( mines.frame == 0 )
							build("mine");
						break;
					case turrets:						
						if( !star && Main.game.money >= 200)
							build("turret");
						break;
				}
			}
		}
		
		public function build(object:String = "mine"):void
		{
			_place.play();
			
			if( object == "mine" ) { 
				var star:Star = collide("star", x, y) as Star;
				
				if(!star || star.harvested || Main.game.money < 200)
					return;
				
				star.harvested = true;
				Main.game._harvested.push(star);
				
				Main.game.pay(-200);
				Main.game.add(new Trail(star, star._power));
			} else { //build a turret				
				Main.game.pay(-200);
				Main.game.add(new Turret(Input.mouseX - Main.game.earth.centerX, - Main.game.earth.centerY + Input.mouseY));
			}
		}
		
		public function pre_build_mine():void
		{
			graphic = mines;
			Mouse.hide();
				
			cursor = "mine";
			
			gx = 6;
			gy = 3;
		}
		
		public function pre_build_turret():void
		{
			graphic = turrets;
			Mouse.hide();
			
			cursor = "turret";
			
			gx = 50;
			gy = 50;
		}
		
		public function reset_cursor():void
		{
			if( graphic != square )
				_cancel.play();
			
			cursor = "";
			
			graphic = square;
			Mouse.show();
			
			gx = 0;
			gy = 0;
		}
	}
}
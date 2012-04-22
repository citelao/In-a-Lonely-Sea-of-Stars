package
{
	import entities.*;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Game extends World
	{
		public var earth:Earth = new Earth(FP.width/2-11, FP.height/2-11);
		public var money:int = 200;
		
		private var zoom:int = 1;
		public var scale:Number = 0.1;
		public var power:int = 1;

		public var cursor:Cursor = new Cursor();
		public var emitter:Emitter = new Emitter(Assets.DOLLAR, 4, 6);
		
		private var zoom_out_snd:Sfx = new Sfx(Assets.SN_ZOOM_OUT);
		private var zoom_in_snd:Sfx = new Sfx(Assets.SN_ZOOM_IN);
		private var money_disp:Text = new Text("$" + money.toString(), 0, 0, 50, 20);
		private var tip_disp:Spritemap = new Spritemap(Assets.TUTORIAL, 404, 20);
		private var tip:Entity = new Entity( 50, FP.height - 25, tip_disp);
		
		public function Game()
		{
			Main.game = this;
				
//			add(new Power());
			
			addGraphic(emitter);
			emitter.newType("dollar", [0]);
			emitter.setAlpha("dollar", 1, 0);
			emitter.setMotion("dollar", 90, 20, 0.2, 40, 10, 0.3);
			
			// Random stars
			var i:int;
			for (i=1; i<10; i++)
			{
				add(new Star(Math.random() * 10, 6, Math.random() * 2 * Math.PI));
			}
			
			// The warm yellow sun
			var sun:Star = new Star(5, 2, 0.5, 2);
			add(sun);
			add(earth);
			
			money_disp.size = 16;
			add(new Entity(6, FP.height - 25, money_disp));
			add(tip);
			tip_disp.setFrame(0, 4);
			add(new Button(FP.width - 30, FP.height - 25, 0, cursor.pre_build_turret));
			add(new Button(FP.width - 60, FP.height - 25, 1, cursor.pre_build_mine));
			add(cursor);
			
			add(new Asteroid(sun));
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
			if( power < old_power )
				zoom_in_snd.play();
			
			if( power > old_power )
				zoom_out_snd.play();
			
			// Calculate the scale (magnitude) from 1 - 10 by
			// 1. figuring out the difference (out of 50) since the last power
			// 2. dividing that number by 5 to get a number out of 10
			// 3. subtracting that number from 11 to flip the number from loss to gain
			scale = 11 - (50 * power - zoom) / 5;
			
			trace(zoom, power, scale, zoom / 50 + 1 );
			
			// Debug
//			trace(scale.toString() + " x 10^" + power + " ly");
			
			if(Input.pressed(Key.ESCAPE))
				cursor.reset_cursor();
			
			super.update();
		}
		
		public function pay(amt:int):void
		{
			money += amt;
			
			money_disp.text = "$" + money.toString();			
			money_disp.updateBuffer();
		}
		
		public function pixel_pos(pscale:Number = 0, ppower:int = 0):Point
		{
			var point:Point = new Point();
			
			point.x = (FP.width * (pscale + 10 * ppower)) / (2 * (Main.game.scale + 10 * Main.game.power));
			point.y = (FP.height * (pscale + 10 * ppower)) / (2 * (Main.game.scale + 10 * Main.game.power));
			
			return point;
		}
		
		public function scale_pos(x:Number = 0, y:Number = 0):Object
		{
			var p:Object = new Object();
			
			var d:Number = Main.game.scale + 10 * Main.game.power;
			
//			trace("yo", 2 * d * x / FP.width, 2 * d * y / FP.height); 
//			2 * d * x / FP.width = r;
//			2 * d * y / FP.height = r;
			
			p.zoom = Math.sqrt( (2 * d * x / FP.width) ^ 2 + (2 * d * y / FP.height) ^ 2 );
			
			trace(p.zoom);
			
			p.power = Math.floor(p.zoom / 10); // = s + 10m
			p.scale = p.zoom - 10 * p.power;
			
			return p;
		}
	}
}
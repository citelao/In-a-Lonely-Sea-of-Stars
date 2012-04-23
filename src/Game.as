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
		
		private var rawzoom:int = 1;
		public var zoom:Number = 1;
		public var power:int;

		public var cursor:Cursor = new Cursor();
		public var emitter:Emitter = new Emitter(Assets.DOLLAR, 4, 6);
		
		private var _pirateCounter:Number = 0;
		public var _harvested:Array = new Array();
		private var _transportCounter:Number = 0;
		public var transports:int = 0;
		private var _spawnpirates:Boolean = false;
		
		private var _tutCounter:Number = 0;
		
		private var zoom_out_snd:Sfx = new Sfx(Assets.SN_ZOOM_OUT);
		private var zoom_in_snd:Sfx = new Sfx(Assets.SN_ZOOM_IN);
		private var money_disp:Text = new Text("$" + money.toString(), 0, 0, 50, 20);
		private var tip_disp:Spritemap = new Spritemap(Assets.TUTORIAL, 202, 20);
		
		public function Game()
		{
			Main.game = this;
				
//			add(new Power());
			
			addGraphic(emitter);
			emitter.newType("dollar", [0]);
			emitter.setAlpha("dollar", 1, 0);
			emitter.setMotion("dollar", 90, 20, 0.2, 40, 10, 0.3);
			
			emitter.newType("explode", [1]);
			emitter.setAlpha("explode", 1, 0);
			emitter.setMotion("explode", 0, 20, 0.4, 360, 10, 0.2);
			
			// Random stars
			var i:int;
			for (i=1; i<10; i++)
			{
				add(new Star(6 + Math.random(), Math.random() * 2 * Math.PI));
			}
			
			// The warm yellow sun
			var sun:Star = new Star(1.5, 0.5, 2);
			add(sun);
			add(earth);
			
			money_disp.size = 16;
			add(new Entity(6, FP.height - 25, money_disp));
			addGraphic(tip_disp, -5, 50, FP.height - 25);
			
			add(new Button(FP.width - 30, FP.height - 25, 0, cursor.pre_build_turret));
			add(new Button(FP.width - 60, FP.height - 25, 1, cursor.pre_build_mine));
			add(cursor);
		}
		
		override public function update():void
		{
			/* Zooming
			 * zoom is stored in scientific notation as (scale) x 10 ^ (power) lightyears
			 * every 50 clicks the order of magnitude changes, while between clicks simply
			   the magnitude changes between 0 and 10
			 */
			
			// Raw mouse wheel data is stored as zoom.
			rawzoom -= Input.mouseWheelDelta;
			if(rawzoom < 1)
				rawzoom = 1;
			
			// The power is calculated by 50. ie every 50 scroll-wheel clicks registered by Flashpunk is one power
			zoom = rawzoom / 50 + 1;
			
			var old_power:Number = power;
			power = Math.floor(zoom);
			
			// Play a sound if the power has changed
			if( power < old_power )
				zoom_in_snd.play();
			
			if( power > old_power )
				zoom_out_snd.play();
			
			if(Input.pressed(Key.ESCAPE))
				cursor.reset_cursor();
			
			// Spawn pirates
			if( _pirateCounter + Math.random() * 2 - 1 >= 10 && _harvested.length > 0 && _spawnpirates) {
				var rand:int = Math.floor(Math.random() * _harvested.length);
				add(new Pirate(zoom + .2, _harvested[rand]._zoom, _harvested[rand]._angle + Math.random() * 0.2 - 0.1));
			}
			
			if( _pirateCounter <= 9.5 )
				_pirateCounter += FP.elapsed;
			else
				_pirateCounter = 0;
			
			if( transports < _harvested.length * 10 )
			{
				trace("transport deficit.");
				
				if( _transportCounter >= 10 ) {
					add(new Transport(earth, _harvested[Math.floor(Math.random() * _harvested.length)], _harvested[Math.floor(Math.random() * _harvested.length)]._power, "supplies"));
					transports++;
					trace("spawned new transport");
				}
				
				if(_transportCounter <= 10 )
					_transportCounter += FP.elapsed;
				else
					_transportCounter = 0;
			}
			
			// Tutorial
			
			if(tip_disp.frame < 2) {
				if( _tutCounter <= 10 )
					_tutCounter += FP.elapsed;
				
				if( _tutCounter >= 10 ) {
					tip_disp.frame++;
					_tutCounter = 0;
				}
			} else if(tip_disp.frame == 2) {
				if(zoom >= 1.5)
					tip_disp.frame++;
			} else if(tip_disp.frame == 3) {				
				if(cursor.cursor == "mine")
					tip_disp.frame++;
			} else if(tip_disp.frame == 4) {
				if(_harvested.length >= 1)
					tip_disp.frame++;
			} else if(tip_disp.frame == 5) {
				if( _tutCounter <= 10 )
					_tutCounter += FP.elapsed;
				
				if( _tutCounter >= 10 ) {
					tip_disp.frame++;
					_tutCounter = 0;
				}
			} else if(tip_disp.frame == 6) {
				_spawnpirates = true;
				
				if(cursor.cursor == "turret")
					tip_disp.frame++;
			} else if(tip_disp.frame == 7) {
				_tutCounter += FP.elapsed;
					
				if( _tutCounter >= 10 ) {
					tip_disp.alpha = 0;
				}
			}
			
			super.update();
		}
		
		public function pay(amt:int):void
		{
			money += amt;
			
			money_disp.text = "$" + money.toString();			
			money_disp.updateBuffer();
		}
		
		public function pixel_pos(_zoom:Number, _angle:Number):Point
		{
			var point:Point = new Point();
			
			point.x = (FP.width * _zoom * Math.cos(_angle)) / (2 * Main.game.zoom);
			point.y = (FP.height * _zoom * Math.sin(_angle)) / (2 * Main.game.zoom);
			
			return point;
		}
		
		public function scale_pos(x:Number = 0, y:Number = 0, angle:Number=0):Number
		{				
			var a:Number = 2 * x * Main.game.zoom / FP.width / Math.cos(angle);
			var b:Number = 2 * y * Main.game.zoom / FP.height / Math.sin(angle);
			
			var c:Number = Math.sqrt(Math.pow(a, 2) + Math.pow(b, 2));
			
			trace(a, b, c);
			
			return c;
		}
	}
}
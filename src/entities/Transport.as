package entities
{
	import Game;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.VarTween;
	
	public class Transport extends Entity
	{
		private var ship:Spritemap = new Spritemap(Assets.TRANSPORT_SHIP, 4, 1);
		public var destination:Point;
		private var start:Point;
		private var angle_rad:Number;
		private var cargo:String = "";
		
		public var velocity:Number = 40;
		
		public function Transport(x:Number=0, y:Number=0, dest_x:Number = 0, dest_y:Number = 0, cargo_temp:String = "cash")
		{
			ship.add("normal", [0], 4);
			ship.play("normal");
			
			super(x - 4, y, ship);
			
			destination = new Point(dest_x - 4, dest_y);
			start = new Point(x - 4, y);
			
			cargo = cargo_temp;
			
			ship.originX = 4;
		}
		
		override public function update():void
		{
			angle_rad = Math.atan2(this.y - destination.y, this.x - destination.x);
			ship.angle = 180 + -180 * angle_rad / Math.PI;
			
			x -= FP.elapsed * velocity * Math.cos(angle_rad);
			y -= FP.elapsed * velocity * Math.sin(angle_rad);
			
			if( Math.abs(destination.x - x) < 10 && Math.abs(destination.y - y) < 10 )
				unload();
			
		}
		
		public function unload():void
		{
			trace("unloading cargo...");
			
			var opposite_cargo:String;
			
			if(cargo == "cash")
			{
				opposite_cargo = "juice";
			} else { 
				opposite_cargo = "cash";
			}
			
			FP.world.add(new Transport(destination.x + 4, destination.y, start.x + 4, start.y, opposite_cargo));
			
			Main.game.pay(40);
			
			destroy();
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
	}
}
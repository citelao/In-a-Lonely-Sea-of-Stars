package entities
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class Transport extends Entity
	{
		private var ship:Image = new Image(Assets.TRANSPORT_SHIP);
		public var destination:Point;
		private var angle_rad:Number;
		
		public var velocity:Number = 20;
		
		public function Transport(x:Number=0, y:Number=0, dest_x:Number = 0, dest_y:Number = 0)
		{
			super(x, y, ship);
			
			destination = new Point(dest_x, dest_y);
			
			ship.originX = 4;
		}
		
		override public function update():void
		{
			angle_rad = Math.atan2(this.y - destination.y, this.x - destination.x);
			ship.angle = 180 + -180 * angle_rad / Math.PI;
			
			x -= FP.elapsed * velocity * Math.cos(angle_rad);
			y -= FP.elapsed * velocity * Math.sin(angle_rad);
			
			if( Math.abs(destination.x - x) < 5 && Math.abs(destination.y - y) < 5 )
				trace("yay", destination.x - x);
			
		}
	}
}
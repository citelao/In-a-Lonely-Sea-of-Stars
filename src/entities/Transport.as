package entities
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class Transport extends Entity
	{
		private var ship:Image = new Image(Assets.TRANSPORT_SHIP);
		
		public function Transport(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, ship, mask);
		}
		
		override public function update():void
		{
			ship.angle += 1;
		}
	}
}
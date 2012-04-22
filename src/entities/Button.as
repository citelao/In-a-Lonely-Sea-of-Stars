package entities
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	
	public class Button extends Entity
	{
		private var image:Spritemap = new Spritemap(Assets.HUD, 24, 20);
		private var _col:int;
		private var _snd:Sfx = new Sfx(Assets.SN_SELECT);
		public var callback:Function;
		
		public function Button(x:Number=0, y:Number=0, frame_col:int = 0, callback:Function = null)
		{			
			_col = image.frame = frame_col;
			
			super(x, y, image);
			
			type = "button";
			
			width = 24;
			height = 20;
			
			this.callback = callback;
		}
		
		override public function update():void
		{
			if( collide("cursor", x, y) ) {
				if( Input.mouseReleased)
				{
					_snd.play();
					
					if( callback != null )
						callback();
				}
				
				image.setFrame(_col, 1);
			} else {
				image.setFrame(_col, 0);
			}
		}
	}
}
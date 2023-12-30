package Code.Display;

public class InvertMagenta extends Display {

   	@Override
   	public void rewriteImage(int v, int h) {
      	int red = (img.getRGB(h, v) & 0x00ff0000) >> 16,
      		blue = img.getRGB(h, v) & 0x000000ff;
      	setImage(v, h, 255 - red, 0, 255 - blue);
   	}

   	@Override
  	public String toString() { return "Invert Magenta"; }
   
}

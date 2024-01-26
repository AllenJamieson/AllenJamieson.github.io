package Display;

public class InvertRed extends Display {

	@Override
   	public void rewriteImage(int v, int h) {
      	int red = (img.getRGB(h, v) & 0x00ff0000) >> 16;
      	setImage(v, h, 255 - red, 0, 0);
   	}

   	@Override
   	public String toString() { return "Invert Red"; }
   
}

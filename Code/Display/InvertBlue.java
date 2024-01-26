package Display;

public class InvertBlue extends Display {

   	@Override
   	public void rewriteImage(int v, int h) {
      	int blue = img.getRGB(h, v) & 0x000000ff;
      	setImage(v, h, 0, 0, 255 - blue);
   	}

   	@Override
   	public String toString() { return "Invert Blue"; }

}

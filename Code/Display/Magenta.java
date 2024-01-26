package Display;

public class Magenta extends Display {

   	@Override
   	public void rewriteImage(int v, int h) {
      	int red = (img.getRGB(h, v) & 0x00ff0000) >> 16,
    		blue = img.getRGB(h, v) & 0x000000ff;
      	setImage(v, h, red, 0, blue);
   	}

   	@Override
   	public String toString() {
    	return "Magenta";
   	}
   
}

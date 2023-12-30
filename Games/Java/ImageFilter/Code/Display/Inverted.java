package Code.Display;

public class Inverted extends Display {

    @Override
    public void rewriteImage(int v, int h) {
        int red = (img.getRGB(h, v) & 0x00ff0000) >> 16,
            green = (img.getRGB(h, v) & 0x0000ff00) >> 8,
            blue = img.getRGB(h, v) & 0x000000ff;
        setImage(v, h, 255-red, 255-green, 255-blue);
    }

    @Override
    public String toString() { return "Inverted"; }
    
}

package Display;

public class InvertYellow extends Display {

    @Override
    public void rewriteImage(int v, int h) {
        int red = (img.getRGB(h, v) & 0x00ff0000) >> 16,
            green = (img.getRGB(h, v) & 0x0000ff00) >> 8;
        setImage(v, h, 255 - red, 255 - green, 0);
    }

    @Override
    public String toString() { return "Invert Yellow"; }
   
}

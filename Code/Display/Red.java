package Display;

public class Red extends Display {

    @Override
    public void rewriteImage(int v, int h) {
        int red = (img.getRGB(h, v) & 0x00ff0000) >> 16;
        setImage(v, h, red, 0, 0);
    }

    @Override
    public String toString() { return "Red"; }

}

package Code.Display;

public class Green extends Display {

    @Override
    public void rewriteImage(int v, int h) {
        int green = (img.getRGB(h, v) & 0x0000ff00) >> 8;
        setImage(v, h, 0, green, 0);
    }

    @Override
    public String toString() { return "Green"; }

}

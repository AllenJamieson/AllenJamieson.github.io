package Display;

public class InvertCyan extends Display {

    @Override
    public void rewriteImage(int v, int h) {
        int green = (img.getRGB(h, v) & 0x0000ff00) >> 8,
            blue = img.getRGB(h, v) & 0x000000ff;
        setImage(v, h, 0, 255 - green, 255 - blue);
    }

    @Override
    public String toString() { return "Invert Cyan"; }

}

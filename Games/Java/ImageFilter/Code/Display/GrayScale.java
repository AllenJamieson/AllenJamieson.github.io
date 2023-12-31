package Code.Display;

public class GrayScale extends Display {

    @Override
    public void rewriteImage(int v, int h) {
        int red = (img.getRGB(h, v) & 0x00ff0000) >> 16,
            green = (img.getRGB(h, v) & 0x0000ff00) >> 8,
            blue = img.getRGB(h, v) & 0x000000ff,
            av = (red + green + blue) / 3;
        setImage(v, h, av, av, av);
    }

    @Override
    public String toString() { return "Grey Scale"; }
    
}

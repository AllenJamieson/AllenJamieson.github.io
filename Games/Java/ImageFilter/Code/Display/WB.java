package Code.Display;

public class WB extends Display {

    @Override
    public void rewriteImage(int v, int h) {
        int red = (img.getRGB(h, v) & 0x00ff0000) >> 16,
            green = (img.getRGB(h, v) & 0x0000ff00) >> 8,
            blue = img.getRGB(h, v) & 0x000000ff,
            bw = red + green + blue;
        if(bw / 3 < 255 / 2) img.setRGB(h, v, 0xffffff);
        else img.setRGB(h, v, 0);
    }

    @Override
    public String toString() { return "White-Black"; }
    
}

package Code.Display;

public class MinMax extends Display {

    @Override
    public void rewriteImage(int v, int h) {
        int red = (img.getRGB(h, v) & 0x00ff0000) >> 16,
            green = (img.getRGB(h, v) & 0x0000ff00) >> 8,
            blue = img.getRGB(h, v) & 0x000000ff;
        if(red < 255 / 2) red = 255;
        else red = 0;
        if(green < 255 / 2) green = 255;
        else green = 0;
        if(blue < 255 / 2) blue = 255;
        else blue = 0;
        setImage(v, h, red, green, blue);
    }

    @Override
    public String toString() { return "Min-Max"; }
    
}

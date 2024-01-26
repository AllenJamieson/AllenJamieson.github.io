package Display;

public class Blue extends Display {

    @Override
    public void rewriteImage(int v, int h) {
        int blue = img.getRGB(h, v) & 0x000000ff;
        setImage(v, h, 0, 0, blue);
    }

    @Override
    public String toString() { return "Blue"; }
    
}

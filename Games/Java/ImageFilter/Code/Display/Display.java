package Code.Display;
import java.awt.Color;
import java.awt.image.BufferedImage;

public abstract class Display {
    protected BufferedImage img;

    public final void display(BufferedImage img) {
        this.img = img;
        if(!(this instanceof Original)) {
            for (int v = 0; v < img.getHeight(); v++) {
                for (int h = 0; h < img.getWidth(); h++) {
                    rewriteImage(v, h);
                }
            }
        }
    }

    public void setImage(int v, int h, int red, int green, int blue) {
        img.setRGB(h, v, new Color(red, green, blue).getRGB());
    }

    public abstract void rewriteImage(int v, int h);

    @Override
    public abstract String toString();
}

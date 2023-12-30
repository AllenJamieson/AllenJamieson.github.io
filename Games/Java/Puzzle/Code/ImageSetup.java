package Code;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.UIManager;
import javax.swing.filechooser.FileFilter;

public class ImageSetup {

    private JFileChooser fileChooser;
    private JFrame app;
    private BufferedImage image;
    private JLabel[][] segmentedImage;
    
    public ImageSetup(JFrame app) {
        this.app = app;
        Boolean old = UIManager.getBoolean("FilleChooser.readOnly");
        UIManager.put("FileChooser.readOnly", Boolean.TRUE);
        fileChooser = new JFileChooser(".");
        UIManager.put("FileChooser.readOnly", old);
        fileChooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
        fileChooser.setFileFilter(imageFilter());
    }

    public void load() {
        int returnVar = fileChooser.showOpenDialog(app);
        System.out.println("Loading in an image");
        if(returnVar == JFileChooser.APPROVE_OPTION) {
            try {
                image = ImageIO.read(fileChooser.getSelectedFile());
                scaleImage();
            }
            catch (IOException e) { System.out.println("Image not found"); }
        }
    }

    public void subdivideImage(int x, int y) {
        segmentedImage = new JLabel[y][x];
        int height = image.getHeight(), width = image.getWidth(),
            newW = width / x, newH = height / y;
        System.out.println(
            "Image height: " + height + "\n" + "Image width: " + width + "\n" +
            "Number of Subdivisions X: " + x + "\n" + "Number of Subdivisions Y: " + y + "\n" +
            "New H: " + newH + "\n" + "New W: " + newW + "\n"
        );
        for (int v = 0; v < y; v++) {
            for (int h = 0; h < x; h++) {
                BufferedImage img = image.getSubimage(((width % x) / 2) + (h*newW), ((height % y) / 2) + (v*newH), newW, newH);
                segmentedImage[v][h] = new JLabel(new ImageIcon(img));
            }
        }
    }

    private FileFilter imageFilter() {
        return new FileFilter() {
            @Override
            public boolean accept(File f) {
                String fileName = f.getName();
                return f.isDirectory()
                    || fileName.endsWith(".jpeg")
                    || fileName.endsWith(".jpg")
                    || fileName.endsWith(".png");
            }

            @Override
            public String getDescription() {
                return "Images";
            }
        };
    }

    private void scaleImage() {
        System.out.println("\nScaling Image");
        int scale = 1,
            imageWidth = image.getWidth(), imageHeight = image.getHeight(),
            appWidth = app.getWidth(), appHeight = app.getHeight();
        System.out.println(
            "App Width: " + appWidth + "\n" + "App Height: " + appHeight + "\n" +
            "Original Width: " + imageWidth + "\n" + "Original Height " + imageHeight
        );
        BufferedImage scaledImage = image;
        if(appWidth <= imageWidth || appHeight <= imageHeight) {
            while(appWidth <= imageWidth/scale) scale++;
            while(appHeight <= imageHeight/scale) scale++;
            scaledImage = new BufferedImage(imageWidth/scale, imageHeight/scale, BufferedImage.SCALE_SMOOTH);
            scaledImage.createGraphics().drawImage(image, 0, 0, imageWidth/scale, imageHeight/scale, null);
        }
        System.out.println("Scaled by: " + scale);
        image = scaledImage;
    }

    public BufferedImage getImage() { return image; }
    public JLabel[][] getSegmentedImage() { return segmentedImage; }
}
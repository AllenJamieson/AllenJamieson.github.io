import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.imageio.ImageIO;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.UIManager;

public class SaveLoad {
    private JFileChooser fileChooser;
    private JFrame app;

    public SaveLoad(JFrame app) {
        this.app = app;
        Boolean old = UIManager.getBoolean("FileChooser.readOnly");
        UIManager.put("FileChooser.readOnly", Boolean.TRUE);
        fileChooser = new JFileChooser(".");
        UIManager.put("FileChooser.readOnly", old);
        fileChooser.setFileSelectionMode(JFileChooser.FILES_AND_DIRECTORIES);
    }

    public void save(BufferedImage[] imgs, String filetype) {
        System.out.println("Saving...");
        int save = fileChooser.showSaveDialog(app);
        if(save == JFileChooser.APPROVE_OPTION) {
            String path = fileChooser.getSelectedFile().getPath();
            try {
                if(imgs.length == 1) {
                    File file = new File(path + "." + filetype);
                    ImageIO.write(imgs[0], filetype, file);
                } else if(imgs.length > 0) {
                    Files.createDirectory(Paths.get(path));
                    for (int img = 0; img < imgs.length; img++) {
                        System.out.println("Image " + img);
                        ImageIO.write(imgs[img], filetype, new File(path + "/" + (img+1) + "." + filetype));
                    }
                }
            } catch (IOException e) {
                System.out.println(e.getStackTrace());
            }
        }
    }

    public File load() {
        int returnVar = fileChooser.showOpenDialog(app);
        if(returnVar == JFileChooser.APPROVE_OPTION) {
            return fileChooser.getSelectedFile();}
        return null;
    }
}

package Code;
import java.awt.Color;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;

import Code.Display.*;

public class TestImage {

    private Display[] displayChoices = {
        new Original(), new Inverted(),
        new GrayScale(), new InvertGreyScale(),
        new MaxMin(), new MinMax(),
        new BW(), new WB(),
        new Red(), new Green(), new Blue(),
        new Yellow(), new Cyan(), new Magenta(),
        new InvertRed(), new InvertGreen(), new InvertBlue(),
        new InvertYellow(), new InvertCyan(), new InvertMagenta()
    };

    private JFrame app = new JFrame("Image Filter");
    private JLabel imageLabel = new JLabel(), status = new JLabel("Load an image to place a filter");
    private JButton close = new JButton("X"), loadButton = new JButton("Load"), saveButton = new JButton("Save");
    private JComboBox<Display> displayChoiceBox = new JComboBox<>(displayChoices);
    private JButton next = new JButton(">"), prev = new JButton("<");

    private BufferedImage image, clone;
    private ArrayList<BufferedImage> images, clones;

    private SaveLoad saveLoad;
    private final int PADDING = 10, HEADER = 50;
    private int index = 0;
    private String filetype;

    public TestImage() {
        int width = (int)Toolkit.getDefaultToolkit().getScreenSize().getWidth(),
            height = (int)Toolkit.getDefaultToolkit().getScreenSize().getHeight();
        app.setSize(width, height);
        app.setLayout(null);
        app.setUndecorated(true);

        saveLoad = new SaveLoad(app);

        setBounds(height, width);
        process();

        close.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent arg0) { System.exit(0); }
        });

        loadButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                displayChoiceBox.setSelectedIndex(0);
                next.setEnabled(false);
                prev.setEnabled(false);
                image = null;
                clone = null;
                images = new ArrayList<>();
                clones = new ArrayList<>();
                File file = saveLoad.load();

                if(file != null) {
                    index = 0;
                    saveButton.setEnabled(true);
                    displayChoiceBox.setEnabled(true);
                    if(file.isDirectory()) {
                        File[] files = file.listFiles();
                        status.setText("Getting the images...");
                        Arrays.sort(files, (a, b) -> a.getName().compareTo(b.getName()));
                        
                        for (File current : files) {
                            if(isImage(current)) {
                                try {
                                    if(filetype == null) filetype = current.getName().substring(current.getName().lastIndexOf(".") + 1);
                                    images.add(ImageIO.read(current));
                                    clones.add(ImageIO.read(current));
                                } catch (IOException e1) { status.setText("There is an issue resolving the image"); }
                            }
                        }
                        status.setText("Images recieved...");
                        images.trimToSize();
                        clones.trimToSize();
                        if(!images.isEmpty()) {
                            imageLabel.setIcon(new ImageIcon(images.get(0)));
                            next.setEnabled(true);
                            prev.setEnabled(true);
                        }
                    } else if(isImage(file)) {
                        status.setText("Image is selected");
                        filetype = file.getName().substring(file.getName().lastIndexOf(".") + 1);
                        try {
                            image = ImageIO.read(file);
                            clone = ImageIO.read(file);
                            imageLabel.setIcon(new ImageIcon(image));
                            status.setText("The image is set");
                        } catch (IOException e1) { status.setText("Can't convert to an image"); }
                    } else {
                        status.setText("No image or folder found");
                        saveButton.setEnabled(false);
                        displayChoiceBox.setEnabled(false);
                    }
                }    
            }
        });

        saveButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent arg0) {
                status.setText("Saving...");
                close.setEnabled(false);
                if(image != null) {
                    saveLoad.save(new BufferedImage[] {clone}, filetype);
                    image = clone;
                }
                else if(!images.isEmpty()) {
                    BufferedImage[] imgs = new BufferedImage[images.size()];
                    saveLoad.save((BufferedImage[]) (clones.toArray(imgs)), filetype);
                    images = new ArrayList<>();
                    for (BufferedImage current : clones) images.add(current);
                }
                else status.setText("Nothing to save");
                close.setEnabled(true);
                status.setText("Saved");
            }
        });

        displayChoiceBox.addItemListener(new ItemListener() {
            @Override
            public void itemStateChanged(ItemEvent e) {
                if(e.getStateChange() == ItemEvent.SELECTED) {
                    if(image != null) {
                        imageEdit(image);
                        imageLabel.setIcon(new ImageIcon(clone));
                        status.setText("Completed");
                    } else if(!images.isEmpty()) {
                        clones.clear();
                        status.setText("Processing images...");
                        for (BufferedImage current : images) {
                            imageEdit(current);
                            clones.add(clone);
                        }
                        status.setText("Completed");
                        imageLabel.setIcon(new ImageIcon(clones.get(index)));
                    } else status.setText("Nothing to alter");
                }
            }
        });

        prev.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent arg0) { prev(); }
        });

        next.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) { next(); }
        });

        app.addKeyListener(new KeyAdapter() {
            public void keyReleased(KeyEvent e) {
                if(e.getKeyCode() == KeyEvent.VK_ESCAPE) System.exit(0);
            };

            public void keyPressed(KeyEvent e) {
                if(e.getKeyChar() == 'a' || e.getKeyCode() == KeyEvent.VK_LEFT) prev();
                if(e.getKeyChar() == 'd' || e.getKeyCode() == KeyEvent.VK_RIGHT) next();};
        });
        
        addToApp();
        app.setVisible(true);
    }

    private boolean isImage(File file) {
        String filename = file.getName();
        return filename.endsWith(".jpg")
            || filename.endsWith(".png")
            || filename.endsWith(".jpeg");
    }

    private void imageEdit(BufferedImage image) {
        clone = new BufferedImage(image.getWidth(), image.getHeight(), BufferedImage.SCALE_SMOOTH);
        for (int v = 0; v < image.getHeight(); v++) for (int h = 0; h < image.getWidth(); h++) clone.setRGB(h, v, image.getRGB(h, v));
        ((Display)displayChoiceBox.getSelectedItem()).display(clone);
    }


    private void setBounds(int height, int width) {
        close.setBounds(width - PADDING - HEADER, PADDING, HEADER, HEADER);
        saveButton.setBounds(close.getX() - PADDING - 100, PADDING, 100, HEADER);
        loadButton.setBounds(saveButton.getX() - PADDING - 100, PADDING, 100, HEADER);
        displayChoiceBox.setBounds(PADDING, PADDING, 200, HEADER);
        imageLabel.setBounds(2 * PADDING + HEADER, HEADER + 2 * PADDING, width - 4 * PADDING - 2 * HEADER, height - 2 * HEADER - 2 * PADDING);
        prev.setBounds(PADDING, height / 2, HEADER, HEADER);
        next.setBounds(width - PADDING - HEADER, height / 2, HEADER, HEADER);
        status.setBounds(displayChoiceBox.getX() + displayChoiceBox.getWidth() + PADDING, PADDING, width / 2, HEADER);
    }

    private void process() {
        close.setFocusable(false);
        loadButton.setFocusable(false);
        saveButton.setFocusable(false);
        displayChoiceBox.setFocusable(false);
        prev.setFocusable(false);
        next.setFocusable(false);
        saveButton.setEnabled(false);
        displayChoiceBox.setEnabled(false);
        prev.setEnabled(false);
        next.setEnabled(false);
        close.setOpaque(true);
        close.setBackground(Color.RED);
        close.setForeground(Color.WHITE);
    }

    private void addToApp() {
        app.add(close);
        app.add(imageLabel);
        app.add(loadButton);
        app.add(saveButton);
        app.add(displayChoiceBox);
        app.add(prev);
        app.add(next);
        app.add(status);
    }

    private void prev() {
        if(--index < 0) index += images.size();
        imageLabel.setIcon(new ImageIcon(clones.get(index)));
        status.setText("Image: " + (index+1));
    }

    private void next() {
        index = (index + 1) %  images.size();
        imageLabel.setIcon(new ImageIcon(clones.get(index)));
        status.setText("Image: " + (index+1));
    }
}

package Code;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;

public class Puzzle {
    private final int MAX_SIZE = 50;
    private JFrame app;
    private JLabel completeImage, widthLabel, heightLabel;
    private JTextField xField, yField;
    private JButton openButton, shuffleButton, close;
    private ImageSetup imageData;
    private boolean visible;
    private Board board;

    public Puzzle() {
        initialize();
        app.setLayout(null);
        app.setUndecorated(true);
        app.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        actions();
        setupComponents();
        app.setVisible(true);
    }

    private boolean isDoable(int subX, int subY) {
        return imageData.getImage() != null &&
                subX > 0 && subY > 0 &&
                subX <= MAX_SIZE && subY <= MAX_SIZE &&
                subX <= imageData.getImage().getWidth() &&
                subY <= imageData.getImage().getHeight();
    }

    private void shuffle() {
        try {
            System.out.println("\nImage splitting");
            int subX = Integer.parseInt(xField.getText()),
                subY = Integer.parseInt(yField.getText());
            if(isDoable(subX, subY)) {
                imageData.subdivideImage(subX, subY);
                System.out.println("Hiding unneeded components");
                visible = false;
                showHide();
                board.boardSetup(imageData.getSegmentedImage(), app);                
            } else System.out.println("Too many subdivisions");
        } catch (NumberFormatException nfe) { System.out.println("This is not a number"); }
    }

    private void actions() {
        app.addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                if(e.getKeyCode() == KeyEvent.VK_ESCAPE) {
                    if(completeImage.isVisible()) System.exit(0);
                    visible = true;
                    showHide();
                    board.removeAll();
                }
                if(e.getKeyCode() == KeyEvent.VK_ENTER) shuffle();
            }
        });

        xField.addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                if(e.getKeyCode() == KeyEvent.VK_ESCAPE) System.exit(0);
                if(e.getKeyCode() == KeyEvent.VK_ENTER) shuffle();
            }
        });

        yField.addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                if(e.getKeyCode() == KeyEvent.VK_ESCAPE) System.exit(0);
                if(e.getKeyCode() == KeyEvent.VK_ENTER) shuffle();
            }
        });

        openButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                imageData.load();
                if(imageData.getImage() != null) {
                    completeImage.setIcon(new ImageIcon(imageData.getImage()));
                    shuffleButton.setEnabled(true);
                    xField.setEditable(true);
                    yField.setEditable(true);
                } else System.out.println("No image found");
            }
        });

        shuffleButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) { shuffle(); }
        });

        close.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) { System.exit(0); }
        });
    }

    private void showHide() {
        close.setVisible(visible);
        openButton.setVisible(visible);
        shuffleButton.setVisible(visible);
        xField.setVisible(visible);
        yField.setVisible(visible);
        completeImage.setVisible(visible);
        widthLabel.setVisible(visible);
        heightLabel.setVisible(visible);
        xField.setFocusable(visible);
        yField.setFocusable(visible);
        app.requestFocus();
    }
    
    private void initialize() {
        app = new JFrame("Puzzle");
        completeImage = new JLabel("", null, JLabel.CENTER);
        widthLabel = new JLabel("Width Subdivision:");
        heightLabel = new JLabel("Height Subdivision:");
        xField = new JTextField();
        yField = new JTextField();
        openButton = new JButton("Get Image");
        shuffleButton = new JButton("Shuffle");
        close = new JButton("x");
        imageData = new ImageSetup(app);
        board = new Board();
        visible = true;
    }

    private void setupComponents() {
        app.setSize(Toolkit.getDefaultToolkit().getScreenSize());
        completeImage.setBounds(0, 0, app.getWidth(), app.getHeight());
        close.setBounds(app.getWidth()-55, 5, 50, 50);
        xField.setBounds(235, 5, 20, 20);// width
        yField.setBounds(235, 35, 20, 20);// height
        openButton.setBounds(5, 5, 100, 20);
        shuffleButton.setBounds(5, 35, 100, 20);
        widthLabel.setBounds(120, 5, 225, 20);
        heightLabel.setBounds(120, 35, 225, 20);

        xField.setEditable(false);
        yField.setEditable(false);
        shuffleButton.setEnabled(false);
        openButton.setFocusable(false);
        close.setFocusable(false);
        shuffleButton.setFocusable(false);
        app.add(close);
        app.add(xField);
        app.add(yField);
        app.add(shuffleButton);
        app.add(openButton);
        app.add(completeImage);
        app.add(board);
        app.add(widthLabel);
        app.add(heightLabel);
    }
}
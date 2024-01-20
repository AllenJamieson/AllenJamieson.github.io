package Code;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.Icon;
import javax.swing.JLabel;

public class Tile extends JLabel {
    private final int PADDING;
    private int data, xPos, yPos, width, height;

    public Tile(int dat, Icon img, int x, int y, int pad, Board board) {
        data = dat;
        xPos = x;
        yPos = y;
        width = img.getIconWidth();
        height = img.getIconHeight();
        PADDING = pad;
        setSize(width, height);
        setIcon(img);
        setTileLocation();
        Tile t = this;
        addMouseListener(new MouseAdapter() {
            @Override
            public void mouseReleased(MouseEvent e) {
                board.setValues(t);
            }
        });
    }
    public int getxPos() { return xPos; }
    public int getyPos() { return yPos; }
    public int getData() { return data; }
    private void setTileLocation() { setLocation(width*xPos + PADDING*xPos, height*yPos + PADDING*yPos); }
    public void setNewLocation(int x, int y) {
        xPos = x; yPos = y;
        setTileLocation();
    }
    public void setData(int data) { this.data = data; }
}

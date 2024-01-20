package Code;
import java.util.Random;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

public class Board extends JPanel {
    private final int PADDING = 2;
    private int v, h;
    private int[][] arrangement;
    private Tile[][] tiles; 
    private boolean completed;
    private Tile tile1;
    
    public Board() {
        setLayout(null);
    }

    public void boardSetup(JLabel[][] current, JFrame app) {
        v = current.length;
        h = current[0].length;
        tiles = new Tile[v][h];
        arrangement = new int[v][h];
        tile1 = null;
        completed = false;

        shuffle(current);
        displayGrid();
        setSize((h*current[0][0].getIcon().getIconWidth())+(PADDING*(h-1)), (v*current[0][0].getIcon().getIconHeight())+(PADDING*(v-1)));
        setLocation((app.getWidth()/2) - (getWidth()/2), (app.getHeight()/2) - (getHeight()/2));
    }

    private void shuffle(JLabel[][] current) {
        Random rand = new Random();
        int currentVal = 1;
        System.out.println("\nMaking shuffle");
        for (int vi = 0; vi < v; vi++) {
            for (int hi = 0; hi < h; hi++) {
                int vChoose = rand.nextInt(v),
                    hChoose = rand.nextInt(h);
                while(arrangement[vChoose][hChoose] != 0) {
                    vChoose = rand.nextInt(v);
                    hChoose = rand.nextInt(h);
                }
                tiles[vi][hi] = new Tile(currentVal, current[vi][hi].getIcon(), hChoose, vChoose, PADDING, this);
                tiles[vi][hi].getWidth();
                add(tiles[vi][hi]);
                arrangement[vChoose][hChoose] = currentVal++;
            }
        }
    }


    private boolean isCorrect() {
        int i = 1;
        for (int v = 0; v < arrangement.length; v++) {
            for (int h = 0; h < arrangement[v].length; h++) {
                if(arrangement[v][h] != i++) return false;
            }
        }
        return true;
    }

    private void displayGrid() {
        for (int i = 0; i < arrangement.length; i++) {
            for (int j = 0; j < arrangement[i].length; j++)
                System.out.print(arrangement[i][j] + "\t");
            System.out.println();
        }
        System.out.println();
    }

    public void setValues(Tile tile) {
        if(!completed) {
            if(tile1 == null) tile1 = tile;
            else {
                int v1 = tile1.getyPos(), h1 = tile1.getxPos(),
                    v2 = tile.getyPos(), h2 = tile.getxPos();
                tile1.setNewLocation(h2, v2);
                tile.setNewLocation(h1, v1);
                tile1.setData(tile.getData());
                tile.setData(tile1.getData());
                int tempAr1 = arrangement[v1][h1];
                arrangement[v1][h1] = arrangement[v2][h2];
                arrangement[v2][h2] = tempAr1;
                System.out.println("Move: ");
                displayGrid();
                tile1 = null;
                if(isCorrect()) {
                    JOptionPane.showMessageDialog(null, "Completed press esc to chose another");
                    completed = true;
                }
            }
        }
    }
}
package Code;
import java.awt.Color;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.Random;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

public class Donsol {

    public class Slot extends JLabel {
        private Card card;

        public Slot() {
            setSize(200, 300);
            setOpaque(true);
            setBackground(Color.WHITE);
            setEnabled(false);
            setFont(new Font("Times New Roman", Font.ROMAN_BASELINE, 30));
            addMouseListener(new MouseAdapter() {
                @Override
                public void mouseReleased(MouseEvent e) {
                    if(isEnabled()) {
                        int amount = card.getAmount();
                        if(card.getStyle() == Suit.Style.ATTACK) {
                            player.damage(amount);
                            if(player.getCurrentLowest() > 0) {
                                currentDefense.setText("Lowest Damage: " + player.getCurrentLowest());
                                currentDefense.setVisible(true);
                            }
                            if(player.getCurrentLowest() == 0) currentDefense.setVisible(false);
                        }
                        else if(card.getStyle() == Suit.Style.HEALTH) player.heal(amount);
                        else if(card.getStyle() == Suit.Style.DEFENCE) {
                            player.defend(amount);
                            currentDefense.setVisible(false);
                        }
                        else System.out.println("Error");
                        finishedLabel.setText("Cards Used: " + ++cardsFinished + "/54");
                        card = null;
                        setText("");
                        setEnabled(false);
                        if(!(slot1.isEnabled() || slot2.isEnabled() || slot3.isEnabled() || slot4.isEnabled())) {
                            if(deck.isEmpty()) winGame();
                            nextRoom.setText("Next Room");
                            nextRoom.setEnabled(true);
                        }
                        if(noAttack()) {
                            fleed = false;
                            nextRoom.setText("Next Room");
                            nextRoom.setEnabled(true);
                        }
                        if(player.isEnd()) loseGame();
                        playerData.setText("<html>Damage: " + player.getDamaged() + "/21<br>Defense: " + player.getDefense() + "</html>");
                    }
                }
            });
        }

        public Card getCard() {
            return card;
        }

        public void setCard(Card card) {
            this.card = card;
            if(card.getStyle() == Suit.Style.ATTACK) setForeground(Color.BLACK);
            else setForeground(Color.RED);
            setEnabled(true);
            setText(card.toString());
        }

    }

    private final int CARD_PADDING = 15;
    
    private JFrame app;
    private JButton nextRoom;
    private JLabel playerData, currentDefense, finishedLabel, rulesLabel;
    
    private Slot slot1 = new Slot(), slot2 = new Slot(), slot3 = new Slot(), slot4 = new Slot();
    private Player player;
    private ArrayList<Card> deck;
    
    private int width = (int) Toolkit.getDefaultToolkit().getScreenSize().getWidth(),
                height = (int) Toolkit.getDefaultToolkit().getScreenSize().getHeight();
    private Random random = new Random();
    private boolean fleed = false;
    private int cardsFinished = 0;
    
    public Donsol() {
        player = new Player();
        deck = new Deck().getDeck();
        setupDisplay();
        setupBoard();
    }

    private void setupDisplay() {
        app = new JFrame("Donsol");
        app.setLayout(null);
        app.setSize(width, height);
        
        app.addKeyListener(new KeyAdapter() {
            @Override
            public void keyReleased(KeyEvent e) {
                if(e.getKeyCode() == KeyEvent.VK_ESCAPE) System.exit(0);
                if(e.getKeyChar() == 'h') rulesLabel.setVisible(!rulesLabel.isVisible());
            }
        });
        
        JButton close = new JButton("X");
        close.setBackground(Color.RED);
        close.setForeground(Color.WHITE);
        close.setBounds(width-55, 5, 50, 50);
        close.setFocusable(false);

        close.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.exit(0);
            }
        });
        
        setupGame();
        app.add(close);
        app.setUndecorated(true);
        app.setVisible(true);
    }

    private void setupGame() {
        nextRoom = new JButton();
        nextRoom.setFocusable(false);
        nextRoom.setBounds((width - 200)/2, height - 105, 200, 50);

        playerData = new JLabel("<html>Damage: 0/21<br>Defense: 0</html>");
        playerData.setBounds(CARD_PADDING, 365, 300, 75);
        playerData.setFont(new Font("Times New Roman", Font.ROMAN_BASELINE, 30));

        currentDefense = new JLabel();
        currentDefense.setBounds(CARD_PADDING, 450, 225, 75);
        currentDefense.setVisible(false);
        currentDefense.setFont(new Font("Times New Roman", Font.ROMAN_BASELINE, 20));

        finishedLabel = new JLabel("Cards Used: 0/54");
        finishedLabel.setBounds(CARD_PADDING, 5, 150, 50);

        slot1.setLocation(CARD_PADDING, 50);
        slot2.setLocation(slot1.getWidth() + slot1.getX() + CARD_PADDING, slot1.getY());
        slot3.setLocation(slot1.getWidth() + slot2.getX() + CARD_PADDING, slot1.getY());
        slot4.setLocation(slot1.getWidth() + slot3.getX() + CARD_PADDING, slot1.getY());

        rulesLabel = new JLabel("<html>" +
            "Welcome to Donsol.<br>The goal of the game is to use all of the cards in the 54 card deck containing 2 Jokers.<br>" +
            "The way to do this is by going through the stages and select the cards to remove them.<br>" +
            "Make sure the damage is below 21. The black suits damage, hearts heal, and diamonds defend you.<br>" +
            "Numbers will heal, defend, or attack depending on the suit. Faces will heal or defend at 11.<br>" +
            "The faces of attacking cards are J = 11, Q - 13, K = 15, A = 17, Joker = 21<br>" +
            "Your defenses can break by attacking cards that are greater than the lowest value attacked previously.</html>");
        rulesLabel.setBounds(slot4.getX() + slot4.getWidth() + CARD_PADDING, 100, 750, 250);

        nextRoom.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                Card c = slot1.getCard();
                if(c != null) deck.add(c);
                c = slot2.getCard();
                if(c != null) deck.add(c);
                c = slot3.getCard();
                if(c != null) deck.add(c);
                c = slot4.getCard();
                if(c != null) deck.add(c);
                if(nextRoom.getText().equals("Flee Room") && !fleed) {
                    fleed = true;
                    nextRoom.setEnabled(false);
                }
                setupBoard();
            }
        });

        app.add(nextRoom);
        app.add(playerData);
        app.add(currentDefense);
        app.add(finishedLabel);
        app.add(rulesLabel);
        app.add(slot1);
        app.add(slot2);
        app.add(slot3);
        app.add(slot4);

    }

    private void setupBoard() {
        nextRoom.setEnabled(true);
        if(!deck.isEmpty()) slot1.setCard(deck.remove(random.nextInt(deck.size())));
        if(!deck.isEmpty()) slot2.setCard(deck.remove(random.nextInt(deck.size())));
        if(!deck.isEmpty()) slot3.setCard(deck.remove(random.nextInt(deck.size())));
        if(!deck.isEmpty()) slot4.setCard(deck.remove(random.nextInt(deck.size())));
        if(!noAttack()) {
            nextRoom.setText("Flee Room");
            nextRoom.setEnabled(!fleed);
        } else nextRoom.setText("Next Room");
    }

    private void loseGame() {
        JOptionPane.showMessageDialog(null, "You Lose", "Donsol", JOptionPane.WARNING_MESSAGE);
        System.exit(0);
    }

    private void winGame() {
        JOptionPane.showMessageDialog(null, "You Win", "Donsol", JOptionPane.WARNING_MESSAGE);
        System.exit(0);
    }

    private boolean noAttack() {
        Card c = slot1.getCard();
        if(c != null && c.getStyle() == Suit.Style.ATTACK) return false;
        c = slot2.getCard();
        if(c != null && c.getStyle() == Suit.Style.ATTACK) return false;
        c = slot3.getCard();
        if(c != null && c.getStyle() == Suit.Style.ATTACK) return false;
        c = slot4.getCard();
        if(c != null && c.getStyle() == Suit.Style.ATTACK) return false;
        return true;
    }
}

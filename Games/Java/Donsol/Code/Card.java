package Code;
public class Card {

    private String name;
    private Suit.Style style;
    private int amount;
    
    public Card(Suit suit, Face face) {
        this();
        name = face.getName() + suit.getUnicode();
        style = suit.getStyle();
        amount = face.getAmount();
        if(style != Suit.Style.ATTACK && amount > 11) amount = 11;
    }

    // JOKER
    public Card() {
        name = "Joker";
        amount = 21;
        style = Suit.Style.ATTACK;
    }

    @Override
    public String toString() {
        return name;
    }

    public Suit.Style getStyle() {
        return style;
    }

    public int getAmount() {
        return amount;
    }
}

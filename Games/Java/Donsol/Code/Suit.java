package Code;
public enum Suit {

    CLUBS("\u2663", Style.ATTACK),
    DIAMONDS("\u2666", Style.DEFENCE),
    HEARTS("\u2665", Style.HEALTH),
    SPADES("\u2660", Style.ATTACK);

    public enum Style {
        ATTACK,
        HEALTH,
        DEFENCE;
    }

    private Style style;
    private String unicode;

    private Suit(String unicode, Style style) {
        this.style = style;
        this.unicode = unicode;
    }

    public Style getStyle() { return style; }
    public String getUnicode() { return unicode; }
}

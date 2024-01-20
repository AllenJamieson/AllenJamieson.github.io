package Code;
public enum Face {
    ACE("A", 17),
    TWO("2", 2),
    THREE("3", 3),
    FOUR("4", 4),
    FIVE("5", 5),
    SIX("6", 6),
    SEVEN("7", 7),
    EIGHT("8", 8),
    NINE("9", 9),
    TEN("10", 10),
    JACK("J", 11),
    QUEEN("Q", 13),
    KING("K", 15);

    private int amount;
    private String name;

    private Face(String name, int amount) {
        this.amount = amount;
        this.name = name;
    }

    public int getAmount() { return amount; }
    public String getName() { return name; }
}

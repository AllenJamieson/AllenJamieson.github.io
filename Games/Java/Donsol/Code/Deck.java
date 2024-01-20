package Code;
import java.util.ArrayList;

public class Deck {

    private ArrayList<Card> deck = new ArrayList<>();
    public Deck() {
        for (Face face : Face.values())
            for (Suit suit : Suit.values())
                deck.add(new Card(suit, face));
        deck.add(new Card());
        deck.add(new Card());
        deck.trimToSize();
    }

    public ArrayList<Card> getDeck() { return deck; }
}

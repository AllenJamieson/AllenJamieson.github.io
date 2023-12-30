package Code;
public class Player {
    private final int MAX_DAMAGE = 21;
    private int damaged = 0, defense = 0, currentLowest = 0;

    public void damage(int amount) {
        if(defense < amount) damaged += (amount-defense);
        if(defense != 0 && currentLowest == 0) currentLowest = amount;
        else if(amount < currentLowest) currentLowest = amount;
        else {
            currentLowest = 0;
            defense = 0;
        }
    }

    public void heal(int amount) {
        damaged -= amount;
        if(damaged < 0) damaged = 0;
    }

    public void defend(int amount) {
        defense = amount;
        currentLowest = 0;
    }

    public boolean isEnd() {
        return damaged >= MAX_DAMAGE;
    }

    public int getDamaged() {
        return damaged;
    }

    public int getDefense() {
        return defense;
    }

    public int getCurrentLowest() { return currentLowest; }
}

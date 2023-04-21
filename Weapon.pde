public class Weapon {
    Player player;
    float attack;
    float attackInterval;

    float attackTimer;

    public Weapon(Player player) {
        this.player = player;
    }

    void update(float second) {
        if (attackTimer > 0) attackTimer -= second;
    }
}
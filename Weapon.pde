public class Weapon {
    Player player;
    float attack;
    float attackInterval;
    int level;

    float attackTimer;

    PImage projectileImage;

    WeaponType TYPE;
    float MAX_LEVEL;

    public Weapon(Player player) {
        this.player = player;
    }

    void update(float second) {
        if (attackTimer > 0) attackTimer -= second;
    }

    void levelUp() {
        if (level < MAX_LEVEL) {
            level ++;
            getLevelBonus();
        }
    }

    void loadProjectileImage(String name) {
        projectileImage = loadImage("ObjectImgs/Projectiles/" + name + ".png");
    }

    void getLevelBonus() {

    }
}
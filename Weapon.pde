public class Weapon {
    Player player;

    int level;

    int PROJ_NUM; // How many projectils to shoot for one attack
    int shootCount; // How many have shot in this attack.

    float attackTimer;

    PImage projectileImage;

    WeaponType TYPE;
    float MAX_LEVEL;

    float attack;
    float ATTACK_MULTIPLIER;

    float attackInterval;
    float BASE_SHOOT_INTERVAL;

    public Weapon(Player player) {
        this.player = player;
    }

    void update(float second) {
        attack = player.ce.attack * ATTACK_MULTIPLIER;
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

    String getDescription(int level) {
        return "";
    }
}
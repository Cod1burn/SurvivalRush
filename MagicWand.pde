public class MagicWand extends Weapon {
    int shootNum;
    int shootCount;
    float projectileSpeed;
    float projectileRadius;
    int level;
    float ATTACK_MULTIPLIER;
    float BASE_ATTACK_INTERVAL;
    final float BASE_PROJECTILE_SPEED = 700;
    final float MINIMAL_SHOOT_INTERVAL = 0.15;
    final float BASE_PROJECTILE_RADIUS = 15;
    final float MAX_LEVEL = 10;
    public MagicWand(Player player) {
        super(player);
        shootNum = 1;
        shootCount = 0;
        level = 1;
        ATTACK_MULTIPLIER = 1.0;
        BASE_ATTACK_INTERVAL = 1.0;
        projectileSpeed = BASE_PROJECTILE_SPEED;
        projectileRadius = BASE_PROJECTILE_RADIUS;
    }

    void update(float second) {
        super.update(second);
        attack = player.ce.attack * ATTACK_MULTIPLIER;
        attackInterval = BASE_ATTACK_INTERVAL / (1 + player.ce.attackSpeed/100.0);
        if (attackTimer <= 0) shootMagicOrb();
    }

    void shootMagicOrb() {
        MagicOrb orb = new MagicOrb(player, player.direction, projectileSpeed, projectileRadius, attack);
        player.projectiles.add(orb);
        if (shootCount < shootNum) {
            shootNum++;
            attackTimer = MINIMAL_SHOOT_INTERVAL;
        } else {
            shootCount = 0;
            attackTimer = attackInterval;
        }
    }

    void levelUp() {
        if (level < MAX_LEVEL) {
            level ++;
            getLevelBonus();
        }
    }

    void getLevelBonus() {
        switch (level) {
            case 2 :
                ATTACK_MULTIPLIER = 1.2;
            break;	

            case 3 :
                BASE_ATTACK_INTERVAL = 0.8;
            break;

            case 4 :
                shootNum ++;
            break;

            case 5 :
                ATTACK_MULTIPLIER = 1.5;
            break;


        }
    }
}

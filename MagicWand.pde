public class MagicWand extends Weapon {
    float projSpeed;
    float projRadius;
    final float PROJ_SPEED = 700;
    final float MINIMAL_SHOOT_INTERVAL = 0.12;
    final float PROJ_RADIUS = 15;
    
    public MagicWand(Player player) {
        super(player);
        PROJ_NUM = 1;
        shootCount = 0;
        level = 1;
        ATTACK_MULTIPLIER = 1.0;
        BASE_SHOOT_INTERVAL = 1.0;
        projSpeed = PROJ_SPEED;
        projRadius = PROJ_RADIUS;
        TYPE = WeaponType.MAGICWAND;
        MAX_LEVEL = 10;

        loadProjectileImage("blue_orb");
    }

    @Override
    void update(float second) {
        super.update(second);
        attackInterval = BASE_SHOOT_INTERVAL / (1 + player.ce.attackSpeed/100.0);
        if (attackTimer <= 0) shootMagicOrb();
    }

    void shootMagicOrb() {
        MagicOrb orb;
        if (player.direction.mag() != 0) {
            orb = new MagicOrb(player, player.direction, projSpeed, projRadius, attack);
        } else {
            orb = new MagicOrb(player, player.lastDirection, projSpeed, projRadius, attack);
        }

        orb.setImage(projectileImage);
        player.projectiles.add(orb);
        shootCount++;
        if (shootCount < PROJ_NUM + player.ce.extraProjs) {
            attackTimer = MINIMAL_SHOOT_INTERVAL;
        } else {
            shootCount = 0;
            attackTimer = attackInterval;
        }
    }

    @Override
    void getLevelBonus() {
        switch (this.level) {
            case 2 :
                ATTACK_MULTIPLIER = 1.2;
            break;	

            case 3 :
                BASE_SHOOT_INTERVAL = 0.85;
            break;

            case 4 :
                PROJ_NUM++;
            break;

            case 5 :
                ATTACK_MULTIPLIER = 1.4;
            break;

            case 6 :
                PROJ_NUM++;
                BASE_SHOOT_INTERVAL = 0.75;
            break;

            case 7 :
                ATTACK_MULTIPLIER = 1.6;
            break;

            case 8 :
                PROJ_NUM++;
            break;	

            case 9 :
                BASE_SHOOT_INTERVAL = 0.65;
            break;	

            case 10:
                PROJ_NUM++;
                BASE_SHOOT_INTERVAL = 0.5;
                ATTACK_MULTIPLIER = 1.8;
            break;
        }
    }
    
    @Override
    String getDescription(int level) {
        String s = "";
        switch (level) {
            case 1 :
                s = "Fire magic orbs through your direction.";
            break;	

            case 2 :
                s =  "Damage +20%";
            break;

            case 3 :
                s = "Shooting Interval -0.15s";
            break;	

            case 4 :
                s = "Shoot one more orb";
            break;	

            case 5 :
                s = "Damage +20%";
            break;	

            case 6 :
                s = "Shoot one more orb, \n Shooting Interval -0.1s%";
            break;

            case 7 :
                s = "Damage +20%";
            break;		

            case 8 :
                s = "Shoot one more orb";
            break; 

            case 9 :
                s = "Shooting Interval -0.15s%";
            break;	

            case 10 :
                s = "Shoot one more orb, \nShooting Interval -0.15s, \nDamage +20%";
            break;	

            default :
            break;
        }
        return s;
    }
}

import java.util.List;

public class Boomrang extends Weapon {
    float projSpeed;
    float projRadius;
    float PROJ_SPEED = 500;
    float PROJ_RADIUS = 20;
    float PROJ_RANGE = 700;
    
    public Boomrang(Player player) {
        super(player);
        PROJ_NUM = 1;
        shootCount = 0;
        level = 1;
        ATTACK_MULTIPLIER = 1.0;
        BASE_SHOOT_INTERVAL = 1.5;
        projSpeed = PROJ_SPEED;
        projRadius = PROJ_RADIUS;
        TYPE = WeaponType.BOOMRANG;
        MAX_LEVEL = 10;

        loadProjectileImage("boomrang");
    }

    @Override
    void update(float second) {
        super.update(second);
        attack = player.ce.attack * ATTACK_MULTIPLIER;
        attackInterval = BASE_SHOOT_INTERVAL / (1 + player.ce.attackSpeed/100.0);
        if (attackTimer <= 0) shootBoomrangs(player.findEnemies(PROJ_NUM));
    }

    void shootBoomrang(PVector direction) {
        BoomrangProj br;
        br = new BoomrangProj(player, direction, PROJ_SPEED, PROJ_RANGE,
        PROJ_RADIUS, attack);
        br.setImage(projectileImage);
        player.projectiles.add(br);
        shootCount++;
        if (shootCount >= PROJ_NUM) attackTimer = attackInterval;
    }

    void shootBoomrangs(List<Enemy> enemies) {
        enemies.forEach((e) -> {
            PVector direction = e.position.copy().sub(player.position).normalize();
            shootBoomrang(direction);
            shootCount++;
        });
        while(shootCount < PROJ_NUM) {
            PVector direction = PVector.fromAngle(random(0, 2*PI));
            shootBoomrang(direction);
            shootCount++;
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

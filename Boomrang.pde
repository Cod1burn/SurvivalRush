import java.util.List;

public class Boomrang extends Weapon {
    float projSpeed;
    float projRadius;
    float PROJ_SPEED = 600;
    float PROJ_RADIUS = 30;
    float PROJ_RANGE = 450;
    
    public Boomrang(Player player) {
        super(player);
        PROJ_NUM = 1;
        shootCount = 0;
        level = 1;
        ATTACK_MULTIPLIER = 1.0;
        BASE_SHOOT_INTERVAL = 2.5;
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
    }

    void shootBoomrangs(List<Enemy> enemies) {
        enemies.forEach((e) -> {
            PVector direction = e.position.copy().sub(player.position).normalize();
            shootBoomrang(direction);
        });

        while(shootCount < PROJ_NUM) {
            PVector direction = PVector.fromAngle(random(0, 2*PI));
            shootBoomrang(direction);
        }
        attackTimer = attackInterval;
        shootCount = 0;
    }

    @Override
    void getLevelBonus() {
        switch (this.level) {
            case 2 :
                ATTACK_MULTIPLIER = 1.2;
            break;	

            case 3 :
                PROJ_SPEED = 600;
                PROJ_RANGE = 800;
            break;

            case 4 :
                PROJ_NUM ++;
            break;

            case 5 :
                BASE_SHOOT_INTERVAL = 2.0;
            break;

            case 6 :
                PROJ_NUM++;
                ATTACK_MULTIPLIER = 1.4;
            break;

            case 7 :
                player.ce.lifesteal += 2;
            break;

            case 8 :
                PROJ_NUM++;
            break;	

            case 9 :
                BASE_SHOOT_INTERVAL = 1.5;
            break;	

            case 10:
                PROJ_NUM++;
                player.ce.lifesteal += 3;
                ATTACK_MULTIPLIER = 1.6;
            break;
        }
    }
    
    @Override
    String getDescription(int level) {
        String s = "";
        switch (level) {
            case 1 :
                s = "Throwing boomrangs that could fly back to you.";
            break;	

            case 2 :
                s =  "Damage +20%";
            break;

            case 3 :
                s = "Boomrang speed +150, \nBoomrang range +200";
            break;	

            case 4 :
                s = "Throw one more boomrang";
            break;	

            case 5 :
                s = "Throw interval -0.5s";
            break;	

            case 6 :
                s = "Throw one more boomrang, \nDamage +20%";
            break;

            case 7 :
                s = "Heal you 2% of all damage";
            break;		

            case 8 :
                s = "Throw one more boomrang";
            break; 

            case 9 :
                s = "Throw interval -0.5s";
            break;	

            case 10 :
                s = "Throw one more boomrang, \nDamage +20%, \nHeal you 2% of all damage";
            break;	

            default :
            break;
        }
        return s;
    }
}

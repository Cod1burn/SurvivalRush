import java.util.List;

public class FirePath extends Weapon{

    float PROJ_DURATION;
    float PROJ_RADIUS;
    float PROJ_HIT_INTERVAL;
    float PROJ_RANGE;
    float FIRE_PER_LINE;

    PImage fire1Img, fire2Img;

    public FirePath(Player player) {
        super(player);
        PROJ_NUM = 1;
        shootCount = 0;
        
        ATTACK_MULTIPLIER = 0.25;
        BASE_SHOOT_INTERVAL = 4.0;
        PROJ_DURATION = 2.5;
        PROJ_RADIUS = 40;
        FIRE_PER_LINE = 10;
        PROJ_HIT_INTERVAL = 0.25;

        loadProjectileImage("fire");
        fire1Img = projectileImage;
        fire2Img = loadImage("ObjectImgs/Projectiles/fire2.png");
        
    } 

    @Override
    void update(float second) {
        super.update(second);
        attackInterval = BASE_SHOOT_INTERVAL / (1 + player.ce.attackSpeed / 100.0);
        if (attackTimer <= 0) summonFirePaths(player.findEnemies(PROJ_NUM + player.ce.extraProjs));
    }

    void summonFirePaths(List<Enemy> enemies) {
        enemies.forEach((e) -> {summonFirePath(e.position.copy().sub(player.position).normalize());});
        while (shootCount < PROJ_NUM + player.ce.extraProjs) {
            summonFirePath(PVector.fromAngle(random(0, 2 * PI)));
        }
        attackTimer = attackInterval;
    }

    void summonFirePath(PVector direction) {
        float distance = 0;
        for (int i = 0; i < FIRE_PER_LINE; i++) {
            PVector firePosition = player.position.copy().add(direction.copy().mult(distance + PROJ_RADIUS/2.0));
            Coord c = new Coord(firePosition.x, firePosition.y);
            if (!player.map.canBeEntered(c.x, c.y)) break;
            Fire fire = new Fire(player, firePosition,
                PROJ_RADIUS, PROJ_DURATION, attack, PROJ_HIT_INTERVAL);
            fire.setImage(fire1Img, fire2Img);
            player.projectiles.add(fire);
            distance += PROJ_RADIUS;
        }
        shootCount ++;
    }

        @Override
    void getLevelBonus() {
        switch (this.level) {
            case 2 :
                ATTACK_MULTIPLIER = 0.3;
            break;	

            case 3 :
                PROJ_NUM ++;
            break;

            case 4 :
                PROJ_RADIUS = 50;
                FIRE_PER_LINE = 12;
            break;

            case 5 :
                PROJ_DURATION = 3.5;
            break;

            case 6 :
                ATTACK_MULTIPLIER = 0.35;
                PROJ_NUM ++;
            break;

            case 7 :
                BASE_SHOOT_INTERVAL = 3.0;
            break;

            case 8 :
                PROJ_NUM ++;
            break;	

            case 9 :
                PROJ_RADIUS = 60;
                PROJ_DURATION = 5.0;
            break;	

            case 10:
                ATTACK_MULTIPLIER = 0.4;
                PROJ_NUM += 2;
            break;
        }
    }
    
    @Override
    String getDescription(int level) {
        String s = "";
        switch (level) {
            case 1 :
                s = "Summon a fire path to burn enemies.";
            break;	

            case 2 :
                s = "Damage +20%";
            break;

            case 3 :
                s = "Summon one more fire path";
            break;	

            case 4 :
                s = "Fire radius +10, \nFire path 2 more longer";
            break;	

            case 5 :
                s = "Fire path duration +1.0s";
            break;	

            case 6 :
                s = "Damage +20%, \nSummon one more fire path";
            break;

            case 7 :
                s = "Fire path summon interval -1.0s";
            break;		

            case 8 :
                s = "Summon one more fire path";
            break; 

            case 9 :
                s = "Fire path radius +10, \nFire path duration +1.5s";
            break;	

            case 10 :
                s = "Damage +20% , \nSummon two more fire paths";
            break;

            default:
            break;	
        }
        return s;
    }

}

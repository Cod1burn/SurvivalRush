public class Spikewand extends Weapon {
    float PROJ_HIT_INTERVAL;
    float PROJ_RADIUS;
    float PROJ_DURATION;

    public Spikewand(Player player) {
        super(player);
        PROJ_NUM = 1;
        shootCount = 0;
        level = 1;
        TYPE = WeaponType.SPIKEWAND;

        MAX_LEVEL = 10;
        ATTACK_MULTIPLIER = 0.5;
        BASE_SHOOT_INTERVAL = 5.0;
        PROJ_HIT_INTERVAL = 0.5;
        PROJ_RADIUS = 60;
        PROJ_DURATION = 2.0;

        loadProjectileImage("spike");
    }

    @Override 
    void update(float second) {
        super.update(second);
        attackInterval = BASE_SHOOT_INTERVAL / (1 + player.ce.attackSpeed / 100.0);
        if (attackTimer <= 0) shootSpikes(player.findEnemies(PROJ_NUM));
    }

    void shootSpikes(List<Enemy> enemies) {
        if (enemies.size() == 0) return;

        for (Enemy enemy: enemies) {
            shootSpike(enemy.position);
            shootCount ++;
        }

        // If enemies are less than shoots number, shoot at random visible positions.
        for (int i = 0; i < PROJ_NUM - shootCount; i ++) {
            shootSpike(player.position.copy()
                .add(random(-width/2.0, width/2.0), random(-height/2.0, height/2.0)));
        }

        attackTimer = attackInterval;
    }

    void shootSpike(PVector position) {
        Spike spike = new Spike(player, position, PROJ_RADIUS, PROJ_DURATION, attack, PROJ_HIT_INTERVAL);
        spike.setImage(projectileImage);
        player.projectiles.add(spike);
    }

    @Override
    void getLevelBonus() {
        switch (this.level) {
            case 2 :
                ATTACK_MULTIPLIER = 0.6;
            break;	

            case 3 :
                PROJ_NUM++;
            break;

            case 4 :
                PROJ_DURATION = 2.5;
                PROJ_RADIUS = 80;
            break;

            case 5 :
                PROJ_HIT_INTERVAL = 0.4;
            break;

            case 6 :
                ATTACK_MULTIPLIER = 0.65;
                PROJ_NUM++;
            break;

            case 7 :
                PROJ_RADIUS = 100;
            break;

            case 8 :
                PROJ_HIT_INTERVAL = 0.3;
            break;	

            case 9 :
                PROJ_NUM++;
            break;	

            case 10:
                player.ce.defence += 5; 
                PROJ_DURATION = 3.0;
                ATTACK_MULTIPLIER = 0.8;
            break;
        }
    }
    
    @Override
    String getDescription(int level) {
        String s = "";
        switch (level) {
            case 1 :
                s = "Summon spikes attack enemies.";
            break;	

            case 2 :
                s = "Damage +20%";
            break;

            case 3 :
                s = "Summon one more spike";
            break;	

            case 4 :
                s = "Spike duration +0.5s, \nSpike Radius +20%";
            break;	

            case 5 :
                s = "Spike damage interval -0.1s";
            break;	

            case 6 :
                s = "Damage +10%, \nSummon one more spike";
            break;

            case 7 :
                s = "Spike Radius +20";
            break;		

            case 8 :
                s = "Spike damage interval -0.1s";
            break; 

            case 9 :
                s = "Summon one more spike";
            break;	

            case 10 :
                s = "defence +10, \nSpike duration +0.5s, \nDamage +30%";
            break;

            default:
            break;	
        }
        return s;
    }

}

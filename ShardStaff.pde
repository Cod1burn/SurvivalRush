public class ShardStaff extends Weapon {
    float SHOOT_DURATION;
    float PROJ_PER_SEC;
    float PER_PROJ_INTERVAL;
    float PROJ_RADIUS;
    float PROJ_RANGE;
    float PROJ_SPEED;

    public ShardStaff(Player player) {
        super(player);
        PROJ_NUM = 1;
        shootCount = 0;
        level = 1;
        TYPE = WeaponType.SHARDSTAFF;

        PROJ_PER_SEC = 10;
        SHOOT_DURATION = 1.0;
        MAX_LEVEL = 10;
        ATTACK_MULTIPLIER = 0.2;
        BASE_SHOOT_INTERVAL = 4.0;
        PROJ_RADIUS = 15;
        PROJ_SPEED = 800;
        PROJ_RANGE = 400;

        PER_PROJ_INTERVAL = 1.0 / PROJ_PER_SEC;

        loadProjectileImage("shard");
    }

    @Override 
    void update(float second) {
        super.update(second);
        attackInterval = BASE_SHOOT_INTERVAL / (1 + player.ce.attackSpeed / 100.0);
        PER_PROJ_INTERVAL = 1.0 / PROJ_PER_SEC;
        if (attackTimer <= 0) shootShards();
    }

    void shootShards() {
        for (int i = 0; i < PROJ_NUM + player.ce.extraProjs; i++) {
            PVector direction;
            if (player.direction.mag() != 0) direction = player.direction.copy().rotate(random(-PI/8.0, PI/8.0));
            else direction = player.lastDirection.copy().rotate(random(-PI/8.0, PI/8.0));
            Shard shard = new Shard(player, direction, PROJ_RANGE, PROJ_SPEED, PROJ_RADIUS, attack);
            shard.setImage(projectileImage);
            player.projectiles.add(shard);
        }
        shootCount += 1;
        if (shootCount < PROJ_PER_SEC * SHOOT_DURATION) {
            attackTimer = PER_PROJ_INTERVAL;
        } else {
            attackTimer = attackInterval;
            shootCount = 0;
        }
    }

    @Override
    void getLevelBonus() {
        switch (this.level) {
            case 2 :
                ATTACK_MULTIPLIER = 0.2;
            break;	

            case 3 :
                PROJ_PER_SEC = 12;
            break;

            case 4 :
                PROJ_SPEED = 1000;
                PROJ_RANGE = 500;
            break;

            case 5 :
                SHOOT_DURATION = 1.25;
            break;

            case 6 :
                PROJ_NUM++;
            break;

            case 7 :
                ATTACK_MULTIPLIER = 0.25;
            break;

            case 8 :
                SHOOT_DURATION = 1.5;
            break;	

            case 9 :
                PROJ_PER_SEC = 15; 
            break;	

            case 10:
                PROJ_NUM ++;
                ATTACK_MULTIPLIER = 0.3;
                player.ce.attackSpeed += 10;
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

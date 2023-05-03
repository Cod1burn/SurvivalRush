public class AsterWand extends Weapon {
    float PROJ_HIT_INTERVAL;
    float PROJ_RADIUS;
    float PROJ_SPIN_RADIUS;

    public AsterWand(Player player) {
        super(player);
        PROJ_NUM = 1;
        shootCount = 0;
        level = 1;
        TYPE = WeaponType.ASTERWAND;

        MAX_LEVEL = 10;
        ATTACK_MULTIPLIER = 0.3;
        PROJ_HIT_INTERVAL = 0.2;
        PROJ_RADIUS = 20;
        PROJ_SPIN_RADIUS = 50;
        
        attack = player.ce.attack * ATTACK_MULTIPLIER;

        loadProjectileImage("aster");
        resetAsters();
    }

    @Override 
    void update(float second) {
        super.update(second);
    }

    void summonAsters(int num) {
        float angle = 0.0;
        for (int i = 0; i < min(num, 4); i ++) {
            summonAster(angle, PROJ_SPIN_RADIUS);
            angle += 2 * PI / min(num, 4);
        }
        if (num <= 4) return;
        num -= 4;
        angle = PI / 4.0;
        for (int i = 0; i < num; i ++) {
            summonAster(angle, 2 * PROJ_SPIN_RADIUS);
            angle += 2 * PI / num;
        }
    }

    void summonAster(float angle, float spinRadius) {
        Aster a = new Aster(player, angle, PROJ_RADIUS, spinRadius, attack, PROJ_HIT_INTERVAL);
        a.setImage(projectileImage);
        player.projectiles.add(a);
    }

    void resetAsters() {
        player.projectiles.removeIf(p -> p instanceof Aster);
        summonAsters(PROJ_NUM);
    }

    @Override
    void levelUp() {
        super.levelUp();
        resetAsters();
    }

    @Override
    void getLevelBonus() {
        switch (this.level) {
            case 2 :
                PROJ_NUM ++;
            break;	

            case 3 :
                ATTACK_MULTIPLIER = 0.35;
            break;

            case 4 :
                PROJ_NUM ++;
            break;

            case 5 :
                PROJ_RADIUS = 25;
                PROJ_SPIN_RADIUS = 65;
            break;

            case 6 :
                ATTACK_MULTIPLIER = 0.4;
                PROJ_NUM += 2;
            break;

            case 7 :
                player.ce.moveSpeed += 50;
            break;

            case 8 :
                ATTACK_MULTIPLIER = 0.45;
                PROJ_NUM++;
            break;	

            case 9 :
                PROJ_RADIUS = 30;
                PROJ_SPIN_RADIUS = 80;
            break;	

            case 10:
                PROJ_NUM += 2;
                ATTACK_MULTIPLIER = 0.5;
                player.ce.moveSpeed += 50;
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
                s = "Summon Interval -0.5s, \nSummon one more spike";
            break;

            case 7 :
                s = "Damage +10%, \nSpike Radius +20";
            break;		

            case 8 :
                s = "Spike damage interval -0.1s";
            break; 

            case 9 :
                s = "Summon Interval -0.5";
            break;	

            case 10 :
                s = "Summon one more spike, \nSpike duration +0.5s, \nDamage +30%";
            break;

            default:
            break;	
        }
        return s;
    }

}

public class CombatEntity {
    MovableObject obj;
    boolean isPlayer;
    
    float health;
    float maxHealth;
    float attack;
    float defence;
    float healthRegen;
    float moveSpeed;
    float attackSpeed;
    float lifesteal;
    float expRate;
    float damageAmplification;
    float baseAttackInterval;
    float radius;
        
    float exp; // For player, current exp; For enemy, exp on die;
    float maxExp;
    int level;

    ArrayList<Aura> auras;

    // Only for enemy
    float attackTimer;
    EnemyType type;

    // Only for player
    float absorbRadius; 


    ArrayList<Weapon> weapons;
    static final int MAX_WEAPONS = 6;

    /**
        For Player
    **/
    public CombatEntity(MovableObject obj) {
        this.obj = obj;
        isPlayer = true;
        moveSpeed = 200;
        attackSpeed = 0.0;
        health = 100;
        maxHealth = 100;
        healthRegen = 1.0;
        attack = 10.0;
        defence = 0.0;
        lifesteal = 0.0;
        expRate = 100.0;
        damageAmplification = 0.0;

        exp = 0.0;
        maxExp = 50.0;
        level = 1;

        absorbRadius = 100;
        weapons = new ArrayList<>();
        auras = new ArrayList<>();
    }

    /**
        For Enemy
    **/
    public CombatEntity() {
        isPlayer = false;
        auras = new ArrayList<>();
    }

    CombatEntity copy(int copyLevel) {
        copyLevel -= level;
        CombatEntity ce = new CombatEntity();
        ce.type = type;
        ce.isPlayer = isPlayer;
        ce.maxHealth = maxHealth * pow(1.2, copyLevel);
        ce.health = ce.maxHealth;  
        ce.healthRegen = healthRegen * pow(1.2, copyLevel);
        ce.attack = attack * pow(1.2, copyLevel);
        ce.defence = defence * (1 + 0.2 * copyLevel);
        ce.moveSpeed = moveSpeed;
        ce.radius = radius;
        ce.attackSpeed = attackSpeed;
        ce.baseAttackInterval = baseAttackInterval;
        return ce;
    }

    void loadEntityFromTemplate(String template) {
        if (template.equals("test")) {
            loadTestTemplate();
        }
    }

    void loadTestTemplate() {
        moveSpeed = 60;
        baseAttackInterval = 1.0;
        attack = 5;
        attackSpeed = 0.0;

        health = 30;
        healthRegen = 0;

    }

    void getExp(float value) {
        obj.addFloatingNumber(new FloatingNumber("EXP", value, 1.0));
        if (value < maxExp - exp) {
            exp += value * (expRate/100);
        } else {
            value -= maxExp;
            levelUp();
            getExp(value);
        }
    }

    void levelUp() {
        level ++;
    }

    void attack(CombatEntity ce) {
        float damage = attack * (1 - ce.defence/100.0);
        ce.takeDamage(damage, true);
        attackTimer = baseAttackInterval * (1 + attackSpeed/100.0);
    }

    
    void hit(CombatEntity ce) {
        float damage = attack * (1 - ce.defence/100.0) * (1 + damageAmplification/100.0);
        ce.takeDamage(damage * (1 + damageAmplification/100.0), true);
        if (lifesteal > 0) heal(damage * lifesteal, true);
    }

    void heal(float value, boolean showing) {
        health += value;
        if (health >= maxHealth) health = maxHealth;
        if(showing) obj.addFloatingNumber(new FloatingNumber("HEALING",value, 1.0));
    }

    void takeDamage(float damage, boolean showing) {
        if (showing) takeDamage(damage, 1.0);
        else takeDamage(damage, 0.0);
    }

    void takeDamage(float damage, float floatNumMultiplier) {
        health -= damage;
        obj.getHurt();
        if (floatNumMultiplier > 0) obj.addFloatingNumber(new FloatingNumber("DAMAGE", damage, floatNumMultiplier));
        if (health <= 0) obj.die();
    }

    void update(float second) {
        auras.forEach((a) -> {a.update(second);});
        heal(healthRegen * second, false);

        if (attackTimer > 0) attackTimer -= second;

        if (isPlayer) weapons.forEach((w) -> {w.update(second);});
    }

    void addWeapon(WeaponType type) {
        if (weapons.size() >= MAX_WEAPONS) return;

        for (Weapon w : weapons) {
            if (w.TYPE == type) return;
        }

        switch (type) {
            case MAGICWAND :
                MagicWand mw = new MagicWand((Player)obj);
                weapons.add(mw);
            break;	
            
            case SPIKEWAND :
                Spikewand sw = new Spikewand((Player)obj);
                weapons.add(sw);
            break;

            case ASTERWAND :
                AsterWand aw = new AsterWand((Player)obj);
                weapons.add(aw);
            break;	

            case SHARDSTAFF :
                ShardStaff ss = new ShardStaff((Player)obj);
                weapons.add(ss);
            break;	

            case BOOMRANG:
                Boomrang br = new Boomrang((Player)obj);
                weapons.add(br);

            default :
                
            break;	
        }
    }

    void levelUpWeapon(WeaponType type) {
        weapons.forEach((w) -> {
            if (w.TYPE == type) w.levelUp();
        });
    }

    void applyAura(Aura a) {
        auras.add(a);
    }
}

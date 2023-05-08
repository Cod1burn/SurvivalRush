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
    int extraProjs;

    float baseAttackInterval;
    float radius;
        
    float exp; // For player, current exp; For enemy, exp on die;
    float maxExp;
    int level;

    ArrayList<Aura> auras;

    // Only for enemy
    float attackTimer;
    EnemyType type;
    int difficulty;

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
        attack = 12.0;
        defence = 0.0;
        lifesteal = 0.0;
        expRate = 100.0;
        damageAmplification = 0.0;
        extraProjs = 0;
        

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
        damageAmplification = 0.0;
    }

    CombatEntity copy(int copyLevel) {
        copyLevel -= level;
        CombatEntity ce = new CombatEntity();
        ce.type = type;
        ce.isPlayer = isPlayer;
        ce.maxHealth = maxHealth * pow(1.5, copyLevel);
        ce.health = ce.maxHealth;  
        ce.healthRegen = healthRegen * pow(1.5, copyLevel);
        ce.attack = attack * pow(1.5, copyLevel);
        ce.defence = defence * (1 + 3 * copyLevel);
        ce.damageAmplification = 0.0;
        ce.moveSpeed = moveSpeed;
        ce.radius = radius;
        ce.attackSpeed = attackSpeed;
        ce.baseAttackInterval = baseAttackInterval;
        ce.difficulty = difficulty;
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
        level++;
        maxExp += 100;
        maxHealth += 5;
        attack += 1;
        healthRegen += 0.1;

    }

    void attack(CombatEntity ce) {
        float damage = attack * (1 - ce.defence/100.0);
        ce.takeDamage(damage, 1.0);
        attackTimer = baseAttackInterval * (1 + attackSpeed/100.0);
    }

    
    void hit(CombatEntity ce) {
        float damage = attack * (1 - ce.defence/100.0) * (1 + damageAmplification/100.0);
        ce.takeDamage(damage * (1 + damageAmplification/100.0), 1.0);
        if (lifesteal > 0) heal(damage * lifesteal, 0.0);
    }

    void heal(float value, float floatNumMultiplier) {
        health += value;
        if (health >= maxHealth) health = maxHealth;
        if(floatNumMultiplier > 0) obj.addFloatingNumber(new FloatingNumber("HEALING",value, floatNumMultiplier));
    }

    void takeDamage(float damage, float floatNumMultiplier) {
        health -= damage;
        obj.getHurt();
        if (floatNumMultiplier > 0) obj.addFloatingNumber(new FloatingNumber("DAMAGE", damage, floatNumMultiplier));
        if (health <= 0) obj.die();
    }

    void update(float second) {
        auras.forEach((a) -> {a.update(second);});
        heal(healthRegen * second, 0.0);

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

            case FIREPATH:
                FirePath fp = new FirePath((Player)obj);
                weapons.add(fp);
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
        auras.forEach((aura) -> {
            if (aura.type == a.type) {
                aura.duration = a.duration;
                return;
            }
        });
        auras.add(a);
    }
}

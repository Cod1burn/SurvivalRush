public class CombatEntity {
    String name;

    boolean isPlayer;
    
    float health;
    float maxHealth;
    float attack;
    float defence;
    float healthRegen;
    float moveSpeed;
    float attackSpeed;
    float baseAttackInterval;
    float radius;
    
    float exp;
    float maxExp;
    int level;

    float attackTimer;

    MovableObject obj;

    ArrayList<Weapon> weapons;
    static final int MAX_WEAPONS = 5;

    /**
        For Player
    **/
    public CombatEntity(MovableObject obj) {
        name = "Player";
        this.obj = obj;
        isPlayer = true;
        moveSpeed = 200;
        attackSpeed = 0.0;
        health = 100;
        maxHealth = 100;
        healthRegen = 1.0;
        attack = 10.0;
        defence = 0.0;
        weapons = new ArrayList<>();
    }

    /**
        For Enemy
    **/
    public CombatEntity() {
        isPlayer = false;
    }

    void CombatEntity copy(int copyLevel) {
        copyLevel -= level;
        CombatEntity ce = new CombatEntity();
        ce.name = name;
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

    void attack(CombatEntity ce) {
        float damage = attack * (1 - ce.defence/100.0);
        ce.takeDamage(damage);
        attackTimer = baseAttackInterval * (1 + attackSpeed/100.0);
    }

    void hit(CombatEntity ce) {
        float damage = attack * (1 - ce.defence/100.0);
        ce.takeDamage(damage);
    }

    void takeDamage(float damage) {
        health -= damage;
        if (isPlayer) ((Player)obj).getHurtAnimation();
        if (health <= 0) obj.die();
    }

    void update(float second) {
        health += healthRegen * second;
        if (health >= maxHealth) health = maxHealth;

        if (attackTimer > 0) attackTimer -= second;

        weapons.forEach((w) -> {w.update(second);});
    }

    void addWeapon(WeaponType type) {
        if (weapons.size() >= MAX_WEAPONS) return;

        for (Weapon w : weapons) {
            if (w.TYPE == type) return;
        }

        switch (type) {
            case MAGICWAND :
                MagicWand w = new MagicWand((Player)obj);
                weapons.add(w);
            break;	

            default :
                
            break;	
        }
    }

    void levelUpWeapon(WeaponType type) {
        weapons.forEach((w) -> {
            if (w.TYPE == type) w.levelUp();
        });
    }
}
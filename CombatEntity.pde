public class CombatEntity {
    boolean isPlayer;
    
    float health;
    float maxHealth;
    float attack;
    float defence;
    float healthRegen;
    float moveSpeed;
    float attackSpeed;
    float baseAttackInterval;
    
    float exp;
    float maxExp;
    int level;

    float attackTimer;

    MovableObject obj;

    /**
        For Player
    **/
    public CombatEntity(MovableObject obj) {
        this.obj = obj;
        isPlayer = true;
        moveSpeed = 200;
        health = 100;
        maxHealth = 100;
    }

    /**
        For Enemy
    **/
    public CombatEntity(String template) {
        isPlayer = false;
        loadEntityFromTemplate(template);
    }

    void loadEntityFromTemplate(String template) {
        if (template.equals("test")) {
            loadTestTemplate();
        }
    }

    void loadTestTemplate() {
        moveSpeed = 120;
        baseAttackInterval = 1.0;
        attack = 5;
        attackSpeed = 0.0;

    }

    void attack(CombatEntity ce) {
        float damage = attack * (1 - ce.defence/100.0);
        ce.takeDamage(damage);
        attackTimer = baseAttackInterval * (1 + attackSpeed/100.0);
    }

    void takeDamage(float damage) {
        health -= damage;
        if (health <= 0) obj.die();
    }

    void update(float second) {
        health += healthRegen * second;
        if (health >= maxHealth) health = maxHealth;

        if (attackTimer > 0) attackTimer -= second;
    }
}
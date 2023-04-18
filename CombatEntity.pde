public class CombatEntity {
    boolean isPlayer;
    
    float health;
    float maxHealth;
    float attack;
    float defence;
    float healthRegen;
    float moveSpeed;
    float attackSpeed;
    
    float exp;
    float maxExp;
    int level;

    MovableObject obj;

    /**
    * For Player
    **/
    public CombatEntity(MovableObject obj) {
        this.obj = obj;
        isPlayer = true;
        moveSpeed = 200;
    }

    /**
    * For Enemy
    **/
    public CombatEntity(String template) {
        isPlayer = false;
        loadEntityFromTemplate(template);
    }

    void loadEntityFromTemplate(String template) {

    }
}
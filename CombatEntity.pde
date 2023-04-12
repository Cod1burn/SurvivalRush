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

    /**
    * For Player
    **/
    public CombatEntity() {
        isPlayer = true;
        moveSpeed = 100;
    }

    /**
    * For Enemy
    **/
    public CombatEntity(int template) {
        isPlayer = false;
    }
}
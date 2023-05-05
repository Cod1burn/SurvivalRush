public class Aura {
    String name;
    AuraType type;
    float value;
    String description;
    
    float duration;
    float timer;
    boolean alive;

    CombatEntity ce;
    PImage icon;

public Aura(CombatEntity ce, String name, AuraType type , float value, float duration) {
    this.ce = ce;
    this.name = name;
    this.type = type;
    this.value = value;
    this.duration = duration;
    this.timer = 0.0;
    
    alive = true;
}

void update(float second) {
    timer += second;
    if (timer >= duration) expire();
    if (type == AuraType.DOT) ce.takeDamage(value * second * (1 - ce.defence/100.0) * (1 + ce.damageAmplification/100.0), false);
    if (type == AuraType.HOT) ce.heal(value * second, false);
}

void apply() {
    switch(type) {
        case DAMAGEAMP:
            ce.damageAmplification += value;
        break;	
        
        case MOVESPDAMP :
            ce.moveSpeed *= (1+(value/100.0));
        break;	

        case ATKSPDAMP :
            ce.attackSpeed *= (1+(value/100.0));
        break;	
        
        default :
        break;	
    }
}

void expire() {
    switch(type) {
        case DAMAGEAMP:
            ce.damageAmplification -= value;
        break;	
        
        case MOVESPDAMP :
            ce.moveSpeed *= (1 / (1+(value/100.0)) );
        break;	

        case ATKSPDAMP :
            ce.attackSpeed *= (1 / (1+(value/100.0)) );
        break;	
        
        default :
        break;	
    }
    alive = false;
}

void setDescription(String description) {
    this.description = description;
}

void setIcon(PImage icon) {
    this.icon = icon;
}
}

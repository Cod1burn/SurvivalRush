public abstract class MovableObject{
    PVector position;
    PVector direction;
    PVector lastDirection;
    PVector speed;
    float collideRadius;

    CombatEntity ce;

    Coord coord;
    Coord blockCoord;
    
    boolean inCamera;

    PVector knockBackForce;
    float knockBackTimer;

    public MovableObject() {
        knockBackForce = null;
        knockBackTimer = 0.0;
        lastDirection = new PVector(0.0, 1.0);
    }

    void knockBack(PVector force, float time) {
        if (knockBackForce != null && force.mag() <= knockBackForce.mag()) return;
        knockBackForce = force.copy();
        knockBackTimer = time;
    }

    void update(float second) {
        if (knockBackTimer > 0) {
            knockBackTimer -= second;
            if (knockBackTimer <= 0) knockBackForce = null;
        }
    }

    boolean isCollide(MovableObject obj, boolean loose) {
        if(loose) return position.copy().sub(obj.position).mag() <= max(collideRadius, obj.collideRadius);
        else return position.copy().sub(obj.position).mag() <= min(collideRadius, obj.collideRadius);
    }

    void die() {}
}
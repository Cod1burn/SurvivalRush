public abstract class MovableObject{
    PVector position;
    PVector direction;
    PVector speed;
    float collideRadius;

    CombatEntity ce;

    Coord coord;
    Coord blockCoord;
    
    boolean inCamera;

    void applyForce(PVector force) {
        speed.add(force);
    }

    boolean isCollide(MovableObject obj, boolean loose) {
        if(loose) return position.copy().sub(obj.position).mag() <= max(collideRadius, obj.collideRadius);
        else return position.copy().sub(obj.position).mag() <= min(collideRadius, obj.collideRadius);
    }

    void die() {}
}
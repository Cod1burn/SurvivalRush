public abstract class MovableObject{
    PVector position;
    PVector direction;
    PVector speed;
    float collideRadius;

    Coord coord;
    Coord blockCoord;
    
    boolean inCamera;

    void draw() {}

    void update(float second) {}

    void applyForce(PVector force) {
        speed.add(force);
    }

    boolean isCollide(MovableObject obj) {
        return position.copy().sub(obj.position).mag() <= (collideRadius + obj.collideRadius);
    }

    void die() {}
}
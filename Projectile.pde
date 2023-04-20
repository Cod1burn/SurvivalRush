public class Projectile extends MovableObject {
    float attack;
    float RADIUS;
    float range;
    float scalarSpeed;
    float hitInterval;
    int hits;
    
    Player owner;
    float relatedPosition;

    float hitTimer;

    boolean active;

    PImage img;

    public Projectile(Player owner, PVector direction, float radius) {
        this.owner = owner;
        this.RADIUS = radius;
        collideRadius = RADIUS;
        this.scalarSpeed = 0.0;
        this.range = null;
        hitTimer = 0.0;
        
        position = owner.position.copy();
        relatedPosition = new PVector(0,0);
        this.direction = direction.copy();

        active = true;
    }
    
    void draw() {
        image(img, relatedPosition.x - RADIUS/2.0, relatedPosition.y - RADIUS/2.0, RADIUS, RADIUS);
    }

    void setImage(PImage image) {
        this.img = image;
    }

    void update(float second) {
        if (hitTimer > 0) hitTimer -= second;
        position.add(speed.x * second, speed.y * second);
        if (range!=null) {
            if (position.copy().sub(owner.position).mag() > range) die();
        }
    }

    void hit(MovableObject obj) {
        if (hit > 0) {
            obj.takeDamage(attack);
            hit--;
            if (hit <= 0) die();
        }
    }

    void runHitTimer() {
        hitTimer = hitInterval;
    }

    void die() {
        active = false;
    }


}
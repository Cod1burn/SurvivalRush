public class Projectile extends MovableObject {
    float attack;
    float RADIUS;
    float range;
    float duration;
    float scalarSpeed;
    float hitInterval;

    PVector knockBackForce;
    float knockBackTime;

    int hits;
    boolean hasHit;
    
    Player owner;
    PVector relatedPosition;

    float lifeTimer;
    float hitTimer;

    PImage img;

    public Projectile(Player owner, PVector direction, float radius) {
        this.owner = owner;
        this.RADIUS = radius;
        collideRadius = RADIUS;
        this.scalarSpeed = 0.0;
        this.range = 0.0;
        this.duration = 0.0;
        hitTimer = 0.0;
        knockBackForce = new PVector(0.0, 0.0);
        knockBackTime = 0.0;
        hasHit = false;
        
        position = owner.position.copy();
        relatedPosition = new PVector(0,0);
        this.direction = direction.copy();
    }
    
    void draw() {
        if(alive) image(img, relatedPosition.x - RADIUS/2.0, relatedPosition.y - RADIUS/2.0, RADIUS, RADIUS);
    }

    void setImage(PImage image) {
        this.img = image;
    }

    void update(float second) {
        speed = direction.copy().mult(scalarSpeed);
        if (hitTimer > 0) {
            hitTimer -= second;
        }
        if (duration > 0) {
            lifeTimer += second;
            if (lifeTimer > duration) {
                die();
                return;
            }
        }
        position.add(speed.x * second, speed.y * second);
        relatedPosition = position.copy().sub(owner.position);
        if (range > 0) {
            if (position.copy().sub(owner.position).mag() > range) die();
        }
    }

    void hit(MovableObject obj) {
        obj.ce.takeDamage(attack);
        if (knockBackTime > 0) obj.knockBack(knockBackForce, knockBackTime);
        hits--;
        if (hits <= 0) die();
    }

    void runHitTimer() {
        hitTimer = hitInterval;
    }
}

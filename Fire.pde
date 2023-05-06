public class Fire extends Projectile {
    float ANIMATION_INTERVAL;
    float animationTimer;
    PImage img1, img2;
    public Fire(Player owner, PVector position, float radius, float duration, float attack, float hitInterval) {
        super(owner, new PVector(0, 0), radius);
        this.position = position.copy();
        this.duration = duration;
        this.attack = attack;
        this.hitInterval = hitInterval;
        infiniteHits = true;

        ANIMATION_INTERVAL = 0.33;
        animationTimer = 0.0;
    }

    void setImage(PImage img1, PImage img2) {
        this.img1 = img1;
        this.img2 = img2;
    }

    @Override
    void update(float second) {
        super.update(second);
        animationTimer += second;
        if (animationTimer >= ANIMATION_INTERVAL) animationTimer = 0.0;
    }
    
    @Override
    void draw() {
        if(alive) { 
            if (animationTimer > ANIMATION_INTERVAL/2.0) image(img1, relatedPosition.x - RADIUS/2.0, relatedPosition.y - RADIUS/2.0, RADIUS, RADIUS);
            else image(img2, relatedPosition.x - RADIUS/2.0, relatedPosition.y - RADIUS/2.0, RADIUS, RADIUS);
        }
    }
}

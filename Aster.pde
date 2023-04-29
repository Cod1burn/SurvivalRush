public class Aster extends Projectile {
    float angle;
    float angularSpeed;
    float spinRadius;
    public Aster(Player owner, float angle, float radius, float spinRadius, float attack, float hitInterval) {
        super(owner, new PVector(0, 0), radius);
        this.position = owner.position.copy();
        this.attack = attack;
        this.hitInterval = hitInterval;
        this.angle = angle;
        this.angularSpeed = PI;
        this.spinRadius = spinRadius;
        infiniteHits = true;
    }

    @Override
    void update(float second) {
        if (hitTimer > 0) {
            hitTimer -= second;
            hasHit = false;
        }
        angle += angularSpeed * second;
        if (angle >= 2*PI) angle -= 2*PI;
        relatedPosition = PVector.fromAngle(angle).mult(spinRadius);
        position = owner.position.copy().add(relatedPosition);
        println(relatedPosition);
    } 
}
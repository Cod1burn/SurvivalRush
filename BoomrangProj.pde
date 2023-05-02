public class BoomrangProj extends Projectile {
    Coord coord;
    boolean returning;
    public BoomrangProj(Player owner, PVector direction, float scalarSpeed, float returnRange, float radius, float attack) {
        super(owner, direction, radius);
        this.attack = attack;
        hits = 1;
        hitInterval = 1.0;
        this.scalarSpeed = scalarSpeed;
        this.range = returnRange;
        speed = direction.copy().mult(scalarSpeed);
        returning = false;

        knockBackForce = direction.copy().mult(0.8 * scalarSpeed);
        knockBackTime = 0.08;
    }

    @Override
    void update(float second) {
        if(returning) facingDirection();
        speed = direction.copy().mult(scalarSpeed);
        if (hitTimer > 0) {
            hasHit = false;
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
        float distance = position.copy().sub(owner.position).mag();
        if (distance > range) returning = true;
        if (returning && distance < owner.collideRadius) die();
    }

    /*
        Set the direction of boomrang to be facing the player
    */
    void facingDirection() {
        direction = position.copy().sub(owner.position).normalize();
    }
}
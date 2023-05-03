public class BoomrangProj extends Projectile {
    Coord coord;
    boolean returning;
    ArrayList<MovableObject> hitEnemies;

    float angle;
    float rotateSpeed;

    public BoomrangProj(Player owner, PVector direction, float scalarSpeed, float returnRange, float radius, float attack) {
        super(owner, direction, radius);
        this.attack = attack;
        hits = 1;
        hitInterval = 0;
        this.scalarSpeed = scalarSpeed;
        this.range = returnRange;
        speed = direction.copy().mult(scalarSpeed);
        returning = false;

        hitEnemies = new ArrayList<>();
        infiniteHits = true;

        knockBackForce = direction.copy().mult(0.5 * scalarSpeed);
        knockBackTime = 0.05;

        angle = 0.0;
        rotateSpeed = 3 * PI;
    }

    @Override
    void update(float second) {
        if(returning) flyingBack();

        angle += rotateSpeed * second;
        if (angle >= 2 * PI) angle -= 2 * PI;

        speed = direction.copy().mult(scalarSpeed);
        position.add(speed.x * second, speed.y * second);
        relatedPosition = position.copy().sub(owner.position);
        float distance = position.copy().sub(owner.position).mag();
        if (!returning && distance > range) {
            returning = true;
            // Reset hit enemies list
            hitEnemies = new ArrayList<>();
        }
        if (returning && distance < owner.collideRadius) die();
    }

    /*
        Hit each enemy once in flying out and once in flying back;
    */
    @Override
    void hit(MovableObject obj) {
        if (!hitEnemies.contains(obj)) {
            super.hit(obj);
            hitEnemies.add(obj);
        }
    }

    @Override
    void draw() {
        if (alive) {
            pushMatrix();
            translate(relatedPosition.x, relatedPosition.y);
            rotate(angle);
            image(img, -RADIUS/2.0, -RADIUS/2.0, RADIUS, RADIUS);
            popMatrix();
        }
    }

    /*
        Set the direction of boomrang to be facing the player
    */
    void flyingBack() {
        direction = owner.position.copy().sub(position).normalize();
    }
}

public class Enemy extends MovableObject {
    EnemyType type;

    Game game;
    GameMap map;

    float RADIUS;
    PVector cameraPosition;
    
    PImage img1, img2;
    float animationTimer;
    float hurtTimer;

    static final float ANIMATION_INTERVAL = 0.3;
    static final float HURT_ANIMATION_INTERVAL = 0.1;

    public Enemy(CombatEntity ce, Game game, PVector position) {
        this.type = ce.type;
        this.game = game;
        this.map = game.map;
        this.position = position.copy();
        this.coord = new Coord(position.x / Floor.UNIT, position.y / Floor.UNIT);
        this.ce = ce;
        ce.obj = this;
        direction = new PVector(0, 0);
        speed = new PVector(0, 0);
        cameraPosition = new PVector(0, 0);
        RADIUS = ce.radius;
        collideRadius = RADIUS;
        inCamera = true;

        animationTimer = ANIMATION_INTERVAL;
        hurtTimer = 0.0;
    }

    void setImage(PImage img1, PImage img2) {
        this.img1 = img1;
        this.img2 = img2;
    }

    void draw() {
        if (!inCamera) return;
        if (!alive) return;

        pushMatrix();

        translate(width/2, height/2);
        translate(cameraPosition.x, cameraPosition.y);
        if (direction.x < 0) scale(-1, 1);
        if (hurtTimer > 0) tint(255, 255, 255, 30);
        if (animationTimer > ANIMATION_INTERVAL/2.0) image(img1, -RADIUS/2.0, -RADIUS/2.0, RADIUS, RADIUS);
        else image(img2, -RADIUS/2.0, -RADIUS/2.0, RADIUS, RADIUS);
        noTint();
        popMatrix();

    }

    boolean isInCamera(PVector camera){
        inCamera = min(abs(camera.x - position.x - RADIUS), abs(camera.x - position.x + RADIUS)) <= width/2.0
                && min(abs(camera.y - position.y - RADIUS), abs(camera.y - position.y - RADIUS)) <= height/2.0;
        if (inCamera) cameraPosition = position.copy().sub(camera);
        return inCamera;
    }

    void movingDirection(PVector direction) {
        this.direction = direction;
        speed = direction.copy().normalize().mult(ce.moveSpeed);
        if (knockBackForce != null) speed.add(knockBackForce);
    }

    void update(float second, PVector camera) {
        super.update(second);
        ce.update(second);

        animationTimer -= second;
        if (animationTimer < 0) animationTimer = ANIMATION_INTERVAL;

        if (hurtTimer > 0) hurtTimer -= second;

        // Update position in x axis
        position = position.add(speed.x * second, 0);
        int cx = coord.vectorToCoord(position.x, Floor.UNIT);
        if (cx != coord.x) {
            if (map.canBeEntered(cx, coord.y)) {
                coord.x = cx;
            } else {
                position = position.sub(speed.x * second, 0);
            }
        }

        position = position.add(0, speed.y * second);
        int cy = coord.vectorToCoord(position.y, Floor.UNIT);
        if (cy != coord.y) {
            if (map.canBeEntered(coord.x, cy)) {
                coord.y = cy;
            } else {
                position = position.sub(0, speed.y * second);
            }
        }

        isInCamera(camera);
    }  

    void hit(MovableObject obj) {
        if (ce.attackTimer <= 0) ce.attack(obj.ce);
    }

    void getHurt() {
        hurtTimer = HURT_ANIMATION_INTERVAL;
    }

    @Override
    void die() {
        super.die();
        game.generateItem(ItemType.EXPORB, 30, position.copy());
    }
}

public class Enemy extends MovableObject {
    Game game;
    GameMap map;

    float RADIUS;
    PVector cameraPosition;
    
    PImage img1, img2;
    float animationTimer;
    static final float ANIMATION_INTERVAL = 0.3;

    String name;

    public Enemy(CombatEntity ce, Game game, PVector position) {
        this.name = ce.name;
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
    }

    void setImage(PImage img1, PImage img2) {
        this.img1 = img1;
        this.img2 = img2;
    }

    void draw(PVector camera) {
        if (!inCamera) return;
        if (!alive) return;

        pushMatrix();

        translate(width/2, height/2);
        translate(cameraPosition.x, cameraPosition.y);
        if (direction.x < 0) scale(-1, 1);
        if (animationTimer > ANIMATION_INTERVAL/2.0) image(img1, -RADIUS/2.0, -RADIUS/2.0, RADIUS, RADIUS);
        else image(img2, -RADIUS/2.0, -RADIUS/2.0, RADIUS, RADIUS);
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

}

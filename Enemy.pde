public class Enemy extends MovableObject {
    Game game;
    GameMap map;

    float RADIUS;
    PVector cameraPosition;
    
    PImage img;

    String name;

    public Enemy(String name, Game game, PVector position) {
        this.name = name;
        this.game = game;
        this.position = position.copy();
        this.coord = new Coord(position.x / Floor.UNIT, position.y / Floor.UNIT);
        ce = new CombatEntity(name);
        direction = new PVector(0, 0);
        speed = new PVector(0, 0);
        cameraPosition = new PVector(0, 0);
        RADIUS = 55;
        collideRadius = RADIUS * 0.9;
        loadImageAssets(name);
        inCamera = true;
    }

    void setMap(GameMap map) {
        this.map = map;
    }

    void loadImageAssets(String name) {
        img = loadImage("ObjectImgs/Enemies/"+name+".png");
    }

    void draw(PVector camera) {
        if (!inCamera) return;

        pushMatrix();

        translate(width/2, height/2);
        translate(cameraPosition.x, cameraPosition.y);
        if (direction.x < 0) scale(-1, 1);
        image(img, -RADIUS/2.0, -RADIUS/2.0, RADIUS, RADIUS);

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
    }

    void update(float second, PVector camera) {
        ce.update(second);

        // Update position in x axis
        position = position.add(speed.x * second, 0);
        int cx = (int)(position.x / Floor.UNIT);
        if (cx != coord.x) {
            if (map.canBeEntered(cx, coord.y)) {
                coord.x = cx;
            } else {
                position = position.sub(speed.x * second, 0);
            }
        }

        position = position.add(0, speed.y * second);
        int cy = (int)(position.y / Floor.UNIT);
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

    @Override
    void die() {
    }  

}

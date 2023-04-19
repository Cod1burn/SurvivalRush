public class Enemy extends MovableObject {
    Game game;
    GameMap map;

    float RADIUS;
    PVector cameraPosition;
    
    PImage img;

    String name;
    CombatEntity ce;

    public Enemy(String name, Game game, PVector position) {
        this.name = name;
        this.game = game;
        this.position = position.copy();
        ce = new CombatEntity(name);
        direction = new PVector(0, 0);
        speed = new PVector(0, 0);
        cameraPosition = new PVector(0, 0);
        collideRadius = RADIUS;
        inCamera = true;
    }

    void setMap(GameMap map) {
        this.map = map;
    }

    void draw(PVector camera) {
        if (!inCamera) return;

        pushMatrix();

        translate(width/2, height/2);
        image(img, cameraPosition.x, cameraPosition.y, RADIUS, RADIUS);

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
        speed = direction.copy().mult(ce.moveSpeed);
    }

    @Override
    void update(float second) {
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
    }    

}

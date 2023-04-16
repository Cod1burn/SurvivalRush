public class Player implements MovableObject{
    Game game;
    GameMap map;

    static final float RADIUS = 50;
    static final float ANIMATION_INTERVAL = 0.5;

    PVector position;
    PVector direction;
    PVector speed;
    

    PImage[] idleIMGs;
    PImage[] runIMGs;
    PImage img;

    float animationTimer;

    Coord coord; // Coordinates in the map
    Coord blockCoord; // Block coordinates.

    CombatEntity ce;

    public Player(Game game) {
        this.game = game;
        ce = new CombatEntity();
        position = new PVector(700,700);
        coord = new Coord(6, 6);
        speed = new PVector(0.0, 0.0);
        direction = new PVector(0.0, 0.0);
        animationTimer = ANIMATION_INTERVAL - 0.01;
        loadImageResources();
    }

    void setMap(GameMap map) {
        this.map = map;
    }

    void draw() {
        if (direction.mag() == 0.0) {
            img = idleIMGs[(int)(animationTimer/(ANIMATION_INTERVAL/2.0))];
        } else {
            img = runIMGs[(int)(animationTimer/(ANIMATION_INTERVAL/3.0))];
        }

        pushMatrix();
        translate(width/2, height/2);
        if (direction.x < 0) scale(-1, 1);
        image(img, -RADIUS/2.0, -RADIUS/2.0, RADIUS, RADIUS);
        popMatrix();
    }

    void loadImageResources() {
        idleIMGs = new PImage[2];
        idleIMGs[0] = loadImage("ObjectImgs/Player/player_idle1.png");
        idleIMGs[1] = loadImage("ObjectImgs/Player/player_idle2.png");

        // Default facing right
        runIMGs = new PImage[3];
        runIMGs[0] = loadImage("ObjectImgs/Player/player_run1.png");
        runIMGs[1] = loadImage("ObjectImgs/Player/player_run2.png");
        runIMGs[2] = loadImage("ObjectImgs/Player/player_run3.png");
        img = idleIMGs[0];
    }

    void movingDirection(float x, float y) {
        direction.add(x, y);
        // Boundry control
        if (direction.x > 1.0) direction.x = 1.0;
        if (direction.x < -1.0) direction.x = -1.0;
        if (direction.y > 1.0) direction.y = 1.0;
        if (direction.y < -1.0) direction.y = -1.0;
    }

    void update(float second) {
        // update animation
        animationTimer -= second;
        if (animationTimer < 0 ) animationTimer = ANIMATION_INTERVAL - 0.01;
        

        // Update position in x axis
        speed = direction.copy().normalize().mult(ce.moveSpeed);
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

        map.updateCamera(position);
    }

}

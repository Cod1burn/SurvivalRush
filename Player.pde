public class Player implements MovableObject{
    Game game;
    GameMap map;

    static final float RADIUS = 70;
    static final float ANIMATION_INTERVAL = 0.5;

    PVector position;
    PVector direction;
    PVector speed;
    

    PImage[] fronts;
    PImage[] lefts;
    PImage[] rights;
    PImage[] backs;
    PImage[] idles;
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
            img = idles[(int)(animationTimer/(ANIMATION_INTERVAL/(float)idles.length))];
        } else {
            if (direction.y < 0) {
                img = backs[(int)(animationTimer/(ANIMATION_INTERVAL/(float)backs.length))];
            } else if (direction.x == 0) {
                img = fronts[(int)(animationTimer/(ANIMATION_INTERVAL/(float)fronts.length))];
            } else if (direction.x < 0) {
                img = lefts[(int)(animationTimer/(ANIMATION_INTERVAL/(float)lefts.length))];
            } else {
                img = rights[(int)(animationTimer/(ANIMATION_INTERVAL/(float)rights.length))];
            }
        }

        pushMatrix();
        translate(width/2, height/2);
        image(img, -RADIUS/2.0, -RADIUS/2.0, RADIUS, RADIUS);
        popMatrix();
    }

    void loadImageResources() {
        idles = new PImage[2];
        idles[0] = loadImage("ObjectImgs/Player/player_idle1.png");
        idles[1] = loadImage("ObjectImgs/Player/player_idle2.png");

        lefts = new PImage[4];
        for (int i = 0; i < lefts.length; i++){
            lefts[i] = loadImage("ObjectImgs/Player/player_left"+(i+1)+".png");
        }

        rights = new PImage[4];
        for (int i = 0; i < rights.length; i++){
            rights[i] = loadImage("ObjectImgs/Player/player_right"+(i+1)+".png");
        }

        fronts = new PImage[2];
        for (int i = 0; i < fronts.length; i++){
            fronts[i] = loadImage("ObjectImgs/Player/player_front"+(i+1)+".png");
        }

        backs = new PImage[2];
        for (int i = 0; i < backs.length; i++){
            backs[i] = loadImage("ObjectImgs/Player/player_back"+(i+1)+".png");
        }
        img = idles[0];
        
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

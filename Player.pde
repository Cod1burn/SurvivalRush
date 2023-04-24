public class Player extends MovableObject{
    Game game;
    GameMap map;

    static final float RADIUS = 70;
    static final float ANIMATION_INTERVAL = 0.5;
    static final float HURT_ANIMATION_INTERVAL = 0.1;

    PImage[] fronts;
    PImage[] lefts;
    PImage[] rights;
    PImage[] backs;
    PImage[] idles;
    PImage img;

    float animationTimer;
    float hurtTimer;

    ArrayList<Projectile> projectiles;


    public Player(Game game, PVector position) {
        super();
        this.game = game;
        ce = new CombatEntity(this);
        projectiles = new ArrayList<>();
        this.position = position;
        this.coord = new Coord(position.x / Floor.UNIT, position.y/Floor.UNIT);
        speed = new PVector(0.0, 0.0);
        direction = new PVector(0.0, 0.0);
        animationTimer = ANIMATION_INTERVAL - 0.01;
        collideRadius = RADIUS * 0.75;
        hurtTimer = 0.0;
        inCamera = true;
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
        if (hurtTimer > 0) tint(230, 50, 50, 150);
        image(img, -RADIUS/2.0, -RADIUS/2.0, RADIUS, RADIUS);
        noTint();
        projectiles.forEach(Projectile::draw);
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
        speed = direction.copy().normalize().mult(ce.moveSpeed);
        if (direction.mag() != 0.0) lastDirection = direction.copy();
        if (knockBackForce != null) speed.add(knockBackForce);
    }

    void update(float second) {
        super.update(second);
        ce.update(second);

        // update animation
        animationTimer -= second;
        if (animationTimer < 0 ) animationTimer = ANIMATION_INTERVAL - 0.01;

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

        game.updateCamera(position);

        projectiles.forEach((p) -> {p.update(second);});
    }

    void getHurt() {
        hurtTimer = HURT_ANIMATION_INTERVAL;
    }

    @Override
    void die() {
        super.die();
        game.playerDie();
    }
}

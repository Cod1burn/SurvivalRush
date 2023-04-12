public class Player implements MovableObject{
    Game game;
    GameMap map;

    PVector position;
    PVector blockPosition;
    PVector direction;
    PVector speed;
    

    PImage img;

    float turnSpeed;
    float angle;
    float speedAngle;

    Coord coord; // Coordinates in the map
    Coord blockCoord; // Block coordinates.

    CombatEntity ce;

    public Player(Game game) {
        this.game = game;
        this.map = game.map;
        ce = new CombatEntity();
        speed = new PVector(0.0, 0.0);
        direction = new PVector(0.0, 0.0);
        
    }

    void draw() {
        storke(0);
        fill(100);
    }

    void movingDirection(float x, float y) {
        direction.add(x, y);
        // Boundry control
        if (direction.x > 1.0) direction.x = 1.0;
        if (direction.x < -1.0) direction.x = -1.0;
        if (direction.y > 1.0) direction.y = 1.0;
        if (direction.y < -1.0) direction.y = -1.0;
    }

    void getFacingAngle(PVector direction) {
        speed = direction.normalize().mult(ce.moveSpeed);
        if (speed.mag() != 0) speedAngle = atan2(speed.y, speed.x);
        if (speedAngle > PI) speedAngle -= 2*PI ;
        else if (speedAngle < -PI) speedAngle += 2*PI ;  
    }

    void update(int time) {
        float second = (float)time/1000.0;
        // Update orientation
        if (angle != speedAngle) {
            float angleIncr = turnSpeed * second;
        
            if (abs(speedAngle - angle) <= angleIncr) {
                angle = speedAngle;
            } else {
                // From Week 6 Lecure: KinematicArriveSketch
                if (speedAngle < angle) {
                    if (angle - speedAngle < PI) angle -= angleIncr;
                    else angle += angleIncr;
                }
                else {
                    if (speedAngle - angle < PI) angle += angleIncr;
                    else angle -= angleIncr;
                }

                // Keep in bounds
                if (angle > PI) angle -= 2*PI ;
                else if (angle < -PI) angle += 2*PI ;  
            }
        }

        // Update position in x axis
        position = position.add(speed.x * second, 0);
        int cx = (int)(position.x / Floor.UNIT);
        if (cx != coord.x) {
            if (!map.getFloor(cx, coord.y).isBlocked) {
                coord.x = cx;
            } else {
                position = position.sub(speed.x * second, 0);
            }
        }

        position = position.add(0, speed.y * second);
        int cy = (int)(position.y / Floor.UNIT);
        if (cy != coord.y) {
            if (!map.getFloor(coord.x, cy).isBlocked) {
                coord.y = cy;
            } else {
                position = position.sub(0, speed.y * second);
            }
        }

        map.updateCamera(PVector position);
    }

}
public class Player implements MovableObject{
    Game game;
    GameMap map;

    PVector position;
    PVector blockPosition;
    PVector speed;

    float turnSpeed;
    float angle;
    float speedAngle;

    Coord coord; // Coordinates in the map
    Coord blockCoord; // Block coordinates.

    CombatEntity ce;

    public Player(Game game) {
        ce = new CombatEntity();
        
    }

    void draw() {
        storke(0);
        fill(100);
    }

    void movingDirection(PVector direction) {
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

        // Update position
        position = position.add(speed.copy().mult(second));
        int cx = (int)(position.x / Floor.UNIT);
        int cy = (int)(position.y / Floor.UNIT);
        
        if (cx != coord.x || cy != coord.y) {

        }
    }

}
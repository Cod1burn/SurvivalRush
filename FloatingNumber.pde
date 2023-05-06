public class FloatingNumber {
    int value;
    
    float angle;
    float speed;
    float range;
    
    PVector relatedPosition;
    
    int size;
    color c;

    boolean alive;

    private FloatingNumber(float value) {
        this.value = int(value);
        this.angle = random(-PI/2.0 - PI/7.5, -PI/2.0 + PI/7.5);
        relatedPosition = PVector.fromAngle(angle).mult(15);
        alive = true;
    }

    public FloatingNumber(String type, float value, float multiplier) {
        /*
            Cannot use static function in Processing,
            so i have to use another approach to simulate factory mode.
        */
        this(value);

        switch(type) {
            case "HEALING" :
                    this.speed = 80 * multiplier;
                    this.range = 50 * multiplier;
                    this.size = (int)(20 * multiplier);
                    this.c = color(40,235,25);
            break;	

            case "DAMAGE":
                    this.speed = 75 * multiplier;
                    this.range = 35 * multiplier;
                    this.size = (int)(18 * multiplier);
                    this.c = color(235, 20, 20);
            break;

            case "EXP":
                    this.speed = 60 * multiplier;
                    this.range = 50 * multiplier;
                    this.size = (int)(23 * multiplier);
                    this.c = color(25, 255, 255);
            break;

            default:
            break;
        }
    }

    void draw() {
        textSize(size);
        textAlign(CENTER, CENTER);
        stroke(0);
        fill(c);

        text(value, relatedPosition.x, relatedPosition.y);
    }

    void update(float second) {
        relatedPosition.add(PVector.fromAngle(angle).mult(speed * second));
        if (relatedPosition.mag() >= range) alive = false;
    }

}

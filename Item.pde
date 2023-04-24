public class Item {
    PVector position;
    PVector cameraPosition;
    float RADIUS;
    boolean alive;

    float value;
    PImage img;

    boolean inCamera;
    boolean absorbing; 

    // Only useful while player absorbing it
    PVector speed;
    float scalarSpeed;

    MovableObject obj;

    public Item(PVector position) {
        this.position = position.copy();
        cameraPosition = new PVector(0.0, 0.0);
        scalarSpeed = 300;
        this.alive = true;

        this.absorbing = false;
        this.obj = null;
    }

    void draw() {
        if (!inCamera) return;

        pushMatrix();
        translate(width/2, height/2);
        translate(cameraPosition.x, cameraPosition.y);
        image(img, -RADIUS/2.0, -RADIUS/2.0, RADIUS, RADIUS);
        popMatrix();
    }

    void setImage(PImage img) {
        this.img = img;
    }

    void getAbsorbed(MovableObject obj) {
        this.absorbing = true;
        this.obj = obj;
    }

    void update(float second, PVector camera) {;
        if(absorbing) {
            speed = obj.position.copy().sub(position).normalize().mult(scalarSpeed);
            position.add(speed.x * second, speed.y * second);
        }
        isInCamera(camera);
    }

    void getCollected(MovableObject obj) {
        if (!absorbing) this.obj = obj;
        alive = false;
    }

    boolean isInCamera(PVector camera) {
        inCamera = min(abs(camera.x - position.x - RADIUS), abs(camera.x - position.x + RADIUS)) <= width/2.0
                && min(abs(camera.y - position.y - RADIUS), abs(camera.y - position.y - RADIUS)) <= height/2.0;
        if (inCamera) cameraPosition = position.copy().sub(camera);
        return inCamera;

    }

    
}

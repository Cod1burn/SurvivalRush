public interface MovableObject{
    void draw();
    void update(float second);
    void applyForce(PVector force);
}
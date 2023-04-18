public class Enemy implements MovableObject {
    Game game;
    GameMap map;

    static final float RADIUS = 70;
    static final float ANIMATION_INTERVAL = 0.5;

    PVector position;
    PVector direction;
    PVector speed;
    
    PImage img;

    Coord coord; // Coordinates in the map
    Coord blockCoord; // Block coordinates.

    String name;
    CombatEntity ce;

    public Enemy(String name, PVector position) {
        this.name = name;
        this.position = position.copy();
        ce = CombatEntity(name);
        direction = new PVector(0, 0);
        speed = new PVector(0, 0);
    }

    void draw() {

    }

    void update(float second) {
        
    }
    
    void applyForce(PVector force) {
        
    }

    

}

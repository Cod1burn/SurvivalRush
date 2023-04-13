public class Floor {
    public final static float UNIT = 80;

    Coord coord; // Coordinates in the block
    boolean blocked;
    PImage img;

    public Floor(Coord coord, boolean blocked, PImage img) {
        this.coord = coord;
        this.blocked = blocked;
        this.img = img;
    }

    void draw() {
        draw(img, coord.x * UNIT, coord.y * UNIT, UNIT, UNIT);
    }
}

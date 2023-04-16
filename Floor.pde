public class Floor {
    public final static float UNIT = 80;

    Coord coord; // Coordinates in the block
    boolean blocked;
    PImage blockedImg;

    public Floor(Coord coord, boolean blocked) {
        this.coord = coord;
        this.blocked = blocked;
    }

    void setBlockedImg(PImage img) {
        blockedImg = img;
    }

    void draw() {
        if (blocked) image(blockedImg, coord.x * UNIT, coord.y * UNIT, UNIT, UNIT);
    }
}

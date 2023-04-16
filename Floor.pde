public class Floor {
    public final static float UNIT = 80;

    Coord coord; // Coordinates in the block
    boolean blocked;
    PImage img;
    PImage blockedImg;

    public Floor(Coord coord, boolean blocked, PImage img) {
        this.coord = coord;
        this.blocked = blocked;
        this.img = img;
    }

    void setBlockedImg(PImage img) {
        blockedImg = img;
    }

    void draw() {
        image(img, coord.x * UNIT, coord.y * UNIT, UNIT, UNIT);
        if (blocked) image(blockedImg, coord.x * UNIT, coord.y * UNIT, UNIT, UNIT);
    }
}

public class GameMap {
    Block block;
    PVector camera;

    public GameMap(int template) {
        block = new Block(template);
    }

    void draw() {
        
    }

    Floor getFloor(int cx, int cy) {
        cx %= block.W;
        cy %= block.h;
        return block.getFloor(cx, cy);
    }

    void updateCamera(PVector camera) {
        this.camera = camera;
    }
}
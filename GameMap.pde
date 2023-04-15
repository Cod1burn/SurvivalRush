public class GameMap {
    Block block;
    PVector camera;
    Player player;

    public GameMap(int template) {
        block = new Block(template);
    }

    void setPlayer(Player player) {
        this.player = player;
    }

    void draw() {
        camera.x %= block.w * Floor.UNIT;
        camera.y %= block.h * Floor.UNIT;

        translate(camera);
        block.draw();
        translate(camera.mult(-1));

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
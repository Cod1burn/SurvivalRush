public class GameMap {
    Block block;
    PVector camera;
    Player player;

    public GameMap(int template) {
        block = new Block(template);
        camera = new PVector(400,400);
    }

    void setPlayer(Player player) {
        this.player = player;
    }

    void draw() {
        camera.x %= block.w * Floor.UNIT;
        camera.y %= block.h * Floor.UNIT;

        pushMatrix();
        translate(camera.x, camera.y);
        block.draw();
        player.draw();
        popMatrix();

    }

    Floor getFloor(int cx, int cy) {
        cx %= block.w;
        cy %= block.h;
        return block.getFloor(cx, cy);
    }

    void updateCamera(PVector camera) {
        this.camera = camera;
    }
}

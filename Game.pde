public class Game {
    GameMap map;
    boolean pause;
    Player player;
    float gameTimer;
    boolean isOver;

    ArrayList<Enemy> enemies;

    PVector camera;


    public Game () {
        int template = 0; // Test template
        player = new Player(this);
        map = new GameMap(template); 

        player.setMap(map);
        gameTimer = 15 * 60; // 15 minutes

        camera = new PVector(0,0);

        enemies = new ArrayList<>();
    }

    void draw() {
        camera.x %= block.w * Floor.UNIT;
        camera.x = camera.x < 0 ? block.w * Floor.UNIT + camera.x : camera.x;
        camera.y %= block.h * Floor.UNIT;
        camera.y = camera.y < 0 ? block.h * Floor.UNIT + camera.y : camera.y;

        background(0);
        // Draw map
        map.draw(camera);
        
        player.draw();
        // Draw UI
        textSize(20);
        stroke(0);
        text("fps: "+frameRate, 50, 50);
        if (pause) {
            // Draw pause menu
        }
    }

    void update(int time) {
        if (pause) return;

        float second = time / 1000.0;

        gameTimer -= second;
        if (gameTimer <= 0) timeOut();

        player.update(second);
        
    }

    void timeOut() {

    }

    void updateCamera(PVector camera) {
        this.camera = camera.copy();
    }

    void keyPressed(char keyChar) {
        if (!pause) {
            if (keyChar == 'd' || keyChar == 'D') player.movingDirection(1, 0);
            if (keyChar == 'a' || keyChar == 'A') player.movingDirection(-1, 0);
            if (keyChar == 'w' || keyChar == 'W') player.movingDirection(0, -1);
            if (keyChar == 's' || keyChar == 'S') player.movingDirection(0, 1);
            if (keyChar == 'f') player.getHurtAnimation();
        }
    }

    void keyReleased(char keyChar) {
        if (!pause) {
            if (keyChar == 'd' || keyChar == 'D') player.movingDirection(-1, 0);
            if (keyChar == 'a' || keyChar == 'A') player.movingDirection(1, 0);
            if (keyChar == 'w' || keyChar == 'W') player.movingDirection(0, 1);
            if (keyChar == 's' || keyChar == 'S') player.movingDirection(0, -1);
        }
    }
}

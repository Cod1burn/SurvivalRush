public class Game {
    GameMap map;
    boolean pause;
    Player player;
    float gameTimer;
    boolean isOver;

    public Game () {
        int template = 0; // Test template
        player = new Player(this);
        map = new GameMap(template); 
        map.setPlayer(player);   
        gameTimer = 15 * 60; // 15 minutes
    }

    void draw() {
        // Draw map
        map.draw();
        // Draw UI
        if (pause) {
            // Draw pause menu
        }
    }

    void update(int time) {
        if (pause) return;

        float second = time / 1000.0;

        gameTimer -= second;
        if (gameTimer <= 0) timeOut();

        player.update(time);
        
    }

    void timeOut() {

    }

    void keyPressed(char keyChar) {
        if (!pause) {
            if (keyChar == 'd' || keyChar == 'D') player.movingDirection(1, 0);
            if (keyChar == 'a' || keyChar == 'A') player.movingDirection(-1, 0);
            if (keyChar == 'w' || keyChar == 'W') player.movingDirection(0, -1);
            if (keyChar == 's' || keyChar == 'S') player.movingDirection(0, 1);
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

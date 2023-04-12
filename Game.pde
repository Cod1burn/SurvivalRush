public class Game {
    GameMap map;
    boolean pause;
    Player player;

    public Game () {
        map = new GameMap(template);    
    }

    void draw() {
        
    }

    void update() {
        
    }

    void playerMove() {

    }

    void keyPressed(char keyChar) {
        if (!pause) {
            if (keyChar == 'd' || keyChar == 'D') player.movingDirection(1, 0);
            if (keyChar == 'a' || keyChar == 'A') player.movingDirection(-1, 0);
            if (keyChar == 'w' || keyChar == 'W') player.movingDirection(0, -1);
            if (keyChar == 's' || keyChar == 'S') player.movingDirection(0, 1);
        }
    }

    void void keyReleased(char keyChar) {
        if (!pause) {
            if (keyChar == 'd' || keyChar == 'D') player.movingDirection(-1, 0);
            if (keyChar == 'a' || keyChar == 'A') player.movingDirection(1, 0);
            if (keyChar == 'w' || keyChar == 'W') player.movingDirection(0, 1);
            if (keyChar == 's' || keyChar == 'S') player.movingDirection(0, -1);
        }
    }
}

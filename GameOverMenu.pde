public class GameOverMenu {
    Game game;
    Player player;
    CombatEntity ce;
    boolean restart;

    public GameOverMenu (Game game) {
        this.game = game;
        this.player = game.player;
        this.ce = player.ce; 
        restart = false;
    }

    void draw() {
        // if else is temporary. 
        if(restart) {
            background(255);
            fill(0);
            textSize(64);
            text("RESTART", width/2, height/2);
        } 
        else {
            background(255);
            fill(0);
            textSize(64);
            textAlign(CENTER);
            text("GAME OVER!", width/2, height/2);
            textSize(32);
            text("You gained " + ce.exp + " exp.", width/2, height/2 + 100);
            text("You reached level " + ce.level, width/2, height/2 + 150);

            // restart
            text("To restart the game, press R", width/2, height/2 + 250);
        }

    }

    void keyPressed(char keyChar) {
        if(keyChar == 'r' || keyChar == 'R') {
            restart = true; 
            // implement RESTART
            print("restart");
        }
    }

}

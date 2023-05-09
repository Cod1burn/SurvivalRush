public class GameOverMenu {
    Game game;
    Player player;
    CombatEntity ce;
    boolean restart;
    Button button;

    public GameOverMenu (Game game) {
        this.game = game;
        this.player = game.player;
        this.ce = player.ce; 
        restart = false;
    }

    void draw() {
        background(0);
        PImage img = loadImage("MapImgs/Map0/wholemap.jpg");
        img.resize(width, height);
        image(img, 0, 0);
        // if else is temporary. Implement restart and only else remains.
        if(restart) {
            textSize(64);
            text("RESTART", width/2, height/2);
        } 
        else {
            textSize(64);
            textAlign(CENTER);
            text("GAME OVER!", width/2, height/2);
            textSize(32);
            text("You Killed " + game.enemiesKilled + " enemies.", width/2, height/2 + 100);
            text("You reached level " + ce.level, width/2, height/2 + 150);

            // restart
            // text("To restart the game, press R or click the button", width/2, height/2 + 250);
            // button
            button = new Button(width/2, height/2 + 250, 450, 50, "To restart, press R or click this button.");
            button.draw();
        }

    }

    void keyPressed(char keyChar) {
        if(keyChar == 'r' || keyChar == 'R') {
            restart = true; 
            // implement RESTART
            setup();
        }
    }

    void mouseClicked(int mouseX, int mouseY) {
        if(button.contains(mouseX, mouseY)) {
            restart = true;
        }
    }

}

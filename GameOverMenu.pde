public class GameOverMenu {
    Game game;
    Player player;
    CombatEntity ce;
    Button button;

    public GameOverMenu (Game game) {
        this.game = game;
        this.player = game.player;
        this.ce = player.ce; 
    }

    void draw() {
        background(0);
        PImage img = loadImage("MapImgs/Map0/wholemap.jpg");
        img.resize(width, height);
        image(img, 0, 0);
    
        textSize(64);
        textAlign(CENTER);
        text("GAME OVER!", width/2, height/2);
        if(game.gameTimer <= 0) {
            textAlign(CENTER, TOP);
            text("YOU WON!!!!!", width/2, 100);
        }
        textSize(32);
        text("You Killed " + game.enemiesKilled + " enemies.", width/2, height/2 + 100);
        text("You reached level " + ce.level, width/2, height/2 + 150);

        // restart
        // text("To restart the game, press R or click the button", width/2, height/2 + 250);
        // button
        button = new Button(width/2, height/2 + 250, 450, 50, "To restart, press R or click this button.");
        button.draw();
    }

    void keyPressed(char keyChar) {
        if(keyChar == 'r' || keyChar == 'R') {
            setup();
        }
    }

    void mouseClicked(int mouseX, int mouseY) {
        if(button.contains(mouseX, mouseY)) {
            setup();
        }
    }

}

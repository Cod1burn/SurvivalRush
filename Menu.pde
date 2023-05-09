public class Menu {
    Game game;
    Player player;
    
    public Menu(Game game) {
        this.game = game;
        this.player = game.player;
    }

    void draw() {
        background(0);
        PImage img = loadImage("MapImgs/Map0/wholemap.jpg");
        img.resize(width, height);
        image(img, 0, 0);
        textSize(64);
        textAlign(CENTER);
        text("Game Paused", width/2, height/6);
        textSize(32);
        // user info from combat entity
        // health as percent of maxHealth
        int percHealth = (int) ((player.ce.health / player.ce.maxHealth) * 100);
        text("Health: " + percHealth + "%", width/2, height/6 + 50);
        // attack
        text("Attack: " + player.ce.attack, width/2, height/6 + 100);
        // defence
        text("Defence: " + player.ce.defence, width/2, height/6 + 150);
        // level
        text("Level: " + player.ce.level, width/2, height/6 + 200);
        // weapons and their levels.
        text("Weapons: ", width/2, height/6 + 250);
        int w = width/2;
        int h = height/6 + 250;
        
        ArrayList<Weapon> weapons = player.ce.weapons;
        if(weapons.size() == 0) {
            text("No weapons acquired yet.", w, h + 50);
        }
        else {
            for(int i = 0; i < weapons.size(); i++) {
                Weapon weapon = weapons.get(i); 
                text(weapon.TYPE.name() + ": LEVEL " + weapon.level, w, h + (50 * (i + 1)));
            }
        }
    }

    void keyPressed(char keyChar) {
        print(keyChar);
    }
}
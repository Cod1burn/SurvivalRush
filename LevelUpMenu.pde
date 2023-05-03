public class LevelUpMenu {
    Game game;
    Player player;
    CombatEntity ce;
    ArrayList<Button> buttons; 
    ArrayList<String> options;

    public LevelUpMenu(Game game, Player player) {
        this.game = game;
        this.player = player;
        this.ce = player.ce;
        options = new ArrayList<>();
        buttons = new ArrayList<>();
        
    }
    void setup() {
        generateOptions();
        createButtons();
    }

    void createButtons() {
        for(int i = 0; i < options.size(); i++) {
            Button button = new Button(width/2 - 50, (height/6 + 100 * i), 100, 50, options.get(i));
            buttons.add(button);
        }
    }
    
    void drawButtons(){
        for (Button button : buttons) 
            button.draw();   
    }
    
    void getRandomPool() {

    }

    // generate the options for the player.
    void generateOptions() { 
        // new weapon options
        if(ce.weapons.size() < ce.MAX_WEAPONS) options.add("add");
        else {
            options.add("upgrade");
            // for (Weapon w : weapons) {
            //     String s = "upgrade " + w.TYPE.toString();
            //     options.add(s);
            // }
        }
    }

    void selectOption(String option) {
        // String[] s = option.split(' ');
        switch (option) {
            case "add":
                //ce.addWeapon(random(WeaponType.values()));
            break;
            
            case "upgrade":
                //ce.levelUpWeapon(random(WeaponType.values()));
            break;
            
            default:

            break;
        }
        game.unpause();
    }

    void draw() {
        setup();
        background(255);
        fill(0);
        textSize(64);
        textAlign(CENTER);
        text("Congratulations you have levelled up!", width/2, height/2);
        textSize(32);
        text("Select one of the options. Add a new weapon to your arsenal or update an existing weapon.", width/2, height/2 + 100);
        textSize(16);
        text("Press the number for the corresponding option", width/2, height/2 + 150);
        drawButtons();
    }

    void keyPressed(char keyChar) {
        
        int input = 0;
        if(keyChar >= '0' && keyChar <= '9') {
            input = int(keyChar) - int('0');
        }
        // number of options generated
        if(input <= buttons.size()) {
            selectOption(options.get(input));
        }
    }

    void keyReleased() {

    }

    void mouseClicked() {
    }
}

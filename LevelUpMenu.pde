import java.util.Arrays;
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
        setup();
    }
    void setup() {
        generateOptions();
        createButtons();
    }

    void createButtons() {
        for(int i = 0; i < options.size(); i++) {
            Button button = new Button(width/2 - 50, (height/6 + 100 * i), 150, 50, options.get(i));
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
        WeaponType[] values = WeaponType.values();
        List<WeaponType> valuesArray = Arrays.asList(values);
        // upgrade options
        for(Weapon w : ce.weapons) {
            options.add("upgrade " + w.TYPE.name());
            valuesArray.remove(w.TYPE);
            break; // leave loop after option added
        }
        // add options
        for(WeaponType wt : valuesArray) {
            options.add("add " + wt.name());
        }
    }

    void selectOption(String option) {
        // String[] s = option.split(' ');
        WeaponType wt = WeaponType.MAGICWAND;
        switch (option) {
            case "add":
                //ce.addWeapon(wt.randomWeapon());
            break;
            
            case "upgrade":
                // ce.levelUpWeapon(wt.randomWeapon());
            break;
            
            default:

            break;
        }
        game.unpause();
    }

    void draw() {
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
        
        int input = 100;
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

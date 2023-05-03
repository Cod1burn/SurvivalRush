import java.util.Arrays;
public class LevelUpMenu {
    Game game;
    Player player;
    CombatEntity ce;
    WeaponType[] values;
    ArrayList<Button> buttons; 
    ArrayList<String> options;

    public LevelUpMenu(Game game, Player player) {
        this.game = game;
        this.player = player;
        this.ce = player.ce;
        options = new ArrayList<>();
        buttons = new ArrayList<>();
        values = WeaponType.values();
        setup();
    }
    void setup() {
        generateOptions();
        createButtons();
    }

    void createButtons() {
        for(int i = 0; i < options.size(); i++) {
            Button button = new Button(350 + 250 * i, (height/2 + 200), 150, 50, options.get(i));
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
        //print(option);
        String[] s = option.split(" ");
        switch (s[0]) {
            case "add":
                // ADD WEAPON
                ce.addWeapon(WeaponType.valueOf(s[1]));
            break;
            
            case "upgrade":
                // UPGRADE WEAPON
                ce.levelUpWeapon(WeaponType.valueOf(s[1]));
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
        if(keyChar >= '1' && keyChar <= '5') {
            input = int(keyChar) - int('1');
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

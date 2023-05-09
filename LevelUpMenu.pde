import java.util.Arrays;
public class LevelUpMenu {
    Game game;
    Player player;
    CombatEntity ce;
    WeaponType[] values;
    String option, description; 
    ArrayList<Button> buttons; 
    ArrayList<String> options;
    
    public LevelUpMenu(Game game, Player player) {
        this.game = game;
        this.player = player;
        this.ce = player.ce;
        option = "";
        description = "";
        options = new ArrayList<>();
        buttons = new ArrayList<>();
        values = WeaponType.values();
        setup();
    }
    String getDescription() {return description;}

    void setup() {
        generateOptions();
        createButtons();
    }

    void createButtons() {
        for(int i = 0; i < options.size(); i++) {
            Button button = new Button(250 + 250 * i, height/2, 195, 50, options.get(i));
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
        for(int i = 0; i < values.length; i++) {
            boolean contains = false;
            for (Weapon w: ce.weapons) {
                if(w.TYPE == values[i]) contains = true;
            }
            if(contains) options.add("upgrade " + values[i].name());
            else options.add("add " + values[i].name());
        }
    }

    void selectOption(int input) {
        String[] s = option.split(" ");
        switch (s[0]) {
            case "add":
                // ADD WEAPON
                ce.addWeapon(WeaponType.valueOf(s[1]));
                
                switch(input) {
                    case 1:
                        MagicWand mw = new MagicWand(player);
                        description = mw.getDescription(1);
                    break;

                    case 2 :
                        AsterWand aw = new AsterWand(player);
                        description = aw.getDescription(1);
                    break;	

                    case 3 :
                        Spikewand sw = new Spikewand(player);
                        description = sw.getDescription(1);
                    break;

                    case 4 :
                        ShardStaff ss = new ShardStaff(player);
                        description = ss.getDescription(1);
                    break;	
                    
                    case 5:
                        Boomrang br = new Boomrang(player);
                        description = br.getDescription(1);
                    break;

                    default:
                    break;
                }
                
            break;
            
            case "upgrade":
                // UPGRADE WEAPON
                ce.levelUpWeapon(WeaponType.valueOf(s[1]));
                
                ce.weapons.forEach((w) -> {
                    if(w.TYPE == WeaponType.valueOf(s[1])) description = w.getDescription(w.level);
                });
            break;
            
            default:

            break;
        }
        game.unpause();
    }
    void draw() {
        background(0);
        PImage img = loadImage("MapImgs/Map0/wholemap.jpg");
        img.resize(width, height);
        image(img, 0, 0);
        PFont font; 
        font = createFont("Serif", 30);
        textFont(font);
        textSize(64);
        textAlign(CENTER, CENTER);
        text("Congratulations you have levelled up!", width/2, height/4);
        textSize(32);
        text("Select one of the options. Add a new weapon to your arsenal or upgrade an existing weapon.", width/2, height/4 + 100);
        text("Use the numbers 1-6 for the corresponding option or click on the buttons.", width/2, height/4 + 175);
        drawButtons();
    }

    void keyPressed(char keyChar) {
        
        int input = 100;
        if(keyChar >= '1' && keyChar <= '6') {
            input = int(keyChar) - int('1');
            option = options.get(input);
            selectOption(input);
        }    
    }

    void keyReleased() {

    }

    void mouseClicked(int mouseX, int mouseY) {
        for(int i = 0 ; i < buttons.size(); i++) {
            if(buttons.get(i).contains(mouseX, mouseY)){
                option = options.get(i);
                System.out.println("Clicked: " + option);
                selectOption(i + 1);
            } 
        }
    }
}

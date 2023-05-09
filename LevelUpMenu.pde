import java.util.Arrays;
public class LevelUpMenu {
    PGraphics pg;
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
        pg = createGraphics(width/2, height/2);
        option = "";
        description = "";
        options = new ArrayList<>();
        buttons = new ArrayList<>();
        values = WeaponType.values();
        setup();
    }

    PImage getImage(WeaponType wt) {
        PImage img;
        switch(wt) {
            case MAGICWAND:
                MagicWand mw = new MagicWand(player);
                img = mw.projectileImage;
            break;
            case ASTERWAND :
                AsterWand aw = new AsterWand(player);
                img = aw.projectileImage;
            break;
            case SPIKEWAND :
                Spikewand sw = new Spikewand(player);
                img = sw.projectileImage;
            break;    
            case SHARDSTAFF :
                ShardStaff ss = new ShardStaff(player);
                img = ss.projectileImage;
            break;
            
            case BOOMRANG:
                Boomrang br = new Boomrang(player);
                img = br.projectileImage;
            break;
        
            case FIREPATH:
                FirePath fp = new FirePath(player);
                img = fp.projectileImage;
            break;
            
            default:
                img = null;
            break;
        }
        return img;
    }
    String getDescription(WeaponType wt, boolean newWeapon) {
        String result = "";
        switch(wt) {
            case MAGICWAND:
                MagicWand mw = new MagicWand(player);
                if(newWeapon) result = mw.getDescription(1);
                else {
                    for(Weapon w : ce.weapons) 
                        if(w.TYPE == wt) result = mw.getDescription(w.level + 1);
                }
                return result;

            case ASTERWAND :
                AsterWand aw = new AsterWand(player);
                if(newWeapon) result = aw.getDescription(1);
                else {
                    for(Weapon w : ce.weapons) 
                        if(w.TYPE == wt) result = aw.getDescription(w.level + 1);
                }
                return result;
            	

            case SPIKEWAND :
                Spikewand sw = new Spikewand(player);
                if(newWeapon) result = sw.getDescription(1);
                else {
                    for(Weapon w : ce.weapons) 
                        if(w.TYPE == wt) result = sw.getDescription(w.level + 1);
                }
                return result;
            

            case SHARDSTAFF :
                ShardStaff ss = new ShardStaff(player);
                if(newWeapon) result = ss.getDescription(1);
                else {
                    for(Weapon w : ce.weapons) 
                        if(w.TYPE == wt) result = ss.getDescription(w.level + 1);
                }
                return result;
            	
            
            case BOOMRANG:
                Boomrang br = new Boomrang(player);
                if(newWeapon) result = br.getDescription(1);
                else {
                    for(Weapon w : ce.weapons) 
                        if(w.TYPE == wt) result = br.getDescription(w.level + 1);
                }
                return result;
            

            case FIREPATH:
                FirePath fp = new FirePath(player);
                if(newWeapon) result = fp.getDescription(1);
                else {
                    for(Weapon w : ce.weapons)
                        if(w.TYPE == wt) result = fp.getDescription(w.level + 1);
                }
                return result;
            
            
            default:
                return " ";
            
        }
    }

    void setup() {
        generateOptions();
        getRandomPool();
        createButtons();
    }

    void createButtons() {
        pg.beginDraw();
        for(int i = 0; i < options.size(); i++) {
            // pg.text("hey", pg.width/)
            int tempW = pg.width/2;
            int tempH = pg.height/4 + (100 * i);
            Button button = new Button(tempW, tempH, 190, 50, options.get(i));
            buttons.add(button);
        }
        pg.endDraw();
    }
    
    void drawButtons(PGraphics pg, LevelUpMenu lp){
        for (Button button : buttons) 
            button.pgDraw(pg, lp);   
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

    void selectOption() {
        String[] s = option.split(" ");
        switch (s[0]) {
            case "add":
                // ADD WEAPON
                ce.addWeapon(WeaponType.valueOf(s[1]));                
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
    // function to generate 3 random options from the existing set.
    void getRandomPool() {
        ArrayList<String> result = new ArrayList<String>();
        for (int i = 0; i < 3; i++) {
            int index = (int) random(options.size()); // Generate a random index
            String text = options.get(index); // Get the number at the random index
            result.add(text); // Add the number to the randomNumbers ArrayList
            options.remove(index); // Remove the number from the original ArrayList to avoid duplicates
        }
        options = result;
    }
    void draw () {
        pg.beginDraw();
        pg.background(255);
        pg.fill(0);
        pg.stroke(0);
        // PImage img = loadImage("MapImgs/Map0/wholemap.jpg");
        // img.resize(pg.width, pg.height);
        // pg.image(img, width - pg.width, height - pg.height);
        pg.textAlign(CENTER, TOP);
        pg.textSize(20);
        pg.text("You have reached level " + player.ce.level, pg.width/2, 0);
        // 
        drawButtons(pg, this); 
        // getRandomPool();

        pg.endDraw();
        image(pg, width/4, height/4);
    }
    void keyPressed(char keyChar) {        
        int input = 100;
        if(keyChar >= '1' && keyChar <= '6') {
            input = int(keyChar) - int('1');
            option = options.get(input);
            selectOption();
        }    
    }

    void mouseClicked(int mouseX, int mouseY) {
        for(int i = 0 ; i < buttons.size(); i++) {
            if(buttons.get(i).contains(mouseX, mouseY)){
                option = options.get(i);
                System.out.println("Clicked: " + option);
                selectOption();
            } 
        }
    }
}

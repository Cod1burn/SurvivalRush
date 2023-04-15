class Menu {

    ArrayList<Button> buttons = new ArrayList<>();
    
    
    public Menu() {
        buttons = new ArrayList<>();
        createButtons();
    }
    
    ArrayList<Button> getButtons() {
        return buttons;
    }

    void draw() {
        background(255);
        fill(0);
        textSize(64);
        textAlign(CENTER);
        text("MENU", width/2, height/6);
        textSize(32);
        text("Choose a template", width/2, height/6 + 100);
        drawButtons();
    }

    void createButtons() {
        
        Button button1 = new Button(width/2 - 50, height/6 + 200, 100, 50, "1");
        Button button2 = new Button(width/2 - 50, height/6 + 300, 100, 50, "2");
        Button button3 = new Button(width/2 - 50, height/6 + 400, 100, 50, "3");
        Button button4 = new Button(width/2 -50, height/6 + 600, 250, 100, "Exit");

        buttons.add(button1);
        buttons.add(button2);
        buttons.add(button3);
        buttons.add(button4);

        // I am not sure if you want to remove the return value or change function return type,
        // so i just comment it.
        // -- Yiran
        // return buttons; 
    }

    void drawButtons(){
        for (Button button : buttons) 
            button.draw();   
    }
}
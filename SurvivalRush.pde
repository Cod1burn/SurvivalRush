boolean menu;
int template;
ArrayList<Button> buttons;
void setup() {
  fullScreen();
  menu = true;
  buttons = new ArrayList<>();
  createButtons();
}

void draw() {
  // draw menu
  if (menu) {
    background(255);
    fill(0);
    textSize(64);
    textAlign(CENTER);
    text("MENU", width/2, height/6);
    textSize(32);
    text("Choose a template", width/2, height/6 + 100);
    drawButtons();
  }
  // draw main game.
  else {
    background(255);
    fill(0);
    textSize(64);
    textAlign(CENTER);
    text("GAME", width/2, height/2);
  }
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
}

void drawButtons(){
  for (Button button : buttons) {
    button.draw();
  }
}
void mousePressed() {
  for (Button button : buttons) {
    if (button.contains(mouseX, mouseY)) {
      if(button.bText.equals("Exit")) {
        System.exit(0);
      }
      print(button.bText);
    }
  }
}

void keyPressed() {
  if (menu && (key == ' ' || key == ENTER)) menu = false;
}

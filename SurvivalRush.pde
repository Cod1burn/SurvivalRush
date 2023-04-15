boolean isMenu;
Menu menu
int template;
ArrayList<Button> buttons;
Game game;

/*
For test only

void setup() {
  size(1200,800);
  frameRate(60);
  game = new Game();
}

void setup() {
  fullScreen();
  isMenu = true;
  menu = new Menu();
  buttons = menu.getButtons();
}

*/

void draw() {
  // draw menu
  if (isMenu) menu.draw();
  // draw main game.
  else {
    background(255);
    fill(0);
    textSize(64);
    textAlign(CENTER);
    text("GAME", width/2, height/2);
  }
}

void mousePressed() {
  for (Button button : buttons) {
    if (button.contains(mouseX, mouseY)) {
      if(button.bText.equals("Exit")) {
        System.exit(0); // exit the game
      }
      // use input to select template. 
      // template = button.bText.toInt();
      print(button.bText); // just temporary. can delete if not needed for button verification
    }
  }
}

void keyPressed() {
  // game starts with menu. 
  // space or ENTER to pause or unpause game. 
  // can change if needed. 
  if (key == ' ' || key == ENTER) isMenu = !isMenu;
}

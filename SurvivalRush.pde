boolean isMenu;
boolean inGame;
Game game;
Menu menu;
int millis;

// For test only
void setup() {
  size(1720, 1080, P2D);
  frameRate(60);
  game = new Game();
  menu = new Menu(game);
  isMenu = false;
  inGame = true;
  millis = millis();
}

void draw() {
  int time = millis() - millis;
  millis = millis();
  if (isMenu) menu.draw();
  else if (inGame) {
    game.update(time);
    pushMatrix();
    game.draw();
    popMatrix();
  }
}

void keyPressed() {
  // game starts with menu. 
  // space or ENTER to pause or unpause game. 
  // can change if needed. 
  if (key == ' ' || key == ENTER) {
    isMenu = !isMenu;
    inGame = !inGame;
  }
  if (inGame) game.keyPressed(key);
  else if (isMenu) menu.keyPressed(key);
}

void keyReleased() {
  if (inGame) game.keyReleased(key);
}
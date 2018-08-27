Player megaman;
enum modes {
  MMENU, LVL1
};

modes mode = modes.MMENU;
Level current;

void setup() {
  size(256, 224); // NES resolution
 // megaman = new Player();
  //megaman.loadImages();
}

void draw() {
  switch(mode) {
  case MMENU:
    drawMainMenu();
    break;
  case LVL1:
    current.drawLevel();
    break;
   
  }
}

void drawMainMenu() {
  image(loadImage("mmenu.png"), 0, 0);
  if (keyPressed) {
    current = new BombStage();
    mode = modes.LVL1;
  }
}

void drawLVL1() {
  current.drawLevel();
}

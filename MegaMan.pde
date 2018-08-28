Player megaman;
enum modes {
  MMENU, LVL1
};

modes mode = modes.MMENU;
Level current;

void setup() {
  size(256, 224); // NES resolution = 256,224
  megaman = new Player();
  megaman.loadImages();
  current = new BombStage();

}

void draw() {
  switch(mode) {
  case MMENU:
    drawMainMenu();
    break;
  case LVL1:
    current.drawLevel();
    megaman.draw();
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

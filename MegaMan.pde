Player megaman; 

enum modes {
  MMENU, STAGESELECT, LVL1, GAMEOVER
};
enum dir {
  NORTH, SOUTH, EAST, WEST
};

modes mode = modes.MMENU;
Level current;

void setup() {
  size(256, 224); // NES resolution = 256,224
  frameRate(60);
  noSmooth();
  megaman = new Player();
  megaman.loadImages();
  current = new BombStage();
}

void draw() {
  switch(mode) {
  case MMENU:
    drawMainMenu();
    break;
      case GAMEOVER:
    drawGameOver();
    break;
      case STAGESELECT:
    drawStageSelect();
    break;
  case LVL1:
    current.drawLevel();
    megaman.draw();

    break;
  }
}

void drawMainMenu() {
  imageMode(CORNER);
  image(loadImage("mmenu.jpg"), 0, 0);
  if (keyPressed) {
    mode = modes.STAGESELECT;
    keyPressed = false;
  }
}

void drawStageSelect() {
  imageMode(CORNER);
  image(loadImage("stageSelect.jpg"), 0, 0);
  if (keyPressed) {
    current = new BombStage();
    mode = modes.LVL1;
    keyPressed = false;
  }
}

void drawGameOver() {
   imageMode(CORNER);
  image(loadImage("gOver.jpg"), 0, 0);
  if (keyPressed) {
    mode = modes.MMENU;
    keyPressed = false;
  }
}


void keyPressed() {
 if  (key == 'd')
  {
    megaman.right = 1;
    megaman.direction = 1;
  }
  if (key == 'a')
  {
    megaman.left = -1;
    megaman.direction = -1;
  }
  if (key == 'w')
  {
    megaman.up = -1;
  }
  if (key == 's')
  {
    megaman.down = 1;
  }
}

void keyReleased()
{
  if (key == 'd')
  {
    megaman.right = 0;
  }
  if (key == 'a')
  {
    megaman.left = 0;
  }
  if (key == 'w')
  {
    megaman.up = 0;
  }
  if (key == 's')
  {
    megaman.down = 0;
  }
}

BombStage stage;
Player megaman;

void setup() {
  surface.setSize(256, 224);
  stage = new BombStage();
  megaman = new Player();
}

void draw() {
  background(#39c6ff);
  // translate(0,-8);
  println((stage.getTilesX() * 16) - 128);
  if (megaman.pos.x > stage.getTilesX() * 16 - 128) {
    translate(-(stage.getTilesX() * 16 - 256), -8);
  } else if (megaman.pos.x > 128) {
    translate(-(megaman.pos.x - 128), -8);
  } else {
    translate(0, -8);
  }

  stage.drawLevel();
  drawGrid();
  megaman.update();
}  

void drawGrid() {
  stroke(#000000);
  for (int i = 0; i < 112; i ++) {
    line(i * 16, 0, i * 16, 232);
    line(0, i * 16, 1792, i * 16);
  }
}

void mousePressed() {
  int tileX = floor(mouseX) / 16;
  int tileY = floor(mouseY) / 16;
  println("TILE AT MOUSE: (" + tileX + ", " + tileY + ")");
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

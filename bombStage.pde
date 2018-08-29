import processing.sound.*;

class BombStage extends Level {
  PImage bgImg;
  PVector pos = new PVector(13, 990); //REG START 13,990
  
  String getSound() {
    return "BombmanStage.wav";
  }

  BombStage() {
    println("Creating BombStage");
    bgImg = loadImage("lvl1.png");
    megaman.pos = new PVector(100, 159);
  }

  void drawLevel() {
    //println("Draw BombStage");
    int dX = 0;
    int dY = 0;
    int d = 2;
    println(megaman.pos);
    if (megaman.pos.x < 100) {
      if (canMoveLeft()) dX = -d;
    }
    if (megaman.pos.x > 140) {
      if (canMoveRight()) dX = d;
    }

    if (megaman.pos.y < 20) {
      if (canMoveUp()) dY = -d;
    }

    if (megaman.pos.y == 224) {
      if (canMoveDown()) dY =d;
    }
    if (megaman.pos.x ==144) {
      if (canMoveRight()) dX = d;
    }

    if (keyPressed) {
      switch(key) {
        case('w'): 
        if (canMoveUp()) dY = -d;
        break;
        case('s'): 
        if (canMoveDown())dY = d;
        break;
        case('a'): 
        if (canMoveLeft()) dX = -d;
        break;
        case('d'): 
        if (canMoveRight()) dX = d;
        break;
      }
      //keyPressed = false;
    }
    pos.y += dY;
    pos.x += dX;
    translate(dX, dY);
    image(bgImg, -pos.x, -pos.y);
    //println(pos);
  }

  boolean canMoveUp() {
    if (pos.x >= 13 && pos.x < 1549 ||
      pos.y == 30 ||
      pos.y == 510 && pos.x < 2826) return false;
    return true;
  }

  boolean canMoveDown() {
    if (pos.y == 990 ||
      pos.y == 926 ||
      pos.y == 30 && !(pos.x == 2829 || pos.x == 4109)||
      pos.y == 510 && pos.x != 4109) return false;
    return true;
  }

  boolean canMoveLeft() {
    if (pos.x == 13 ||
      pos.x == 1549 && pos.y != 990 ||
      pos.x == 2829 && pos.y != 510 ||
      pos.x == 4109 && pos.y != 30) return false;
    return true;
  }

  boolean canMoveRight() {
    if (pos.x == 1549 && pos.y != 510 ||
      pos.x == 4109 ||
      pos.x == 2829 && pos.y != 30) return false;
    return true;
  }

  boolean atLowestPoint() {
     return pos.y == 194;
  }
}

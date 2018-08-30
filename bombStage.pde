class BombStage extends Level {

  BombStage() {
    println("Loading BombStage");
    bgImg = loadImage("stages/bombMan.jpg");
    collisionImg = loadImage("stages/bombManCollision.jpg");
    pos = new PVector(13, 990);
    megaman.pos = new PVector(100, 159); // Set where Megaman should start
  }

  void drawLevel() {
    float pX = megaman.pos.x;
    float pY = megaman.pos.y;
    float dX = 0;
    int dY = 0;
   //println("Player (x,y) = (" + pX + ", " + pY + ")" + "DIRECTION: " + megaman.direction+ " VELOCITY:  " + megaman.velocity);
    //println("Camera (x,y) = (" + pos.x + ", " + pos.y + ")");
    
    //Only move camera if player is moving
    if (keyPressed) {
      // RIGHT HALF
      if (pX > 127 && megaman.direction > 0) {
        if (canMoveRight()) {
          megaman.pos.x = 127;

          dX = megaman.walkSpeed;
          pos.x += megaman.walkSpeed;
        }

        // LEFT HALF
      } else if (pX < 128 && megaman.direction< 0) {
        if (canMoveLeft()) {
                    megaman.pos.x = 128;

          dX = -megaman.walkSpeed;
          pos.x -= megaman.walkSpeed;
        }
      }
    }

    translate(dX, dY);
    imageMode(CORNER);
    image(bgImg, -pos.x, -pos.y);

        fill(#000000);
    //  megaman.draw();
  }

  boolean canMove(dir d) {
    switch(d) {
    case NORTH:
      return canMoveUp();
    case SOUTH:
      return canMoveDown();
    case EAST:
      return canMoveRight();
    case WEST:
      return canMoveLeft();
    default:
      return false;
    }
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

  int getGroundPosition(float x) {
    return 170;
  }
}

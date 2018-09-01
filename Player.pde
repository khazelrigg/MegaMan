enum playerState {
  STAND, WALK, JUMP, HURT, SHOOTINGG, SHOOTINGJ
};

class Player {
  int health = 30;
  int lives = 2;

  PVector velocity = new PVector(0, 0);
  float jumpSpeed = 6;

  PVector pos = new PVector(124, 140);
  playerState state = playerState.STAND;

  float walkSpeed = 2;
  float direction = 1;
  float left;
  float right;
  float up;
  float down;

  int walkImg = 2;
  int framesSinceWalk = 0;
  int framesSinceStand = 0;

  PImage img;
  boolean drawHitBox = true;
  public PImage[] images = new PImage[9];

  void loadImages()
  {
    /*
     0 - Blink
     1 - Standing
     2-4 - Running
     5 - Jumping
     6 - Shooting ground
     7 - Shooting jump
     8 - Hurt
     */
    for (int i = 0; i < images.length; i++) {
      images[i] = loadImage("mmSprites/right" + i + ".png");
    } 

    img = images[1];
  }

  void draw() {
    moveCharacter();
    if (int(pos.y + img.height / 2) > 224) {
      keyPressed = false;
      mode = modes.GAMEOVER;
    }
  }


  void moveCharacter() {

    boolean onGround = false;
    if (current.collisionImg.get(int(current.pos.x + pos.x + 5), int(current.pos.y + current.pos.y )) == #0000bb) println("LADDER");


    if (!checkCollision(dir.SOUTH, pos)) {
      velocity.y += 0.5;
    } else {
      if (checkDownCollision(pos, -1)) //Player must be below ground if colliding with pixel above feet so move them up
        pos.y -= 1;

      onGround = true;
      state = playerState.STAND;
      velocity.y = 0;
    }

    if (onGround && up != 0) {
      state = playerState.JUMP;
      velocity.y = -jumpSpeed;
    }

    velocity.x = walkSpeed * (left + right);
    if (left != 0 || right != 0) {
      state = playerState.WALK;
    }

    // Get future position
    PVector fPos = new PVector(pos.x, pos.y);
    fPos.add(velocity);

    if (!current.canMove(dir.WEST) && fPos.x > img.width / 2 ||  !current.canMove(dir.EAST) && fPos.x < 256 - img.width / 2 || fPos.x > 123 && fPos.x < 130) {
      if (fPos.x > pos.x && !checkCollision(dir.EAST, fPos) || fPos.x < pos.x && !checkCollision(dir.WEST, fPos)) {
        pos.x = fPos.x;
      }
    }

    //No Collsion going up
    if (!checkCollision(dir.NORTH, fPos) && fPos.y > 0 && fPos.y < 224) {
      pos.y = fPos.y;
    }

    pushMatrix();
    translate(pos.x, pos.y);
    scale(direction, 1);
    imageMode(CENTER);

    // Update img based on state
    setCurrentImg();

    image(img, 0, 0);

    //Draw hitbox
    if (drawHitBox) {
      //stroke(#ff00ff);
      noFill();
      //rect(-9, -12, 18, 23);
    }

    popMatrix();
  }

  void setCurrentImg() {
    if (velocity.y != 0) {
      img = images[5];
      return;
    }

    switch(state) {
    case STAND:
      stand();
      break;
    case SHOOTINGG: 
      img = images[6]; 
      break;
    case WALK: 
      walk();
      break;
    case JUMP: 
      img = images[5]; 
      break;
    default:    
      img = images[1];
    }
  }

  void walk() {
    img = images[walkImg];
    if (framesSinceWalk == 7) { //How many frames until next walk img
      walkImg++;
      framesSinceWalk  = 0;
    }
    framesSinceWalk++;
    if (walkImg > 4) walkImg = 2;
  }

  void stand() {
    int blinkFreq = 60;
    if (framesSinceStand > blinkFreq) {
      img = images[0];
      if (framesSinceStand == blinkFreq + 3) // How long to hold the blink
        framesSinceStand = 0;
    } else 
    img = images[1];
    framesSinceStand++;
  }

  boolean checkCollision(dir d, PVector pos) {
    stroke(#ff0000);

    switch(d) {
    case NORTH:
      return checkUpCollision(pos);
    case SOUTH:
      return checkDownCollision(pos, 0);
    case EAST:
      return checkLRCollision(pos);
    case WEST:
      return checkLRCollision(pos);
    default:
      return false;
    }
  }

  boolean checkLRCollision(PVector pos) {
    // Use direction (-1 or 1) to flip sign
    int pX = int(current.pos.x + pos.x + direction * 9);
    int pY = int(current.pos.y + pos.y);

    color[] colors = new color[3];
    // PIXEL TOP 
    colors[0] = current.collisionImg.get(pX + 1, pY - 11);
    // PIXEL CENTERED 
    colors[1] = current.collisionImg.get(pX + 1, pY);
    // PIXEL BOTTOM
    colors[2] = current.collisionImg.get(pX + 1, pY + 1); // Take out 1 from y so that we are not checking in ground


    if (drawHitBox) {
      stroke(#00ff00);
      rect( pos.x + direction * (9), pos.y - 10, 1, 1);
      rect( pos.x + direction * (9), pos.y, 1, 1);
      rect( pos.x + direction * (9), pos.y + 10, 1, 1);
    }

    for (color c : colors) {
      if (c == #000000) {
        if (direction > 0) {
          println("RIGHT COLLISION");
        } else {
          println("LEFT COLLISION");
        }
        return true;
      }
    }
    return false;
  }

  boolean checkUpCollision(PVector pos) {
    int xOff = 8;
    int yOff = 13;

    int pX = int(current.pos.x +  pos.x);
    int pY = int(current.pos.y + pos.y) - yOff;
    color[] colors = new color[3];

    // PIXEL CENTERED ABOVE
    colors[0] = current.collisionImg.get(pX, pY);
    if (drawHitBox)
      rect( pos.x, pos.y - yOff, 1, 1);

    // PIXEL TOP RIGHT
    colors[1] = current.collisionImg.get(pX + xOff, pY);
    if (drawHitBox)rect( pos.x + xOff, pos.y -yOff, 1, 1);

    // PIXEL TOP LEFT
    colors[2] = current.collisionImg.get(pX - xOff, pY);
    if (drawHitBox)rect( pos.x - xOff, pos.y - yOff, 1, 1);

    for (color c : colors) {
      if (c == #000000) {
        println("UPPER COLLISION");
        return true;
      }
    }
    return false;
  }

  boolean checkDownCollision(PVector pos, int dist) {
    int xOff = 7;
    int pX = int(current.pos.x +  pos.x);
    int pY = int(current.pos.y + pos.y) + 11 + dist;


    // LEFT BELOW
    color bL = current.collisionImg.get(pX - xOff, pY);
    color bR = current.collisionImg.get(pX + xOff, pY);
    if (drawHitBox)rect( pos.x - xOff, pos.y + 11 + dist, 1, 1);
    if (drawHitBox)rect( pos.x + xOff, pos.y + 11 + dist, 1, 1);



    if (bL == #000000 || bR == #000000) {
      return true;
    }

    return false;
  }


  void printcoor(String s, int pX, int pY) {
    println(s + " (" + pX + ", " + pY + ")");
  }
}

enum playerState {
  STAND, WALK, JUMP, HURT, SHOOTINGG, SHOOTINGJ
};

class Player {
  int health = 30;
  int lives = 2;

  PVector velocity = new PVector(0, 0);
  float jumpSpeed = 7;

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

    if (!checkDownCollision(pos)) {
      velocity.y += 0.5;
    } else {
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
      if (fPos.x > pos.x && !checkRightCollision(fPos) || fPos.x < pos.x && !checkLeftCollision(fPos)) {
      pos.x = fPos.x;
      }
    }
    
    if (fPos.y > 0 && fPos.y < 224)
      pos.y = fPos.y;

    pushMatrix();
    translate(pos.x, pos.y);
    scale(direction, 1);
    imageMode(CENTER);

    // Update img based on state
    setCurrentImg();

    image(img, 0, 0);

    //Draw hitbox
    stroke(#ffff00);
    noFill();
    rect(-img.width/2, -img.height/2,img.width,img.height);

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
      img = images[walkImg];

      if (framesSinceWalk == 7) { //How many frames until next walk img
        walkImg++;
        framesSinceWalk  = 0;
      }
      framesSinceWalk++;
      if (walkImg > 4) walkImg = 2;
      break;
    case JUMP: 
      img = images[5]; 
      break;
    default:    
      img = images[1];
    }
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

  boolean checkDownCollision(PVector pos) {
     int pWidth = img.width;
    int pHeight = 22;
    int pX = int(current.pos.x +  pos.x);
    int pY = int(current.pos.y + pos.y) + pHeight/2;
    color pixBelow = current.collisionImg.get(pX, pY + 2);
    printcoor("B ", pX, pY - 1);
    println("B: " + (pixBelow == #000000));
    
    stroke(#ff0000);
    rect( pos.x,pos.y + pHeight/2,1,1);
    return pixBelow == #000000;
  }
  
  //TODO CHECK TOP/BOTTOM CORNERS
  boolean checkRightCollision(PVector pos) {
     int pWidth =img.width;
    int pHeight = img.height;
    int pX = int(current.pos.x +  pos.x) +  pWidth / 2;
    int pY = int(current.pos.y + pos.y); //+ pHeight / 2 -1;
    color pixRight = current.collisionImg.get(pX +1, pY);
    printcoor("R", pX + 1, pY);
    print ("R : " + (pixRight == #000000));
    
    stroke(#ff0000);
    rect(pos.x + pWidth / 2, pos.y , 1,1);
    
    return pixRight == #000000;
  }

  boolean checkLeftCollision(PVector pos) {
    println("EFT");
     int pWidth =img.width;
    int pHeight = img.height;
    int pX = int(current.pos.x +  pos.x -  pWidth / 2);
    int pY = int(current.pos.y + pos.y); //+ pHeight / 2 -1;
    color pixLeft = current.collisionImg.get(pX - 1, pY);
    printcoor("L", pX +-1, pY);
    print ("L : " + (pixLeft == #000000));
    
    stroke(#ff0000);
    rect((pos.x - pWidth /2) - 1, pos.y , 1,1);
    
    return pixLeft == #000000;
  }


  void printcoor(String s, int pX, int pY) {
    println(s + " (" + pX + ", " + pY + ")");
  }
}

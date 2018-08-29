enum playerState {
  STAND, WALK, JUMP, HURT, SHOOTINGG, SHOOTINGJ
};

class Player {
  int health = 30;
  int lives = 2;
  PVector pos ;
  playerState state = playerState.STAND;
  int walkImg = 2;
  int framesSinceWalk = 0;
  int framesSinceStand = 0;
  PImage img;

  public PImage[] imagesR = new PImage[9];
  public PImage[] imagesL = new PImage[9];
  PImage[] images = imagesR;

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
    for (int i = 0; i < imagesR.length; i++) {
      imagesR[i] = loadImage("right" + i + ".png");
    } 
    for (int j = 0; j < imagesR.length; j++) {
      imagesL[j] = loadImage("left" + j + ".png");
    }

    img = imagesR[1];
  }


  void update() {
    if (keyPressed) {
      if (key == 'z') {
        state = playerState.SHOOTINGG;
      } else if (keyCode == UP) {
        pos.y -= 4;
        state = playerState.JUMP;
      } else if (keyCode == DOWN) {
        pos.y += 4;
        state = playerState.JUMP;
      } else if (keyCode == LEFT) {
        images = imagesL;
        state = playerState.WALK;
        pos.x -= 4;
      } else if (keyCode == RIGHT) {
        images = imagesR;
        state = playerState.WALK;
        pos.x += 2;
      }
    } else {
      state = playerState.STAND;
    }
    /*
    if (!current.atLowestPoint()) {
     pos.y += 1;
     }*/

    checkFrameBoundaries();
  }

  void draw() {
    update();
    if (!current.atLowestPoint()) {
      img = images[5];
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
      if (framesSinceWalk ==3 ) {
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
    image(img, pos.x, pos.y);
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

  void checkFrameBoundaries() {
    if (pos.x > 144) pos.x=144;
    if (pos.x < 0) pos.x=0;
    if (pos.y < 0) pos.y = 0;
    if (pos.y > 224 - img.height) pos.y = 224 - img.height;
  }
}

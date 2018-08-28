enum playerState {
  STAND, WALK, JUMP, HURT, SHOOTINGG, SHOOTINGJ
};

class Player {
  int health = 30;
  int lives = 2;
  PVector pos ;
  playerState state = playerState.STAND;

  public PImage[] imagesR = new PImage[9];
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
    // Load all images running right
    for (int i = 0; i < imagesR.length; i++) {
      imagesR[i] = loadImage("right" + i + ".png");
      println("Loaded image: right"+ i + ".png");
    } 
    // Loa
    /*d all images running left
     for (int j = 0; j < imagesR.length; j++) {
     imagesL[j] = loadImage("mmL" + j + ".png");
     } */
  }


  void update() {
    if (keyPressed) {
      if (key == 'z') {
        state = playerState.SHOOTINGG; 
      } else if (keyCode == UP) {
        pos.y -= 4;
        state = playerState.JUMP;
      } else if (keyCode == LEFT) {
         pos.x -= 4;
      } else if (keyCode == RIGHT) {
        state = playerState.WALK;
        pos.x += 4;
      }
      
    } else {
        if (state == playerState.JUMP) {
          pos.y += 1;
        }
    }
  }

  void draw() {
    println("Drawing Megaman");
    update();
    PImage img;
    switch(state) {
    case SHOOTINGG: 
      img = imagesR[6]; 
      break;
    case WALK: 
      img = imagesR[2]; 
      break;
    case JUMP: 
      img = imagesR[5]; 
      break;
    default:    
      img = imagesR[1];
    }
  


    image(img, pos.x, pos.y);
  }
}

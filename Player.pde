class Player {
  
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
    } 
    // Loa
    /*d all images running left
    for (int j = 0; j < imagesR.length; j++) {
      imagesL[j] = loadImage("mmL" + j + ".png");
    } */

  }
  
}

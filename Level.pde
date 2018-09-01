abstract class Level {
  PImage bgImg;
  PImage collisionImg;
  PVector pos;
  int score = 0;

  abstract void drawLevel();  
  abstract boolean canMove(dir d); //1N, 2E, 3S, 4W 
}  

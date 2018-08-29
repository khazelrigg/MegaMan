abstract class Level {
  PVector pos;
  int score = 0;

  abstract void drawLevel();  
  abstract boolean atLowestPoint();
  abstract String getSound();
}  

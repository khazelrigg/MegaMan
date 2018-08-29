Player megaman;
enum modes {
  MMENU, LVL1
};

modes mode = modes.MMENU;
Level current;
SoundFile audio;
 
void setup() {
  size(256, 224); // NES resolution = 256,224
  frameRate(30);
  megaman = new Player();
  megaman.loadImages();
  current = new BombStage();
  audio = new SoundFile(this, "StageSelect.wav");
 Sound s = new Sound(this);
 s.volume(1);
  audio.loop();
  audio.play();
}

void draw() {
  switch(mode) {
  case MMENU:
    drawMainMenu();
    break;
  case LVL1:
    audio.play();
    current.drawLevel();
    megaman.draw();
    break;
   
  }
}

void drawMainMenu() {
  image(loadImage("mmenu.png"), 0, 0);
  if (keyPressed) {
    current = new BombStage();
    println(current.getSound());
    audio = new SoundFile(this, current.getSound());
    mode = modes.LVL1;
  }

}

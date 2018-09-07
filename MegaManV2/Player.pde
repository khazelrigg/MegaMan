class Player {
  PImage img;
  PVector pos;

  PVector velocity = new PVector(0, 0);
  int direction = 1;
  float jumpSpeed = 6.5;
  int walkSpeed = 2;
  float left, right, up, down;

  Player() {
    pos = new PVector(100, 184);
    img = loadImage("mmSprites/1.png");
  }

  void update() {
    stroke(#ff00ff);
    noFill();
    rect(pos.x - img.width / 2, pos.y - img.height / 2, img.width, img.height);
    move();
    if (pos.x > 128) {
      translate(-(pos.x - 128), -8);
    }
    println(pos.x);
  }

  void move() {
    if (pos.y > 200) {
      println("Fell off map, resetting");
      pos = new PVector(100, 184);
    }

    boolean standingOnTile = collisionSouth();

    if (!standingOnTile) {
      velocity.y += 0.5; //Gravity if we are not at bottom of screen
    } else {
      int playerTileY = ceil(pos.y) / 16;
      int yEdgeTile = (playerTileY + 1) * 16;
      pos.y = yEdgeTile - img.height/2 + 1;
      velocity.y = 0;
    }

    if (standingOnTile &&  up != 0) {
      velocity.y = -jumpSpeed;
    }

    velocity.x = walkSpeed * (left + right);

    PVector futurePos = new PVector(pos.x, pos.y);
    futurePos.add(velocity);

    if (futurePos.x > 0 && pos.x < 16 * stage.getTilesX()) {
      if (collisionSide(futurePos)) {
        int limit = getTileX(futurePos) + 16 - img.width / 2;
        if (direction > 0 && futurePos.x < limit)
          pos.x = futurePos.x;
        if (direction < 0 && futurePos.x > limit)
          pos.x = futurePos.x;
      } else {
        pos.x = futurePos.x;
      }
    }

    if (futurePos.y < height && futurePos.y > 0) {
      pos.y = futurePos.y;
    }

    pushMatrix();
    translate(pos.x, pos.y);
    imageMode(CENTER);
    scale(direction, 1); // Scaling with direction means we can flip our image if moving left/right
    image(img, 0, 0);
    popMatrix();
  }

  int getTileX(PVector pos) {
    return 16 * (floor(pos.x) / 16);
  }

  boolean collisionSouth() {
    int playerTileX = floor(pos.x) / 16;
    int playerTileY = ceil(pos.y) / 16;
    Tile tileBelow = stage.tileMap.get(playerTileX, playerTileY + 1);
    return tileBelow != null && tileBelow.isSolid();
  }

  boolean collisionSide(PVector pos) {
    int playerTileX = floor(pos.x) / 16;
    int playerTileY = ceil(pos.y) / 16;
    Tile side = stage.tileMap.get(playerTileX + (1 * direction), playerTileY);
    Tile upper = stage.tileMap.get(playerTileX + (1 * direction), playerTileY - 1);

    int[] sideCoords = {(playerTileX + (1 * direction)) * 16, playerTileY * 16, (playerTileX + (1 * direction)) * 16 + 16, (playerTileY * 16)};
    int[] upCoords = {(playerTileX + (1 * direction)) * 16, (playerTileY - 1) * 16, (playerTileX + (1 * direction)) * 16 + 16, (playerTileY - 1) * 16 + 16};

    boolean collisionSide = false;
    boolean collisionUp = false;

    if (side != null) {
      if (side.isSolid())
        collisionSide = collision(sideCoords, getCoords(pos));
    }
    if (upper != null) {
      if (upper.isSolid())
        collisionUp = collision(upCoords, getCoords(pos));
    }

    return collisionUp || collisionSide;
  }

  boolean collision(int[] coords1, int[] coords2) {
    return !(coords1[0] < coords2[2] && 
      coords1[2] > coords2[0] &&
      coords1[1] < coords2[3] &&
      coords1[3] > coords2[1]);
  }

  int[] getCoords(PVector pos) {
    int x = int(pos.x);
    int y = int(pos.y);
    int[] coords = {x, y, x + img.width, y + img.width};
    return coords;
  }
}

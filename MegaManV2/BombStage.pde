class BombStage {
  TileMap tileMap;

  BombStage() {
    loadTiles();
    tileMap.importMap("bombStage/worldTiles");
  }

  void loadTiles() {
    Tile[] tiles = new Tile[15];
    PImage tiles014 = loadImage("bombStage/tiles/tiles0-14.png");
    for (int i = 0; i < 14; i++) {
      tiles[i] = new Tile(tiles014.get(16*i, 0, 16, 16));
      tiles[i].setSolid(true);
    }
    tiles[14] = new Tile(loadImage("bombStage/tiles/15.png"), 1, 0);
    tileMap = new TileMap(tiles, 15, 112);
  }

  void drawLevel() {
    tileMap.drawMap();
  }
  
  int getTilesX() {
    return tileMap.map[0].length;
  }
  
}

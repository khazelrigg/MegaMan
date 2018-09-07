class Tile {
  PImage img;
  boolean solid = false;
  int width, height;
  int posX, posY = 0;
  int offX, offY = 0;

  Tile(PImage img) {
    this.img = img;
    width = img.width;
    height = img.height;
  }

  Tile(PImage img, int offX, int offY) {
    this.img = img;
    width = img.width;
    height = img.height;
    this.offX = offX;
    this.offY = offY;
  }

  void draw() {
    imageMode(CORNER);
    image(img, posX + offX, posY + offY);
  }

  void setSolid(boolean t) {
    solid = t;
  }

  boolean isSolid() {
    return solid;
  }
  
  int[] getCoords() {
    int[] coords = {posX, posY, posX + 16, posY + 16};
    return coords;
  }
  
}


class TileMap {
  Tile[] tiles;
  int[][] map;
  int scale = 1;

  TileMap(Tile[] tiles, int dimX, int dimY) {
    this.tiles = tiles;
    map = new int[dimX][dimY];
    for (int i = 0; i < map.length; i++) {
      for (int j = 0; j <map[i].length; j++) {
        map[i][j] = 999;
      }
    }
  }

  void setMap(int[][] map) {
    this.map = map;
  }

  void setTile(int x, int y, int t) {
    map[x][y] = t;
  }


  Tile get(int x, int y) {
    if (y >= 0 && x >= 0 && y < map.length && x < map[0].length) {
      int tileId = map[y][x];
      if (tileId != 999) {
        return tiles[map[y][x]];
      }
    }
    return null;
  }

  void drawMap() {
    for (int r = 0; r < map.length; r++) {
      for (int c = 0; c < map[r].length; c++) {
        int tile = map[r][c];
        if (tile != 999) {
          Tile t = tiles[tile];
          t.posX = c * 16;
          t.posY = r * 16;
          t.draw();
        }
      }
    }
  }

  void fillArea(int tileId, int x1, int y1, int x2, int y2) {
    if (x1 == x2) {
      for (int i = y1; i < y2; i++) {
        map[i][x1] = tileId;
      }
    } else if (y1 == y2) {
      for (int i = x1; i < x2; i++) {
        map[y1][i] = tileId;
      }
    } else {
      for (int i = y1; i < y2; i++) {
        for (int j = x1; j < x2; j++) {
          map[i][j] = tileId;
        }
      }
    }
  }

  void importMap(String fileName) {
    Table table = loadTable("data/" + fileName + ".csv", "header");
    for (TableRow row : table.rows()) {
      int x = row.getInt("x");
      int y = row.getInt("y");
      int id = row.getInt("tileId");
      if (id != 999) {
      }
      map[y][x] = id;
    }
  }

  void export(String fileName) {
    Table export = new Table();
    export.addColumn("x");
    export.addColumn("y");
    export.addColumn("tileId");
    for (int r = 0; r < map.length; r++) {
      for (int c = 0; c < map[r].length; c++) {
        TableRow row = export.addRow();
        row.setInt("x", c);
        row.setInt("y", r);
        row.setInt("tileId", map[r][c]);
      }
    }
    saveTable(export, "data/" + fileName + ".csv");
  }
}

class Grid {
  PVector[] gridPos;
  int border, cols, rows; //border = spacing from edge, cols = number of collums, rows = vertical rows;
  Grid( int border, int cols, int rows) {
    this.border = border;
    this.cols = cols;
    this.rows = rows;
    setup();
  }

  void setup() {
    if (cols < 2 || rows < 0) {
      gridPos = new PVector[4];
      gridPos[0] = new PVector(border, border);
      gridPos[1] = new PVector(width-border, border);
      gridPos[2] = new PVector(border, height-border);
      gridPos[3] = new PVector(width-border, height-border);
    } else {
      gridPos = new PVector[(cols)*(rows)];
      int index = 0;
      for (int x = 0; x < cols; x ++) {

        for (int y = 0; y < rows; y++) {
          gridPos[index] = new PVector(border+(x*((width-(border*2))/(cols-1))), border+(y*((height-(border*2))/(rows-1))));
          index ++;
        }
      }
    }
  }

  PVector findGrid(int bias) {
    int choice;
    if (bias == -1) {
      choice = int(random(0, gridPos.length/cols));
      gridPos[choice].set(gridPos[choice].x, gridPos[choice].y, -1);
      return(gridPos[choice]);
    } else if (bias == 1) {
      choice = int(random((cols-1)*gridPos.length/cols, gridPos.length/cols)); 
      //checkCorner(gridPos[choice]);
      gridPos[choice].set(gridPos[choice].x,gridPos[choice].y,1);
      return(gridPos[choice]);
    } else if (bias == -2) {
      int[] random = new int[rows];
      for (int x = 0; x < rows; x ++) {
        random[x] = x*cols;
      }
      choice = random[int(random(0, random.length))];
      //checkCorner(gridPos[choice]);
      gridPos[choice].set(gridPos[choice].x,gridPos[choice].y,-2);
      return(gridPos[choice]);
    } else if (bias == 2) {
      int[] random = new int[rows];
      for (int x = 0; x < rows; x ++) {
        random[x] = (cols-1)+x*cols;
      }
      choice = random[int(random(0, random.length))];
      //checkCorner(gridPos[choice]);
      gridPos[choice].set(gridPos[choice].x,gridPos[choice].y,-2);
      return(gridPos[choice]);
    } else {
      choice = int(random(0, gridPos.length)); 
      //checkCorner(gridPos[choice]);
      gridPos[choice].set(gridPos[choice].x,gridPos[choice].y,0);
      return(gridPos[choice]);
    }
  }

  void draw() {
    for (PVector pos : gridPos) {
      fill(brightest);
      ellipse(pos.x, pos.y, 20, 20);
    }
  }
}

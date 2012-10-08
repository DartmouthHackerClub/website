int gridWidth;
int gridHeight;
int cellWidth = 16;
int cellHeight = cellWidth;
int[][] grid;
color alive = color(0, 255, 0);
color dead = color(0);
int lastTime = 0;
boolean active = true;
int fadeSteps = 20;

var changelist = [];

jQuery(window).resize(function(e) {
    setCanvasDimensions();
    resizeGrid();
    });

void setup() {
  setCanvasDimensions();
  background(dead);
  reset();

  gridWidth = round(width / cellWidth);
  gridHeight = round(height / cellHeight);
  if (gridWidth < 13) {
    cellWidth = width / 15;
    gridWidth = 15;
  }
  if (gridHeight < 37) {
    cellHeight = height / 39;
    gridHeight = 39;
  }
  grid = new int[gridHeight][gridWidth];

  // glider gun
  int xcenter = floor((gridWidth - 13) / 4);
  int ycenter = floor((gridHeight - 37) / 4);

  grid[ycenter][xcenter+2]=fadeSteps;
  grid[ycenter][xcenter+3]=fadeSteps;
  grid[ycenter+1][xcenter+2]=fadeSteps;
  grid[ycenter+1][xcenter+3]=fadeSteps;
  grid[ycenter+8][xcenter+3]=fadeSteps;
  grid[ycenter+8][xcenter+4]=fadeSteps;
  grid[ycenter+9][xcenter+2]=fadeSteps;
  grid[ycenter+9][xcenter+4]=fadeSteps;
  grid[ycenter+10][xcenter+2]=fadeSteps;
  grid[ycenter+10][xcenter+3]=fadeSteps;
  grid[ycenter+16][xcenter+4]=fadeSteps;
  grid[ycenter+16][xcenter+5]=fadeSteps;
  grid[ycenter+16][xcenter+6]=fadeSteps;
  grid[ycenter+17][xcenter+4]=fadeSteps;
  grid[ycenter+18][xcenter+5]=fadeSteps;
  grid[ycenter+22][xcenter+1]=fadeSteps;
  grid[ycenter+22][xcenter+2]=fadeSteps;
  grid[ycenter+23][xcenter+0]=fadeSteps;
  grid[ycenter+23][xcenter+2]=fadeSteps;
  grid[ycenter+24][xcenter+0]=fadeSteps;
  grid[ycenter+24][xcenter+1]=fadeSteps;
  grid[ycenter+24][xcenter+12]=fadeSteps;
  grid[ycenter+24][xcenter+13]=fadeSteps;
  grid[ycenter+25][xcenter+12]=fadeSteps;
  grid[ycenter+25][xcenter+14]=fadeSteps;
  grid[ycenter+26][xcenter+12]=fadeSteps;
  grid[ycenter+34][xcenter]=fadeSteps;
  grid[ycenter+34][xcenter+1]=fadeSteps;
  grid[ycenter+35][xcenter]=fadeSteps;
  grid[ycenter+35][xcenter+1]=fadeSteps;
  grid[ycenter+35][xcenter+7]=fadeSteps;
  grid[ycenter+35][xcenter+8]=fadeSteps;
  grid[ycenter+35][xcenter+9]=fadeSteps;
  grid[ycenter+36][xcenter+7]=fadeSteps;
  grid[ycenter+37][xcenter+8]=fadeSteps;

  /*
  // f-pentomino
  int xcenter = round((gridWidth / 2)) - 1;
  int ycenter = round((gridHeight / 2)) - 1;
  grid[ycenter][xcenter] = 1;
  grid[ycenter+1][xcenter] = 1;
  grid[ycenter-1][xcenter] = 1;
  grid[ycenter-1][xcenter+1] = 1;
  grid[ycenter][xcenter-1] = 1;
   */
}

function resizeGrid() {
  gridWidth = round(width / cellWidth);
  gridHeight = round(height / cellHeight);
  newGrid = new int[gridHeight][gridWidth];
  for (int y=0; y < gridHeight; y++) {
    for (int x=0; x < gridWidth; x++) {
      if (grid[y] != null && grid[y][x] != null)
        newGrid[y][x] = grid[y][x];
      else
        newGrid[y][x] = 0;
    }
  }
  grid = newGrid;
}

void update() {     
  int[][] next_grid = new int[gridHeight][gridWidth];
  for (int y=0; y < gridHeight; y++) {
    for (int x=0; x < gridWidth; x++) {
      next_grid[y][x] = life(x, y); 
      if (grid[y][x] != next_grid[y][x]) {
        changelist.push([x, y]);
      }
    }
  }
  arrayCopy(next_grid, grid);
}

void reset() {
  for (y=0; y < gridHeight; y++) {
    for (x=0; x < gridWidth; x++) {
      grid[y][x] = 0;
    }
  }
}

function setCanvasDimensions() {
  setupHeight = jQuery("#hero").height();
  setupWidth = jQuery("#hero").width();
  jQuery("#life").width(setupWidth);
  jQuery("#life").height(setupHeight);
  size(setupWidth, setupHeight);
}

void draw() {      

  if (mousePressed && mouseButton == LEFT) {
    mousePressed();
  }    

  int currentTime = millis();    
  if ((currentTime > lastTime + 40) && active) {
    update();
    lastTime = currentTime;

    for (var i in changelist) {
      coords = changelist[i];
      x = coords[0];
      y = coords[1];
      fill(lerpColor(dead, alive, float(grid[y][x]) / float(fadeSteps)));
      stroke(lerpColor(dead, alive, float(grid[y][x]) / float(fadeSteps)));
      rect(x * cellWidth, y * cellHeight, cellWidth, cellHeight);
    }
    changelist = [];
  }
}

int life(x, y) {
  cell = grid[y][x];
  neighbors = get_neighbors(x, y);
  if (cell == fadeSteps) {
    if (neighbors.length < 2) {
      return cell - 1;
    } else if ((neighbors.length == 2) || (neighbors.length == 3)) {
      return fadeSteps;
    } else {
      return cell - 1;
    }
  } else {
    if (neighbors.length == 3) {
      return fadeSteps;
    } else {
      return max(0, cell - 1);
    }
  }    
}

function get_neighbors(x, y) {
  neighbors = [];
  for (dx = -1; dx <= 1; dx++) {
    for (dy = -1; dy <= 1; dy++) {
      x_query = x + dx;
      if (x_query < 0) {
        // wrap around to other side
        x_query = gridWidth - 1;
      } else if (x_query >= gridWidth) {
        x_query = 0;
      }
      y_query = y + dy;            
      if (y_query < 0) {
        // wrap around to other side
        y_query = gridHeight - 1;
      } else if (y_query >= gridHeight) {
        y_query = 0;
      }

      if (x_query == x && y_query == y) {
        continue;
      }

      if (grid[y_query][x_query] == fadeSteps) {
        neighbors.push(grid[y_query][x_query]);
      }
    }
  }
  return neighbors;
}

void mousePressed() {
  if (mouseButton == LEFT) {
    x = int(mouseX / cellWidth);
    y = int(mouseY / cellHeight);
    if (grid[y][x] < fadeSteps) {            
      grid[y][x] = fadeSteps;
    } else {
      grid[y][x] = 0;
    }
  } else if (mouseButton == CENTER) {
    reset();
  } else {
    active = !active;
  }
}

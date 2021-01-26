//Represents the grid of cells composing the Game of Life
class Grid {

  Cell[][] grid;  //2D array of cells
  int size;  //the size of this array
  
  //constructor of the Grid with the given size
  Grid(int s){
    this.size = s;
    grid = new Cell[size][size];
    
    for(int i = 0; i < this.size; i++){
      for(int j = 0; j < this.size; j++){
        grid[i][j] = new Cell();  //each cell is instantiated as a dead cell
      }
    }
  }

  //dispose random live cells on the grid
  void populate(){
    for(int i = 0; i < size; i++){
      for(int j = 0; j < size; j++){
        grid[i][j].alive = (random(0,1) > 0.79)? true : false;  //the 0.79 can be tweaked to increase or decrease the probability of live cell appearance
      }
    }
  }

  //shows the grid of cells onto the screen
  void show(){
    for(int i = 0; i < this.size; i++){
      for(int j = 0; j < this.size; j++){
        grid[i][j].show(j * (width/this.size), i * (height/this.size) , height/this.size - 1);    
      }
    }
  }
  
  //updates the state of the grid
  void update(){
    Grid tmp = new Grid(size);  //it is very important to compute the next step in another Grid in order to prevent the corruption of the actual grid
    
    for(int i = 0; i < size; i++){
      for(int j = 0; j < size; j++){
        int neighbours = countNeighbours(i,j);  //for each cell we count the number of neighbours (maximum = 8)
        tmp.grid[i][j] = new Cell(rule(grid[i][j].alive, neighbours));  //we compute the result according to the rule function and we store the data in the temporary grid
      }
    }
    
    //here we update the state of each cell of the actual grid
    for(int i = 0; i < size; i++){
      for(int j = 0; j < size; j++){
        grid[i][j] = tmp.grid[i][j];
      }
    }
  }
  
  //simply counts the number of neighbours for the given cell, including limit cells in the grid
  int countNeighbours(int i, int j){
    int neighbours = 0;
    
    //top left corner
    if(i == 0 && j == 0){
      neighbours += (grid[i][j+1].alive)?1:0;
      neighbours += (grid[i+1][j+1].alive)?1:0;
      neighbours += (grid[i+1][j].alive)?1:0;
      
      return neighbours;
    }
    
    //top right corner
    if(i == 0 && j == size - 1){
      neighbours += (grid[i][j-1].alive)?1:0;
      neighbours += (grid[i+1][j-1].alive)?1:0;
      neighbours += (grid[i+1][j].alive)?1:0;
      
      return neighbours;
    }
    
    //top raw (except corners)
    if(i == 0 && j > 0 && j < size - 1){
      neighbours += (grid[i][j-1].alive)?1:0;
      neighbours += (grid[i+1][j-1].alive)?1:0;
      neighbours += (grid[i+1][j].alive)?1:0;
      neighbours += (grid[i+1][j+1].alive)?1:0;
      neighbours += (grid[i][j+1].alive)?1:0;
      
      return neighbours;
    }
    
    //left column (except corners)
    if(i > 0 && i < size - 1 && j == 0){
      neighbours += (grid[i-1][j].alive)?1:0;
      neighbours += (grid[i-1][j+1].alive)?1:0;
      neighbours += (grid[i][j+1].alive)?1:0;
      neighbours += (grid[i+1][j+1].alive)?1:0;
      neighbours += (grid[i+1][j].alive)?1:0;
      
      return neighbours;
    }
    
    //right column (except corners)
    if(i > 0 && i < size - 1 && j == size - 1){
      neighbours += (grid[i-1][j].alive)?1:0;
      neighbours += (grid[i-1][j-1].alive)?1:0;
      neighbours += (grid[i][j-1].alive)?1:0;
      neighbours += (grid[i+1][j-1].alive)?1:0;
      neighbours += (grid[i+1][j].alive)?1:0;
      
      return neighbours;
    }
    
    //bottom left corners
    if(i == size - 1 && j == 0){
      neighbours += (grid[i-1][j].alive)?1:0;
      neighbours += (grid[i-1][j+1].alive)?1:0;
      neighbours += (grid[i][j+1].alive)?1:0;
      
      return neighbours;
    }
    
    //bottom raw (except corners)
    if(i == size - 1 && j > 0 && j < size - 1){
      neighbours += (grid[i][j-1].alive)?1:0;
      neighbours += (grid[i-1][j-1].alive)?1:0;
      neighbours += (grid[i-1][j].alive)?1:0;
      neighbours += (grid[i-1][j+1].alive)?1:0;
      neighbours += (grid[i][j+1].alive)?1:0;
      
      return neighbours;
    }
    
    //bottom right corner
    if(i == size - 1 && j == i){
      neighbours += (grid[i][j-1].alive)?1:0;
      neighbours += (grid[i-1][j-1].alive)?1:0;
      neighbours += (grid[i-1][j].alive)?1:0;
      
      return neighbours;
    }
    
    //the rest (everything except borders)
    neighbours += (grid[i-1][j-1].alive)?1:0;
    neighbours += (grid[i-1][j].alive)?1:0;
    neighbours += (grid[i-1][j+1].alive)?1:0;
    neighbours += (grid[i][j-1].alive)?1:0;
    neighbours += (grid[i][j+1].alive)?1:0;
    neighbours += (grid[i+1][j-1].alive)?1:0;
    neighbours += (grid[i+1][j].alive)?1:0;
    neighbours += (grid[i+1][j+1].alive)?1:0;
    
    return neighbours;
    
  }
  
  //this function corresponds to the basic rule of the Game of Life
  //a live cell stays alive if it is surrounded by 2 or 3 live cells, otherwise it dies
  //birth occurs if a dead cell is surrounded by exactly 3 live cells, otherwise it remains dead 
  boolean rule(boolean state, int neighbours){
    if(state){
      return (neighbours == 2 || neighbours == 3);
    } else {
      return (neighbours == 3);
    }
  }
  
  //checks if the grid only contains dead cells
  boolean isEmpty(){
    for(int i = 0; i < size; i++){
      for(int j = 0; j < size; j++){
        if(grid[i][j].alive) return false;
      }
    } return true;
  }
}

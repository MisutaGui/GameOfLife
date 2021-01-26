//Represents a cell with 2 possible states: dead or alive
class Cell{
 
  boolean alive = false;  //by default, a cell is dead
  
  //shows the cell onto the screen
  void show(int x, int y, int length){
    if(alive){
      stroke(0);
      fill(0);
    } else {
      noStroke();
      fill(255);
    }
    square(x,y,length);
  }
  
  //needed constructor at some point
  Cell(){}
  
  //another constructor needed at some point
  Cell(boolean state){
    alive = state;
  }
  
  //and an another one
  Cell(Cell cell){
    alive = cell.alive;
  }
}

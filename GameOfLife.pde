/*
A simple code for the Conway's Game of Life
Enjoy trying to find some cool patterns :)

Guillermo
GitHub : @MisutaGui
*/

Grid grid; //grid declaration
int acc;  //variable used for image update. The draw function has an update rate of 30updates per second, this program is set up to be updated 3 times per second

void settings(){
  size(1000,1000); //window size (make sure its a square...)
  grid = new Grid(200);  //the parameter corresponds to the number of cells in a row (and a column!)
  acc = 0;  //initialization of the accumulator to 0
  grid.populate();  //random generation of living cells
}

void draw(){
  acc++;  //each time draw() is called, we increase the accumulator
  background(255);  //white background
  if(acc >= 10) { grid.update(); acc = 0; }  //update of the grid every 0.34 seconds
  grid.show();  //shows the grid onto the screen
  if(grid.isEmpty())System.exit(1);  //if the grid becomes empty at some point the program stops
}

/*
---------------- KNOWN PATTERNS ----------------

Here you can find on the Internet known patterns and explore them.
I admit the patterns can be implemented much better hehehe...

*/

//still life, it is simply a 2x2 square of living cells
Grid loadBoat(){
  Grid grid = new Grid(4);
  grid.grid[1][1].alive = true;
  grid.grid[1][2].alive = true;
  grid.grid[2][1].alive = true;
  grid.grid[2][2].alive = true;
  return grid;
}

//Globals for gui
int WIN_HEIGHT = 640, WIN_WIDTH = 360;


Robot rob = new Robot();

void setup()
{
  size(640, 360);
  
  startX = width/4 - startSize;
  startY = height*3/4;
  
  modeX = width/2 - startSize;
  modeY = height*3/4;
  
  ellipseMode(CENTER);
}

void draw()
{
  
  background(currentColor);
  rob.update();
  update();
  if(startOver){
    fill(startHigh);
  }
  else
  {
   fill(startColor); 
  }
  
  stroke(255);
  rect(startX, startY, startSize, startSize);
  
  if(modeOver){
    fill(modeHigh);
  }
  else
  {
   fill(modeColor); 
  }
  
  stroke(255);
  rect(modeX, modeY, modeSize, modeSize);
}

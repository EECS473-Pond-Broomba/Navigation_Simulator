import controlP5.*;

Robot rob;
ControlP5 cp5;
GeoFence gf;
FloodFill ff;

boolean startVal = false, modeVal = false;
float gf_rad = 150;

void setup()
{
  size(1000, 800);
  
  cp5 = new ControlP5(this);
  rob = new Robot();
  gf = new GeoFence();
  ff = new FloodFill(rob, gf);
  
  frameRate(120);
  
  gf.set_pos(200, 600, gf_rad);
  
  cp5.addToggle("startVal")
     .setPosition(50, height-75)
     .setSize(50, 50);

  cp5.addToggle("modeVal")
     .setPosition(150, height-75)
     .setSize(50,50);
    
}

void draw()
{
  if(startVal)
  {
    
  //rob.set_speed(1.5);
  //rob.set_bearing(270);
  ff.update();
  println("Target bearing: " + ff.targetBearing);
  println("Target X: " + ff.targetX + " Target Y: " + ff.targetY);
  ff.move();
  }
  
  else
  {
   rob.speed = 0; 
  }
  background(0, 200, 100);
   
   rectMode(CORNER);
   fill(100);
   rect(0, height - 100, width, 100); 
  
  gf.update();
  rob.update();
}

void mouseClicked()
{
  if(startVal)
  {
    return;
  }
 if(modeVal)
 {
  rob.setPosition(mouseX, mouseY); 
 }
 else
 {
   ff.updateGeofence(mouseX, mouseY, gf_rad);
 }
}

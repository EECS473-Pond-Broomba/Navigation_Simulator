import controlP5.*;

Robot rob;
ControlP5 cp5;

boolean startVal = false, modeVal = false;

void setup()
{
  size(1000, 800);
  
  cp5 = new ControlP5(this);
  rob = new Robot();
  
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
    
  rob.set_speed(1.5);
  rob.set_bearing(90);
  }
  
  else
  {
   rob.speed = 0; 
  }
  background(0, 200, 100);
   
   rectMode(CORNER);
   fill(100);
   rect(0, height - 100, width, 100); 
  rob.update();
}

void mouseClicked()
{
 if(modeVal)
 {
  rob.setPosition(mouseX, mouseY); 
 }
}

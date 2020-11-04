class Robot{
  color robot_color;
  float xpos, ypos;
  float speed, bearing;
  float speed_diff = 0.25, bearing_diff = 1;
  
  Robot(){
   robot_color = color(255);
   xpos = width/2;
   ypos = height/2;
   speed = 0;
   bearing = 0;
  }
  
  float inc_speed()
  {
    return speed += speed_diff;
  }
  
  float dec_speed()
  {
   return speed -= speed_diff; 
  }
  
  float rotateCC()
  {
     bearing += bearing_diff;

     if(bearing > 360)
     {
       bearing -= 360;
     }
     return bearing;
  }

  float rotateCCW()
  {
    bearing -= bearing_diff;

    if(bearing < 0)
    {
      bearing += 360;
    }

    return bearing;
  }

  void update()
  {
    pushMatrix();
    stroke(255);
    rotate(radians(bearing));
    fill(robot_color);
    rectMode(CENTER);
    rect(xpos, ypos, 10, 20);
    popMatrix();
  }
  
};

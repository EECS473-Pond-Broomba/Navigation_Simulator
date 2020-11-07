class Robot{
  color robot_color;
  float xPos, yPos;
  float speed, bearing;
  float speed_diff = 0.01, bearing_diff = 0.1;
  
  Robot(){
   robot_color = color(255);
   xPos = width/2;
   yPos = height/2;
   speed = 0;
   bearing = 0;
  }
  
  void set_speed(float s)
  {
   if(s > speed)
   {
       inc_speed();
   }
   else if(s < speed)
   {
      dec_speed(); 
   }
  }
  
  void set_bearing(float b)
  {
   if(b > 360)
   {
    b = 360; 
   }
   
   if(b > bearing)
   {
    rotateCW(); 
   }
   else if(b < bearing)
   {
     rotateCCW();
   }
  }
  
  void inc_speed()
  {
    speed += speed_diff;
  }
  
  void dec_speed()
  {
   speed -= speed_diff; 
  }
  
  void rotateCW()
  {
     bearing += bearing_diff;

     if(bearing > 360)
     {
       bearing -= 360;
     }
  }

  void rotateCCW()
  {
    bearing -= bearing_diff;

    if(bearing < 0)
    {
      bearing += 360;
    }
  }

  void update()
  {
    move();
    pushMatrix();
    stroke(255);
    translate(xPos, yPos);
    rotate(radians(bearing));
    fill(robot_color);
    rectMode(CENTER);
    rect(0, 0, 10, 20);
    popMatrix();
  }
  
  void move()
  {
   xPos = xPos + speed*sin(radians(bearing));
   yPos = yPos + speed*cos(radians(bearing));
  }
  
  void setPosition(int x, int y)
  {
   if(x > width)
   {
     x = width;
   }
   if(y > height)
   {
    y = height; 
   }
   
   xPos = x;
   yPos = y;
  }
  
};

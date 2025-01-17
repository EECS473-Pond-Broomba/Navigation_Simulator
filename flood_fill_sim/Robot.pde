class Robot{
  color robot_color;
  float xPos, yPos;
  float speed, bearing;
  float speed_diff = 0.5, bearing_diff = 1;
  
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
   if(b >= 360)
   {
    b -= 360; 
   }
   if(abs(bearing - b) < bearing_diff)
   {
    return; 
   }
   
   float b_diff = (b - bearing + 540)%360 -180;
   
   if(b_diff > 0)
   {
    rotateCW(); 
   }
   else
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

     if(bearing >= 360)
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
    rect(0, 0, 10, 10);
    popMatrix();
  }
  
  void move()
  {
   xPos = xPos + speed*sin(radians(bearing));
   yPos = yPos - speed*cos(radians(bearing));
   if(xPos > width)
   {
     xPos = width;
   }
   else if(xPos < 0)
   {
     xPos = 0;
   }
   
   if(yPos > height)
   {
      yPos = height;
   }
   else if(yPos < 0)
   {
    yPos = 0; 
   }
  }
  
  
  void setPosition(int x, int y)
  {
    
      if(y >= height -100)
      {
        return;
      }
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

class GUI{
  int startX, startY, modeX, modeY, startSize = 20, modeSize = 20;
  boolean startOver = false, modeOver = false;
  color startHigh = color(255), startColor = color(200), modeHigh = color(255), modeColor = color(200);
  color currentColor = color(100);
  
 void update()
{
   if(overCheck(startX, startY, startSize))
   {
    startOver = true;
    modeOver = false;
   }
   else if(overCheck(modeX, modeY, modeSize))
   {
     startOver = false;
     modeOver = true;
   }
}

void mousePressed()
{
 if(startOver)
 {
   currentColor = color(200);
 }
 else if(modeOver)
 {
  currentColor = color(50); 
 }
 else
 {
  currentColor = color(100); 
 }
}

boolean overCheck(int x, int y, int size)
{
  if(mouseX >= x && mouseX <= x+size && mouseY >= y && mouseY <= y+size)
  {
    return true; 
  }
  return false;
} 
}

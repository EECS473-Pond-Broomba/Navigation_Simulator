class Position{
    int xPos, yPos;

    Position(int xIn, int yIn) {
        xPos = xIn / stepSize;
        yPos = yIn / stepSize;
    }
    
    float getX()
    {
     return (float)(xPos + 0.5) * stepSize; 
    }
    
    float getY()
    {
     return (float)(yPos + 0.5) * stepSize; 
    }
    
    String getString()
    {
      return "X " + xPos + " Y " + yPos;
    }
};

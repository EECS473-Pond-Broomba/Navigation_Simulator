class GeoFence{
    float centerX, centerY;
    float radius;

    int in_fence(float x, float y)
    {
        float d = radius - sqrt(sq((centerX -x)) + sq((centerY - y)));

        if(d < -1)
        {
            return 0;
        }
        else if(d > 1)
        {
            return 1;
        }
        else
        {
            return -1;
        }
    }
    
    float get_dist(float x, float y)
    {
      return radius - sqrt(sq((centerX -x)) + sq((centerY - y)));
      
    }
    
    void set_pos(float x, float y, float rad)
    {
        centerX = x;
        centerY = y;
        radius = rad;
    }

    void update()
    {
        pushMatrix();
        stroke(255, 100, 0);
        fill(255, 0, 0);
        ellipseMode(CENTER);
        ellipse(centerX, centerY, radius, radius);
        popMatrix();
    }
};

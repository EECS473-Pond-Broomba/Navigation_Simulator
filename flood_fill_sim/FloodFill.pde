import java.util.HashSet;

class FloodFill{
    Robot robot;
    GeoFence activeGeofence;
    HashSet<Position> pos_set = new HashSet<Position>();
    float targetBearing;
    int stepSize;   // Simulation distance between adjacent points
    int targetX, targetY;
    // positions array keeps track of which places have been visited
    // int previousGeoFenceStatus;
    int currentGeoFenceStatus;
    // boolean direction;  // Stores what direction robot is moving in, true is moving "left"

    FloodFill(Robot robotIn, GeoFence gfIn) {
        robot = robotIn;
        activeGeofence = gfIn;
        stepSize = 10;      // Same width as robot
        targetX = -1;
        targetY = -1;
        // previousGeoFenceStatus = 0;
        // currentGeoFenceStatus = 0;
    }

    void updateGeofence(float x, float y, float radius) {
        activeGeofence.set_pos(x, y, radius);
    }
    
    int num_visited_adj_block(Position p)
    {
      int val = 0;
      Position pos = new Position(p.xPos-stepSize, p.yPos);
      if(pos_set.contains(pos))
      {
        val++;
      }
      
      pos = new Position(p.xPos, p.yPos - stepSize);
      if(pos_set.contains(pos))
      {
       val++; 
      }
      
      pos = new Position(p.xPos, p.yPos + stepSize);
      if(pos_set.contains(pos))
      {
       val++; 
      }
      
      pos = new Position(p.xPos + stepSize, p.yPos);
      if(pos_set.contains(pos))
      {
       val++; 
      }
      
      return val;
    }

    float distanceBetweenPoints(float x1, float x2, float y1, float y2) {
        return sqrt(sq((x1 -x2)) + sq((y1 - y2)));
    }
    
    int calculateWeight(Position p)
    {
      int score = 0;
      int gfStatus = activeGeofence.in_fence(p.xPos, p.yPos);
      
      if(pos_set.contains(p) || gfStatus == 0)
      {
        return -1;
      }
      if(gfStatus == 1)
      {
        score++; 
      }
      
      float dist_edge = activeGeofence.get_dist(p.xPos, p.yPos);
      
      if(dist_edge <= 10)
      {
       score += 2; 
      }
      
      score += num_visited_adj_block(p);
      return score;
    }
    
    boolean checkPos()
    {
      if(targetX == -1 && targetY == -1)
      {
        return true;
      }
      int xDiff = abs((int)(targetX - rob.xPos));
      int yDiff = abs((int)(targetY - rob.yPos));
           
      
      if(xDiff > stepSize || yDiff > stepSize)
      {
        targetBearing =180 - (degrees(atan((targetX - robot.xPos)/(targetY - robot.yPos))));
                
                if(robot.yPos > activeGeofence.centerY)
                {
                  targetBearing -= 180;
                }

               if(targetBearing <0)
               {
                targetBearing += 360; 
               }
        return false;
      }
      return true;
    }

    void update() {
        Position nextPosition[] = new Position[4];
        // previousGeoFenceStatus = currentGeoFenceStatus;
        currentGeoFenceStatus = activeGeofence.in_fence(robot.xPos, robot.yPos);
        println("Geofence Status: " + currentGeoFenceStatus);
        // If robot is in geofence
        if(currentGeoFenceStatus != 0) {
           if(!checkPos())
           {
            return; 
           }
            // Do flood fill algorithm
            // Mark position as visited
            // Add 4 neighbors to list of possible next step
            nextPosition[0] = new Position((int)robot.xPos, (int)robot.yPos-stepSize);
            nextPosition[1] = new Position((int)robot.xPos+stepSize, (int)robot.yPos);
            nextPosition[2] = new Position((int)robot.xPos, (int)robot.yPos+stepSize);
            nextPosition[3] = new Position((int)robot.xPos-stepSize, (int)robot.yPos);

            // For each possible neighbor, determine if it is within the map and geofence
            int maxWeight = -1, max_idx = 0;
            for(int i = 0; i < 4; ++i) {

                int weight = calculateWeight(nextPosition[i]);
                if(weight > maxWeight)
                {
                  maxWeight = weight;
                  max_idx = i;
                }
            }

            // TODO: If weight is positive, go to point
            if(maxWeight > 0) {
                targetX = nextPosition[max_idx].xPos;
                targetY = nextPosition[max_idx].yPos;
                pos_set.add(new Position(targetX, targetY));
                targetBearing =180 - (degrees(atan((targetX - robot.xPos)/(targetY - robot.yPos))));
                
                if(robot.yPos > activeGeofence.centerY)
                {
                  targetBearing -= 180;
                }

             if(targetBearing <0)
             {
              targetBearing += 360; 
             }
            }
            // TODO: If weight is negative, go towards center of geofence
            else {

            }
            // TODO: HOW DO WE FIGURE OUT WHEN GEOFENCE IS DONE
        }
        // If robot not in geofence
        else {            
            // Move robot in direction of center of geofence
             targetBearing = 180 - (degrees(atan((activeGeofence.centerX - robot.xPos)/(activeGeofence.centerY - robot.yPos))));
             if(robot.yPos > activeGeofence.centerY)
                {
                  targetBearing -= 180;
                }
             if(targetBearing <0)
             {
              targetBearing += 360; 
             }
          
            
        }
    }
    
    void move()
    {
      println("Robot bearing: " + robot.bearing);
     if(abs(robot.bearing - targetBearing) < 2) {
                robot.set_speed(1);
            }
            else {
                robot.set_speed(0);
                robot.set_bearing(targetBearing);
            } 
    }
    
};

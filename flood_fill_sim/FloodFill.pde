import java.util.HashSet;

class FloodFill{
    Robot robot;
    GeoFence activeGeofence;
    HashSet<Position> pos_set = new HashSet<Position>();
    float targetBearing;
    int stepSize;   // Simulation distance between adjacent points
    int targetX, targetY;
    // positions array keeps track of which places have been visited
    boolean[][] positions = new boolean[80][100];   // Screen size divided by step size
    // int previousGeoFenceStatus;
    int currentGeoFenceStatus;
    // boolean direction;  // Stores what direction robot is moving in, true is moving "left"

    FloodFill(Robot robotIn, GeoFence gfIn) {
        robot = robotIn;
        activeGeofence = gfIn;
        stepSize = 10;      // Same width as robot
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

    void update() {
        Position nextPosition[] = new Position[4];
        // previousGeoFenceStatus = currentGeoFenceStatus;
        currentGeoFenceStatus = activeGeofence.in_fence(robot.xPos, robot.yPos);
        // If robot is in geofence
        if(currentGeoFenceStatus == 1) {
            // Do flood fill algorithm
            // Mark position as visited
            positions[(int)robot.yPos / stepSize][(int)robot.xPos / stepSize] = true;
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
                targetBearing = (degrees(atan2(targetX - robot.yPos, targetX - robot.xPos)) - 90) % 360;
            }
            // TODO: If weight is negative, go towards center of geofence
            else {

            }
            // TODO: HOW DO WE FIGURE OUT WHEN GEOFENCE IS DONE
        }
        // If robot not in geofence
        else if(currentGeoFenceStatus == -1) {            
            // Move robot in direction of center of geofence
             targetBearing = (degrees(atan2(activeGeofence.centerY - robot.yPos, activeGeofence.centerX - robot.xPos)) - 90) % 360;
            // Only drive forward if the error in bearing is less than 5 deg
            
        }
        //If unknown
        else {
            // What is the right behavior for unknown geofence status?
            // Should we maybe keep a history of status?
        }
    }
    
    void move()
    {
     if(abs(robot.bearing - targetBearing) < 2.5) {
                robot.set_speed(1.0);
            }
            else {
                robot.set_bearing(targetBearing);
            } 
    }
    
};

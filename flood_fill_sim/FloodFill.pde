class FloodFill{
    Robot robot;
    GeoFence activeGeofence;
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

    float distanceBetweenPoints(float x1, float x2, float y1, float y2) {
        return sqrt(sq((x1 -x2)) + sq((y1 - y2)));
    }

    void update() {
        Position nextPosition[4];
        // previousGeoFenceStatus = currentGeoFenceStatus;
        currentGeoFenceStatus = activeGeofence.in_fence(robot.xPos, robot.yPos);
        // If robot is in geofence
        if(currentGeoFenceStatus == 1) {
            // Do flood fill algorithm
            // Mark position as visited
            positions[(int)robot.yPos / stepSize][(int)robot.xPos / stepSize] = true;
            // Add 4 neighbors to list of possible next step
            nextPosition[0] = Position((int)robot.xPos, (int)robot.yPos-stepSize, distanceBetweenPoints(activeGeofence.centerX, (int)robot.xPos, activeGeofence.centerY, (int)robot.yPos - stepSize), positions[((int)robot.yPos - stepSize) / stepSize][(int)robot.xPos / stepSize]);
            nextPosition[1] = Position((int)robot.xPos+stepSize, (int)robot.yPos, distanceBetweenPoints(activeGeofence.centerX, (int)robot.xPos + stepSize, activeGeofence.centerY, (int)robot.yPos), positions[((int)robot.yPos) / stepSize][((int)robot.xPos + stepSize) / stepSize]);
            nextPosition[2] = Position((int)robot.xPos, (int)robot.yPos+stepSize, distanceBetweenPoints(activeGeofence.centerX, (int)robot.xPos, activeGeofence.centerY, (int)robot.yPos + stepSize), positions[((int)robot.yPos + stepSize) / stepSize][(int)robot.xPos / stepSize]);
            nextPosition[3] = Position((int)robot.xPos-stepSize, (int)robot.yPos, distanceBetweenPoints(activeGeofence.centerX, (int)robot.xPos - stepSize, activeGeofence.centerY, (int)robot.yPos), positions[((int)robot.yPos) / stepSize][((int)robot.xPos - stepSize) / stepSize]);

            // For each possible neighbor, determine if it is within the map and geofence
            for(int i = 0; i < 4; ++i) {
                // If visited or out of map or out of geofence, set weight to -1
                if( nextPosition[i].visited ||
                    nextPosition[i].xPos < 0 || nextPosition[i].xPos >= 1000 ||
                    nextPosition[i].yPos < 0 || nextPosition[i].yPos >= 800 ||
                    nextPosition[i].weight > activeGeofence.radius) {
                        nextPosition[i].weight = -1
                }
            }

            // Find max weight and go to that one
            float maxWeight = nextPosition[i].weight;
            int maxIndex = 0;
            for(int i = 0; i < 4; ++i) {
                if(nextPosition[i].weight > maxWeight) {
                    maxIndex = i;
                    maxWeight = nextPosition[i].weight;
                }
            }

            // TODO: If weight is positive, go to point
            if(maxWeight > 0) {
                targetX = nextPosition[maxIndex].xPos;
                targetY = nextPosition[maxIndex].yPos;
            }
            // TODO: If weight is negative, go towards center of geofence
            else {

            }
            // TODO: HOW DO WE FIGURE OUT WHEN GEOFENCE IS DONE
        }
        // If robot not in geofence
        else if(currentGeoFenceStatus == -1) {            
            // Move robot in direction of center of geofence
            float targetBearing = (degrees(atan2(activeGeofence.centerY - robot.yPos, activeGeofence.centerX - robot.xPos)) - 90) % 360;
            // Only drive forward if the error in bearing is less than 5 deg
            if(abs(robot.bearing - targetBearing) < 5) {
                robot.set_speed(1.0);
            }
            else {
                robot.set_bearing(targetBearing);
            }
        }
        //If unknown
        else {
            // What is the right behavior for unknown geofence status?
            // Should we maybe keep a history of status?
        }
    }
};

class Position{
    int xPos, yPos;
    float weight;
    boolean visited;

    Position(int xIn, int yIn, float weightIn, boolean visitedIn) {
        xPos = xIn;
        yPos = yIn;
        weight = weightIn;
        visited = visitedIn;
    }
};
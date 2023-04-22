public class Coord {
    int x;
    int y;

    public Coord(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public Coord(float fx, float fy) {
        this.x = vectorToCoord(fx, Floor.UNIT);
        this.y = vectorToCoord(fy, Floor.UNIT);
    }

    /*
        Euclidean Distance
        d = ((x1-x2)^2+(y1-y2)^2)^0.5
    */
    public float euDistance(Coord c2) {
        return sqrt(pow(x - c2.x, 2) + pow(y - c2.y, 2));
    }

    /*
        Mahanttan Distance
    */
    public int manDistance(Coord c2) {
        return abs(x - c2.x) + abs(y - c2.y);
    }

    public Coord add(int x, int y) {
        return new Coord(this.x + x, this.y + y);
    }

    public boolean equals(Coord c2) {
        return x == c2.x && y == c2.y;
    }

        
    public int vectorToCoord(float v, float unit) {
        float cv = v / unit;
        if (cv >= 0) return (int)cv;
        else if (cv % 1.0 == 0.0) return (int)cv;
        else return (int)cv - 1;
    }


    @Override
    public String toString() {
        return "(" + x + "," + y + ")";
    }
}

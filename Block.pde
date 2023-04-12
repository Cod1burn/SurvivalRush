public class Block {
    Coord coord;
    Floor[][] floors;
    int w, h;

    public Block(int template) {
        loadMapFromTemplate(template);
    }

    void loadMapFromTemplate(int num) {
        String filename = "MapTemplates/Map" + template + ".txt";
        String[] floorStrings = loadStrings(filename);
        w = floorStrings[0].length();
        h = floorStrings.length();
        floors = new Floor[h][w];
        for (int i = 0; i < h; ++i) {
            for (int j = 0; j < w; ++j) {
                Coord c = new Coord(j, i);
                switch (floorStrings[i].charAt(j)) {
                    case '1' :
                        floors[i][j] = new Floor(c, true);
                    break;

                    case '0' :
                        floors[i][j] = new Floor(c, false);
                    break;

                    default :
                    break;	
                }
            }
        }
    }

    Floor getFloor(int cx, int cy) {
        if (cy >= 0 && cy < floors.length && cx >= 0 && cx < floors[0].length) {
            return floors[cy][cx];
        } else {
            return null;
        }
    } 
}
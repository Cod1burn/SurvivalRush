public class Block {
    Coord coord;
    Floor[][] floors;

    public Block(int template) {
        loadMapFromTemplate(template);
    }

    void loadMapFromTemplate(int num) {
        floors = new Floor[10][10];
        String filename = "MapTemplates/Map" + template + ".txt";
        String[] floorStrings = loadStrings(filename);
        for (int i = 0; i < floorStrings.length; ++i) {
            for (int j = 0; j < floorStrings[i].length(); ++j) {
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
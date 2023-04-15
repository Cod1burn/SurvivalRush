public class Block {
    Floor[][] floors;
    int w, h;

    public Block(int template) {
        loadMapFromTemplate(template);
    }

    void draw() {
        for (Floor[] col : floors) {
            for (Floor f : col) {
                f.draw();
            }
        }
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
                        PImage img = loadImage("MapImgs/Map" + num + "/BlockedFloor.png");
                        floors[i][j] = new Floor(c, true, img);
                    break;

                    case '0' :
                        PImage img = loadImage("MapImgs/Map" + num + "/Map_img_" + j + "" + i + ".png");
                        floors[i][j] = new Floor(c, false, img);
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
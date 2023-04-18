public class Block {
    Floor[][] floors;
    int w, h;
    PImage img;

    public Block(int template) {
        loadMapFromTemplate(template);
    }

    void draw() {
        image(img, 0, 0);
        for (Floor[] fs: floors) {
            for (Floor f: fs) {
                f.draw();
            }
        }
    }

    void loadMapFromTemplate(int num) {
        img = loadImage("MapImgs/Map" + num +"/wholemap.jpg");

        String filename = "MapTemplates/Map" + num + ".txt";
        String[] floorStrings = loadStrings(filename);
        w = floorStrings[0].length();
        h = floorStrings.length;
        floors = new Floor[h][w];
        for (int i = 0; i < h; ++i) {
            for (int j = 0; j < w; ++j) {
                Coord c = new Coord(j, i);
                PImage img;
                switch (floorStrings[i].charAt(j)) {
                    case '1' :
                        PImage blockedImg = loadImage("MapImgs/Map" + num + "/BlockedFloor.png");
                        Floor f = new Floor(c, true);
                        f.setBlockedImg(blockedImg);
                        floors[i][j] = f;
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
            println("Invalid coordinates: " + cx + "," + cy);
            return null;
        }
    } 
}

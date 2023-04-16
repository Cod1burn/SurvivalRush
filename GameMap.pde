public class GameMap {
    Block block;
    PVector camera;
    Player player;

    public GameMap(int template) {
        block = new Block(template);
        camera = new PVector(400,400);
    }

    void setPlayer(Player player) {
        this.player = player;
    }

    void draw() {
        camera.x %= block.w * Floor.UNIT;
        camera.x = camera.x < 0 ? block.w * Floor.UNIT + camera.x : camera.x;
        camera.y %= block.h * Floor.UNIT;
        camera.y = camera.y < 0 ? block.h * Floor.UNIT + camera.y : camera.y;

        pushMatrix();
        translate(-camera.x, -camera.y);
        translate(width/2, height/2);
        block.draw();
        // Left leave blank
        if (width/2 - camera.x > 0) {
            pushMatrix();
            translate(-block.w * Floor.UNIT, 0);
            block.draw();
            // Left-Bottom leave blank
            if (height/2 - camera.y > 0) {
                pushMatrix();
                translate(0, -block.h * Floor.UNIT);
                block.draw();
                popMatrix();
            }
            
            // Left-Top leave blank
            if (block.h * Floor.UNIT - camera.y  < height/2) {
                pushMatrix();
                translate(0, block.h * Floor.UNIT);
                block.draw();
                popMatrix();
            }
            popMatrix();
        }
         
        // Right leave blank
        if (block.w * Floor.UNIT - camera.x  < width/2) {
            pushMatrix();
            translate(block.w * Floor.UNIT, 0);
            block.draw();

            // Right-Bottom leave blank
            if (height/2 - camera.y > 0) {
                pushMatrix();
                translate(0, -block.h * Floor.UNIT);
                block.draw();
                popMatrix();
            }
            
            // Right-Top leave blank
            if (block.h * Floor.UNIT - camera.y  < height/2) {
                pushMatrix();
                translate(0, block.h * Floor.UNIT);
                block.draw();
                popMatrix();
            }
            popMatrix();
        }

        // Bottom leave blank
        if (height/2 - camera.y > 0) {
            pushMatrix();
            translate(0, -block.h * Floor.UNIT);
            block.draw();
            popMatrix();
        }
         
        // Top leave blank
        if (block.h * Floor.UNIT - camera.y  < height/2) {
            pushMatrix();
            translate(0, block.h * Floor.UNIT);
            block.draw();
            popMatrix();
        }

        popMatrix();
        player.draw();

    }

    boolean canBeEntered(int cx, int cy) {
        cx %= block.w;
        cx = cx < 0 ? block.w + cx : cx;

        cy %= block.h;
        cy = cy < 0 ? block.h + cy : cy;

        return !block.getFloor(cx, cy).blocked;
    }

    void updateCamera(PVector position) {
        this.camera = position.copy();
    }
}

public class GameMap {
    Block block;

    public GameMap(int template) {
        block = new Block(template);
    }

    void draw(PVector camera) {
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
    }

    boolean canBeEntered(int cx, int cy) {
        cx %= block.w;
        cx = cx < 0 ? block.w + cx : cx;

        cy %= block.h;
        cy = cy < 0 ? block.h + cy : cy;

        return !block.getFloor(cx, cy).blocked;
    }
    
}

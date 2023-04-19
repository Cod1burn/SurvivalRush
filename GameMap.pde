public class GameMap {
    Block block;
    float blockWidth, blockHeight;

    public GameMap(int template) {
        block = new Block(template);
        blockWidth = block.w * Floor.UNIT;
        blockHeight = block.h * Floor.UNIT;
    }

    void draw(PVector camera) {
        pushMatrix();
        translate(-camera.x, -camera.y);
        translate(width/2, height/2);
        block.draw();

            pushMatrix(); 
                translate(blockWidth, 0);
                block.draw();

                pushMatrix();
                    translate(0, blockHeight);
                    block.draw();
                popMatrix();

                pushMatrix();
                    translate(0, -blockHeight);
                    block.draw();
                popMatrix();
            popMatrix();

            pushMatrix(); 
                translate(-blockWidth, 0);
                block.draw();

                pushMatrix();
                    translate(0, blockHeight);
                    block.draw();
                popMatrix();

                pushMatrix();
                    translate(0, -blockHeight);
                    block.draw();
                popMatrix();
            popMatrix();

            pushMatrix(); 
                translate(0, blockHeight);
                block.draw();
            popMatrix();

            pushMatrix();
                translate(0, -blockHeight);
                block.draw();
            popMatrix();
            
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

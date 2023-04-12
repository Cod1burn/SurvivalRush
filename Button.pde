public class Button extends InteractableObject{
    int x;
    int y;
    int w;
    int h;
    String bText;
    int bgColor;
    boolean pressed;
    public Button(int x, int y, int w, int h, String bText){
        this.x = x - w/2;
        this.y = y - h/2;
        this.w = w;
        this.h = h;
        this.bText = bText;
        this.bgColor = 212;
        this.pressed = false;
        this.active = true;
    }

    void draw(){
        if (!active) return;
        int bColor = bgColor;
        if(contains(mouseX, mouseY)) {
            if(mousePressed) bColor = 255 - bColor;
            else bColor = max(0, bColor-30);
        }
        stroke(255 - bColor);
        fill(bColor);
        rect(x, y, w, h, min(w, h)/5);
        fill((1-bColor/128)*255);
        textAlign(CENTER,CENTER);
        int fontNum = min(w, h)/3;
        textSize(fontNum);
        text(bText, x + w/2, y + h/2 - fontNum/4);
    }
    
    boolean contains(int mx, int my) {
        return (mx >= x && mx <= x + w && my >= y && my <= y + h);
    }
}

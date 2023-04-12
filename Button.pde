public class Button extends InteractableObject{
    int x;
    int y;
    int width;
    int height;
    String bText;
    int bgColor;
    boolean mouseIn;
    boolean pressed;
    public Button(int x, int y, int w, int h, String bText){
        this.x = x - w/2;
        this.y = y - h/2;
        this.width = w;
        this.height = h;
        this.bText = bText;
        this.bgColor = 212;
        this.pressed = false;
        this.active = true;
    }

    void draw(){
        if (!active) return;
        int bColor = bgColor;
        if(isMouseIn(mouseX, mouseY)) {
            if(mousePressed) bColor = 255 - bColor;
            else bColor = max(0, bColor-30);
        }
        stroke(255 - bColor);
        fill(bColor);
        rect(x, y, width, height, min(width, height)/5);
        fill((1-bColor/128)*255);
        textAlign(CENTER,CENTER);
        int fontNum = min(width, height)/3;
        textSize(fontNum);
        text(bText, x + width/2, y + height/2 - fontNum/4);
    }
    
    boolean isMouseIn(int mx, int my){
        return (mx > x)&&(mx < x+width)&&(my > y)&&(my < y+height);
    }
}

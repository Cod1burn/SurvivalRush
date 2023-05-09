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
        fill(90,90,0);
        rect(x, y, w, h, min(w, h)/5);
        fill((1-bColor/128)*255);
        textAlign(CENTER,CENTER);
        int fontNum = min(w, h)/3;
        PFont font;
        font = createFont("Serif.bold", fontNum);
        textFont(font);
        text(bText.toUpperCase(), x + w/2, y + h/2 - fontNum/4);
    }

    void pgDraw(PGraphics pg, LevelUpMenu lp) {
            
        if (!active) return;
        int bColor = bgColor;
        if(contains(mouseX, mouseY)) {
            if(mousePressed) bColor = 255 - bColor;
            else bColor = max(0, bColor-30);
        }
        pg.stroke(255 - bColor);
        pg.fill(90,90,0);
        pg.rect(x, y, w, h, min(w, h)/5);
        pg.fill((1-bColor/128)*255);
        pg.textAlign(CENTER,CENTER);
        int fontNum = min(w, h)/3;
        PFont font;
        font = createFont("Serif.bold", fontNum);
        pg.textFont(font);
        pg.text(bText.toUpperCase(), x + w/2, y + h/2 - fontNum/4);
        pg.textSize(16);
        
        String[] st = bText.split(" ");
        if(st[0].equals("add")) {
            pg.text(lp.getDescription(WeaponType.valueOf(st[1]), true), x + w/2, y + h/2 + 40);
        } else pg.text(lp.getDescription(WeaponType.valueOf(st[1]), false), x + w/2, y + h/2 + 40);
        // add weapon icon
        PImage img = lp.getImage(WeaponType.valueOf(st[1]));
        img.resize(30,30); 
        pg.image(img, x - 50, y + h/2);

    }
    
    boolean contains(int mx, int my) {
        return (mx >= x && mx <= x + w && my >= y && my <= y + h);
    }
}

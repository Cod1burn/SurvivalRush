import java.util.Collections;
import java.util.List;
import java.util.stream.Stream;
import java.util.stream.Collectors;

public class Game {
    GameMap map;
    boolean pause;
    Player player;
    int playerLastLevel;

    static final float MAX_TIME = 15 * 60.0;
    float gameTimer;
    int gameLevel;
    boolean isOver;

    EnemyGenerator eg;
    ItemGenerator ig;
    ArrayList<Enemy> enemies;
    ArrayList<Item> items;

    PVector camera;


    public Game () {
        int template = 0; // Test template
        player = new Player(this, new PVector(600, 600));
        playerLastLevel = player.ce.level;
        map = new GameMap(template); 

        player.setMap(map);
        gameTimer = MAX_TIME;
        gameLevel = 1;

        camera = new PVector(0,0);

        eg = new EnemyGenerator(this);
        ig = new ItemGenerator(this);

        enemies = new ArrayList<>();
        items = new ArrayList<>();
    }

    void draw() {

        camera.x %= map.blockWidth;
        camera.x = camera.x < 0 ? map.blockWidth + camera.x : camera.x;
        camera.y %= map.blockHeight;
        camera.y = camera.y < 0 ? map.blockHeight + camera.y : camera.y;


        background(0);
        // Draw map
        map.draw(camera);
        enemies.forEach(Enemy::draw);
        items.forEach(Item::draw);
        player.draw();
        // Draw UI
        textSize(20);
        stroke(0);
        text("fps:" + frameRate, 50, 70);
        //text("position:" + player.position, 50, 70);
        //text("coord: "+ player.coord, 50, 50);
        if (pause) {
            textSize(80);
            textAlign(CENTER, CENTER);
            text("PAUSE", width/2, height/2);
            // Draw pause menu
        }
    }

    void update(int time) {
        if (playerLastLevel < player.ce.level) pause();
        
        if (pause) return;

        float second = time / 1000.0;

        gameTimer -= second;
        gameLevel = 1 + (int)((MAX_TIME - gameTimer) / 180);

        if (gameTimer <= 0) timeOut();

        player.update(second);
        enemies.forEach((e) -> {
            e.update(second, camera);
            e.movingDirection(player.position.copy().sub(e.position));
            });
        items.forEach((i) -> {
            i.update(second, camera);
        });

        // Collision Detection:
        // 1. Projectiles with enemies
        player.projectiles.forEach((p) -> {
            if (p.hitTimer <= 0.0) {
                enemies.forEach((e) -> {
                    if (e.inCamera && e.isCollide(p, true)) {
                        if(p.alive) p.hit(e);
                    }
                });
                if (p.hasHit) p.runHitTimer();
            } 
        });
        // Remove dead projectiles and enemies
        player.projectiles.removeIf(p -> !p.alive);
        enemies.removeIf(e -> !e.alive);

        // 2. Items with player
        items.forEach((i) -> {
            float distance = player.position.copy().sub(i.position).mag();
            if (distance <= player.collideRadius) {
                i.getCollected(player);
            } else if (!i.absorbing && distance <= player.ce.absorbRadius) {
                i.getAbsorbed(player);
            }
        });
        items.removeIf(i -> !i.alive);

        // 2. Enemies with player
        enemies.forEach((e) -> {
            if (e.isCollide(player, false)) e.hit(player);
        });

        if (!player.alive) player.die();
        
    }

    void timeOut() {

    }

    void playerDie() {

    }

    void enemyDie(Enemy enemy) {
        enemies.remove(enemy);
        // Drop loot
    }

    void generateEnemy(EnemyType et, PVector position) {
        enemies.add(eg.generateEnemy(et, gameLevel, position));
    }

    /**
        Get a Specific number of random visible enemies from enemies list.
    **/
    List<Enemy> getRandomEnemies(int num) {
        List<Enemy> visibleEnemies = enemies.stream()
            .filter(e -> e.inCamera)
            .collect(Collectors.toList());

        Collections.shuffle(visibleEnemies);
        if (num >= visibleEnemies.size()) return visibleEnemies;
        return visibleEnemies.subList(0, num);
    }

    void generateItem(ItemType it, float value, PVector position) {
        items.add(ig.generateItem(it, value, position));
    }

    void generateEnemies(EnemyType et, int num, float minDistance, float maxDistance) {
        map.getAvailablePositions(player.position, num, minDistance, maxDistance).forEach((p) -> {generateEnemy(et, p);});
    }

    void addWeapon(WeaponType type) {
        player.ce.addWeapon(type);
    }

    void levelUpWeapon(WeaponType type) {
        player.ce.levelUpWeapon(type);
    }

    void updateCamera(PVector camera) {
        this.camera = camera.copy();
    }

    void addAllWeapons() {
        for (WeaponType wt : WeaponType.values()) {
            player.ce.addWeapon(wt);
        }
    }

    void levelUpAllWeapons() {
        for (WeaponType wt : WeaponType.values()) {
            player.ce.levelUpWeapon(wt);
        }
    }

    void pause() {pause = true;}

    void unpause() {pause = false;}

    void keyPressed(char keyChar) {
        if (!pause) {
            if (keyChar == 'd' || keyChar == 'D' || keyCode == LEFT) player.movingDirection(1, 0);
            if (keyChar == 'a' || keyChar == 'A' || keyCode == RIGHT) player.movingDirection(-1, 0);
            if (keyChar == 'w' || keyChar == 'W' || keyCode == UP) player.movingDirection(0, -1);
            if (keyChar == 's' || keyChar == 'S' || keyCode == DOWN) player.movingDirection(0, 1);
            if (keyChar == 'c') generateEnemies(EnemyType.MEGAORC, 3, 700, 2000);
            if (keyChar == 'x') addAllWeapons();
            if (keyChar == 'z') levelUpAllWeapons();
        }
    }

    void keyReleased(char keyChar) {
        if (!pause) {
            if (keyChar == 'd' || keyChar == 'D' || keyCode == LEFT) player.movingDirection(-1, 0);
            if (keyChar == 'a' || keyChar == 'A' || keyCode == RIGHT) player.movingDirection(1, 0);
            if (keyChar == 'w' || keyChar == 'W' || keyCode == UP) player.movingDirection(0, 1);
            if (keyChar == 's' || keyChar == 'S' || keyCode == DOWN) player.movingDirection(0, -1);
        }
    }
}

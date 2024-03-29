import java.util.Collections;
import java.util.List;
import java.util.stream.Stream;
import java.util.stream.Collectors;

public class Game {
    GameMap map;
    boolean pause;
    Player player;
    int playerLastLevel;

    static final float MAX_TIME = 5 * 60.0; // changed to 5 in video recording.
    float gameTimer;
    int gameLevel;
    int enemiesKilled;
    boolean isOver;

    float ENEMY_GENERATION_INTERVAL = 5.0;
    float enemyTimer;
    int sumDifficulty;

    EnemyGenerator eg;
    ItemGenerator ig;
    ArrayList<Enemy> enemies;
    ArrayList<Item> items;

    LevelUpMenu lpMenu;
    GameOverMenu goMenu;

    PVector camera;

    public Game () {
        int template = 0; // Test template
        player = new Player(this, new PVector(600, 600));
        playerLastLevel = player.ce.level;
        map = new GameMap(template); 

        player.setMap(map);
        gameTimer = MAX_TIME;
        gameLevel = 1;

        enemiesKilled = 0;

        enemyTimer = ENEMY_GENERATION_INTERVAL;

        camera = new PVector(0,0);

        eg = new EnemyGenerator(this);
        ig = new ItemGenerator(this);

        enemies = new ArrayList<>();
        items = new ArrayList<>();

        initialWeapon();
    }

    void initialWeapon() {
        int i = (int)(random(0, WeaponType.values().length));
        player.ce.addWeapon(WeaponType.values()[i]);
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
        displayInfo();
        if (pause) {
            // textSize(80);
            // textAlign(CENTER, CENTER);
            // text("PAUSE", width/2, height/2);
            // Draw pause menu
            if (lpMenu != null) lpMenu.draw();
        }
        if(goMenu != null) goMenu.draw();
    }

    // method to draw the user info
    void displayInfo() {
        int barWidth = 100;
        textSize(16);
        textAlign(LEFT);
        stroke(0);
        fill(0);
        // exp and level
        text("level: ", 50, 50);
        noFill();
        rect(100, 40, barWidth, 10);
        fill(0);
        int exp = (int) ((player.ce.exp / player.ce.maxExp) * 100);
        rect(100, 40, exp, 10);
        text(player.ce.level, 105 + barWidth, 50);
        // health
        text("health: ", 50, 70);
        int health = (int) ((player.ce.health / player.ce.maxHealth) * 100);
        noFill();
        rect(100, 60, barWidth, 10);
        fill(0);
        rect(100, 60, health, 10);
        text((int) health + "%", 105 + barWidth, 70);
        // weapons icons
        text("Weapons: ", 50, 100);
        if(player.ce.weapons.size() == 0) {
            text("NONE", 120, 100);
        }
        else {
            int w = 100;
            int h = 90;
            for (int i = 0; i < player.ce.weapons.size(); i++) {
                Weapon weapon = player.ce.weapons.get(i);
                image(weapon.projectileImage, w + (30 * (i+1)) , h, 25, 25);
            }
        }
        // auras
        text("Auras: ", 50, 150);
        if (player.ce.auras.size() == 0) {
            text("NONE", 100, 150);
        }
        else {
            int w = 100; 
            int h = 140;
            for(int i = 0; i < player.ce.auras.size(); i++) {
                Aura aura = player.ce.auras.get(i);
                image(aura.getIcon(), w, h + (25 * i), 25, 25);
                noFill();
                rect(w + 25, h + (25 * i), aura.duration, 10);
                float time = aura.duration - aura.timer; 
                if(time < 0) time = 0;
                fill(0);
                rect(w + 25, h + (25 * i), time, 10);
            }
        }
        // time left
        textSize(32);
        int timeSec = (int) gameTimer;
        int min = (int) timeSec / 60;
        int sec = timeSec % 60 ;
        text(min + ":" + sec, width/2, 50);
    }

    void update(int time) {
        if (pause || goMenu != null) {
            player.stop();
            return;
        }

        if (playerLastLevel < player.ce.level) {
            boolean upgradable = false;
            if (player.ce.weapons.size() < CombatEntity.MAX_WEAPONS) {
                upgradable = true;
            } else {
                for (Weapon w : player.ce.weapons) {
                    if (w.level < w.MAX_LEVEL) upgradable = true;
                }
            }

            if (upgradable) {
                pause();
                lpMenu = new LevelUpMenu(this, player);
            }
            playerLastLevel++;
        } else if (lpMenu != null) {
            lpMenu = null;
        }

        
        
        float second = time / 1000.0;

        gameTimer -= second;
        
        gameLevel = 1 + (int)((MAX_TIME - gameTimer) / 180);

        if (gameTimer <= 0) timeOut();

        enemyTimer -= second;
        if (enemyTimer <= 0) {
            sumDifficulty += 6 + gameLevel * gameLevel * 4;
            while(sumDifficulty > 0) generateAGroupEnemies();
            enemyTimer = ENEMY_GENERATION_INTERVAL;
        }

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
        goMenu = new GameOverMenu(this);
        isOver = true;
    }

    void playerDie() {
        // implement game over menu
        goMenu = new GameOverMenu(this);
        isOver = true;
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
        if (num < 0) return new ArrayList<Enemy>();
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

    void generateAGroupEnemies() {
        int ran = (int)(random(0, EnemyType.values().length));
        EnemyType et = EnemyType.values()[ran];
        int num = sumDifficulty / et.difficulty;
        if (num == 0) num = 1;
        generateEnemies(et, num, 300, 600);
        sumDifficulty -= et.difficulty * num;
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

    void pause() {
        pause = true;
    }

    void unpause() {
        pause = false;
        player.stop();
    }

    void keyPressed(char keyChar) {
        if (!pause) {
            if (keyChar == 'd' || keyChar == 'D' || keyCode == RIGHT) player.movingDirection(1, 0);
            if (keyChar == 'a' || keyChar == 'A' || keyCode == LEFT) player.movingDirection(-1, 0);
            if (keyChar == 'w' || keyChar == 'W' || keyCode == UP) player.movingDirection(0, -1);
            if (keyChar == 's' || keyChar == 'S' || keyCode == DOWN) player.movingDirection(0, 1);
            // Cheat Codes
            if (keyChar == 'x' || keyChar == 'X') addAllWeapons(); // Press X to add all weapons
            if (keyChar == 'z' || keyChar == 'Z') levelUpAllWeapons(); // Press Z to upgrade all weapons
            if (keyChar == 'l' || keyChar == 'L') player.ce.levelUp(); // Press L to test level up menu
            if (keyChar == 't' || keyChar == 'T') gameTimer -= 60; // Press T to move 1 minute forward
            if(keyChar == 'g' || keyChar == 'G') playerDie(); // Press G to test game over menu

            if(isOver) goMenu.keyPressed(keyChar);
        } else {
            if (lpMenu != null) lpMenu.keyPressed(keyChar);
        }
    }

    void keyReleased(char keyChar) {
        if (!pause) {
            if (keyChar == 'd' || keyChar == 'D' || keyCode == RIGHT) player.movingDirection(-1, 0);
            if (keyChar == 'a' || keyChar == 'A' || keyCode == LEFT) player.movingDirection(1, 0);
            if (keyChar == 'w' || keyChar == 'W' || keyCode == UP) player.movingDirection(0, 1);
            if (keyChar == 's' || keyChar == 'S' || keyCode == DOWN) player.movingDirection(0, -1);
        }
    }

    void mouseClicked(int mouseX, int mouseY) {
        if(pause && lpMenu != null) lpMenu.mouseClicked(mouseX, mouseY);
        if(isOver) goMenu.mouseClicked(mouseX, mouseY);
    }
}

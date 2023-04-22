import java.util.Map;

public class EnemyGenerator {
    Game game;
    HashMap<String, PImage> imageMap;
    HashMap<EnemyType, CombatEntity> ceMap;
    public EnemyGenerator(Game game) {
        this.game = game;
        initialMaps();
    }

    Enemy generateEnemy(EnemyType et, int level, PVector position) {
        CombatEntity ce = ceMap.get(et).copy(level);
        Enemy enemy = new Enemy(ce, game, position);
        enemy.setImage(imageMap.get(et.label+"1"), imageMap.get(et.label+"2"));
    }

    void initialMaps() {
        ceMap = new HashMap<String, CombatEntity>();
        imageMap = new HashMap<String, PImage>();

        XML xml = loadXML("EnemyTemplats/enemies.xml");
        for (EnemyType et : EnemyType.values()) {
            String label = et.label;          
            ce = new CombatEntity();
            XML enemyXML = xml.getChildren(label)[0];
            ce.name = enemyXML.getChildren("name").getContent();
            ce.maxHealth = enemyXML.getChildren("health").getFloatContent();
            ce.health = maxHealth;
            ce.radius = enemyXML.getChildren("radius").getFloatContent();
            ce.healthRegen = enemyXML.getChildren("healthRegen").getFloatContent();
            ce.attack = enemyXML.getChildren("attack").getFloatContent();
            ce.defence = enemyXML.getChildren("defence").getFloatContent();
            ce.moveSpeed = enemyXML.getChildren("moveSpeed").getFloatContent();
            ce.attackInterval = enemyXML.getChildren("attackInterval").getFloatContent();
            ce.attackSpeed = enemyXML.getChildren("attackSpeed").getFloatContent();
            ceMap.put(et, ce);

            String imgPath = "ObjectImgs/Enemies/"enemyXML.getChildren("image").getContent();
            PImage img1 = loadImage(imgPath + "1.png");
            PImage img2 = loadImage(imgPath + "2.png");
            imageMap.put(label + "1", img1);
            imageMap.put(label + "2", img2);
        }
    }


}
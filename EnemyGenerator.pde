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
        return enemy;
    }

    void initialMaps() {
        ceMap = new HashMap<EnemyType, CombatEntity>();
        imageMap = new HashMap<String, PImage>();

        XML xml = loadXML("EnemyTemplates/enemies.xml");
        for (EnemyType et : EnemyType.values()) {
            String label = et.label;          
            CombatEntity ce = new CombatEntity();
            ce.type = et;
            XML enemyXML = xml.getChildren(label)[0];
            ce.maxHealth = enemyXML.getChildren("health")[0].getFloatContent();
            ce.health = ce.maxHealth;
            ce.radius = enemyXML.getChildren("radius")[0].getFloatContent();
            ce.healthRegen = enemyXML.getChildren("healthRegen")[0].getFloatContent();
            ce.attack = enemyXML.getChildren("attack")[0].getFloatContent();
            ce.defence = enemyXML.getChildren("defence")[0].getFloatContent();
            ce.moveSpeed = enemyXML.getChildren("moveSpeed")[0].getFloatContent();
            ce.baseAttackInterval = enemyXML.getChildren("attackInterval")[0].getFloatContent();
            ce.attackSpeed = enemyXML.getChildren("attackSpeed")[0].getFloatContent();
            ce.difficulty = enemyXML.getChildren("difficulty")[0].getIntContent();
            ceMap.put(et, ce);

            String imgPath = "ObjectImgs/Enemies/" + enemyXML.getChildren("image")[0].getContent();
            PImage img1 = loadImage(imgPath + "1.png");
            PImage img2 = loadImage(imgPath + "2.png");
            imageMap.put(label + "1", img1);
            imageMap.put(label + "2", img2);
        }
    }


}

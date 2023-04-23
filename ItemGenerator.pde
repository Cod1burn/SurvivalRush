public class ItemGenerator {
    Game game;
    HashMap<ItemType, PImage> imageMap;
    public EnemyGenerator(Game game) {
        this.game = game;
        initialMaps();
    }

    public initialMap() {
        imageMap = new HashMap<ItemType, PImage>();
        for (ItemType it: ItemType.values()) {
            String path = it.imagePath;
            PImage img = loadImage("ObjectImgs/Items/" + path + ".png");
            imageMap.put(it, img);
        }
    }

    Enemy generateItem(ItemType it, int level, PVector position) {
        PImage img = imageMap.get(it);
        switch (it) {
            case EXPORB :

            break;	
        }
    }
}
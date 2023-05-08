public class ItemGenerator {
    Game game;
    HashMap<ItemType, PImage> imageMap;
    public ItemGenerator(Game game) {
        this.game = game;
        initialMap();
    }

    void initialMap() {
        imageMap = new HashMap<ItemType, PImage>();
        for (ItemType it: ItemType.values()) {
            String path = it.imagePath;
            PImage img = loadImage("ObjectImgs/Items/" + path + ".png");
            imageMap.put(it, img);
        }
    }

    Item generateItem(ItemType it, float value, PVector position) {
        PImage img = imageMap.get(it);
        Item item = null;
        switch (it) {
            case EXPORB :
                item = new ExpOrb(position, value);
                item.setImage(imageMap.get(it));
            break;	

            case ATTACK:
                item = new AttackCrystal(position);
                item.setImage(imageMap.get(it));
            break;

            case HEART:
                item = new Heart(position, value);
                item.setImage(imageMap.get(it));
            break;

            case SPEED:
                item = new SpeedUp(position);
                item.setImage(imageMap.get(it));
            break;
            
            default:
            break;
        }
        return item;
    }
}

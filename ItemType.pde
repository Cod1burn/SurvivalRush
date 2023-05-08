public enum ItemType {
    EXPORB ("exporb"),
    HEART("heart"),
    ATTACK("attack"),
    SPEED ("speedCrystal");
    
    String imagePath;
    private ItemType(String imagePath) {
        this.imagePath = imagePath;
    }
}

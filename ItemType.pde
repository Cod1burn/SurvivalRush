public enum ItemType {
    EXPORB ("exporb"),
    POTION("potion"),
    FEATHER("feather"),
    BOOK ("book");
    
    String imagePath;
    private ItemType(String imagePath) {
        this.imagePath = imagePath;
    }
}

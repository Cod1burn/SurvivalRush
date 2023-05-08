public enum AuraType {
    DAMAGEAMP(null),
    MOVESPDAMP("moveSpeed"),
    ATKSPDAMP("atkSpeed"),
    EXPAMP(null),
    EXTRAPROJS("projectiles"),
    HOT(null), 
    DOT(null),
    SPECIAL(null);

    String imgPath;
    private AuraType(String imgPath){
        this.imgPath = imgPath;
    }
}
// DOT: Damage Over Time
// HOT: Healing Over Time

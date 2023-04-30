public enum EnemyType {
    ORC ("orc"),
    VAMPIRE ("vampire"),
    MEGAORC ("megaOrc");

    String label;
    EnemyType(String label) {
        this.label = label;
    }
}
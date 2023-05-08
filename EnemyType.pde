public enum EnemyType {
    ORC ("orc", 3),
    VAMPIRE ("vampire", 3),
    MEGAORC ("megaOrc", 10);

    String label;
    int difficulty;
    EnemyType(String label, int difficulty) {
        this.label = label;
        this.difficulty = difficulty;
    }
}
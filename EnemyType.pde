public enum EnemyType {
    ORC ("orc", 3),
    ROBOT ("robot", 5),
    BERSERK ("berserk", 5),
    MEGAORC ("megaOrc", 10);

    String label;
    int difficulty;
    EnemyType(String label, int difficulty) {
        this.label = label;
        this.difficulty = difficulty;
    }
}
public class SpeedUp extends Item {
    public SpeedUp(PVector position) {
        super(position);
        this.value = value;
        RADIUS = 25;
    }

    @Override
    void getCollected(MovableObject obj) {
        super.getCollected(obj);
        Aura moveSpeed = new Aura(obj.ce, "Move speed+", AuraType.MOVESPDAMP, 35, 20);
        Aura atkSpeed = new Aura(obj.ce, "Attack speed+", AuraType.ATKSPDAMP, 50, 20);  
    }
}
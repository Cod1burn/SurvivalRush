public class ExpOrb extends Item {
    public ExpOrb(PVector position, float value) {
        super(position);
        this.value = value;
        RADIUS = 20;
    }

    @Override
    void getCollected(MovableObject obj) {
        super.getCollected(obj);
        obj.ce.getExp(value);
    }
}
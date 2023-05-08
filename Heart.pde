public class Heart extends Item {
    public Heart(PVector position, float value) {
        super(position);
        this.value = value;
        RADIUS = 25;
    }

    @Override
    void getCollected(MovableObject obj) {
        super.getCollected(obj);
        obj.ce.heal(value, 1.2);
    }
}

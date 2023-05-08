public class AttackCrystal extends Item {
    public AttackCrystal(PVector position) {
        super(position);
        this.value = 3;
        RADIUS = 25;
    }

    @Override
    void getCollected(MovableObject obj) {
        super.getCollected(obj);
        Aura extraProj = new Aura(obj.ce, "Weapon Targets", AuraType.EXTRAPROJS, value, 20);
    }
}

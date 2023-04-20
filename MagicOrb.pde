public class MagicOrb extends Projectile {
    Coord coord;
    boolean pierceBlock;
    public MagicOrb(Player owner, PVector direction, float scalarSpeed, float radius, float attack) {
        super(owner, direction, radius);
        this.attack = attack;
        hits = 1;
        hitInterval = 1.0;
        this.scalarSpeed = scalarSpeed;
        coord = new Coord(position.x / Floor.UNIT, position.y / Floor.UNIT);
        speed = direction.copy().mult(scalarSpeed);
        pierceBlock = false;
    }

    @Override
    void update(float second) {
        super.update(second);
        if (pierceBlock) return;
        int cx, cy;
        cx = (int)(position.x / Floor.UNIT);
        cy = (int)(position.y / Floor.UNIT);
        if (!owner.map.canBeEntered(cx, cy)) die();
    }
}
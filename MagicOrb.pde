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

        knockBackForce = direction.copy().mult(0.8 * scalarSpeed);
        knockBackTime = 0.05;
    }

    @Override
    void update(float second) {
        super.update(second);
        if (pierceBlock) return;

        int cx = coord.vectorToCoord(position.x, Floor.UNIT);
        int cy = coord.vectorToCoord(position.y, Floor.UNIT);
        if (!owner.map.canBeEntered(cx, cy)) die();
    }
}
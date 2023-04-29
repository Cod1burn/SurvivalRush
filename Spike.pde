public class Spike extends Projectile {
    public Spike(Player owner, PVector position, float radius, float duration, float attack, float hitInterval) {
        super(owner, new PVector(0, 0), radius);
        this.position = position.copy();
        this.duration = duration;
        this.attack = attack;
        this.hitInterval = hitInterval;
        hits = 999;
    }
}
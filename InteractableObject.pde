import java.util.function.Consumer;


abstract class InteractableObject {
    boolean active;
    Consumer<Integer> action;
    

    boolean isActive() {
        return active;
    }

    void addAction(Consumer c) {
        this.action = c;
    }
    
}

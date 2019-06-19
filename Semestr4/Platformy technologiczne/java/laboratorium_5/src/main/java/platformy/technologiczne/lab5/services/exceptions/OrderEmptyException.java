package platformy.technologiczne.lab5.services.exceptions;

import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderEmptyException extends RuntimeException {
    public OrderEmptyException() {
        Logger logger = Logger.getLogger(getClass().getName());
        logger.log(Level.WARNING, "Handling " + this.getClass().getName());
    }
}

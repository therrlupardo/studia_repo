package platformy.technologiczne.lab4.services.exceptions;


import java.util.logging.*;

public class OutOfStockException extends RuntimeException {
    public OutOfStockException() {
        Logger logger = Logger.getLogger(getClass().getName());
        logger.log(Level.WARNING, "Handling " + this.getClass().getName());
    }
}

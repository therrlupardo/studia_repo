package platformy.technologiczne.lab5;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.MockitoJUnitRunner;
import platformy.technologiczne.lab5.models.Computers;
import platformy.technologiczne.lab5.models.OrderedComputers;
import platformy.technologiczne.lab5.models.Orders;
import platformy.technologiczne.lab5.services.OrderService;
import platformy.technologiczne.lab5.services.exceptions.*;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.times;

import javax.persistence.EntityManager;

@RunWith(MockitoJUnitRunner.class)
public class OrderServiceTest {

    @Mock
    private EntityManager em;

    @Test(expected = OutOfStockException.class)
    public void whenOrderComputerNotAvailable_placeOrderThrowsOutOfStockException() {
        //Arrange
        Orders order = new Orders();

        Computers computer = new Computers();
        computer.setAmount(10);

        OrderedComputers orderedComputer = new OrderedComputers();
        orderedComputer.setComputers(computer);
        orderedComputer.setAmount(20000);

        order.getOrderedComputers().add(orderedComputer);
        Mockito.when(em.find(Computers.class,
                orderedComputer.getComputers().getId())).thenReturn(computer);
        OrderService orderService = new OrderService(em);
        //Act
        orderService.placeOrder(order);

        //Assert - OutOfStockException expected
    }

    @Test(expected = OutOfStockException.class)
    public void whenManyOrderedComputersAndAtLeastOneOutOfStock_placeOrderThrowsOutOfStockException() {
        //Arrange
        Computers computer1 = new Computers();
        Computers computer2 = new Computers();
        computer1.setAmount(10);
        computer2.setAmount(5);

        OrderedComputers orderedComputer1 = new OrderedComputers();
        OrderedComputers orderedComputer2 = new OrderedComputers();
        orderedComputer1.setAmount(5);
        orderedComputer2.setAmount(10);
        orderedComputer1.setComputers(computer1);
        orderedComputer2.setComputers(computer2);

        Orders order = new Orders();
        order.getOrderedComputers().add(orderedComputer1);
        order.getOrderedComputers().add(orderedComputer2);

        Mockito.when(em.find(Computers.class,
                orderedComputer1.getComputers().getId()))
                .thenReturn(computer1);
        Mockito.when(em.find(Computers.class,
                orderedComputer2.getComputers().getId()))
                .thenReturn(computer2);

        OrderService orderService = new OrderService(em);

        //Act
        orderService.placeOrder(order);

        //Assert - OutOfStockException expected

    }

    @Test(expected = OutOfStockException.class)
    public void whenOrderedManyTimesSameComputerNotAvailable_placeOrderDecreaseAmountOfOrderedComputer() {
        //Arrange
        Computers computer = new Computers();
        computer.setAmount(5);

        OrderedComputers orderedComputer1 = new OrderedComputers();
        OrderedComputers orderedComputer2 = new OrderedComputers();
        orderedComputer1.setAmount(5);
        orderedComputer2.setAmount(5);
        orderedComputer1.setComputers(computer);
        orderedComputer2.setComputers(computer);

        Orders order = new Orders();
        order.getOrderedComputers().add(orderedComputer1);
        order.getOrderedComputers().add(orderedComputer2);

        Mockito.when(em.find(Computers.class,
                orderedComputer1.getComputers().getId()))
                .thenReturn(computer);

        OrderService orderService = new OrderService(em);

        //Act
        orderService.placeOrder(order);

        //Assert - OutOfStockException expected

    }

    @Test(expected = OrderEmptyException.class)
    public void whenOrderIsEmpty_placeOrderThrowsOrderEmptyException() {
        //Arrange
        OrderService orderService = new OrderService(em);

        //Act
        orderService.placeOrder(null);

        //Assert - OrderEmptyException expected
    }

    @Test(expected = OrderEmptyException.class)
    public void whenNoComputersInOrder_placeOrderThrowOrderEmptyException() {
        //Arrange
        OrderedComputers orderedComputers = new OrderedComputers();
        Orders order = new Orders();
        OrderService orderService = new OrderService(em);

        //Act
        orderService.placeOrder(order);

        //Assert - OrderEmptyException expected

    }

    @Test(expected = NotEnoughItemsInOrderException.class)
    public void whenOnlyOneComputerInOrder_placeOrderThrowNotEnoughItemsInOrderException(){
        //Arrange
        Computers computer = new Computers();
        computer.setAmount(10);

        OrderedComputers orderedComputers = new OrderedComputers();
        orderedComputers.setAmount(1);
        orderedComputers.setComputers(computer);

        Orders order = new Orders();
        order.getOrderedComputers().add(orderedComputers);

        OrderService orderService = new OrderService(em);
        //Act
        orderService.placeOrder(order);

        //Assert - NotEnoughItemsInOrderException expected
    }

    @Test(expected = NullComputerException.class)
    public void whenNullComputerInOrder_placeOrderThrowNotEnoughItemsInOrderException(){
        //Arrange
        Computers computer1 = new Computers();
        computer1.setAmount(10);

        OrderedComputers orderedComputers = new OrderedComputers();
        orderedComputers.setAmount(1);
        orderedComputers.setComputers(null);
        OrderedComputers orderedComputer1 = new OrderedComputers();
        orderedComputer1.setAmount(5);
        orderedComputer1.setComputers(computer1);

        Orders order = new Orders();
        order.getOrderedComputers().add(orderedComputers);
        order.getOrderedComputers().add(orderedComputer1);




        OrderService orderService = new OrderService(em);
        //Act
        orderService.placeOrder(order);

        //Assert - NotEnoughItemsInOrderException expected
    }

    @Test(expected = NotPositiveAmountOfItemsInOrderException.class)
    public void whenNegativeAmountOfItemsInOrder_placeOrderThrowNotPositiveAmountOfItemsInOrderException(){
        //Arrange
        Computers computer1 = new Computers();
        Computers computer2 = new Computers();
        computer1.setAmount(10);
        computer2.setAmount(5);

        OrderedComputers orderedComputer1 = new OrderedComputers();
        OrderedComputers orderedComputer2 = new OrderedComputers();
        orderedComputer1.setAmount(-5);
        orderedComputer2.setAmount(10);
        orderedComputer1.setComputers(computer1);
        orderedComputer2.setComputers(computer2);

        Orders order = new Orders();
        order.getOrderedComputers().add(orderedComputer1);
        order.getOrderedComputers().add(orderedComputer2);

        OrderService orderService = new OrderService(em);
        Mockito.when(em.find(Computers.class,
                orderedComputer1.getComputers().getId()))
                .thenReturn(computer1);

        //Act
        orderService.placeOrder(order);

        //Assert - NotPositiveAmountOfItemsInOrderException expected
    }

    @Test(expected = NotPositiveAmountOfItemsInOrderException.class)
    public void whenZeroAmountOfItemsInOrder_placeOrderThrowNotPositiveAmountOfItemsInOrderException(){
        //Arrange
        Computers computer1 = new Computers();
        Computers computer2 = new Computers();
        computer1.setAmount(10);
        computer2.setAmount(5);

        OrderedComputers orderedComputer1 = new OrderedComputers();
        OrderedComputers orderedComputer2 = new OrderedComputers();
        orderedComputer1.setAmount(0);
        orderedComputer2.setAmount(10);
        orderedComputer1.setComputers(computer1);
        orderedComputer2.setComputers(computer2);

        Orders order = new Orders();
        order.getOrderedComputers().add(orderedComputer1);
        order.getOrderedComputers().add(orderedComputer2);

        Mockito.when(em.find(Computers.class,
                orderedComputer1.getComputers().getId()))
                .thenReturn(computer1);

        OrderService orderService = new OrderService(em);

        //Act
        orderService.placeOrder(order);

        //Assert - NotPositiveAmountOfItemsInOrderException expected
    }

    @Test
    public void whenOrderedComputerAvailable_placeOrderDecreasesAmountByOrderedComputerAmount() {
        //Arrange
        Computers computer = new Computers();
        computer.setAmount(5);

        OrderedComputers orderedComputers = new OrderedComputers();
        orderedComputers.setAmount(5);
        orderedComputers.setComputers(computer);

        Orders order = new Orders();
        order.getOrderedComputers().add(orderedComputers);


        Mockito.when(em.find(Computers.class,
                orderedComputers.getComputers().getId()))
                .thenReturn(computer);

        OrderService orderService = new OrderService(em);

        //Act
        orderService.placeOrder(order);

        //Assert
        assertEquals(0, (int) computer.getAmount());
        Mockito.verify(em, times(1)).persist(order);
    }

    @Test
    public void whenOrderedManyComputersAllAvailable_placeOrderDecreasesAmountsOfOrderedComputersAmounts() {
        //Arrange
        Computers computer1 = new Computers();
        Computers computer2 = new Computers();
        computer1.setAmount(10);
        computer2.setAmount(20);

        OrderedComputers orderedComputer1 = new OrderedComputers();
        OrderedComputers orderedComputer2 = new OrderedComputers();
        orderedComputer1.setAmount(5);
        orderedComputer2.setAmount(10);
        orderedComputer1.setComputers(computer1);
        orderedComputer2.setComputers(computer2);

        Orders order = new Orders();
        order.getOrderedComputers().add(orderedComputer1);
        order.getOrderedComputers().add(orderedComputer2);

        Mockito.when(em.find(Computers.class,
                orderedComputer1.getComputers().getId()))
                .thenReturn(computer1);
        Mockito.when(em.find(Computers.class,
                orderedComputer2.getComputers().getId()))
                .thenReturn(computer2);

        OrderService orderService = new OrderService(em);

        //Act
        orderService.placeOrder(order);

        //Assert
        assertEquals(5, (int) computer1.getAmount());
        assertEquals(10, (int) computer2.getAmount());
        Mockito.verify(em, times(2)).persist(order);


    }

    @Test
    public void whenOrderedManyTimesSameComputerAllAvailable_placeOrderDecreaseAmountOfOrderedComputer() {
        //Arrange
        Computers computer = new Computers();
        computer.setAmount(20);

        OrderedComputers orderedComputer1 = new OrderedComputers();
        OrderedComputers orderedComputer2 = new OrderedComputers();
        orderedComputer1.setAmount(5);
        orderedComputer2.setAmount(5);
        orderedComputer1.setComputers(computer);
        orderedComputer2.setComputers(computer);

        Orders order = new Orders();
        order.getOrderedComputers().add(orderedComputer1);
        order.getOrderedComputers().add(orderedComputer2);

        Mockito.when(em.find(Computers.class,
                orderedComputer1.getComputers().getId()))
                .thenReturn(computer);

        OrderService orderService = new OrderService(em);

        //Act
        orderService.placeOrder(order);

        //Assert
        assertEquals(10, (int) computer.getAmount());
        Mockito.verify(em, times(2)).persist(order);

    }
}

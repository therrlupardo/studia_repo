package platformy.technologiczne.lab5.services;


import org.springframework.stereotype.Service;
import platformy.technologiczne.lab5.models.Computers;
import platformy.technologiczne.lab5.models.OrderedComputers;
import platformy.technologiczne.lab5.models.Orders;
import platformy.technologiczne.lab5.services.exceptions.*;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.List;

@Service
public class OrderService extends EntityService<Orders> {

    public OrderService(EntityManager em){
        super(em, Orders.class, Orders::getId);
    }

    public List<Orders> findAll(){
        return em.createNamedQuery(Orders.findAll, Orders.class).getResultList();
    }

    /**
     *
     * @param order order to be made
     * @throws OrderEmptyException exception threw, when order is empty
     * @throws OutOfStockException exception threw, when is stock is out of some element of order
     */
    @Transactional
    public void placeOrder(Orders order)
            throws OrderEmptyException,
                    OutOfStockException,
                    NotEnoughItemsInOrderException,
                    NullComputerException,
                    NotPositiveAmountOfItemsInOrderException {
        if(order == null){
            throw new OrderEmptyException();
        }
        else if (order.getOrderedComputers().size() == 0){
            throw new OrderEmptyException();
        } else if (order.getOrderedComputers().size() == 1){
            OrderedComputers orderedComputers = order.getOrderedComputers().get(0);
            if(orderedComputers.getAmount() < 2) {
                throw new NotEnoughItemsInOrderException();
            }
        }

        for(OrderedComputers orderedComputers : order.getOrderedComputers()){
            if(orderedComputers.getComputers() == null) {
                throw new NullComputerException();
            }
            Computers computers = em.find(Computers.class, orderedComputers.getComputers().getId());

            if(orderedComputers.getAmount() <= 0){
                throw new NotPositiveAmountOfItemsInOrderException();
            }
            else if(computers.getAmount() < orderedComputers.getAmount()){
                throw new OutOfStockException();
            } else {
                int new_amount = computers.getAmount() - orderedComputers.getAmount();
                computers.setAmount(new_amount);
            }

            save(order);

        }

    }


}

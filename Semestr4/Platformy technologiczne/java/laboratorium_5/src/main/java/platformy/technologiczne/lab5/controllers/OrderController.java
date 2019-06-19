package platformy.technologiczne.lab5.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
import platformy.technologiczne.lab5.models.Orders;
import platformy.technologiczne.lab5.services.OrderService;
import platformy.technologiczne.lab5.services.exceptions.OutOfStockException;

import java.net.URI;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/orders")
public class OrderController {
    private final OrderService orderService;

    public OrderController(OrderService orderService){
        this.orderService = orderService;
    }

    /**
    * @return list of made orders
    **/
    @GetMapping
    public List<Orders> listOrders(){
        return orderService.findAll();
    }


    /**
     *
     * @param id id of order to return
     * @return if there is order with given id, it is returned
     *         otherwise 404 NOT FOUND
     */
    @GetMapping("/{id}")
    public ResponseEntity<Orders> getOrder(@PathVariable UUID id){
        Orders order = orderService.find(id);

        if(order == null){
            return ResponseEntity.notFound().build();
        }
        else{
            return ResponseEntity.ok(order);
        }
    }

    /**
     *
     * @param order json matching class Orders, order to be made
     * @param uriComponentsBuilder default, helps with building url for new order
     * @return 201 (created) if request is ok and order can be made,
     *         406 (not acceptable) if there is something wrong with request (i.e. not enough products in stock)
     */
    @PostMapping
    public ResponseEntity<Void> addOrder(@RequestBody Orders order,
                                         UriComponentsBuilder uriComponentsBuilder){
        try{
            orderService.placeOrder(order);
            URI location = uriComponentsBuilder.path("/orders/{id}").buildAndExpand(order.getId()).toUri();
            return ResponseEntity.created(location).build();
        } catch (OutOfStockException e1){
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).build();
        }
    }
}

package platformy.technologiczne.lab4.models;


import lombok.EqualsAndHashCode;
import lombok.Getter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import static javax.persistence.TemporalType.TIMESTAMP;

@Entity
@Table(name = "orders")
@EqualsAndHashCode(of = "id")
@NamedQueries(value = {
        @NamedQuery(name = Orders.findAll, query = "SELECT o FROM Orders o")
})
public class Orders {
    public static final String findAll = "Orders.findAll";

    @Getter
    @Id
    private UUID id = UUID.randomUUID();

    @Getter
    @OneToMany(cascade = CascadeType.ALL)
    private List<OrderedComputers> orderedComputers = new ArrayList<>();

    @Getter
    @Temporal(TIMESTAMP)
    private Date creationDate;

    @PrePersist
    public void prePersist(){
        this.creationDate = new Date();
    }
}

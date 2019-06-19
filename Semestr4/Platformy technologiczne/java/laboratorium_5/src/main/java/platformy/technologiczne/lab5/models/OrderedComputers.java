package platformy.technologiczne.lab5.models;


import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.util.UUID;

@Entity
@Table(name = "orderedcomputers")
@EqualsAndHashCode(of = "id")
public class OrderedComputers {

    @Id
    private UUID id = UUID.randomUUID();

    @Getter
    @Setter
    @ManyToOne
    private Computers computers;

    @Getter
    @Setter
    private Integer amount;

}

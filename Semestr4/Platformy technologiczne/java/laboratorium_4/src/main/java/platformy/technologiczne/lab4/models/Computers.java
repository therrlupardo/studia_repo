package platformy.technologiczne.lab4.models;


import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.UUID;

@Entity
@Table(name = "computers")
@EqualsAndHashCode(of = "id")
@NamedQueries(value = {
        @NamedQuery(name = Computers.findAll, query = "SELECT m FROM Computers m")
})
public class Computers {
    public static final String findAll = "Computers.RETURN_ALL";

    @Getter
    @Setter
    @Id
    private UUID id = UUID.randomUUID();

    @Getter
    @Setter
    private String processor;

    @Getter
    @Setter
    private String type;

    @Getter
    @Setter
    private String memory;

    @Getter
    @Setter
    private String graphic_card;

    @Getter
    @Setter
    private Integer amount;

    @Getter
    @Setter
    private Float price;



}

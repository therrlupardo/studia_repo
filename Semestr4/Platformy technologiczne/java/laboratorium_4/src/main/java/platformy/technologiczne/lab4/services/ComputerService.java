package platformy.technologiczne.lab4.services;

import org.springframework.stereotype.Service;
import platformy.technologiczne.lab4.models.Computers;

import javax.persistence.EntityManager;
import java.util.List;

@Service
public class ComputerService extends EntityService<Computers> {

    public ComputerService(EntityManager em){
        super(em, Computers.class, Computers::getId);
    }

    public List<Computers> findAll(){
        return em.createNamedQuery(Computers.findAll, Computers.class).getResultList();
    }

}

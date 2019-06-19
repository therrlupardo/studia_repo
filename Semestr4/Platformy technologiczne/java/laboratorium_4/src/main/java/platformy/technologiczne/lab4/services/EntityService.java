package platformy.technologiczne.lab4.services;


import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.util.UUID;
import java.util.function.Function;

abstract public class EntityService<T> {
    final EntityManager em;
    private final Class<T> entityClass;
    private final Function<T, Object> idSuplier;

    public EntityService(EntityManager em, Class<T> entityClass, Function<T, Object> idSuplier){
        this.em = em;
        this.entityClass = entityClass;
        this.idSuplier = idSuplier;
    }

    @Transactional
    public void save(T entity){
        if (em.find(entityClass, idSuplier.apply(entity)) == null){
            em.persist(entity);
        }
        else{
             em.merge(entity);
        }
    }

    public T find(UUID id){
        return em.find(entityClass, id);
    }
}

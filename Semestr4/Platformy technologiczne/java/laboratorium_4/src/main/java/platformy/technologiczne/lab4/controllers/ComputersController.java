package platformy.technologiczne.lab4.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.util.UriComponentsBuilder;
import platformy.technologiczne.lab4.models.Computers;
import platformy.technologiczne.lab4.services.ComputerService;

import java.net.URI;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/computers")
public class ComputersController {

    private final ComputerService computerService;

    public ComputersController(ComputerService computerService){
        this.computerService = computerService;
    }

    /**
     *
     * @return list of computers in database
     */
    @GetMapping
    public List<Computers> listComputers(){
        return computerService.findAll();
    }

    /**
     *
     * @param computers Computers class object
     * @param uriComponentsBuilder help with building new utl for co
     * @return 201 (created) if everything is ok
     *         otherwise 409 (conflict)
     */
    @PostMapping
    public ResponseEntity<Void> addComputers(@RequestBody Computers computers,
                                             UriComponentsBuilder uriComponentsBuilder){
        if(computerService.find(computers.getId()) == null){
            computerService.save(computers);

            URI location = uriComponentsBuilder.path("/computers/{id}").buildAndExpand(computers.getId()).toUri();
            return ResponseEntity.created(location).build();
        } else {
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }
    }

    /**
     *
     * @param id id of co to return
     * @return if found return co with given id
     *         otherwise 404 not found
     */
    @GetMapping("/{id}")
    public ResponseEntity<Computers> getComputers(@PathVariable UUID id){
        Computers computers = computerService.find(id);

        if(computers == null){
            return ResponseEntity.notFound().build();
        } else{
            return ResponseEntity.ok(computers);
        }
    }

    /**
     *
     * @param computers Computers class object, to replace old one with same id
     * @return 200 if everything is ok
     *         404 if co to be replaced was not found.
     */
    @PutMapping("/{id}")
    public ResponseEntity<Void> updatecomputer(@RequestBody Computers computers, @PathVariable UUID id){
        if(computerService.find(id) != null){
            computers.setId(id);
            computerService.save(computers);
            return ResponseEntity.ok().build();
        } else{
            return ResponseEntity.notFound().build();
        }
    }

}

package com.wheref.paperlessqms.web.rest;

import com.wheref.paperlessqms.domain.QueueDepartment;
import com.wheref.paperlessqms.repository.QueueDepartmentRepository;
import com.wheref.paperlessqms.service.QueueDepartmentQueryService;
import com.wheref.paperlessqms.service.QueueDepartmentService;
import com.wheref.paperlessqms.service.criteria.QueueDepartmentCriteria;
import com.wheref.paperlessqms.web.rest.errors.BadRequestAlertException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import tech.jhipster.web.util.HeaderUtil;
import tech.jhipster.web.util.PaginationUtil;
import tech.jhipster.web.util.ResponseUtil;

/**
 * REST controller for managing {@link com.wheref.paperlessqms.domain.QueueDepartment}.
 */
@RestController
@RequestMapping("/api/queue-departments")
public class QueueDepartmentResource {

    private final Logger log = LoggerFactory.getLogger(QueueDepartmentResource.class);

    private static final String ENTITY_NAME = "queueDepartment";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final QueueDepartmentService queueDepartmentService;

    private final QueueDepartmentRepository queueDepartmentRepository;

    private final QueueDepartmentQueryService queueDepartmentQueryService;

    public QueueDepartmentResource(
        QueueDepartmentService queueDepartmentService,
        QueueDepartmentRepository queueDepartmentRepository,
        QueueDepartmentQueryService queueDepartmentQueryService
    ) {
        this.queueDepartmentService = queueDepartmentService;
        this.queueDepartmentRepository = queueDepartmentRepository;
        this.queueDepartmentQueryService = queueDepartmentQueryService;
    }

    /**
     * {@code POST  /queue-departments} : Create a new queueDepartment.
     *
     * @param queueDepartment the queueDepartment to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new queueDepartment, or with status {@code 400 (Bad Request)} if the queueDepartment has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<QueueDepartment> createQueueDepartment(@Valid @RequestBody QueueDepartment queueDepartment)
        throws URISyntaxException {
        log.debug("REST request to save QueueDepartment : {}", queueDepartment);
        if (queueDepartment.getId() != null) {
            throw new BadRequestAlertException("A new queueDepartment cannot already have an ID", ENTITY_NAME, "idexists");
        }
        QueueDepartment result = queueDepartmentService.save(queueDepartment);
        return ResponseEntity
            .created(new URI("/api/queue-departments/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /queue-departments/:id} : Updates an existing queueDepartment.
     *
     * @param id the id of the queueDepartment to save.
     * @param queueDepartment the queueDepartment to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated queueDepartment,
     * or with status {@code 400 (Bad Request)} if the queueDepartment is not valid,
     * or with status {@code 500 (Internal Server Error)} if the queueDepartment couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<QueueDepartment> updateQueueDepartment(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody QueueDepartment queueDepartment
    ) throws URISyntaxException {
        log.debug("REST request to update QueueDepartment : {}, {}", id, queueDepartment);
        if (queueDepartment.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, queueDepartment.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!queueDepartmentRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        QueueDepartment result = queueDepartmentService.update(queueDepartment);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, queueDepartment.getId().toString()))
            .body(result);
    }

    /**
     * {@code PATCH  /queue-departments/:id} : Partial updates given fields of an existing queueDepartment, field will ignore if it is null
     *
     * @param id the id of the queueDepartment to save.
     * @param queueDepartment the queueDepartment to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated queueDepartment,
     * or with status {@code 400 (Bad Request)} if the queueDepartment is not valid,
     * or with status {@code 404 (Not Found)} if the queueDepartment is not found,
     * or with status {@code 500 (Internal Server Error)} if the queueDepartment couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<QueueDepartment> partialUpdateQueueDepartment(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody QueueDepartment queueDepartment
    ) throws URISyntaxException {
        log.debug("REST request to partial update QueueDepartment partially : {}, {}", id, queueDepartment);
        if (queueDepartment.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, queueDepartment.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!queueDepartmentRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<QueueDepartment> result = queueDepartmentService.partialUpdate(queueDepartment);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, queueDepartment.getId().toString())
        );
    }

    /**
     * {@code GET  /queue-departments} : get all the queueDepartments.
     *
     * @param pageable the pagination information.
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of queueDepartments in body.
     */
    @GetMapping("")
    public ResponseEntity<List<QueueDepartment>> getAllQueueDepartments(
        QueueDepartmentCriteria criteria,
        @org.springdoc.core.annotations.ParameterObject Pageable pageable
    ) {
        log.debug("REST request to get QueueDepartments by criteria: {}", criteria);

        Page<QueueDepartment> page = queueDepartmentQueryService.findByCriteria(criteria, pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /queue-departments/count} : count all the queueDepartments.
     *
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the count in body.
     */
    @GetMapping("/count")
    public ResponseEntity<Long> countQueueDepartments(QueueDepartmentCriteria criteria) {
        log.debug("REST request to count QueueDepartments by criteria: {}", criteria);
        return ResponseEntity.ok().body(queueDepartmentQueryService.countByCriteria(criteria));
    }

    /**
     * {@code GET  /queue-departments/:id} : get the "id" queueDepartment.
     *
     * @param id the id of the queueDepartment to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the queueDepartment, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<QueueDepartment> getQueueDepartment(@PathVariable("id") Long id) {
        log.debug("REST request to get QueueDepartment : {}", id);
        Optional<QueueDepartment> queueDepartment = queueDepartmentService.findOne(id);
        return ResponseUtil.wrapOrNotFound(queueDepartment);
    }

    /**
     * {@code DELETE  /queue-departments/:id} : delete the "id" queueDepartment.
     *
     * @param id the id of the queueDepartment to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteQueueDepartment(@PathVariable("id") Long id) {
        log.debug("REST request to delete QueueDepartment : {}", id);
        queueDepartmentService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}

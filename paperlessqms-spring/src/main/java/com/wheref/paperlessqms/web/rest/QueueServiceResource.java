package com.wheref.paperlessqms.web.rest;

import com.wheref.paperlessqms.domain.QueueService;
import com.wheref.paperlessqms.repository.QueueServiceRepository;
import com.wheref.paperlessqms.service.QueueServiceQueryService;
import com.wheref.paperlessqms.service.QueueServiceService;
import com.wheref.paperlessqms.service.criteria.QueueServiceCriteria;
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
 * REST controller for managing {@link com.wheref.paperlessqms.domain.QueueService}.
 */
@RestController
@RequestMapping("/api/queue-services")
public class QueueServiceResource {

    private final Logger log = LoggerFactory.getLogger(QueueServiceResource.class);

    private static final String ENTITY_NAME = "queueService";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final QueueServiceService queueServiceService;

    private final QueueServiceRepository queueServiceRepository;

    private final QueueServiceQueryService queueServiceQueryService;

    public QueueServiceResource(
        QueueServiceService queueServiceService,
        QueueServiceRepository queueServiceRepository,
        QueueServiceQueryService queueServiceQueryService
    ) {
        this.queueServiceService = queueServiceService;
        this.queueServiceRepository = queueServiceRepository;
        this.queueServiceQueryService = queueServiceQueryService;
    }

    /**
     * {@code POST  /queue-services} : Create a new queueService.
     *
     * @param queueService the queueService to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new queueService, or with status {@code 400 (Bad Request)} if the queueService has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<QueueService> createQueueService(@Valid @RequestBody QueueService queueService) throws URISyntaxException {
        log.debug("REST request to save QueueService : {}", queueService);
        if (queueService.getId() != null) {
            throw new BadRequestAlertException("A new queueService cannot already have an ID", ENTITY_NAME, "idexists");
        }
        QueueService result = queueServiceService.save(queueService);
        return ResponseEntity
            .created(new URI("/api/queue-services/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /queue-services/:id} : Updates an existing queueService.
     *
     * @param id the id of the queueService to save.
     * @param queueService the queueService to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated queueService,
     * or with status {@code 400 (Bad Request)} if the queueService is not valid,
     * or with status {@code 500 (Internal Server Error)} if the queueService couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<QueueService> updateQueueService(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody QueueService queueService
    ) throws URISyntaxException {
        log.debug("REST request to update QueueService : {}, {}", id, queueService);
        if (queueService.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, queueService.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!queueServiceRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        QueueService result = queueServiceService.update(queueService);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, queueService.getId().toString()))
            .body(result);
    }

    /**
     * {@code PATCH  /queue-services/:id} : Partial updates given fields of an existing queueService, field will ignore if it is null
     *
     * @param id the id of the queueService to save.
     * @param queueService the queueService to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated queueService,
     * or with status {@code 400 (Bad Request)} if the queueService is not valid,
     * or with status {@code 404 (Not Found)} if the queueService is not found,
     * or with status {@code 500 (Internal Server Error)} if the queueService couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<QueueService> partialUpdateQueueService(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody QueueService queueService
    ) throws URISyntaxException {
        log.debug("REST request to partial update QueueService partially : {}, {}", id, queueService);
        if (queueService.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, queueService.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!queueServiceRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<QueueService> result = queueServiceService.partialUpdate(queueService);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, queueService.getId().toString())
        );
    }

    /**
     * {@code GET  /queue-services} : get all the queueServices.
     *
     * @param pageable the pagination information.
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of queueServices in body.
     */
    @GetMapping("")
    public ResponseEntity<List<QueueService>> getAllQueueServices(
        QueueServiceCriteria criteria,
        @org.springdoc.core.annotations.ParameterObject Pageable pageable
    ) {
        log.debug("REST request to get QueueServices by criteria: {}", criteria);

        Page<QueueService> page = queueServiceQueryService.findByCriteria(criteria, pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /queue-services/count} : count all the queueServices.
     *
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the count in body.
     */
    @GetMapping("/count")
    public ResponseEntity<Long> countQueueServices(QueueServiceCriteria criteria) {
        log.debug("REST request to count QueueServices by criteria: {}", criteria);
        return ResponseEntity.ok().body(queueServiceQueryService.countByCriteria(criteria));
    }

    /**
     * {@code GET  /queue-services/:id} : get the "id" queueService.
     *
     * @param id the id of the queueService to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the queueService, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<QueueService> getQueueService(@PathVariable("id") Long id) {
        log.debug("REST request to get QueueService : {}", id);
        Optional<QueueService> queueService = queueServiceService.findOne(id);
        return ResponseUtil.wrapOrNotFound(queueService);
    }

    /**
     * {@code DELETE  /queue-services/:id} : delete the "id" queueService.
     *
     * @param id the id of the queueService to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteQueueService(@PathVariable("id") Long id) {
        log.debug("REST request to delete QueueService : {}", id);
        queueServiceService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}

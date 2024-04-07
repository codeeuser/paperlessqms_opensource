package com.wheref.paperlessqms.web.rest;

import com.wheref.paperlessqms.domain.QueueTerminal;
import com.wheref.paperlessqms.repository.QueueTerminalRepository;
import com.wheref.paperlessqms.service.QueueTerminalQueryService;
import com.wheref.paperlessqms.service.QueueTerminalService;
import com.wheref.paperlessqms.service.criteria.QueueTerminalCriteria;
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
 * REST controller for managing {@link com.wheref.paperlessqms.domain.QueueTerminal}.
 */
@RestController
@RequestMapping("/api/queue-terminals")
public class QueueTerminalResource {

    private final Logger log = LoggerFactory.getLogger(QueueTerminalResource.class);

    private static final String ENTITY_NAME = "queueTerminal";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final QueueTerminalService queueTerminalService;

    private final QueueTerminalRepository queueTerminalRepository;

    private final QueueTerminalQueryService queueTerminalQueryService;

    public QueueTerminalResource(
        QueueTerminalService queueTerminalService,
        QueueTerminalRepository queueTerminalRepository,
        QueueTerminalQueryService queueTerminalQueryService
    ) {
        this.queueTerminalService = queueTerminalService;
        this.queueTerminalRepository = queueTerminalRepository;
        this.queueTerminalQueryService = queueTerminalQueryService;
    }

    /**
     * {@code POST  /queue-terminals} : Create a new queueTerminal.
     *
     * @param queueTerminal the queueTerminal to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new queueTerminal, or with status {@code 400 (Bad Request)} if the queueTerminal has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<QueueTerminal> createQueueTerminal(@Valid @RequestBody QueueTerminal queueTerminal) throws URISyntaxException {
        log.debug("REST request to save QueueTerminal : {}", queueTerminal);
        if (queueTerminal.getId() != null) {
            throw new BadRequestAlertException("A new queueTerminal cannot already have an ID", ENTITY_NAME, "idexists");
        }
        QueueTerminal result = queueTerminalService.save(queueTerminal);
        return ResponseEntity
            .created(new URI("/api/queue-terminals/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /queue-terminals/:id} : Updates an existing queueTerminal.
     *
     * @param id the id of the queueTerminal to save.
     * @param queueTerminal the queueTerminal to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated queueTerminal,
     * or with status {@code 400 (Bad Request)} if the queueTerminal is not valid,
     * or with status {@code 500 (Internal Server Error)} if the queueTerminal couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<QueueTerminal> updateQueueTerminal(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody QueueTerminal queueTerminal
    ) throws URISyntaxException {
        log.debug("REST request to update QueueTerminal : {}, {}", id, queueTerminal);
        if (queueTerminal.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, queueTerminal.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!queueTerminalRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        QueueTerminal result = queueTerminalService.update(queueTerminal);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, queueTerminal.getId().toString()))
            .body(result);
    }

    /**
     * {@code PATCH  /queue-terminals/:id} : Partial updates given fields of an existing queueTerminal, field will ignore if it is null
     *
     * @param id the id of the queueTerminal to save.
     * @param queueTerminal the queueTerminal to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated queueTerminal,
     * or with status {@code 400 (Bad Request)} if the queueTerminal is not valid,
     * or with status {@code 404 (Not Found)} if the queueTerminal is not found,
     * or with status {@code 500 (Internal Server Error)} if the queueTerminal couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<QueueTerminal> partialUpdateQueueTerminal(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody QueueTerminal queueTerminal
    ) throws URISyntaxException {
        log.debug("REST request to partial update QueueTerminal partially : {}, {}", id, queueTerminal);
        if (queueTerminal.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, queueTerminal.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!queueTerminalRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<QueueTerminal> result = queueTerminalService.partialUpdate(queueTerminal);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, queueTerminal.getId().toString())
        );
    }

    /**
     * {@code GET  /queue-terminals} : get all the queueTerminals.
     *
     * @param pageable the pagination information.
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of queueTerminals in body.
     */
    @GetMapping("")
    public ResponseEntity<List<QueueTerminal>> getAllQueueTerminals(
        QueueTerminalCriteria criteria,
        @org.springdoc.core.annotations.ParameterObject Pageable pageable
    ) {
        log.debug("REST request to get QueueTerminals by criteria: {}", criteria);

        Page<QueueTerminal> page = queueTerminalQueryService.findByCriteria(criteria, pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /queue-terminals/count} : count all the queueTerminals.
     *
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the count in body.
     */
    @GetMapping("/count")
    public ResponseEntity<Long> countQueueTerminals(QueueTerminalCriteria criteria) {
        log.debug("REST request to count QueueTerminals by criteria: {}", criteria);
        return ResponseEntity.ok().body(queueTerminalQueryService.countByCriteria(criteria));
    }

    /**
     * {@code GET  /queue-terminals/:id} : get the "id" queueTerminal.
     *
     * @param id the id of the queueTerminal to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the queueTerminal, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<QueueTerminal> getQueueTerminal(@PathVariable("id") Long id) {
        log.debug("REST request to get QueueTerminal : {}", id);
        Optional<QueueTerminal> queueTerminal = queueTerminalService.findOne(id);
        return ResponseUtil.wrapOrNotFound(queueTerminal);
    }

    /**
     * {@code DELETE  /queue-terminals/:id} : delete the "id" queueTerminal.
     *
     * @param id the id of the queueTerminal to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteQueueTerminal(@PathVariable("id") Long id) {
        log.debug("REST request to delete QueueTerminal : {}", id);
        queueTerminalService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}

package com.wheref.paperlessqms.web.rest;

import com.wheref.paperlessqms.domain.OpenHour;
import com.wheref.paperlessqms.repository.OpenHourRepository;
import com.wheref.paperlessqms.service.OpenHourQueryService;
import com.wheref.paperlessqms.service.OpenHourService;
import com.wheref.paperlessqms.service.criteria.OpenHourCriteria;
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
 * REST controller for managing {@link com.wheref.paperlessqms.domain.OpenHour}.
 */
@RestController
@RequestMapping("/api/open-hours")
public class OpenHourResource {

    private final Logger log = LoggerFactory.getLogger(OpenHourResource.class);

    private static final String ENTITY_NAME = "openHour";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final OpenHourService openHourService;

    private final OpenHourRepository openHourRepository;

    private final OpenHourQueryService openHourQueryService;

    public OpenHourResource(
        OpenHourService openHourService,
        OpenHourRepository openHourRepository,
        OpenHourQueryService openHourQueryService
    ) {
        this.openHourService = openHourService;
        this.openHourRepository = openHourRepository;
        this.openHourQueryService = openHourQueryService;
    }

    /**
     * {@code POST  /open-hours} : Create a new openHour.
     *
     * @param openHour the openHour to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new openHour, or with status {@code 400 (Bad Request)} if the openHour has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<OpenHour> createOpenHour(@Valid @RequestBody OpenHour openHour) throws URISyntaxException {
        log.debug("REST request to save OpenHour : {}", openHour);
        if (openHour.getId() != null) {
            throw new BadRequestAlertException("A new openHour cannot already have an ID", ENTITY_NAME, "idexists");
        }
        OpenHour result = openHourService.save(openHour);
        return ResponseEntity
            .created(new URI("/api/open-hours/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /open-hours/:id} : Updates an existing openHour.
     *
     * @param id the id of the openHour to save.
     * @param openHour the openHour to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated openHour,
     * or with status {@code 400 (Bad Request)} if the openHour is not valid,
     * or with status {@code 500 (Internal Server Error)} if the openHour couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<OpenHour> updateOpenHour(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody OpenHour openHour
    ) throws URISyntaxException {
        log.debug("REST request to update OpenHour : {}, {}", id, openHour);
        if (openHour.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, openHour.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!openHourRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        OpenHour result = openHourService.update(openHour);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, openHour.getId().toString()))
            .body(result);
    }

    /**
     * {@code PATCH  /open-hours/:id} : Partial updates given fields of an existing openHour, field will ignore if it is null
     *
     * @param id the id of the openHour to save.
     * @param openHour the openHour to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated openHour,
     * or with status {@code 400 (Bad Request)} if the openHour is not valid,
     * or with status {@code 404 (Not Found)} if the openHour is not found,
     * or with status {@code 500 (Internal Server Error)} if the openHour couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<OpenHour> partialUpdateOpenHour(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody OpenHour openHour
    ) throws URISyntaxException {
        log.debug("REST request to partial update OpenHour partially : {}, {}", id, openHour);
        if (openHour.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, openHour.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!openHourRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<OpenHour> result = openHourService.partialUpdate(openHour);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, openHour.getId().toString())
        );
    }

    /**
     * {@code GET  /open-hours} : get all the openHours.
     *
     * @param pageable the pagination information.
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of openHours in body.
     */
    @GetMapping("")
    public ResponseEntity<List<OpenHour>> getAllOpenHours(
        OpenHourCriteria criteria,
        @org.springdoc.core.annotations.ParameterObject Pageable pageable
    ) {
        log.debug("REST request to get OpenHours by criteria: {}", criteria);

        Page<OpenHour> page = openHourQueryService.findByCriteria(criteria, pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /open-hours/count} : count all the openHours.
     *
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the count in body.
     */
    @GetMapping("/count")
    public ResponseEntity<Long> countOpenHours(OpenHourCriteria criteria) {
        log.debug("REST request to count OpenHours by criteria: {}", criteria);
        return ResponseEntity.ok().body(openHourQueryService.countByCriteria(criteria));
    }

    /**
     * {@code GET  /open-hours/:id} : get the "id" openHour.
     *
     * @param id the id of the openHour to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the openHour, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<OpenHour> getOpenHour(@PathVariable("id") Long id) {
        log.debug("REST request to get OpenHour : {}", id);
        Optional<OpenHour> openHour = openHourService.findOne(id);
        return ResponseUtil.wrapOrNotFound(openHour);
    }

    /**
     * {@code DELETE  /open-hours/:id} : delete the "id" openHour.
     *
     * @param id the id of the openHour to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteOpenHour(@PathVariable("id") Long id) {
        log.debug("REST request to delete OpenHour : {}", id);
        openHourService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}

package com.wheref.paperlessqms.web.rest;

import com.wheref.paperlessqms.domain.MaxToken;
import com.wheref.paperlessqms.repository.MaxTokenRepository;
import com.wheref.paperlessqms.service.MaxTokenQueryService;
import com.wheref.paperlessqms.service.MaxTokenService;
import com.wheref.paperlessqms.service.criteria.MaxTokenCriteria;
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
 * REST controller for managing {@link com.wheref.paperlessqms.domain.MaxToken}.
 */
@RestController
@RequestMapping("/api/max-tokens")
public class MaxTokenResource {

    private final Logger log = LoggerFactory.getLogger(MaxTokenResource.class);

    private static final String ENTITY_NAME = "maxToken";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final MaxTokenService maxTokenService;

    private final MaxTokenRepository maxTokenRepository;

    private final MaxTokenQueryService maxTokenQueryService;

    public MaxTokenResource(
        MaxTokenService maxTokenService,
        MaxTokenRepository maxTokenRepository,
        MaxTokenQueryService maxTokenQueryService
    ) {
        this.maxTokenService = maxTokenService;
        this.maxTokenRepository = maxTokenRepository;
        this.maxTokenQueryService = maxTokenQueryService;
    }

    /**
     * {@code POST  /max-tokens} : Create a new maxToken.
     *
     * @param maxToken the maxToken to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new maxToken, or with status {@code 400 (Bad Request)} if the maxToken has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<MaxToken> createMaxToken(@Valid @RequestBody MaxToken maxToken) throws URISyntaxException {
        log.debug("REST request to save MaxToken : {}", maxToken);
        if (maxToken.getId() != null) {
            throw new BadRequestAlertException("A new maxToken cannot already have an ID", ENTITY_NAME, "idexists");
        }
        MaxToken result = maxTokenService.save(maxToken);
        return ResponseEntity
            .created(new URI("/api/max-tokens/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /max-tokens/:id} : Updates an existing maxToken.
     *
     * @param id the id of the maxToken to save.
     * @param maxToken the maxToken to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated maxToken,
     * or with status {@code 400 (Bad Request)} if the maxToken is not valid,
     * or with status {@code 500 (Internal Server Error)} if the maxToken couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<MaxToken> updateMaxToken(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody MaxToken maxToken
    ) throws URISyntaxException {
        log.debug("REST request to update MaxToken : {}, {}", id, maxToken);
        if (maxToken.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, maxToken.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!maxTokenRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        MaxToken result = maxTokenService.update(maxToken);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, maxToken.getId().toString()))
            .body(result);
    }

    /**
     * {@code PATCH  /max-tokens/:id} : Partial updates given fields of an existing maxToken, field will ignore if it is null
     *
     * @param id the id of the maxToken to save.
     * @param maxToken the maxToken to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated maxToken,
     * or with status {@code 400 (Bad Request)} if the maxToken is not valid,
     * or with status {@code 404 (Not Found)} if the maxToken is not found,
     * or with status {@code 500 (Internal Server Error)} if the maxToken couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<MaxToken> partialUpdateMaxToken(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody MaxToken maxToken
    ) throws URISyntaxException {
        log.debug("REST request to partial update MaxToken partially : {}, {}", id, maxToken);
        if (maxToken.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, maxToken.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!maxTokenRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<MaxToken> result = maxTokenService.partialUpdate(maxToken);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, maxToken.getId().toString())
        );
    }

    /**
     * {@code GET  /max-tokens} : get all the maxTokens.
     *
     * @param pageable the pagination information.
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of maxTokens in body.
     */
    @GetMapping("")
    public ResponseEntity<List<MaxToken>> getAllMaxTokens(
        MaxTokenCriteria criteria,
        @org.springdoc.core.annotations.ParameterObject Pageable pageable
    ) {
        log.debug("REST request to get MaxTokens by criteria: {}", criteria);

        Page<MaxToken> page = maxTokenQueryService.findByCriteria(criteria, pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /max-tokens/count} : count all the maxTokens.
     *
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the count in body.
     */
    @GetMapping("/count")
    public ResponseEntity<Long> countMaxTokens(MaxTokenCriteria criteria) {
        log.debug("REST request to count MaxTokens by criteria: {}", criteria);
        return ResponseEntity.ok().body(maxTokenQueryService.countByCriteria(criteria));
    }

    /**
     * {@code GET  /max-tokens/:id} : get the "id" maxToken.
     *
     * @param id the id of the maxToken to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the maxToken, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<MaxToken> getMaxToken(@PathVariable("id") Long id) {
        log.debug("REST request to get MaxToken : {}", id);
        Optional<MaxToken> maxToken = maxTokenService.findOne(id);
        return ResponseUtil.wrapOrNotFound(maxToken);
    }

    /**
     * {@code DELETE  /max-tokens/:id} : delete the "id" maxToken.
     *
     * @param id the id of the maxToken to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMaxToken(@PathVariable("id") Long id) {
        log.debug("REST request to delete MaxToken : {}", id);
        maxTokenService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}

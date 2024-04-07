package com.wheref.paperlessqms.web.rest;

import com.wheref.paperlessqms.domain.TokenNumber;
import com.wheref.paperlessqms.repository.TokenNumberRepository;
import com.wheref.paperlessqms.service.TokenNumberQueryService;
import com.wheref.paperlessqms.service.TokenNumberService;
import com.wheref.paperlessqms.service.criteria.TokenNumberCriteria;
import com.wheref.paperlessqms.web.rest.errors.BadRequestAlertException;
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
 * REST controller for managing {@link com.wheref.paperlessqms.domain.TokenNumber}.
 */
@RestController
@RequestMapping("/api/token-numbers")
public class TokenNumberResource {

    private final Logger log = LoggerFactory.getLogger(TokenNumberResource.class);

    private static final String ENTITY_NAME = "tokenNumber";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final TokenNumberService tokenNumberService;

    private final TokenNumberRepository tokenNumberRepository;

    private final TokenNumberQueryService tokenNumberQueryService;

    public TokenNumberResource(
        TokenNumberService tokenNumberService,
        TokenNumberRepository tokenNumberRepository,
        TokenNumberQueryService tokenNumberQueryService
    ) {
        this.tokenNumberService = tokenNumberService;
        this.tokenNumberRepository = tokenNumberRepository;
        this.tokenNumberQueryService = tokenNumberQueryService;
    }

    @PutMapping("/next-number")
    public ResponseEntity<TokenNumber> nextNumber(@RequestBody TokenNumber tokenNumber) throws InterruptedException, URISyntaxException {
        log.debug("REST request to NEXT TokenNumber : {}", tokenNumber);
        Long departmentId = tokenNumber.getDepartmentId();
        Long serviceId = tokenNumber.getServiceId();
        TokenNumber current = tokenNumberRepository.findFirstByDepartmentIdAndServiceIdAndReset(departmentId, serviceId, false);
        current.setNumber(current.getNumber() + 1L);
        Optional<TokenNumber> result = tokenNumberService.partialUpdate(current);
        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, current.getId().toString())
        );
    }

    /**
     * {@code POST  /token-numbers} : Create a new tokenNumber.
     *
     * @param tokenNumber the tokenNumber to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new tokenNumber, or with status {@code 400 (Bad Request)} if the tokenNumber has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<TokenNumber> createTokenNumber(@RequestBody TokenNumber tokenNumber) throws URISyntaxException {
        log.debug("REST request to save TokenNumber : {}", tokenNumber);
        if (tokenNumber.getId() != null) {
            throw new BadRequestAlertException("A new tokenNumber cannot already have an ID", ENTITY_NAME, "idexists");
        }
        TokenNumber result = tokenNumberService.save(tokenNumber);
        return ResponseEntity
            .created(new URI("/api/token-numbers/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /token-numbers/:id} : Updates an existing tokenNumber.
     *
     * @param id the id of the tokenNumber to save.
     * @param tokenNumber the tokenNumber to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated tokenNumber,
     * or with status {@code 400 (Bad Request)} if the tokenNumber is not valid,
     * or with status {@code 500 (Internal Server Error)} if the tokenNumber couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<TokenNumber> updateTokenNumber(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody TokenNumber tokenNumber
    ) throws URISyntaxException {
        log.debug("REST request to update TokenNumber : {}, {}", id, tokenNumber);
        if (tokenNumber.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, tokenNumber.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!tokenNumberRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        TokenNumber result = tokenNumberService.update(tokenNumber);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, tokenNumber.getId().toString()))
            .body(result);
    }

    /**
     * {@code PATCH  /token-numbers/:id} : Partial updates given fields of an existing tokenNumber, field will ignore if it is null
     *
     * @param id the id of the tokenNumber to save.
     * @param tokenNumber the tokenNumber to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated tokenNumber,
     * or with status {@code 400 (Bad Request)} if the tokenNumber is not valid,
     * or with status {@code 404 (Not Found)} if the tokenNumber is not found,
     * or with status {@code 500 (Internal Server Error)} if the tokenNumber couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<TokenNumber> partialUpdateTokenNumber(
        @PathVariable(value = "id", required = false) final Long id,
        @RequestBody TokenNumber tokenNumber
    ) throws URISyntaxException {
        log.debug("REST request to partial update TokenNumber partially : {}, {}", id, tokenNumber);
        if (tokenNumber.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, tokenNumber.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!tokenNumberRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<TokenNumber> result = tokenNumberService.partialUpdate(tokenNumber);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, tokenNumber.getId().toString())
        );
    }

    /**
     * {@code GET  /token-numbers} : get all the tokenNumbers.
     *
     * @param pageable the pagination information.
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of tokenNumbers in body.
     */
    @GetMapping("")
    public ResponseEntity<List<TokenNumber>> getAllTokenNumbers(
        TokenNumberCriteria criteria,
        @org.springdoc.core.annotations.ParameterObject Pageable pageable
    ) {
        log.debug("REST request to get TokenNumbers by criteria: {}", criteria);

        Page<TokenNumber> page = tokenNumberQueryService.findByCriteria(criteria, pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /token-numbers/count} : count all the tokenNumbers.
     *
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the count in body.
     */
    @GetMapping("/count")
    public ResponseEntity<Long> countTokenNumbers(TokenNumberCriteria criteria) {
        log.debug("REST request to count TokenNumbers by criteria: {}", criteria);
        return ResponseEntity.ok().body(tokenNumberQueryService.countByCriteria(criteria));
    }

    /**
     * {@code GET  /token-numbers/:id} : get the "id" tokenNumber.
     *
     * @param id the id of the tokenNumber to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the tokenNumber, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<TokenNumber> getTokenNumber(@PathVariable("id") Long id) {
        log.debug("REST request to get TokenNumber : {}", id);
        Optional<TokenNumber> tokenNumber = tokenNumberService.findOne(id);
        return ResponseUtil.wrapOrNotFound(tokenNumber);
    }

    /**
     * {@code DELETE  /token-numbers/:id} : delete the "id" tokenNumber.
     *
     * @param id the id of the tokenNumber to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTokenNumber(@PathVariable("id") Long id) {
        log.debug("REST request to delete TokenNumber : {}", id);
        tokenNumberService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}

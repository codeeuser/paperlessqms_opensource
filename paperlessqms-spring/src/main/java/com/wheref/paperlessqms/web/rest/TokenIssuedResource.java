package com.wheref.paperlessqms.web.rest;

import com.wheref.paperlessqms.domain.TokenIssued;
import com.wheref.paperlessqms.repository.TokenIssuedRepository;
import com.wheref.paperlessqms.service.TokenIssuedQueryService;
import com.wheref.paperlessqms.service.TokenIssuedService;
import com.wheref.paperlessqms.service.criteria.TokenIssuedCriteria;
import com.wheref.paperlessqms.web.rest.errors.BadRequestAlertException;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import tech.jhipster.service.filter.BooleanFilter;
import tech.jhipster.service.filter.IntegerFilter;
import tech.jhipster.service.filter.LongFilter;
import tech.jhipster.web.util.HeaderUtil;
import tech.jhipster.web.util.PaginationUtil;
import tech.jhipster.web.util.ResponseUtil;

/**
 * REST controller for managing {@link com.wheref.paperlessqms.domain.TokenIssued}.
 */
@RestController
@RequestMapping("/api/token-issueds")
public class TokenIssuedResource {

    private final Logger log = LoggerFactory.getLogger(TokenIssuedResource.class);

    private static final String ENTITY_NAME = "tokenIssued";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final TokenIssuedService tokenIssuedService;

    private final TokenIssuedRepository tokenIssuedRepository;

    private final TokenIssuedQueryService tokenIssuedQueryService;

    private final SimpMessageSendingOperations messagingTemplate;

    public TokenIssuedResource(
        TokenIssuedService tokenIssuedService,
        TokenIssuedRepository tokenIssuedRepository,
        TokenIssuedQueryService tokenIssuedQueryService,
        SimpMessageSendingOperations messagingTemplate
    ) {
        this.tokenIssuedService = tokenIssuedService;
        this.tokenIssuedRepository = tokenIssuedRepository;
        this.tokenIssuedQueryService = tokenIssuedQueryService;
        this.messagingTemplate = messagingTemplate;
    }

    /**
     * {@code POST  /token-issueds} : Create a new tokenIssued.
     *
     * @param tokenIssued the tokenIssued to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new tokenIssued, or with status {@code 400 (Bad Request)} if the tokenIssued has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<TokenIssued> createTokenIssued(@Valid @RequestBody TokenIssued tokenIssued) throws URISyntaxException {
        log.debug("REST request to save TokenIssued : {}", tokenIssued);
        if (tokenIssued.getId() != null) {
            throw new BadRequestAlertException("A new tokenIssued cannot already have an ID", ENTITY_NAME, "idexists");
        }
        TokenIssued result = tokenIssuedService.save(tokenIssued);

        sendMessage(result);

        return ResponseEntity
            .created(new URI("/api/token-issueds/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /token-issueds/:id} : Updates an existing tokenIssued.
     *
     * @param id the id of the tokenIssued to save.
     * @param tokenIssued the tokenIssued to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated tokenIssued,
     * or with status {@code 400 (Bad Request)} if the tokenIssued is not valid,
     * or with status {@code 500 (Internal Server Error)} if the tokenIssued couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<TokenIssued> updateTokenIssued(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody TokenIssued tokenIssued
    ) throws URISyntaxException {
        log.debug("REST request to update TokenIssued : {}, {}", id, tokenIssued);
        if (tokenIssued.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, tokenIssued.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!tokenIssuedRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        TokenIssued result = tokenIssuedService.update(tokenIssued);

        sendMessage(result);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, tokenIssued.getId().toString()))
            .body(result);
    }

    private void sendMessage(TokenIssued result) {
        sendMessageOnHomePage(result);
        sendMessageOnUniqueTokenPage(result);
        sendMessageOnRunningTokens(result);
        sendMessageCountCall(result);
        sendMessageCountList(result);
    }

    private void sendMessageCountCall(TokenIssued result) {
        TokenIssuedCriteria criteria = new TokenIssuedCriteria();
        LongFilter filter = new LongFilter();
        IntegerFilter filterStatus = new IntegerFilter();
        filter.setEquals(result.getDepartmentId());
        criteria.setDepartmentId(filter);

        StatusCode code = new StatusCode();
        List<Integer> codeList = new ArrayList<>();
        codeList.add(code.onwait);
        filterStatus.setIn(codeList);
        criteria.setStatusCode(filterStatus);

        long count = tokenIssuedQueryService.countByCriteria(criteria);
        messagingTemplate.convertAndSend("/topic/countCall/" + result.getDepartmentId(), count);
    }

    private void sendMessageCountList(TokenIssued result) {
        TokenIssuedCriteria criteria = new TokenIssuedCriteria();
        LongFilter filter = new LongFilter();
        LongFilter filter2 = new LongFilter();
        IntegerFilter filterStatus = new IntegerFilter();
        filter.setEquals(result.getDepartmentId());
        criteria.setDepartmentId(filter);

        filter2.setEquals(result.getTerminalId());
        criteria.setTerminalId(filter2);

        StatusCode code = new StatusCode();
        List<Integer> codeList = new ArrayList<>();
        codeList.add(code.onqueue);
        codeList.add(code.recall);
        codeList.add(code.transfer);
        filterStatus.setIn(codeList);
        criteria.setStatusCode(filterStatus);

        long count = tokenIssuedQueryService.countByCriteria(criteria);
        messagingTemplate.convertAndSend("/topic/countList/" + result.getDepartmentId() + "/" + result.getTerminalId(), count);
    }

    private void sendMessageOnRunningTokens(TokenIssued result) {
        TokenIssuedCriteria criteria = new TokenIssuedCriteria();
        Pageable pageable = PageRequest.of(0, 50, Sort.by(Direction.DESC, "statusCode", "modifiedDate"));
        LongFilter filter = new LongFilter();
        BooleanFilter filterReset = new BooleanFilter();
        filter.setEquals(result.getDepartmentId());
        filterReset.setEquals(false);
        criteria.setDepartmentId(filter);
        criteria.setReset(filterReset);
        Page<TokenIssued> page = tokenIssuedQueryService.findByCriteria(criteria, pageable);
        if (page.hasContent()) {
            messagingTemplate.convertAndSend("/topic/runningToken/" + result.getDepartmentId(), page.getContent());
        }
    }

    private void sendMessageOnUniqueTokenPage(TokenIssued result) {
        TokenIssuedCriteria criteria = new TokenIssuedCriteria();
        Pageable pageable = PageRequest.of(0, Integer.MAX_VALUE);
        LongFilter filter = new LongFilter();
        filter.setEquals(result.getId());
        criteria.setId(filter);

        Page<TokenIssued> page = tokenIssuedQueryService.findByCriteria(criteria, pageable);
        if (page.hasContent()) {
            TokenIssued issued = page.getContent().get(0);
            if (issued != null) {
                messagingTemplate.convertAndSend("/topic/tokenIssuedId/" + result.getId(), issued);
            }
        }
    }

    private void sendMessageOnHomePage(TokenIssued result) {
        TokenIssuedCriteria criteria = new TokenIssuedCriteria();
        Pageable pageable = PageRequest.of(0, Integer.MAX_VALUE);
        LongFilter filter = new LongFilter();
        BooleanFilter filterReset = new BooleanFilter();
        IntegerFilter filterStatus = new IntegerFilter();
        filterReset.setEquals(false);
        filter.setEquals(result.getUid());

        StatusCode code = new StatusCode();
        List<Integer> codeList = new ArrayList<>();
        codeList.add(code.onwait);
        codeList.add(code.onqueue);
        codeList.add(code.recall);
        codeList.add(code.transfer);
        filterStatus.setIn(codeList);

        criteria.setUid(filter);
        criteria.setReset(filterReset);
        criteria.setStatusCode(filterStatus);
        Page<TokenIssued> page = tokenIssuedQueryService.findByCriteria(criteria, pageable);
        if (page.hasContent()) {
            messagingTemplate.convertAndSend("/topic/tokenIssuedUid/" + result.getUid(), page.getContent());
        }
    }

    /**
     * {@code PATCH  /token-issueds/:id} : Partial updates given fields of an existing tokenIssued, field will ignore if it is null
     *
     * @param id the id of the tokenIssued to save.
     * @param tokenIssued the tokenIssued to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated tokenIssued,
     * or with status {@code 400 (Bad Request)} if the tokenIssued is not valid,
     * or with status {@code 404 (Not Found)} if the tokenIssued is not found,
     * or with status {@code 500 (Internal Server Error)} if the tokenIssued couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<TokenIssued> partialUpdateTokenIssued(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody TokenIssued tokenIssued
    ) throws URISyntaxException {
        log.debug("REST request to partial update TokenIssued partially : {}, {}", id, tokenIssued);
        if (tokenIssued.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, tokenIssued.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!tokenIssuedRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<TokenIssued> result = tokenIssuedService.partialUpdate(tokenIssued);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, tokenIssued.getId().toString())
        );
    }

    /**
     * {@code GET  /token-issueds} : get all the tokenIssueds.
     *
     * @param pageable the pagination information.
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of tokenIssueds in body.
     */
    @GetMapping("")
    public ResponseEntity<List<TokenIssued>> getAllTokenIssueds(
        TokenIssuedCriteria criteria,
        @org.springdoc.core.annotations.ParameterObject Pageable pageable
    ) {
        log.debug("REST request to get TokenIssueds by criteria: {}", criteria);

        Page<TokenIssued> page = tokenIssuedQueryService.findByCriteria(criteria, pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /token-issueds/count} : count all the tokenIssueds.
     *
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the count in body.
     */
    @GetMapping("/count")
    public ResponseEntity<Long> countTokenIssueds(TokenIssuedCriteria criteria) {
        log.debug("REST request to count TokenIssueds by criteria: {}", criteria);
        return ResponseEntity.ok().body(tokenIssuedQueryService.countByCriteria(criteria));
    }

    /**
     * {@code GET  /token-issueds/:id} : get the "id" tokenIssued.
     *
     * @param id the id of the tokenIssued to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the tokenIssued, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<TokenIssued> getTokenIssued(@PathVariable("id") Long id) {
        log.debug("REST request to get TokenIssued : {}", id);
        Optional<TokenIssued> tokenIssued = tokenIssuedService.findOne(id);
        return ResponseUtil.wrapOrNotFound(tokenIssued);
    }

    /**
     * {@code DELETE  /token-issueds/:id} : delete the "id" tokenIssued.
     *
     * @param id the id of the tokenIssued to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTokenIssued(@PathVariable("id") Long id) {
        log.debug("REST request to delete TokenIssued : {}", id);
        tokenIssuedService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}

class StatusCode {

    int onwait = 100;
    int onqueue = 200;
    int recall = 300;
    int completed = 400;
    int timeout = 500;
    int transfer = 600;
    int cancel = 700;
}

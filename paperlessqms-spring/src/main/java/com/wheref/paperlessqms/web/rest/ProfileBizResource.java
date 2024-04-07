package com.wheref.paperlessqms.web.rest;

import com.wheref.paperlessqms.domain.ProfileBiz;
import com.wheref.paperlessqms.repository.ProfileBizRepository;
import com.wheref.paperlessqms.service.ProfileBizQueryService;
import com.wheref.paperlessqms.service.ProfileBizService;
import com.wheref.paperlessqms.service.criteria.ProfileBizCriteria;
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
 * REST controller for managing {@link com.wheref.paperlessqms.domain.ProfileBiz}.
 */
@RestController
@RequestMapping("/api/profile-bizs")
public class ProfileBizResource {

    private final Logger log = LoggerFactory.getLogger(ProfileBizResource.class);

    private static final String ENTITY_NAME = "profileBiz";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final ProfileBizService profileBizService;

    private final ProfileBizRepository profileBizRepository;

    private final ProfileBizQueryService profileBizQueryService;

    public ProfileBizResource(
        ProfileBizService profileBizService,
        ProfileBizRepository profileBizRepository,
        ProfileBizQueryService profileBizQueryService
    ) {
        this.profileBizService = profileBizService;
        this.profileBizRepository = profileBizRepository;
        this.profileBizQueryService = profileBizQueryService;
    }

    /**
     * {@code POST  /profile-bizs} : Create a new profileBiz.
     *
     * @param profileBiz the profileBiz to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new profileBiz, or with status {@code 400 (Bad Request)} if the profileBiz has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<ProfileBiz> createProfileBiz(@Valid @RequestBody ProfileBiz profileBiz) throws URISyntaxException {
        log.debug("REST request to save ProfileBiz : {}", profileBiz);
        if (profileBiz.getId() != null) {
            throw new BadRequestAlertException("A new profileBiz cannot already have an ID", ENTITY_NAME, "idexists");
        }
        ProfileBiz result = profileBizService.save(profileBiz);
        return ResponseEntity
            .created(new URI("/api/profile-bizs/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /profile-bizs/:id} : Updates an existing profileBiz.
     *
     * @param id the id of the profileBiz to save.
     * @param profileBiz the profileBiz to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated profileBiz,
     * or with status {@code 400 (Bad Request)} if the profileBiz is not valid,
     * or with status {@code 500 (Internal Server Error)} if the profileBiz couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<ProfileBiz> updateProfileBiz(
        @PathVariable(value = "id", required = false) final Long id,
        @Valid @RequestBody ProfileBiz profileBiz
    ) throws URISyntaxException {
        log.debug("REST request to update ProfileBiz : {}, {}", id, profileBiz);
        if (profileBiz.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, profileBiz.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!profileBizRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        ProfileBiz result = profileBizService.update(profileBiz);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, profileBiz.getId().toString()))
            .body(result);
    }

    /**
     * {@code PATCH  /profile-bizs/:id} : Partial updates given fields of an existing profileBiz, field will ignore if it is null
     *
     * @param id the id of the profileBiz to save.
     * @param profileBiz the profileBiz to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated profileBiz,
     * or with status {@code 400 (Bad Request)} if the profileBiz is not valid,
     * or with status {@code 404 (Not Found)} if the profileBiz is not found,
     * or with status {@code 500 (Internal Server Error)} if the profileBiz couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<ProfileBiz> partialUpdateProfileBiz(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody ProfileBiz profileBiz
    ) throws URISyntaxException {
        log.debug("REST request to partial update ProfileBiz partially : {}, {}", id, profileBiz);
        if (profileBiz.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, profileBiz.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!profileBizRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<ProfileBiz> result = profileBizService.partialUpdate(profileBiz);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, profileBiz.getId().toString())
        );
    }

    /**
     * {@code GET  /profile-bizs} : get all the profileBizs.
     *
     * @param pageable the pagination information.
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of profileBizs in body.
     */
    @GetMapping("")
    public ResponseEntity<List<ProfileBiz>> getAllProfileBizs(
        ProfileBizCriteria criteria,
        @org.springdoc.core.annotations.ParameterObject Pageable pageable
    ) {
        log.debug("REST request to get ProfileBizs by criteria: {}", criteria);

        Page<ProfileBiz> page = profileBizQueryService.findByCriteria(criteria, pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /profile-bizs/count} : count all the profileBizs.
     *
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the count in body.
     */
    @GetMapping("/count")
    public ResponseEntity<Long> countProfileBizs(ProfileBizCriteria criteria) {
        log.debug("REST request to count ProfileBizs by criteria: {}", criteria);
        return ResponseEntity.ok().body(profileBizQueryService.countByCriteria(criteria));
    }

    /**
     * {@code GET  /profile-bizs/:id} : get the "id" profileBiz.
     *
     * @param id the id of the profileBiz to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the profileBiz, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<ProfileBiz> getProfileBiz(@PathVariable("id") Long id) {
        log.debug("REST request to get ProfileBiz : {}", id);
        Optional<ProfileBiz> profileBiz = profileBizService.findOne(id);
        return ResponseUtil.wrapOrNotFound(profileBiz);
    }

    /**
     * {@code DELETE  /profile-bizs/:id} : delete the "id" profileBiz.
     *
     * @param id the id of the profileBiz to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProfileBiz(@PathVariable("id") Long id) {
        log.debug("REST request to delete ProfileBiz : {}", id);
        profileBizService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}

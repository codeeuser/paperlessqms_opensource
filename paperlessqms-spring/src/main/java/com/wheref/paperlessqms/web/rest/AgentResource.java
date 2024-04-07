package com.wheref.paperlessqms.web.rest;

import com.wheref.paperlessqms.domain.Agent;
import com.wheref.paperlessqms.repository.AgentRepository;
import com.wheref.paperlessqms.service.AgentQueryService;
import com.wheref.paperlessqms.service.AgentService;
import com.wheref.paperlessqms.service.criteria.AgentCriteria;
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
 * REST controller for managing {@link com.wheref.paperlessqms.domain.Agent}.
 */
@RestController
@RequestMapping("/api/agents")
public class AgentResource {

    private final Logger log = LoggerFactory.getLogger(AgentResource.class);

    private static final String ENTITY_NAME = "agent";

    @Value("${jhipster.clientApp.name}")
    private String applicationName;

    private final AgentService agentService;

    private final AgentRepository agentRepository;

    private final AgentQueryService agentQueryService;

    public AgentResource(AgentService agentService, AgentRepository agentRepository, AgentQueryService agentQueryService) {
        this.agentService = agentService;
        this.agentRepository = agentRepository;
        this.agentQueryService = agentQueryService;
    }

    /**
     * {@code POST  /agents} : Create a new agent.
     *
     * @param agent the agent to create.
     * @return the {@link ResponseEntity} with status {@code 201 (Created)} and with body the new agent, or with status {@code 400 (Bad Request)} if the agent has already an ID.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PostMapping("")
    public ResponseEntity<Agent> createAgent(@Valid @RequestBody Agent agent) throws URISyntaxException {
        log.debug("REST request to save Agent : {}", agent);
        if (agent.getId() != null) {
            throw new BadRequestAlertException("A new agent cannot already have an ID", ENTITY_NAME, "idexists");
        }
        Agent result = agentService.save(agent);
        return ResponseEntity
            .created(new URI("/api/agents/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(applicationName, true, ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * {@code PUT  /agents/:id} : Updates an existing agent.
     *
     * @param id the id of the agent to save.
     * @param agent the agent to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated agent,
     * or with status {@code 400 (Bad Request)} if the agent is not valid,
     * or with status {@code 500 (Internal Server Error)} if the agent couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PutMapping("/{id}")
    public ResponseEntity<Agent> updateAgent(@PathVariable(value = "id", required = false) final Long id, @Valid @RequestBody Agent agent)
        throws URISyntaxException {
        log.debug("REST request to update Agent : {}, {}", id, agent);
        if (agent.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, agent.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!agentRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Agent result = agentService.update(agent);
        return ResponseEntity
            .ok()
            .headers(HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, agent.getId().toString()))
            .body(result);
    }

    /**
     * {@code PATCH  /agents/:id} : Partial updates given fields of an existing agent, field will ignore if it is null
     *
     * @param id the id of the agent to save.
     * @param agent the agent to update.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the updated agent,
     * or with status {@code 400 (Bad Request)} if the agent is not valid,
     * or with status {@code 404 (Not Found)} if the agent is not found,
     * or with status {@code 500 (Internal Server Error)} if the agent couldn't be updated.
     * @throws URISyntaxException if the Location URI syntax is incorrect.
     */
    @PatchMapping(value = "/{id}", consumes = { "application/json", "application/merge-patch+json" })
    public ResponseEntity<Agent> partialUpdateAgent(
        @PathVariable(value = "id", required = false) final Long id,
        @NotNull @RequestBody Agent agent
    ) throws URISyntaxException {
        log.debug("REST request to partial update Agent partially : {}, {}", id, agent);
        if (agent.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        if (!Objects.equals(id, agent.getId())) {
            throw new BadRequestAlertException("Invalid ID", ENTITY_NAME, "idinvalid");
        }

        if (!agentRepository.existsById(id)) {
            throw new BadRequestAlertException("Entity not found", ENTITY_NAME, "idnotfound");
        }

        Optional<Agent> result = agentService.partialUpdate(agent);

        return ResponseUtil.wrapOrNotFound(
            result,
            HeaderUtil.createEntityUpdateAlert(applicationName, true, ENTITY_NAME, agent.getId().toString())
        );
    }

    /**
     * {@code GET  /agents} : get all the agents.
     *
     * @param pageable the pagination information.
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the list of agents in body.
     */
    @GetMapping("")
    public ResponseEntity<List<Agent>> getAllAgents(
        AgentCriteria criteria,
        @org.springdoc.core.annotations.ParameterObject Pageable pageable
    ) {
        log.debug("REST request to get Agents by criteria: {}", criteria);

        Page<Agent> page = agentQueryService.findByCriteria(criteria, pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(ServletUriComponentsBuilder.fromCurrentRequest(), page);
        return ResponseEntity.ok().headers(headers).body(page.getContent());
    }

    /**
     * {@code GET  /agents/count} : count all the agents.
     *
     * @param criteria the criteria which the requested entities should match.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and the count in body.
     */
    @GetMapping("/count")
    public ResponseEntity<Long> countAgents(AgentCriteria criteria) {
        log.debug("REST request to count Agents by criteria: {}", criteria);
        return ResponseEntity.ok().body(agentQueryService.countByCriteria(criteria));
    }

    /**
     * {@code GET  /agents/:id} : get the "id" agent.
     *
     * @param id the id of the agent to retrieve.
     * @return the {@link ResponseEntity} with status {@code 200 (OK)} and with body the agent, or with status {@code 404 (Not Found)}.
     */
    @GetMapping("/{id}")
    public ResponseEntity<Agent> getAgent(@PathVariable("id") Long id) {
        log.debug("REST request to get Agent : {}", id);
        Optional<Agent> agent = agentService.findOne(id);
        return ResponseUtil.wrapOrNotFound(agent);
    }

    /**
     * {@code DELETE  /agents/:id} : delete the "id" agent.
     *
     * @param id the id of the agent to delete.
     * @return the {@link ResponseEntity} with status {@code 204 (NO_CONTENT)}.
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAgent(@PathVariable("id") Long id) {
        log.debug("REST request to delete Agent : {}", id);
        agentService.delete(id);
        return ResponseEntity
            .noContent()
            .headers(HeaderUtil.createEntityDeletionAlert(applicationName, true, ENTITY_NAME, id.toString()))
            .build();
    }
}

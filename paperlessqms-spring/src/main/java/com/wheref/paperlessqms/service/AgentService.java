package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.Agent;
import com.wheref.paperlessqms.repository.AgentRepository;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.wheref.paperlessqms.domain.Agent}.
 */
@Service
@Transactional
public class AgentService {

    private final Logger log = LoggerFactory.getLogger(AgentService.class);

    private final AgentRepository agentRepository;

    public AgentService(AgentRepository agentRepository) {
        this.agentRepository = agentRepository;
    }

    /**
     * Save a agent.
     *
     * @param agent the entity to save.
     * @return the persisted entity.
     */
    public Agent save(Agent agent) {
        log.debug("Request to save Agent : {}", agent);
        return agentRepository.save(agent);
    }

    /**
     * Update a agent.
     *
     * @param agent the entity to save.
     * @return the persisted entity.
     */
    public Agent update(Agent agent) {
        log.debug("Request to update Agent : {}", agent);
        return agentRepository.save(agent);
    }

    /**
     * Partially update a agent.
     *
     * @param agent the entity to update partially.
     * @return the persisted entity.
     */
    public Optional<Agent> partialUpdate(Agent agent) {
        log.debug("Request to partially update Agent : {}", agent);

        return agentRepository
            .findById(agent.getId())
            .map(existingAgent -> {
                if (agent.getProfileBizId() != null) {
                    existingAgent.setProfileBizId(agent.getProfileBizId());
                }
                if (agent.getUid() != null) {
                    existingAgent.setUid(agent.getUid());
                }
                if (agent.getLogin() != null) {
                    existingAgent.setLogin(agent.getLogin());
                }
                if (agent.getEmail() != null) {
                    existingAgent.setEmail(agent.getEmail());
                }
                if (agent.getUpdateUid() != null) {
                    existingAgent.setUpdateUid(agent.getUpdateUid());
                }
                if (agent.getEnable() != null) {
                    existingAgent.setEnable(agent.getEnable());
                }
                if (agent.getOrderNum() != null) {
                    existingAgent.setOrderNum(agent.getOrderNum());
                }
                if (agent.getCreatedDate() != null) {
                    existingAgent.setCreatedDate(agent.getCreatedDate());
                }
                if (agent.getModifiedDate() != null) {
                    existingAgent.setModifiedDate(agent.getModifiedDate());
                }

                return existingAgent;
            })
            .map(agentRepository::save);
    }

    /**
     * Get all the agents.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    @Transactional(readOnly = true)
    public Page<Agent> findAll(Pageable pageable) {
        log.debug("Request to get all Agents");
        return agentRepository.findAll(pageable);
    }

    /**
     * Get one agent by id.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    @Transactional(readOnly = true)
    public Optional<Agent> findOne(Long id) {
        log.debug("Request to get Agent : {}", id);
        return agentRepository.findById(id);
    }

    /**
     * Delete the agent by id.
     *
     * @param id the id of the entity.
     */
    public void delete(Long id) {
        log.debug("Request to delete Agent : {}", id);
        agentRepository.deleteById(id);
    }
}

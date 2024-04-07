package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.*; // for static metamodels
import com.wheref.paperlessqms.domain.Agent;
import com.wheref.paperlessqms.repository.AgentRepository;
import com.wheref.paperlessqms.service.criteria.AgentCriteria;
import jakarta.persistence.criteria.JoinType;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import tech.jhipster.service.QueryService;

/**
 * Service for executing complex queries for {@link Agent} entities in the database.
 * The main input is a {@link AgentCriteria} which gets converted to {@link Specification},
 * in a way that all the filters must apply.
 * It returns a {@link List} of {@link Agent} or a {@link Page} of {@link Agent} which fulfills the criteria.
 */
@Service
@Transactional(readOnly = true)
public class AgentQueryService extends QueryService<Agent> {

    private final Logger log = LoggerFactory.getLogger(AgentQueryService.class);

    private final AgentRepository agentRepository;

    public AgentQueryService(AgentRepository agentRepository) {
        this.agentRepository = agentRepository;
    }

    /**
     * Return a {@link List} of {@link Agent} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public List<Agent> findByCriteria(AgentCriteria criteria) {
        log.debug("find by criteria : {}", criteria);
        final Specification<Agent> specification = createSpecification(criteria);
        return agentRepository.findAll(specification);
    }

    /**
     * Return a {@link Page} of {@link Agent} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @param page The page, which should be returned.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public Page<Agent> findByCriteria(AgentCriteria criteria, Pageable page) {
        log.debug("find by criteria : {}, page: {}", criteria, page);
        final Specification<Agent> specification = createSpecification(criteria);
        return agentRepository.findAll(specification, page);
    }

    /**
     * Return the number of matching entities in the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the number of matching entities.
     */
    @Transactional(readOnly = true)
    public long countByCriteria(AgentCriteria criteria) {
        log.debug("count by criteria : {}", criteria);
        final Specification<Agent> specification = createSpecification(criteria);
        return agentRepository.count(specification);
    }

    /**
     * Function to convert {@link AgentCriteria} to a {@link Specification}
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching {@link Specification} of the entity.
     */
    protected Specification<Agent> createSpecification(AgentCriteria criteria) {
        Specification<Agent> specification = Specification.where(null);
        if (criteria != null) {
            // This has to be called first, because the distinct method returns null
            if (criteria.getDistinct() != null) {
                specification = specification.and(distinct(criteria.getDistinct()));
            }
            if (criteria.getId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getId(), Agent_.id));
            }
            if (criteria.getProfileBizId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getProfileBizId(), Agent_.profileBizId));
            }
            if (criteria.getUid() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getUid(), Agent_.uid));
            }
            if (criteria.getLogin() != null) {
                specification = specification.and(buildStringSpecification(criteria.getLogin(), Agent_.login));
            }
            if (criteria.getEmail() != null) {
                specification = specification.and(buildStringSpecification(criteria.getEmail(), Agent_.email));
            }
            if (criteria.getUpdateUid() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getUpdateUid(), Agent_.updateUid));
            }
            if (criteria.getEnable() != null) {
                specification = specification.and(buildSpecification(criteria.getEnable(), Agent_.enable));
            }
            if (criteria.getOrderNum() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getOrderNum(), Agent_.orderNum));
            }
            if (criteria.getCreatedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedDate(), Agent_.createdDate));
            }
            if (criteria.getModifiedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedDate(), Agent_.modifiedDate));
            }
            if (criteria.getQueueTerminalId() != null) {
                specification =
                    specification.and(
                        buildSpecification(
                            criteria.getQueueTerminalId(),
                            root -> root.join(Agent_.queueTerminal, JoinType.LEFT).get(QueueTerminal_.id)
                        )
                    );
            }
            if (criteria.getQueueDepartmentId() != null) {
                specification =
                    specification.and(
                        buildSpecification(
                            criteria.getQueueDepartmentId(),
                            root -> root.join(Agent_.queueDepartment, JoinType.LEFT).get(QueueDepartment_.id)
                        )
                    );
            }
        }
        return specification;
    }
}

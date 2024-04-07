package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.*; // for static metamodels
import com.wheref.paperlessqms.domain.QueueTerminal;
import com.wheref.paperlessqms.repository.QueueTerminalRepository;
import com.wheref.paperlessqms.service.criteria.QueueTerminalCriteria;
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
 * Service for executing complex queries for {@link QueueTerminal} entities in the database.
 * The main input is a {@link QueueTerminalCriteria} which gets converted to {@link Specification},
 * in a way that all the filters must apply.
 * It returns a {@link List} of {@link QueueTerminal} or a {@link Page} of {@link QueueTerminal} which fulfills the criteria.
 */
@Service
@Transactional(readOnly = true)
public class QueueTerminalQueryService extends QueryService<QueueTerminal> {

    private final Logger log = LoggerFactory.getLogger(QueueTerminalQueryService.class);

    private final QueueTerminalRepository queueTerminalRepository;

    public QueueTerminalQueryService(QueueTerminalRepository queueTerminalRepository) {
        this.queueTerminalRepository = queueTerminalRepository;
    }

    /**
     * Return a {@link List} of {@link QueueTerminal} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public List<QueueTerminal> findByCriteria(QueueTerminalCriteria criteria) {
        log.debug("find by criteria : {}", criteria);
        final Specification<QueueTerminal> specification = createSpecification(criteria);
        return queueTerminalRepository.findAll(specification);
    }

    /**
     * Return a {@link Page} of {@link QueueTerminal} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @param page The page, which should be returned.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public Page<QueueTerminal> findByCriteria(QueueTerminalCriteria criteria, Pageable page) {
        log.debug("find by criteria : {}, page: {}", criteria, page);
        final Specification<QueueTerminal> specification = createSpecification(criteria);
        return queueTerminalRepository.findAll(specification, page);
    }

    /**
     * Return the number of matching entities in the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the number of matching entities.
     */
    @Transactional(readOnly = true)
    public long countByCriteria(QueueTerminalCriteria criteria) {
        log.debug("count by criteria : {}", criteria);
        final Specification<QueueTerminal> specification = createSpecification(criteria);
        return queueTerminalRepository.count(specification);
    }

    /**
     * Function to convert {@link QueueTerminalCriteria} to a {@link Specification}
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching {@link Specification} of the entity.
     */
    protected Specification<QueueTerminal> createSpecification(QueueTerminalCriteria criteria) {
        Specification<QueueTerminal> specification = Specification.where(null);
        if (criteria != null) {
            // This has to be called first, because the distinct method returns null
            if (criteria.getDistinct() != null) {
                specification = specification.and(distinct(criteria.getDistinct()));
            }
            if (criteria.getId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getId(), QueueTerminal_.id));
            }
            if (criteria.getProfileBizId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getProfileBizId(), QueueTerminal_.profileBizId));
            }
            if (criteria.getName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getName(), QueueTerminal_.name));
            }
            if (criteria.getEnable() != null) {
                specification = specification.and(buildSpecification(criteria.getEnable(), QueueTerminal_.enable));
            }
            if (criteria.getOrderNum() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getOrderNum(), QueueTerminal_.orderNum));
            }
            if (criteria.getCreatedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedDate(), QueueTerminal_.createdDate));
            }
            if (criteria.getModifiedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedDate(), QueueTerminal_.modifiedDate));
            }
            if (criteria.getQueueDepartmentId() != null) {
                specification =
                    specification.and(
                        buildSpecification(
                            criteria.getQueueDepartmentId(),
                            root -> root.join(QueueTerminal_.queueDepartment, JoinType.LEFT).get(QueueDepartment_.id)
                        )
                    );
            }
            if (criteria.getAgentId() != null) {
                specification =
                    specification.and(
                        buildSpecification(criteria.getAgentId(), root -> root.join(QueueTerminal_.agents, JoinType.LEFT).get(Agent_.id))
                    );
            }
        }
        return specification;
    }
}

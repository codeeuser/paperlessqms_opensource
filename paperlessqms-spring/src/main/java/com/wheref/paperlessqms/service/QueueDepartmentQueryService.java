package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.*; // for static metamodels
import com.wheref.paperlessqms.domain.QueueDepartment;
import com.wheref.paperlessqms.repository.QueueDepartmentRepository;
import com.wheref.paperlessqms.service.criteria.QueueDepartmentCriteria;
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
 * Service for executing complex queries for {@link QueueDepartment} entities in the database.
 * The main input is a {@link QueueDepartmentCriteria} which gets converted to {@link Specification},
 * in a way that all the filters must apply.
 * It returns a {@link List} of {@link QueueDepartment} or a {@link Page} of {@link QueueDepartment} which fulfills the criteria.
 */
@Service
@Transactional(readOnly = true)
public class QueueDepartmentQueryService extends QueryService<QueueDepartment> {

    private final Logger log = LoggerFactory.getLogger(QueueDepartmentQueryService.class);

    private final QueueDepartmentRepository queueDepartmentRepository;

    public QueueDepartmentQueryService(QueueDepartmentRepository queueDepartmentRepository) {
        this.queueDepartmentRepository = queueDepartmentRepository;
    }

    /**
     * Return a {@link List} of {@link QueueDepartment} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public List<QueueDepartment> findByCriteria(QueueDepartmentCriteria criteria) {
        log.debug("find by criteria : {}", criteria);
        final Specification<QueueDepartment> specification = createSpecification(criteria);
        return queueDepartmentRepository.findAll(specification);
    }

    /**
     * Return a {@link Page} of {@link QueueDepartment} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @param page The page, which should be returned.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public Page<QueueDepartment> findByCriteria(QueueDepartmentCriteria criteria, Pageable page) {
        log.debug("find by criteria : {}, page: {}", criteria, page);
        final Specification<QueueDepartment> specification = createSpecification(criteria);
        return queueDepartmentRepository.findAll(specification, page);
    }

    /**
     * Return the number of matching entities in the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the number of matching entities.
     */
    @Transactional(readOnly = true)
    public long countByCriteria(QueueDepartmentCriteria criteria) {
        log.debug("count by criteria : {}", criteria);
        final Specification<QueueDepartment> specification = createSpecification(criteria);
        return queueDepartmentRepository.count(specification);
    }

    /**
     * Function to convert {@link QueueDepartmentCriteria} to a {@link Specification}
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching {@link Specification} of the entity.
     */
    protected Specification<QueueDepartment> createSpecification(QueueDepartmentCriteria criteria) {
        Specification<QueueDepartment> specification = Specification.where(null);
        if (criteria != null) {
            // This has to be called first, because the distinct method returns null
            if (criteria.getDistinct() != null) {
                specification = specification.and(distinct(criteria.getDistinct()));
            }
            if (criteria.getId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getId(), QueueDepartment_.id));
            }
            if (criteria.getProfileBizId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getProfileBizId(), QueueDepartment_.profileBizId));
            }
            if (criteria.getBizName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getBizName(), QueueDepartment_.bizName));
            }
            if (criteria.getBizCategoryName() != null) {
                specification =
                    specification.and(buildStringSpecification(criteria.getBizCategoryName(), QueueDepartment_.bizCategoryName));
            }
            if (criteria.getName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getName(), QueueDepartment_.name));
            }
            if (criteria.getDesc() != null) {
                specification = specification.and(buildStringSpecification(criteria.getDesc(), QueueDepartment_.desc));
            }
            if (criteria.getLat() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getLat(), QueueDepartment_.lat));
            }
            if (criteria.getLng() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getLng(), QueueDepartment_.lng));
            }
            if (criteria.getTimeZone() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getTimeZone(), QueueDepartment_.timeZone));
            }
            if (criteria.getThreshold() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getThreshold(), QueueDepartment_.threshold));
            }
            if (criteria.getNearbyRange() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getNearbyRange(), QueueDepartment_.nearbyRange));
            }
            if (criteria.getTokenTimeoutMin() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getTokenTimeoutMin(), QueueDepartment_.tokenTimeoutMin));
            }
            if (criteria.getSelected() != null) {
                specification = specification.and(buildSpecification(criteria.getSelected(), QueueDepartment_.selected));
            }
            if (criteria.getEnable() != null) {
                specification = specification.and(buildSpecification(criteria.getEnable(), QueueDepartment_.enable));
            }
            if (criteria.getOrderNum() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getOrderNum(), QueueDepartment_.orderNum));
            }
            if (criteria.getCurrencySymbol() != null) {
                specification = specification.and(buildStringSpecification(criteria.getCurrencySymbol(), QueueDepartment_.currencySymbol));
            }
            if (criteria.getLenMetric() != null) {
                specification = specification.and(buildStringSpecification(criteria.getLenMetric(), QueueDepartment_.lenMetric));
            }
            if (criteria.getCurrencyCode() != null) {
                specification = specification.and(buildStringSpecification(criteria.getCurrencyCode(), QueueDepartment_.currencyCode));
            }
            if (criteria.getBannerName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getBannerName(), QueueDepartment_.bannerName));
            }
            if (criteria.getCreatedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedDate(), QueueDepartment_.createdDate));
            }
            if (criteria.getModifiedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedDate(), QueueDepartment_.modifiedDate));
            }
            if (criteria.getAgentId() != null) {
                specification =
                    specification.and(
                        buildSpecification(criteria.getAgentId(), root -> root.join(QueueDepartment_.agents, JoinType.LEFT).get(Agent_.id))
                    );
            }
            if (criteria.getQueueTerminalId() != null) {
                specification =
                    specification.and(
                        buildSpecification(
                            criteria.getQueueTerminalId(),
                            root -> root.join(QueueDepartment_.queueTerminals, JoinType.LEFT).get(QueueTerminal_.id)
                        )
                    );
            }
            if (criteria.getQueueServiceId() != null) {
                specification =
                    specification.and(
                        buildSpecification(
                            criteria.getQueueServiceId(),
                            root -> root.join(QueueDepartment_.queueServices, JoinType.LEFT).get(QueueService_.id)
                        )
                    );
            }
        }
        return specification;
    }
}

package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.*; // for static metamodels
import com.wheref.paperlessqms.domain.QueueService;
import com.wheref.paperlessqms.repository.QueueServiceRepository;
import com.wheref.paperlessqms.service.criteria.QueueServiceCriteria;
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
 * Service for executing complex queries for {@link QueueService} entities in the database.
 * The main input is a {@link QueueServiceCriteria} which gets converted to {@link Specification},
 * in a way that all the filters must apply.
 * It returns a {@link List} of {@link QueueService} or a {@link Page} of {@link QueueService} which fulfills the criteria.
 */
@Service
@Transactional(readOnly = true)
public class QueueServiceQueryService extends QueryService<QueueService> {

    private final Logger log = LoggerFactory.getLogger(QueueServiceQueryService.class);

    private final QueueServiceRepository queueServiceRepository;

    public QueueServiceQueryService(QueueServiceRepository queueServiceRepository) {
        this.queueServiceRepository = queueServiceRepository;
    }

    /**
     * Return a {@link List} of {@link QueueService} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public List<QueueService> findByCriteria(QueueServiceCriteria criteria) {
        log.debug("find by criteria : {}", criteria);
        final Specification<QueueService> specification = createSpecification(criteria);
        return queueServiceRepository.findAll(specification);
    }

    /**
     * Return a {@link Page} of {@link QueueService} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @param page The page, which should be returned.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public Page<QueueService> findByCriteria(QueueServiceCriteria criteria, Pageable page) {
        log.debug("find by criteria : {}, page: {}", criteria, page);
        final Specification<QueueService> specification = createSpecification(criteria);
        return queueServiceRepository.findAll(specification, page);
    }

    /**
     * Return the number of matching entities in the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the number of matching entities.
     */
    @Transactional(readOnly = true)
    public long countByCriteria(QueueServiceCriteria criteria) {
        log.debug("count by criteria : {}", criteria);
        final Specification<QueueService> specification = createSpecification(criteria);
        return queueServiceRepository.count(specification);
    }

    /**
     * Function to convert {@link QueueServiceCriteria} to a {@link Specification}
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching {@link Specification} of the entity.
     */
    protected Specification<QueueService> createSpecification(QueueServiceCriteria criteria) {
        Specification<QueueService> specification = Specification.where(null);
        if (criteria != null) {
            // This has to be called first, because the distinct method returns null
            if (criteria.getDistinct() != null) {
                specification = specification.and(distinct(criteria.getDistinct()));
            }
            if (criteria.getId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getId(), QueueService_.id));
            }
            if (criteria.getProfileBizId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getProfileBizId(), QueueService_.profileBizId));
            }
            if (criteria.getName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getName(), QueueService_.name));
            }
            if (criteria.getType() != null) {
                specification = specification.and(buildStringSpecification(criteria.getType(), QueueService_.type));
            }
            if (criteria.getLetter() != null) {
                specification = specification.and(buildStringSpecification(criteria.getLetter(), QueueService_.letter));
            }
            if (criteria.getStart() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getStart(), QueueService_.start));
            }
            if (criteria.getDesc() != null) {
                specification = specification.and(buildStringSpecification(criteria.getDesc(), QueueService_.desc));
            }
            if (criteria.getEnable() != null) {
                specification = specification.and(buildSpecification(criteria.getEnable(), QueueService_.enable));
            }
            if (criteria.getOrderNum() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getOrderNum(), QueueService_.orderNum));
            }
            if (criteria.getEnableCatalog() != null) {
                specification = specification.and(buildSpecification(criteria.getEnableCatalog(), QueueService_.enableCatalog));
            }
            if (criteria.getCreatedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedDate(), QueueService_.createdDate));
            }
            if (criteria.getModifiedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedDate(), QueueService_.modifiedDate));
            }
            if (criteria.getQueueDepartmentId() != null) {
                specification =
                    specification.and(
                        buildSpecification(
                            criteria.getQueueDepartmentId(),
                            root -> root.join(QueueService_.queueDepartment, JoinType.LEFT).get(QueueDepartment_.id)
                        )
                    );
            }
        }
        return specification;
    }
}

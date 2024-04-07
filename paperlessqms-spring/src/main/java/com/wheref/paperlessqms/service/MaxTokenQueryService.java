package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.*; // for static metamodels
import com.wheref.paperlessqms.domain.MaxToken;
import com.wheref.paperlessqms.repository.MaxTokenRepository;
import com.wheref.paperlessqms.service.criteria.MaxTokenCriteria;
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
 * Service for executing complex queries for {@link MaxToken} entities in the database.
 * The main input is a {@link MaxTokenCriteria} which gets converted to {@link Specification},
 * in a way that all the filters must apply.
 * It returns a {@link List} of {@link MaxToken} or a {@link Page} of {@link MaxToken} which fulfills the criteria.
 */
@Service
@Transactional(readOnly = true)
public class MaxTokenQueryService extends QueryService<MaxToken> {

    private final Logger log = LoggerFactory.getLogger(MaxTokenQueryService.class);

    private final MaxTokenRepository maxTokenRepository;

    public MaxTokenQueryService(MaxTokenRepository maxTokenRepository) {
        this.maxTokenRepository = maxTokenRepository;
    }

    /**
     * Return a {@link List} of {@link MaxToken} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public List<MaxToken> findByCriteria(MaxTokenCriteria criteria) {
        log.debug("find by criteria : {}", criteria);
        final Specification<MaxToken> specification = createSpecification(criteria);
        return maxTokenRepository.findAll(specification);
    }

    /**
     * Return a {@link Page} of {@link MaxToken} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @param page The page, which should be returned.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public Page<MaxToken> findByCriteria(MaxTokenCriteria criteria, Pageable page) {
        log.debug("find by criteria : {}, page: {}", criteria, page);
        final Specification<MaxToken> specification = createSpecification(criteria);
        return maxTokenRepository.findAll(specification, page);
    }

    /**
     * Return the number of matching entities in the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the number of matching entities.
     */
    @Transactional(readOnly = true)
    public long countByCriteria(MaxTokenCriteria criteria) {
        log.debug("count by criteria : {}", criteria);
        final Specification<MaxToken> specification = createSpecification(criteria);
        return maxTokenRepository.count(specification);
    }

    /**
     * Function to convert {@link MaxTokenCriteria} to a {@link Specification}
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching {@link Specification} of the entity.
     */
    protected Specification<MaxToken> createSpecification(MaxTokenCriteria criteria) {
        Specification<MaxToken> specification = Specification.where(null);
        if (criteria != null) {
            // This has to be called first, because the distinct method returns null
            if (criteria.getDistinct() != null) {
                specification = specification.and(distinct(criteria.getDistinct()));
            }
            if (criteria.getId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getId(), MaxToken_.id));
            }
            if (criteria.getProfileBizId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getProfileBizId(), MaxToken_.profileBizId));
            }
            if (criteria.getMaxToken() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getMaxToken(), MaxToken_.maxToken));
            }
            if (criteria.getDayNum() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getDayNum(), MaxToken_.dayNum));
            }
            if (criteria.getModifiedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedDate(), MaxToken_.modifiedDate));
            }
            if (criteria.getCreatedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedDate(), MaxToken_.createdDate));
            }
        }
        return specification;
    }
}

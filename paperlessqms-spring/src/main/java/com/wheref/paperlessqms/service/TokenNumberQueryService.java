package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.*; // for static metamodels
import com.wheref.paperlessqms.domain.TokenNumber;
import com.wheref.paperlessqms.repository.TokenNumberRepository;
import com.wheref.paperlessqms.service.criteria.TokenNumberCriteria;
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
 * Service for executing complex queries for {@link TokenNumber} entities in the database.
 * The main input is a {@link TokenNumberCriteria} which gets converted to {@link Specification},
 * in a way that all the filters must apply.
 * It returns a {@link List} of {@link TokenNumber} or a {@link Page} of {@link TokenNumber} which fulfills the criteria.
 */
@Service
@Transactional(readOnly = true)
public class TokenNumberQueryService extends QueryService<TokenNumber> {

    private final Logger log = LoggerFactory.getLogger(TokenNumberQueryService.class);

    private final TokenNumberRepository tokenNumberRepository;

    public TokenNumberQueryService(TokenNumberRepository tokenNumberRepository) {
        this.tokenNumberRepository = tokenNumberRepository;
    }

    /**
     * Return a {@link List} of {@link TokenNumber} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public List<TokenNumber> findByCriteria(TokenNumberCriteria criteria) {
        log.debug("find by criteria : {}", criteria);
        final Specification<TokenNumber> specification = createSpecification(criteria);
        return tokenNumberRepository.findAll(specification);
    }

    /**
     * Return a {@link Page} of {@link TokenNumber} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @param page The page, which should be returned.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public Page<TokenNumber> findByCriteria(TokenNumberCriteria criteria, Pageable page) {
        log.debug("find by criteria : {}, page: {}", criteria, page);
        final Specification<TokenNumber> specification = createSpecification(criteria);
        return tokenNumberRepository.findAll(specification, page);
    }

    /**
     * Return the number of matching entities in the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the number of matching entities.
     */
    @Transactional(readOnly = true)
    public long countByCriteria(TokenNumberCriteria criteria) {
        log.debug("count by criteria : {}", criteria);
        final Specification<TokenNumber> specification = createSpecification(criteria);
        return tokenNumberRepository.count(specification);
    }

    /**
     * Function to convert {@link TokenNumberCriteria} to a {@link Specification}
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching {@link Specification} of the entity.
     */
    protected Specification<TokenNumber> createSpecification(TokenNumberCriteria criteria) {
        Specification<TokenNumber> specification = Specification.where(null);
        if (criteria != null) {
            // This has to be called first, because the distinct method returns null
            if (criteria.getDistinct() != null) {
                specification = specification.and(distinct(criteria.getDistinct()));
            }
            if (criteria.getId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getId(), TokenNumber_.id));
            }
            if (criteria.getNumber() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getNumber(), TokenNumber_.number));
            }
            if (criteria.getDepartmentId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getDepartmentId(), TokenNumber_.departmentId));
            }
            if (criteria.getServiceId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getServiceId(), TokenNumber_.serviceId));
            }
            if (criteria.getReset() != null) {
                specification = specification.and(buildSpecification(criteria.getReset(), TokenNumber_.reset));
            }
        }
        return specification;
    }
}

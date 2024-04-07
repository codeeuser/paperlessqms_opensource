package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.*; // for static metamodels
import com.wheref.paperlessqms.domain.OpenHour;
import com.wheref.paperlessqms.repository.OpenHourRepository;
import com.wheref.paperlessqms.service.criteria.OpenHourCriteria;
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
 * Service for executing complex queries for {@link OpenHour} entities in the database.
 * The main input is a {@link OpenHourCriteria} which gets converted to {@link Specification},
 * in a way that all the filters must apply.
 * It returns a {@link List} of {@link OpenHour} or a {@link Page} of {@link OpenHour} which fulfills the criteria.
 */
@Service
@Transactional(readOnly = true)
public class OpenHourQueryService extends QueryService<OpenHour> {

    private final Logger log = LoggerFactory.getLogger(OpenHourQueryService.class);

    private final OpenHourRepository openHourRepository;

    public OpenHourQueryService(OpenHourRepository openHourRepository) {
        this.openHourRepository = openHourRepository;
    }

    /**
     * Return a {@link List} of {@link OpenHour} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public List<OpenHour> findByCriteria(OpenHourCriteria criteria) {
        log.debug("find by criteria : {}", criteria);
        final Specification<OpenHour> specification = createSpecification(criteria);
        return openHourRepository.findAll(specification);
    }

    /**
     * Return a {@link Page} of {@link OpenHour} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @param page The page, which should be returned.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public Page<OpenHour> findByCriteria(OpenHourCriteria criteria, Pageable page) {
        log.debug("find by criteria : {}, page: {}", criteria, page);
        final Specification<OpenHour> specification = createSpecification(criteria);
        return openHourRepository.findAll(specification, page);
    }

    /**
     * Return the number of matching entities in the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the number of matching entities.
     */
    @Transactional(readOnly = true)
    public long countByCriteria(OpenHourCriteria criteria) {
        log.debug("count by criteria : {}", criteria);
        final Specification<OpenHour> specification = createSpecification(criteria);
        return openHourRepository.count(specification);
    }

    /**
     * Function to convert {@link OpenHourCriteria} to a {@link Specification}
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching {@link Specification} of the entity.
     */
    protected Specification<OpenHour> createSpecification(OpenHourCriteria criteria) {
        Specification<OpenHour> specification = Specification.where(null);
        if (criteria != null) {
            // This has to be called first, because the distinct method returns null
            if (criteria.getDistinct() != null) {
                specification = specification.and(distinct(criteria.getDistinct()));
            }
            if (criteria.getId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getId(), OpenHour_.id));
            }
            if (criteria.getProfileBizId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getProfileBizId(), OpenHour_.profileBizId));
            }
            if (criteria.getStartHour() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getStartHour(), OpenHour_.startHour));
            }
            if (criteria.getStartMin() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getStartMin(), OpenHour_.startMin));
            }
            if (criteria.getEndHour() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getEndHour(), OpenHour_.endHour));
            }
            if (criteria.getEndMin() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getEndMin(), OpenHour_.endMin));
            }
            if (criteria.getDayNum() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getDayNum(), OpenHour_.dayNum));
            }
            if (criteria.getEnable() != null) {
                specification = specification.and(buildSpecification(criteria.getEnable(), OpenHour_.enable));
            }
            if (criteria.getModifiedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedDate(), OpenHour_.modifiedDate));
            }
            if (criteria.getCreatedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedDate(), OpenHour_.createdDate));
            }
        }
        return specification;
    }
}

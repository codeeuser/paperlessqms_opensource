package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.*; // for static metamodels
import com.wheref.paperlessqms.domain.ProfileBiz;
import com.wheref.paperlessqms.repository.ProfileBizRepository;
import com.wheref.paperlessqms.service.criteria.ProfileBizCriteria;
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
 * Service for executing complex queries for {@link ProfileBiz} entities in the database.
 * The main input is a {@link ProfileBizCriteria} which gets converted to {@link Specification},
 * in a way that all the filters must apply.
 * It returns a {@link List} of {@link ProfileBiz} or a {@link Page} of {@link ProfileBiz} which fulfills the criteria.
 */
@Service
@Transactional(readOnly = true)
public class ProfileBizQueryService extends QueryService<ProfileBiz> {

    private final Logger log = LoggerFactory.getLogger(ProfileBizQueryService.class);

    private final ProfileBizRepository profileBizRepository;

    public ProfileBizQueryService(ProfileBizRepository profileBizRepository) {
        this.profileBizRepository = profileBizRepository;
    }

    /**
     * Return a {@link List} of {@link ProfileBiz} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public List<ProfileBiz> findByCriteria(ProfileBizCriteria criteria) {
        log.debug("find by criteria : {}", criteria);
        final Specification<ProfileBiz> specification = createSpecification(criteria);
        return profileBizRepository.findAll(specification);
    }

    /**
     * Return a {@link Page} of {@link ProfileBiz} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @param page The page, which should be returned.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public Page<ProfileBiz> findByCriteria(ProfileBizCriteria criteria, Pageable page) {
        log.debug("find by criteria : {}, page: {}", criteria, page);
        final Specification<ProfileBiz> specification = createSpecification(criteria);
        return profileBizRepository.findAll(specification, page);
    }

    /**
     * Return the number of matching entities in the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the number of matching entities.
     */
    @Transactional(readOnly = true)
    public long countByCriteria(ProfileBizCriteria criteria) {
        log.debug("count by criteria : {}", criteria);
        final Specification<ProfileBiz> specification = createSpecification(criteria);
        return profileBizRepository.count(specification);
    }

    /**
     * Function to convert {@link ProfileBizCriteria} to a {@link Specification}
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching {@link Specification} of the entity.
     */
    protected Specification<ProfileBiz> createSpecification(ProfileBizCriteria criteria) {
        Specification<ProfileBiz> specification = Specification.where(null);
        if (criteria != null) {
            // This has to be called first, because the distinct method returns null
            if (criteria.getDistinct() != null) {
                specification = specification.and(distinct(criteria.getDistinct()));
            }
            if (criteria.getId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getId(), ProfileBiz_.id));
            }
            if (criteria.getBizName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getBizName(), ProfileBiz_.bizName));
            }
            if (criteria.getBizAddress() != null) {
                specification = specification.and(buildStringSpecification(criteria.getBizAddress(), ProfileBiz_.bizAddress));
            }
            if (criteria.getBizLevel() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getBizLevel(), ProfileBiz_.bizLevel));
            }
            if (criteria.getBizEmail() != null) {
                specification = specification.and(buildStringSpecification(criteria.getBizEmail(), ProfileBiz_.bizEmail));
            }
            if (criteria.getBizPhoneNumber() != null) {
                specification = specification.and(buildStringSpecification(criteria.getBizPhoneNumber(), ProfileBiz_.bizPhoneNumber));
            }
            if (criteria.getBizPhoneCode() != null) {
                specification = specification.and(buildStringSpecification(criteria.getBizPhoneCode(), ProfileBiz_.bizPhoneCode));
            }
            if (criteria.getBizPhoneIsoCode() != null) {
                specification = specification.and(buildStringSpecification(criteria.getBizPhoneIsoCode(), ProfileBiz_.bizPhoneIsoCode));
            }
            if (criteria.getBizWebsite() != null) {
                specification = specification.and(buildStringSpecification(criteria.getBizWebsite(), ProfileBiz_.bizWebsite));
            }
            if (criteria.getBizDesc() != null) {
                specification = specification.and(buildStringSpecification(criteria.getBizDesc(), ProfileBiz_.bizDesc));
            }
            if (criteria.getEnable() != null) {
                specification = specification.and(buildSpecification(criteria.getEnable(), ProfileBiz_.enable));
            }
            if (criteria.getCreatedByUid() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedByUid(), ProfileBiz_.createdByUid));
            }
            if (criteria.getUpdatedByUid() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getUpdatedByUid(), ProfileBiz_.updatedByUid));
            }
            if (criteria.getModifiedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedDate(), ProfileBiz_.modifiedDate));
            }
            if (criteria.getCreatedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedDate(), ProfileBiz_.createdDate));
            }
        }
        return specification;
    }
}

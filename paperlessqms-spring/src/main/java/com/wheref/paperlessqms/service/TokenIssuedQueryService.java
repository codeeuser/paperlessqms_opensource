package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.*; // for static metamodels
import com.wheref.paperlessqms.domain.TokenIssued;
import com.wheref.paperlessqms.repository.TokenIssuedRepository;
import com.wheref.paperlessqms.service.criteria.TokenIssuedCriteria;
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
 * Service for executing complex queries for {@link TokenIssued} entities in the database.
 * The main input is a {@link TokenIssuedCriteria} which gets converted to {@link Specification},
 * in a way that all the filters must apply.
 * It returns a {@link List} of {@link TokenIssued} or a {@link Page} of {@link TokenIssued} which fulfills the criteria.
 */
@Service
@Transactional(readOnly = true)
public class TokenIssuedQueryService extends QueryService<TokenIssued> {

    private final Logger log = LoggerFactory.getLogger(TokenIssuedQueryService.class);

    private final TokenIssuedRepository tokenIssuedRepository;

    public TokenIssuedQueryService(TokenIssuedRepository tokenIssuedRepository) {
        this.tokenIssuedRepository = tokenIssuedRepository;
    }

    /**
     * Return a {@link List} of {@link TokenIssued} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public List<TokenIssued> findByCriteria(TokenIssuedCriteria criteria) {
        log.debug("find by criteria : {}", criteria);
        final Specification<TokenIssued> specification = createSpecification(criteria);
        return tokenIssuedRepository.findAll(specification);
    }

    /**
     * Return a {@link Page} of {@link TokenIssued} which matches the criteria from the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @param page The page, which should be returned.
     * @return the matching entities.
     */
    @Transactional(readOnly = true)
    public Page<TokenIssued> findByCriteria(TokenIssuedCriteria criteria, Pageable page) {
        log.debug("find by criteria : {}, page: {}", criteria, page);
        final Specification<TokenIssued> specification = createSpecification(criteria);
        return tokenIssuedRepository.findAll(specification, page);
    }

    /**
     * Return the number of matching entities in the database.
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the number of matching entities.
     */
    @Transactional(readOnly = true)
    public long countByCriteria(TokenIssuedCriteria criteria) {
        log.debug("count by criteria : {}", criteria);
        final Specification<TokenIssued> specification = createSpecification(criteria);
        return tokenIssuedRepository.count(specification);
    }

    /**
     * Function to convert {@link TokenIssuedCriteria} to a {@link Specification}
     * @param criteria The object which holds all the filters, which the entities should match.
     * @return the matching {@link Specification} of the entity.
     */
    protected Specification<TokenIssued> createSpecification(TokenIssuedCriteria criteria) {
        Specification<TokenIssued> specification = Specification.where(null);
        if (criteria != null) {
            // This has to be called first, because the distinct method returns null
            if (criteria.getDistinct() != null) {
                specification = specification.and(distinct(criteria.getDistinct()));
            }
            if (criteria.getId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getId(), TokenIssued_.id));
            }
            if (criteria.getUid() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getUid(), TokenIssued_.uid));
            }
            if (criteria.getProfileBizId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getProfileBizId(), TokenIssued_.profileBizId));
            }
            if (criteria.getPhoneNumber() != null) {
                specification = specification.and(buildStringSpecification(criteria.getPhoneNumber(), TokenIssued_.phoneNumber));
            }
            if (criteria.getPhoneIsoCode() != null) {
                specification = specification.and(buildStringSpecification(criteria.getPhoneIsoCode(), TokenIssued_.phoneIsoCode));
            }
            if (criteria.getPhoneCode() != null) {
                specification = specification.and(buildStringSpecification(criteria.getPhoneCode(), TokenIssued_.phoneCode));
            }
            if (criteria.getUserEmail() != null) {
                specification = specification.and(buildStringSpecification(criteria.getUserEmail(), TokenIssued_.userEmail));
            }
            if (criteria.getUserFirstName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getUserFirstName(), TokenIssued_.userFirstName));
            }
            if (criteria.getUserLastName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getUserLastName(), TokenIssued_.userLastName));
            }
            if (criteria.getTokenLetter() != null) {
                specification = specification.and(buildStringSpecification(criteria.getTokenLetter(), TokenIssued_.tokenLetter));
            }
            if (criteria.getTokenNumber() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getTokenNumber(), TokenIssued_.tokenNumber));
            }
            if (criteria.getServiceName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getServiceName(), TokenIssued_.serviceName));
            }
            if (criteria.getServiceId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getServiceId(), TokenIssued_.serviceId));
            }
            if (criteria.getTerminalName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getTerminalName(), TokenIssued_.terminalName));
            }
            if (criteria.getTerminalId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getTerminalId(), TokenIssued_.terminalId));
            }
            if (criteria.getOrgTerminalName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getOrgTerminalName(), TokenIssued_.orgTerminalName));
            }
            if (criteria.getOrgTerminalId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getOrgTerminalId(), TokenIssued_.orgTerminalId));
            }
            if (criteria.getStatusName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getStatusName(), TokenIssued_.statusName));
            }
            if (criteria.getStatusCode() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getStatusCode(), TokenIssued_.statusCode));
            }
            if (criteria.getIsPending() != null) {
                specification = specification.and(buildSpecification(criteria.getIsPending(), TokenIssued_.isPending));
            }
            if (criteria.getIsQueue() != null) {
                specification = specification.and(buildSpecification(criteria.getIsQueue(), TokenIssued_.isQueue));
            }
            if (criteria.getIsReject() != null) {
                specification = specification.and(buildSpecification(criteria.getIsReject(), TokenIssued_.isReject));
            }
            if (criteria.getIsAbsent() != null) {
                specification = specification.and(buildSpecification(criteria.getIsAbsent(), TokenIssued_.isAbsent));
            }
            if (criteria.getIsCancel() != null) {
                specification = specification.and(buildSpecification(criteria.getIsCancel(), TokenIssued_.isCancel));
            }
            if (criteria.getIsRecall() != null) {
                specification = specification.and(buildSpecification(criteria.getIsRecall(), TokenIssued_.isRecall));
            }
            if (criteria.getIsCompleted() != null) {
                specification = specification.and(buildSpecification(criteria.getIsCompleted(), TokenIssued_.isCompleted));
            }
            if (criteria.getIsTimeout() != null) {
                specification = specification.and(buildSpecification(criteria.getIsTimeout(), TokenIssued_.isTimeout));
            }
            if (criteria.getAssignedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getAssignedDate(), TokenIssued_.assignedDate));
            }
            if (criteria.getAssignedYear() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getAssignedYear(), TokenIssued_.assignedYear));
            }
            if (criteria.getAssignedMonth() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getAssignedMonth(), TokenIssued_.assignedMonth));
            }
            if (criteria.getAssignedDay() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getAssignedDay(), TokenIssued_.assignedDay));
            }
            if (criteria.getAssignedHour() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getAssignedHour(), TokenIssued_.assignedHour));
            }
            if (criteria.getAssignedMin() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getAssignedMin(), TokenIssued_.assignedMin));
            }
            if (criteria.getAssignedTimeZoneOffset() != null) {
                specification =
                    specification.and(buildRangeSpecification(criteria.getAssignedTimeZoneOffset(), TokenIssued_.assignedTimeZoneOffset));
            }
            if (criteria.getAssignedTimeZoneName() != null) {
                specification =
                    specification.and(buildStringSpecification(criteria.getAssignedTimeZoneName(), TokenIssued_.assignedTimeZoneName));
            }
            if (criteria.getAssignedNow() != null) {
                specification = specification.and(buildStringSpecification(criteria.getAssignedNow(), TokenIssued_.assignedNow));
            }
            if (criteria.getAssignedUid() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getAssignedUid(), TokenIssued_.assignedUid));
            }
            if (criteria.getCompletedYear() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCompletedYear(), TokenIssued_.completedYear));
            }
            if (criteria.getCompletedMonth() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCompletedMonth(), TokenIssued_.completedMonth));
            }
            if (criteria.getCompletedDay() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCompletedDay(), TokenIssued_.completedDay));
            }
            if (criteria.getCompletedHour() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCompletedHour(), TokenIssued_.completedHour));
            }
            if (criteria.getCompletedMin() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCompletedMin(), TokenIssued_.completedMin));
            }
            if (criteria.getCompletedTimeZoneOffset() != null) {
                specification =
                    specification.and(buildRangeSpecification(criteria.getCompletedTimeZoneOffset(), TokenIssued_.completedTimeZoneOffset));
            }
            if (criteria.getCompletedTimeZoneName() != null) {
                specification =
                    specification.and(buildStringSpecification(criteria.getCompletedTimeZoneName(), TokenIssued_.completedTimeZoneName));
            }
            if (criteria.getCompletedNow() != null) {
                specification = specification.and(buildStringSpecification(criteria.getCompletedNow(), TokenIssued_.completedNow));
            }
            if (criteria.getCompletedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCompletedDate(), TokenIssued_.completedDate));
            }
            if (criteria.getCompletedUid() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCompletedUid(), TokenIssued_.completedUid));
            }
            if (criteria.getCreatedYear() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedYear(), TokenIssued_.createdYear));
            }
            if (criteria.getCreatedMonth() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedMonth(), TokenIssued_.createdMonth));
            }
            if (criteria.getCreatedDay() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedDay(), TokenIssued_.createdDay));
            }
            if (criteria.getCreatedHour() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedHour(), TokenIssued_.createdHour));
            }
            if (criteria.getCreatedMin() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedMin(), TokenIssued_.createdMin));
            }
            if (criteria.getCreatedTimeZoneOffset() != null) {
                specification =
                    specification.and(buildRangeSpecification(criteria.getCreatedTimeZoneOffset(), TokenIssued_.createdTimeZoneOffset));
            }
            if (criteria.getCreatedTimeZoneName() != null) {
                specification =
                    specification.and(buildStringSpecification(criteria.getCreatedTimeZoneName(), TokenIssued_.createdTimeZoneName));
            }
            if (criteria.getCreatedNow() != null) {
                specification = specification.and(buildStringSpecification(criteria.getCreatedNow(), TokenIssued_.createdNow));
            }
            if (criteria.getCreatedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getCreatedDate(), TokenIssued_.createdDate));
            }
            if (criteria.getModifiedYear() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedYear(), TokenIssued_.modifiedYear));
            }
            if (criteria.getModifiedMonth() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedMonth(), TokenIssued_.modifiedMonth));
            }
            if (criteria.getModifiedDay() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedDay(), TokenIssued_.modifiedDay));
            }
            if (criteria.getModifiedHour() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedHour(), TokenIssued_.modifiedHour));
            }
            if (criteria.getModifiedMin() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedMin(), TokenIssued_.modifiedMin));
            }
            if (criteria.getModifiedTimeZoneOffset() != null) {
                specification =
                    specification.and(buildRangeSpecification(criteria.getModifiedTimeZoneOffset(), TokenIssued_.modifiedTimeZoneOffset));
            }
            if (criteria.getModifiedTimeZoneName() != null) {
                specification =
                    specification.and(buildStringSpecification(criteria.getModifiedTimeZoneName(), TokenIssued_.modifiedTimeZoneName));
            }
            if (criteria.getModifiedNow() != null) {
                specification = specification.and(buildStringSpecification(criteria.getModifiedNow(), TokenIssued_.modifiedNow));
            }
            if (criteria.getModifiedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getModifiedDate(), TokenIssued_.modifiedDate));
            }
            if (criteria.getTransferedYear() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getTransferedYear(), TokenIssued_.transferedYear));
            }
            if (criteria.getTransferedMonth() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getTransferedMonth(), TokenIssued_.transferedMonth));
            }
            if (criteria.getTransferedDay() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getTransferedDay(), TokenIssued_.transferedDay));
            }
            if (criteria.getTransferedHour() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getTransferedHour(), TokenIssued_.transferedHour));
            }
            if (criteria.getTransferedMin() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getTransferedMin(), TokenIssued_.transferedMin));
            }
            if (criteria.getTransferedDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getTransferedDate(), TokenIssued_.transferedDate));
            }
            if (criteria.getTransferedTimeZoneOffset() != null) {
                specification =
                    specification.and(
                        buildRangeSpecification(criteria.getTransferedTimeZoneOffset(), TokenIssued_.transferedTimeZoneOffset)
                    );
            }
            if (criteria.getTransferedTimeZoneName() != null) {
                specification =
                    specification.and(buildStringSpecification(criteria.getTransferedTimeZoneName(), TokenIssued_.transferedTimeZoneName));
            }
            if (criteria.getTransferedNow() != null) {
                specification = specification.and(buildStringSpecification(criteria.getTransferedNow(), TokenIssued_.transferedNow));
            }
            if (criteria.getTransferedUid() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getTransferedUid(), TokenIssued_.transferedUid));
            }
            if (criteria.getIssuedFrom() != null) {
                specification = specification.and(buildStringSpecification(criteria.getIssuedFrom(), TokenIssued_.issuedFrom));
            }
            if (criteria.getDepartmentId() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getDepartmentId(), TokenIssued_.departmentId));
            }
            if (criteria.getDepartmentName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getDepartmentName(), TokenIssued_.departmentName));
            }
            if (criteria.getBizName() != null) {
                specification = specification.and(buildStringSpecification(criteria.getBizName(), TokenIssued_.bizName));
            }
            if (criteria.getRating() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getRating(), TokenIssued_.rating));
            }
            if (criteria.getFeedback() != null) {
                specification = specification.and(buildStringSpecification(criteria.getFeedback(), TokenIssued_.feedback));
            }
            if (criteria.getSmsComingCount() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getSmsComingCount(), TokenIssued_.smsComingCount));
            }
            if (criteria.getPushComingCount() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getPushComingCount(), TokenIssued_.pushComingCount));
            }
            if (criteria.getOrderId() != null) {
                specification = specification.and(buildStringSpecification(criteria.getOrderId(), TokenIssued_.orderId));
            }
            if (criteria.getReset() != null) {
                specification = specification.and(buildSpecification(criteria.getReset(), TokenIssued_.reset));
            }
            if (criteria.getResetDate() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getResetDate(), TokenIssued_.resetDate));
            }
            if (criteria.getResetUid() != null) {
                specification = specification.and(buildRangeSpecification(criteria.getResetUid(), TokenIssued_.resetUid));
            }
        }
        return specification;
    }
}

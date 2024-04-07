package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.TokenIssued;
import com.wheref.paperlessqms.repository.TokenIssuedRepository;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.wheref.paperlessqms.domain.TokenIssued}.
 */
@Service
@Transactional
public class TokenIssuedService {

    private final Logger log = LoggerFactory.getLogger(TokenIssuedService.class);

    private final TokenIssuedRepository tokenIssuedRepository;

    public TokenIssuedService(TokenIssuedRepository tokenIssuedRepository) {
        this.tokenIssuedRepository = tokenIssuedRepository;
    }

    /**
     * Save a tokenIssued.
     *
     * @param tokenIssued the entity to save.
     * @return the persisted entity.
     */
    public TokenIssued save(TokenIssued tokenIssued) {
        log.debug("Request to save TokenIssued : {}", tokenIssued);
        return tokenIssuedRepository.save(tokenIssued);
    }

    /**
     * Update a tokenIssued.
     *
     * @param tokenIssued the entity to save.
     * @return the persisted entity.
     */
    public TokenIssued update(TokenIssued tokenIssued) {
        log.debug("Request to update TokenIssued : {}", tokenIssued);
        return tokenIssuedRepository.save(tokenIssued);
    }

    /**
     * Partially update a tokenIssued.
     *
     * @param tokenIssued the entity to update partially.
     * @return the persisted entity.
     */
    public Optional<TokenIssued> partialUpdate(TokenIssued tokenIssued) {
        log.debug("Request to partially update TokenIssued : {}", tokenIssued);

        return tokenIssuedRepository
            .findById(tokenIssued.getId())
            .map(existingTokenIssued -> {
                if (tokenIssued.getUid() != null) {
                    existingTokenIssued.setUid(tokenIssued.getUid());
                }
                if (tokenIssued.getProfileBizId() != null) {
                    existingTokenIssued.setProfileBizId(tokenIssued.getProfileBizId());
                }
                if (tokenIssued.getPhoneNumber() != null) {
                    existingTokenIssued.setPhoneNumber(tokenIssued.getPhoneNumber());
                }
                if (tokenIssued.getPhoneIsoCode() != null) {
                    existingTokenIssued.setPhoneIsoCode(tokenIssued.getPhoneIsoCode());
                }
                if (tokenIssued.getPhoneCode() != null) {
                    existingTokenIssued.setPhoneCode(tokenIssued.getPhoneCode());
                }
                if (tokenIssued.getUserEmail() != null) {
                    existingTokenIssued.setUserEmail(tokenIssued.getUserEmail());
                }
                if (tokenIssued.getUserFirstName() != null) {
                    existingTokenIssued.setUserFirstName(tokenIssued.getUserFirstName());
                }
                if (tokenIssued.getUserLastName() != null) {
                    existingTokenIssued.setUserLastName(tokenIssued.getUserLastName());
                }
                if (tokenIssued.getTokenLetter() != null) {
                    existingTokenIssued.setTokenLetter(tokenIssued.getTokenLetter());
                }
                if (tokenIssued.getTokenNumber() != null) {
                    existingTokenIssued.setTokenNumber(tokenIssued.getTokenNumber());
                }
                if (tokenIssued.getServiceName() != null) {
                    existingTokenIssued.setServiceName(tokenIssued.getServiceName());
                }
                if (tokenIssued.getServiceId() != null) {
                    existingTokenIssued.setServiceId(tokenIssued.getServiceId());
                }
                if (tokenIssued.getTerminalName() != null) {
                    existingTokenIssued.setTerminalName(tokenIssued.getTerminalName());
                }
                if (tokenIssued.getTerminalId() != null) {
                    existingTokenIssued.setTerminalId(tokenIssued.getTerminalId());
                }
                if (tokenIssued.getOrgTerminalName() != null) {
                    existingTokenIssued.setOrgTerminalName(tokenIssued.getOrgTerminalName());
                }
                if (tokenIssued.getOrgTerminalId() != null) {
                    existingTokenIssued.setOrgTerminalId(tokenIssued.getOrgTerminalId());
                }
                if (tokenIssued.getStatusName() != null) {
                    existingTokenIssued.setStatusName(tokenIssued.getStatusName());
                }
                if (tokenIssued.getStatusCode() != null) {
                    existingTokenIssued.setStatusCode(tokenIssued.getStatusCode());
                }
                if (tokenIssued.getIsPending() != null) {
                    existingTokenIssued.setIsPending(tokenIssued.getIsPending());
                }
                if (tokenIssued.getIsQueue() != null) {
                    existingTokenIssued.setIsQueue(tokenIssued.getIsQueue());
                }
                if (tokenIssued.getIsReject() != null) {
                    existingTokenIssued.setIsReject(tokenIssued.getIsReject());
                }
                if (tokenIssued.getIsAbsent() != null) {
                    existingTokenIssued.setIsAbsent(tokenIssued.getIsAbsent());
                }
                if (tokenIssued.getIsCancel() != null) {
                    existingTokenIssued.setIsCancel(tokenIssued.getIsCancel());
                }
                if (tokenIssued.getIsRecall() != null) {
                    existingTokenIssued.setIsRecall(tokenIssued.getIsRecall());
                }
                if (tokenIssued.getIsCompleted() != null) {
                    existingTokenIssued.setIsCompleted(tokenIssued.getIsCompleted());
                }
                if (tokenIssued.getIsTimeout() != null) {
                    existingTokenIssued.setIsTimeout(tokenIssued.getIsTimeout());
                }
                if (tokenIssued.getAssignedDate() != null) {
                    existingTokenIssued.setAssignedDate(tokenIssued.getAssignedDate());
                }
                if (tokenIssued.getAssignedYear() != null) {
                    existingTokenIssued.setAssignedYear(tokenIssued.getAssignedYear());
                }
                if (tokenIssued.getAssignedMonth() != null) {
                    existingTokenIssued.setAssignedMonth(tokenIssued.getAssignedMonth());
                }
                if (tokenIssued.getAssignedDay() != null) {
                    existingTokenIssued.setAssignedDay(tokenIssued.getAssignedDay());
                }
                if (tokenIssued.getAssignedHour() != null) {
                    existingTokenIssued.setAssignedHour(tokenIssued.getAssignedHour());
                }
                if (tokenIssued.getAssignedMin() != null) {
                    existingTokenIssued.setAssignedMin(tokenIssued.getAssignedMin());
                }
                if (tokenIssued.getAssignedTimeZoneOffset() != null) {
                    existingTokenIssued.setAssignedTimeZoneOffset(tokenIssued.getAssignedTimeZoneOffset());
                }
                if (tokenIssued.getAssignedTimeZoneName() != null) {
                    existingTokenIssued.setAssignedTimeZoneName(tokenIssued.getAssignedTimeZoneName());
                }
                if (tokenIssued.getAssignedNow() != null) {
                    existingTokenIssued.setAssignedNow(tokenIssued.getAssignedNow());
                }
                if (tokenIssued.getAssignedUid() != null) {
                    existingTokenIssued.setAssignedUid(tokenIssued.getAssignedUid());
                }
                if (tokenIssued.getCompletedYear() != null) {
                    existingTokenIssued.setCompletedYear(tokenIssued.getCompletedYear());
                }
                if (tokenIssued.getCompletedMonth() != null) {
                    existingTokenIssued.setCompletedMonth(tokenIssued.getCompletedMonth());
                }
                if (tokenIssued.getCompletedDay() != null) {
                    existingTokenIssued.setCompletedDay(tokenIssued.getCompletedDay());
                }
                if (tokenIssued.getCompletedHour() != null) {
                    existingTokenIssued.setCompletedHour(tokenIssued.getCompletedHour());
                }
                if (tokenIssued.getCompletedMin() != null) {
                    existingTokenIssued.setCompletedMin(tokenIssued.getCompletedMin());
                }
                if (tokenIssued.getCompletedTimeZoneOffset() != null) {
                    existingTokenIssued.setCompletedTimeZoneOffset(tokenIssued.getCompletedTimeZoneOffset());
                }
                if (tokenIssued.getCompletedTimeZoneName() != null) {
                    existingTokenIssued.setCompletedTimeZoneName(tokenIssued.getCompletedTimeZoneName());
                }
                if (tokenIssued.getCompletedNow() != null) {
                    existingTokenIssued.setCompletedNow(tokenIssued.getCompletedNow());
                }
                if (tokenIssued.getCompletedDate() != null) {
                    existingTokenIssued.setCompletedDate(tokenIssued.getCompletedDate());
                }
                if (tokenIssued.getCompletedUid() != null) {
                    existingTokenIssued.setCompletedUid(tokenIssued.getCompletedUid());
                }
                if (tokenIssued.getCreatedYear() != null) {
                    existingTokenIssued.setCreatedYear(tokenIssued.getCreatedYear());
                }
                if (tokenIssued.getCreatedMonth() != null) {
                    existingTokenIssued.setCreatedMonth(tokenIssued.getCreatedMonth());
                }
                if (tokenIssued.getCreatedDay() != null) {
                    existingTokenIssued.setCreatedDay(tokenIssued.getCreatedDay());
                }
                if (tokenIssued.getCreatedHour() != null) {
                    existingTokenIssued.setCreatedHour(tokenIssued.getCreatedHour());
                }
                if (tokenIssued.getCreatedMin() != null) {
                    existingTokenIssued.setCreatedMin(tokenIssued.getCreatedMin());
                }
                if (tokenIssued.getCreatedTimeZoneOffset() != null) {
                    existingTokenIssued.setCreatedTimeZoneOffset(tokenIssued.getCreatedTimeZoneOffset());
                }
                if (tokenIssued.getCreatedTimeZoneName() != null) {
                    existingTokenIssued.setCreatedTimeZoneName(tokenIssued.getCreatedTimeZoneName());
                }
                if (tokenIssued.getCreatedNow() != null) {
                    existingTokenIssued.setCreatedNow(tokenIssued.getCreatedNow());
                }
                if (tokenIssued.getCreatedDate() != null) {
                    existingTokenIssued.setCreatedDate(tokenIssued.getCreatedDate());
                }
                if (tokenIssued.getModifiedYear() != null) {
                    existingTokenIssued.setModifiedYear(tokenIssued.getModifiedYear());
                }
                if (tokenIssued.getModifiedMonth() != null) {
                    existingTokenIssued.setModifiedMonth(tokenIssued.getModifiedMonth());
                }
                if (tokenIssued.getModifiedDay() != null) {
                    existingTokenIssued.setModifiedDay(tokenIssued.getModifiedDay());
                }
                if (tokenIssued.getModifiedHour() != null) {
                    existingTokenIssued.setModifiedHour(tokenIssued.getModifiedHour());
                }
                if (tokenIssued.getModifiedMin() != null) {
                    existingTokenIssued.setModifiedMin(tokenIssued.getModifiedMin());
                }
                if (tokenIssued.getModifiedTimeZoneOffset() != null) {
                    existingTokenIssued.setModifiedTimeZoneOffset(tokenIssued.getModifiedTimeZoneOffset());
                }
                if (tokenIssued.getModifiedTimeZoneName() != null) {
                    existingTokenIssued.setModifiedTimeZoneName(tokenIssued.getModifiedTimeZoneName());
                }
                if (tokenIssued.getModifiedNow() != null) {
                    existingTokenIssued.setModifiedNow(tokenIssued.getModifiedNow());
                }
                if (tokenIssued.getModifiedDate() != null) {
                    existingTokenIssued.setModifiedDate(tokenIssued.getModifiedDate());
                }
                if (tokenIssued.getTransferedYear() != null) {
                    existingTokenIssued.setTransferedYear(tokenIssued.getTransferedYear());
                }
                if (tokenIssued.getTransferedMonth() != null) {
                    existingTokenIssued.setTransferedMonth(tokenIssued.getTransferedMonth());
                }
                if (tokenIssued.getTransferedDay() != null) {
                    existingTokenIssued.setTransferedDay(tokenIssued.getTransferedDay());
                }
                if (tokenIssued.getTransferedHour() != null) {
                    existingTokenIssued.setTransferedHour(tokenIssued.getTransferedHour());
                }
                if (tokenIssued.getTransferedMin() != null) {
                    existingTokenIssued.setTransferedMin(tokenIssued.getTransferedMin());
                }
                if (tokenIssued.getTransferedDate() != null) {
                    existingTokenIssued.setTransferedDate(tokenIssued.getTransferedDate());
                }
                if (tokenIssued.getTransferedTimeZoneOffset() != null) {
                    existingTokenIssued.setTransferedTimeZoneOffset(tokenIssued.getTransferedTimeZoneOffset());
                }
                if (tokenIssued.getTransferedTimeZoneName() != null) {
                    existingTokenIssued.setTransferedTimeZoneName(tokenIssued.getTransferedTimeZoneName());
                }
                if (tokenIssued.getTransferedNow() != null) {
                    existingTokenIssued.setTransferedNow(tokenIssued.getTransferedNow());
                }
                if (tokenIssued.getTransferedUid() != null) {
                    existingTokenIssued.setTransferedUid(tokenIssued.getTransferedUid());
                }
                if (tokenIssued.getIssuedFrom() != null) {
                    existingTokenIssued.setIssuedFrom(tokenIssued.getIssuedFrom());
                }
                if (tokenIssued.getDepartmentId() != null) {
                    existingTokenIssued.setDepartmentId(tokenIssued.getDepartmentId());
                }
                if (tokenIssued.getDepartmentName() != null) {
                    existingTokenIssued.setDepartmentName(tokenIssued.getDepartmentName());
                }
                if (tokenIssued.getBizName() != null) {
                    existingTokenIssued.setBizName(tokenIssued.getBizName());
                }
                if (tokenIssued.getRating() != null) {
                    existingTokenIssued.setRating(tokenIssued.getRating());
                }
                if (tokenIssued.getFeedback() != null) {
                    existingTokenIssued.setFeedback(tokenIssued.getFeedback());
                }
                if (tokenIssued.getSmsComingCount() != null) {
                    existingTokenIssued.setSmsComingCount(tokenIssued.getSmsComingCount());
                }
                if (tokenIssued.getPushComingCount() != null) {
                    existingTokenIssued.setPushComingCount(tokenIssued.getPushComingCount());
                }
                if (tokenIssued.getOrderId() != null) {
                    existingTokenIssued.setOrderId(tokenIssued.getOrderId());
                }
                if (tokenIssued.getReset() != null) {
                    existingTokenIssued.setReset(tokenIssued.getReset());
                }
                if (tokenIssued.getResetDate() != null) {
                    existingTokenIssued.setResetDate(tokenIssued.getResetDate());
                }
                if (tokenIssued.getResetUid() != null) {
                    existingTokenIssued.setResetUid(tokenIssued.getResetUid());
                }

                return existingTokenIssued;
            })
            .map(tokenIssuedRepository::save);
    }

    /**
     * Get all the tokenIssueds.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    @Transactional(readOnly = true)
    public Page<TokenIssued> findAll(Pageable pageable) {
        log.debug("Request to get all TokenIssueds");
        return tokenIssuedRepository.findAll(pageable);
    }

    /**
     * Get one tokenIssued by id.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    @Transactional(readOnly = true)
    public Optional<TokenIssued> findOne(Long id) {
        log.debug("Request to get TokenIssued : {}", id);
        return tokenIssuedRepository.findById(id);
    }

    /**
     * Delete the tokenIssued by id.
     *
     * @param id the id of the entity.
     */
    public void delete(Long id) {
        log.debug("Request to delete TokenIssued : {}", id);
        tokenIssuedRepository.deleteById(id);
    }
}

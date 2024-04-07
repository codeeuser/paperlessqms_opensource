package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.MaxToken;
import com.wheref.paperlessqms.repository.MaxTokenRepository;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.wheref.paperlessqms.domain.MaxToken}.
 */
@Service
@Transactional
public class MaxTokenService {

    private final Logger log = LoggerFactory.getLogger(MaxTokenService.class);

    private final MaxTokenRepository maxTokenRepository;

    public MaxTokenService(MaxTokenRepository maxTokenRepository) {
        this.maxTokenRepository = maxTokenRepository;
    }

    /**
     * Save a maxToken.
     *
     * @param maxToken the entity to save.
     * @return the persisted entity.
     */
    public MaxToken save(MaxToken maxToken) {
        log.debug("Request to save MaxToken : {}", maxToken);
        return maxTokenRepository.save(maxToken);
    }

    /**
     * Update a maxToken.
     *
     * @param maxToken the entity to save.
     * @return the persisted entity.
     */
    public MaxToken update(MaxToken maxToken) {
        log.debug("Request to update MaxToken : {}", maxToken);
        return maxTokenRepository.save(maxToken);
    }

    /**
     * Partially update a maxToken.
     *
     * @param maxToken the entity to update partially.
     * @return the persisted entity.
     */
    public Optional<MaxToken> partialUpdate(MaxToken maxToken) {
        log.debug("Request to partially update MaxToken : {}", maxToken);

        return maxTokenRepository
            .findById(maxToken.getId())
            .map(existingMaxToken -> {
                if (maxToken.getProfileBizId() != null) {
                    existingMaxToken.setProfileBizId(maxToken.getProfileBizId());
                }
                if (maxToken.getMaxToken() != null) {
                    existingMaxToken.setMaxToken(maxToken.getMaxToken());
                }
                if (maxToken.getDayNum() != null) {
                    existingMaxToken.setDayNum(maxToken.getDayNum());
                }
                if (maxToken.getModifiedDate() != null) {
                    existingMaxToken.setModifiedDate(maxToken.getModifiedDate());
                }
                if (maxToken.getCreatedDate() != null) {
                    existingMaxToken.setCreatedDate(maxToken.getCreatedDate());
                }

                return existingMaxToken;
            })
            .map(maxTokenRepository::save);
    }

    /**
     * Get all the maxTokens.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    @Transactional(readOnly = true)
    public Page<MaxToken> findAll(Pageable pageable) {
        log.debug("Request to get all MaxTokens");
        return maxTokenRepository.findAll(pageable);
    }

    /**
     * Get one maxToken by id.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    @Transactional(readOnly = true)
    public Optional<MaxToken> findOne(Long id) {
        log.debug("Request to get MaxToken : {}", id);
        return maxTokenRepository.findById(id);
    }

    /**
     * Delete the maxToken by id.
     *
     * @param id the id of the entity.
     */
    public void delete(Long id) {
        log.debug("Request to delete MaxToken : {}", id);
        maxTokenRepository.deleteById(id);
    }
}

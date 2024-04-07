package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.TokenNumber;
import com.wheref.paperlessqms.repository.TokenNumberRepository;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.wheref.paperlessqms.domain.TokenNumber}.
 */
@Service
@Transactional
public class TokenNumberService {

    private final Logger log = LoggerFactory.getLogger(TokenNumberService.class);

    private final TokenNumberRepository tokenNumberRepository;

    public TokenNumberService(TokenNumberRepository tokenNumberRepository) {
        this.tokenNumberRepository = tokenNumberRepository;
    }

    /**
     * Save a tokenNumber.
     *
     * @param tokenNumber the entity to save.
     * @return the persisted entity.
     */
    public TokenNumber save(TokenNumber tokenNumber) {
        log.debug("Request to save TokenNumber : {}", tokenNumber);
        return tokenNumberRepository.save(tokenNumber);
    }

    /**
     * Update a tokenNumber.
     *
     * @param tokenNumber the entity to save.
     * @return the persisted entity.
     */
    public TokenNumber update(TokenNumber tokenNumber) {
        log.debug("Request to update TokenNumber : {}", tokenNumber);
        return tokenNumberRepository.save(tokenNumber);
    }

    /**
     * Partially update a tokenNumber.
     *
     * @param tokenNumber the entity to update partially.
     * @return the persisted entity.
     */
    public Optional<TokenNumber> partialUpdate(TokenNumber tokenNumber) {
        log.debug("Request to partially update TokenNumber : {}", tokenNumber);

        return tokenNumberRepository
            .findById(tokenNumber.getId())
            .map(existingTokenNumber -> {
                if (tokenNumber.getNumber() != null) {
                    existingTokenNumber.setNumber(tokenNumber.getNumber());
                }
                if (tokenNumber.getDepartmentId() != null) {
                    existingTokenNumber.setDepartmentId(tokenNumber.getDepartmentId());
                }
                if (tokenNumber.getServiceId() != null) {
                    existingTokenNumber.setServiceId(tokenNumber.getServiceId());
                }
                if (tokenNumber.getReset() != null) {
                    existingTokenNumber.setReset(tokenNumber.getReset());
                }

                return existingTokenNumber;
            })
            .map(tokenNumberRepository::save);
    }

    /**
     * Get all the tokenNumbers.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    @Transactional(readOnly = true)
    public Page<TokenNumber> findAll(Pageable pageable) {
        log.debug("Request to get all TokenNumbers");
        return tokenNumberRepository.findAll(pageable);
    }

    /**
     * Get one tokenNumber by id.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    @Transactional(readOnly = true)
    public Optional<TokenNumber> findOne(Long id) {
        log.debug("Request to get TokenNumber : {}", id);
        return tokenNumberRepository.findById(id);
    }

    /**
     * Delete the tokenNumber by id.
     *
     * @param id the id of the entity.
     */
    public void delete(Long id) {
        log.debug("Request to delete TokenNumber : {}", id);
        tokenNumberRepository.deleteById(id);
    }
}

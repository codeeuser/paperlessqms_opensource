package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.QueueTerminal;
import com.wheref.paperlessqms.repository.QueueTerminalRepository;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.wheref.paperlessqms.domain.QueueTerminal}.
 */
@Service
@Transactional
public class QueueTerminalService {

    private final Logger log = LoggerFactory.getLogger(QueueTerminalService.class);

    private final QueueTerminalRepository queueTerminalRepository;

    public QueueTerminalService(QueueTerminalRepository queueTerminalRepository) {
        this.queueTerminalRepository = queueTerminalRepository;
    }

    /**
     * Save a queueTerminal.
     *
     * @param queueTerminal the entity to save.
     * @return the persisted entity.
     */
    public QueueTerminal save(QueueTerminal queueTerminal) {
        log.debug("Request to save QueueTerminal : {}", queueTerminal);
        return queueTerminalRepository.save(queueTerminal);
    }

    /**
     * Update a queueTerminal.
     *
     * @param queueTerminal the entity to save.
     * @return the persisted entity.
     */
    public QueueTerminal update(QueueTerminal queueTerminal) {
        log.debug("Request to update QueueTerminal : {}", queueTerminal);
        return queueTerminalRepository.save(queueTerminal);
    }

    /**
     * Partially update a queueTerminal.
     *
     * @param queueTerminal the entity to update partially.
     * @return the persisted entity.
     */
    public Optional<QueueTerminal> partialUpdate(QueueTerminal queueTerminal) {
        log.debug("Request to partially update QueueTerminal : {}", queueTerminal);

        return queueTerminalRepository
            .findById(queueTerminal.getId())
            .map(existingQueueTerminal -> {
                if (queueTerminal.getProfileBizId() != null) {
                    existingQueueTerminal.setProfileBizId(queueTerminal.getProfileBizId());
                }
                if (queueTerminal.getName() != null) {
                    existingQueueTerminal.setName(queueTerminal.getName());
                }
                if (queueTerminal.getEnable() != null) {
                    existingQueueTerminal.setEnable(queueTerminal.getEnable());
                }
                if (queueTerminal.getOrderNum() != null) {
                    existingQueueTerminal.setOrderNum(queueTerminal.getOrderNum());
                }
                if (queueTerminal.getCreatedDate() != null) {
                    existingQueueTerminal.setCreatedDate(queueTerminal.getCreatedDate());
                }
                if (queueTerminal.getModifiedDate() != null) {
                    existingQueueTerminal.setModifiedDate(queueTerminal.getModifiedDate());
                }

                return existingQueueTerminal;
            })
            .map(queueTerminalRepository::save);
    }

    /**
     * Get all the queueTerminals.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    @Transactional(readOnly = true)
    public Page<QueueTerminal> findAll(Pageable pageable) {
        log.debug("Request to get all QueueTerminals");
        return queueTerminalRepository.findAll(pageable);
    }

    /**
     * Get one queueTerminal by id.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    @Transactional(readOnly = true)
    public Optional<QueueTerminal> findOne(Long id) {
        log.debug("Request to get QueueTerminal : {}", id);
        return queueTerminalRepository.findById(id);
    }

    /**
     * Delete the queueTerminal by id.
     *
     * @param id the id of the entity.
     */
    public void delete(Long id) {
        log.debug("Request to delete QueueTerminal : {}", id);
        queueTerminalRepository.deleteById(id);
    }
}

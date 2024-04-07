package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.QueueService;
import com.wheref.paperlessqms.repository.QueueServiceRepository;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.wheref.paperlessqms.domain.QueueService}.
 */
@Service
@Transactional
public class QueueServiceService {

    private final Logger log = LoggerFactory.getLogger(QueueServiceService.class);

    private final QueueServiceRepository queueServiceRepository;

    public QueueServiceService(QueueServiceRepository queueServiceRepository) {
        this.queueServiceRepository = queueServiceRepository;
    }

    /**
     * Save a queueService.
     *
     * @param queueService the entity to save.
     * @return the persisted entity.
     */
    public QueueService save(QueueService queueService) {
        log.debug("Request to save QueueService : {}", queueService);
        return queueServiceRepository.save(queueService);
    }

    /**
     * Update a queueService.
     *
     * @param queueService the entity to save.
     * @return the persisted entity.
     */
    public QueueService update(QueueService queueService) {
        log.debug("Request to update QueueService : {}", queueService);
        return queueServiceRepository.save(queueService);
    }

    /**
     * Partially update a queueService.
     *
     * @param queueService the entity to update partially.
     * @return the persisted entity.
     */
    public Optional<QueueService> partialUpdate(QueueService queueService) {
        log.debug("Request to partially update QueueService : {}", queueService);

        return queueServiceRepository
            .findById(queueService.getId())
            .map(existingQueueService -> {
                if (queueService.getProfileBizId() != null) {
                    existingQueueService.setProfileBizId(queueService.getProfileBizId());
                }
                if (queueService.getName() != null) {
                    existingQueueService.setName(queueService.getName());
                }
                if (queueService.getType() != null) {
                    existingQueueService.setType(queueService.getType());
                }
                if (queueService.getLetter() != null) {
                    existingQueueService.setLetter(queueService.getLetter());
                }
                if (queueService.getStart() != null) {
                    existingQueueService.setStart(queueService.getStart());
                }
                if (queueService.getDesc() != null) {
                    existingQueueService.setDesc(queueService.getDesc());
                }
                if (queueService.getEnable() != null) {
                    existingQueueService.setEnable(queueService.getEnable());
                }
                if (queueService.getOrderNum() != null) {
                    existingQueueService.setOrderNum(queueService.getOrderNum());
                }
                if (queueService.getEnableCatalog() != null) {
                    existingQueueService.setEnableCatalog(queueService.getEnableCatalog());
                }
                if (queueService.getCreatedDate() != null) {
                    existingQueueService.setCreatedDate(queueService.getCreatedDate());
                }
                if (queueService.getModifiedDate() != null) {
                    existingQueueService.setModifiedDate(queueService.getModifiedDate());
                }

                return existingQueueService;
            })
            .map(queueServiceRepository::save);
    }

    /**
     * Get all the queueServices.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    @Transactional(readOnly = true)
    public Page<QueueService> findAll(Pageable pageable) {
        log.debug("Request to get all QueueServices");
        return queueServiceRepository.findAll(pageable);
    }

    /**
     * Get one queueService by id.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    @Transactional(readOnly = true)
    public Optional<QueueService> findOne(Long id) {
        log.debug("Request to get QueueService : {}", id);
        return queueServiceRepository.findById(id);
    }

    /**
     * Delete the queueService by id.
     *
     * @param id the id of the entity.
     */
    public void delete(Long id) {
        log.debug("Request to delete QueueService : {}", id);
        queueServiceRepository.deleteById(id);
    }
}

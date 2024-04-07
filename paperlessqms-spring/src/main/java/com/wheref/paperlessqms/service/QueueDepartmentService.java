package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.QueueDepartment;
import com.wheref.paperlessqms.repository.QueueDepartmentRepository;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.wheref.paperlessqms.domain.QueueDepartment}.
 */
@Service
@Transactional
public class QueueDepartmentService {

    private final Logger log = LoggerFactory.getLogger(QueueDepartmentService.class);

    private final QueueDepartmentRepository queueDepartmentRepository;

    public QueueDepartmentService(QueueDepartmentRepository queueDepartmentRepository) {
        this.queueDepartmentRepository = queueDepartmentRepository;
    }

    /**
     * Save a queueDepartment.
     *
     * @param queueDepartment the entity to save.
     * @return the persisted entity.
     */
    public QueueDepartment save(QueueDepartment queueDepartment) {
        log.debug("Request to save QueueDepartment : {}", queueDepartment);
        return queueDepartmentRepository.save(queueDepartment);
    }

    /**
     * Update a queueDepartment.
     *
     * @param queueDepartment the entity to save.
     * @return the persisted entity.
     */
    public QueueDepartment update(QueueDepartment queueDepartment) {
        log.debug("Request to update QueueDepartment : {}", queueDepartment);
        return queueDepartmentRepository.save(queueDepartment);
    }

    /**
     * Partially update a queueDepartment.
     *
     * @param queueDepartment the entity to update partially.
     * @return the persisted entity.
     */
    public Optional<QueueDepartment> partialUpdate(QueueDepartment queueDepartment) {
        log.debug("Request to partially update QueueDepartment : {}", queueDepartment);

        return queueDepartmentRepository
            .findById(queueDepartment.getId())
            .map(existingQueueDepartment -> {
                if (queueDepartment.getProfileBizId() != null) {
                    existingQueueDepartment.setProfileBizId(queueDepartment.getProfileBizId());
                }
                if (queueDepartment.getBizName() != null) {
                    existingQueueDepartment.setBizName(queueDepartment.getBizName());
                }
                if (queueDepartment.getBizCategoryName() != null) {
                    existingQueueDepartment.setBizCategoryName(queueDepartment.getBizCategoryName());
                }
                if (queueDepartment.getName() != null) {
                    existingQueueDepartment.setName(queueDepartment.getName());
                }
                if (queueDepartment.getDesc() != null) {
                    existingQueueDepartment.setDesc(queueDepartment.getDesc());
                }
                if (queueDepartment.getLat() != null) {
                    existingQueueDepartment.setLat(queueDepartment.getLat());
                }
                if (queueDepartment.getLng() != null) {
                    existingQueueDepartment.setLng(queueDepartment.getLng());
                }
                if (queueDepartment.getTimeZone() != null) {
                    existingQueueDepartment.setTimeZone(queueDepartment.getTimeZone());
                }
                if (queueDepartment.getThreshold() != null) {
                    existingQueueDepartment.setThreshold(queueDepartment.getThreshold());
                }
                if (queueDepartment.getNearbyRange() != null) {
                    existingQueueDepartment.setNearbyRange(queueDepartment.getNearbyRange());
                }
                if (queueDepartment.getTokenTimeoutMin() != null) {
                    existingQueueDepartment.setTokenTimeoutMin(queueDepartment.getTokenTimeoutMin());
                }
                if (queueDepartment.getSelected() != null) {
                    existingQueueDepartment.setSelected(queueDepartment.getSelected());
                }
                if (queueDepartment.getEnable() != null) {
                    existingQueueDepartment.setEnable(queueDepartment.getEnable());
                }
                if (queueDepartment.getOrderNum() != null) {
                    existingQueueDepartment.setOrderNum(queueDepartment.getOrderNum());
                }
                if (queueDepartment.getCurrencySymbol() != null) {
                    existingQueueDepartment.setCurrencySymbol(queueDepartment.getCurrencySymbol());
                }
                if (queueDepartment.getLenMetric() != null) {
                    existingQueueDepartment.setLenMetric(queueDepartment.getLenMetric());
                }
                if (queueDepartment.getCurrencyCode() != null) {
                    existingQueueDepartment.setCurrencyCode(queueDepartment.getCurrencyCode());
                }
                if (queueDepartment.getBannerName() != null) {
                    existingQueueDepartment.setBannerName(queueDepartment.getBannerName());
                }
                if (queueDepartment.getCreatedDate() != null) {
                    existingQueueDepartment.setCreatedDate(queueDepartment.getCreatedDate());
                }
                if (queueDepartment.getModifiedDate() != null) {
                    existingQueueDepartment.setModifiedDate(queueDepartment.getModifiedDate());
                }

                return existingQueueDepartment;
            })
            .map(queueDepartmentRepository::save);
    }

    /**
     * Get all the queueDepartments.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    @Transactional(readOnly = true)
    public Page<QueueDepartment> findAll(Pageable pageable) {
        log.debug("Request to get all QueueDepartments");
        return queueDepartmentRepository.findAll(pageable);
    }

    /**
     * Get one queueDepartment by id.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    @Transactional(readOnly = true)
    public Optional<QueueDepartment> findOne(Long id) {
        log.debug("Request to get QueueDepartment : {}", id);
        return queueDepartmentRepository.findById(id);
    }

    /**
     * Delete the queueDepartment by id.
     *
     * @param id the id of the entity.
     */
    public void delete(Long id) {
        log.debug("Request to delete QueueDepartment : {}", id);
        queueDepartmentRepository.deleteById(id);
    }
}

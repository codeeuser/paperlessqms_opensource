package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.OpenHour;
import com.wheref.paperlessqms.repository.OpenHourRepository;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.wheref.paperlessqms.domain.OpenHour}.
 */
@Service
@Transactional
public class OpenHourService {

    private final Logger log = LoggerFactory.getLogger(OpenHourService.class);

    private final OpenHourRepository openHourRepository;

    public OpenHourService(OpenHourRepository openHourRepository) {
        this.openHourRepository = openHourRepository;
    }

    /**
     * Save a openHour.
     *
     * @param openHour the entity to save.
     * @return the persisted entity.
     */
    public OpenHour save(OpenHour openHour) {
        log.debug("Request to save OpenHour : {}", openHour);
        return openHourRepository.save(openHour);
    }

    /**
     * Update a openHour.
     *
     * @param openHour the entity to save.
     * @return the persisted entity.
     */
    public OpenHour update(OpenHour openHour) {
        log.debug("Request to update OpenHour : {}", openHour);
        return openHourRepository.save(openHour);
    }

    /**
     * Partially update a openHour.
     *
     * @param openHour the entity to update partially.
     * @return the persisted entity.
     */
    public Optional<OpenHour> partialUpdate(OpenHour openHour) {
        log.debug("Request to partially update OpenHour : {}", openHour);

        return openHourRepository
            .findById(openHour.getId())
            .map(existingOpenHour -> {
                if (openHour.getProfileBizId() != null) {
                    existingOpenHour.setProfileBizId(openHour.getProfileBizId());
                }
                if (openHour.getStartHour() != null) {
                    existingOpenHour.setStartHour(openHour.getStartHour());
                }
                if (openHour.getStartMin() != null) {
                    existingOpenHour.setStartMin(openHour.getStartMin());
                }
                if (openHour.getEndHour() != null) {
                    existingOpenHour.setEndHour(openHour.getEndHour());
                }
                if (openHour.getEndMin() != null) {
                    existingOpenHour.setEndMin(openHour.getEndMin());
                }
                if (openHour.getDayNum() != null) {
                    existingOpenHour.setDayNum(openHour.getDayNum());
                }
                if (openHour.getEnable() != null) {
                    existingOpenHour.setEnable(openHour.getEnable());
                }
                if (openHour.getModifiedDate() != null) {
                    existingOpenHour.setModifiedDate(openHour.getModifiedDate());
                }
                if (openHour.getCreatedDate() != null) {
                    existingOpenHour.setCreatedDate(openHour.getCreatedDate());
                }

                return existingOpenHour;
            })
            .map(openHourRepository::save);
    }

    /**
     * Get all the openHours.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    @Transactional(readOnly = true)
    public Page<OpenHour> findAll(Pageable pageable) {
        log.debug("Request to get all OpenHours");
        return openHourRepository.findAll(pageable);
    }

    /**
     * Get one openHour by id.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    @Transactional(readOnly = true)
    public Optional<OpenHour> findOne(Long id) {
        log.debug("Request to get OpenHour : {}", id);
        return openHourRepository.findById(id);
    }

    /**
     * Delete the openHour by id.
     *
     * @param id the id of the entity.
     */
    public void delete(Long id) {
        log.debug("Request to delete OpenHour : {}", id);
        openHourRepository.deleteById(id);
    }
}

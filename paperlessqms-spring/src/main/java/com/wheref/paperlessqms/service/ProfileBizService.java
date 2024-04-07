package com.wheref.paperlessqms.service;

import com.wheref.paperlessqms.domain.ProfileBiz;
import com.wheref.paperlessqms.repository.ProfileBizRepository;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Service Implementation for managing {@link com.wheref.paperlessqms.domain.ProfileBiz}.
 */
@Service
@Transactional
public class ProfileBizService {

    private final Logger log = LoggerFactory.getLogger(ProfileBizService.class);

    private final ProfileBizRepository profileBizRepository;

    public ProfileBizService(ProfileBizRepository profileBizRepository) {
        this.profileBizRepository = profileBizRepository;
    }

    /**
     * Save a profileBiz.
     *
     * @param profileBiz the entity to save.
     * @return the persisted entity.
     */
    public ProfileBiz save(ProfileBiz profileBiz) {
        log.debug("Request to save ProfileBiz : {}", profileBiz);
        return profileBizRepository.save(profileBiz);
    }

    /**
     * Update a profileBiz.
     *
     * @param profileBiz the entity to save.
     * @return the persisted entity.
     */
    public ProfileBiz update(ProfileBiz profileBiz) {
        log.debug("Request to update ProfileBiz : {}", profileBiz);
        return profileBizRepository.save(profileBiz);
    }

    /**
     * Partially update a profileBiz.
     *
     * @param profileBiz the entity to update partially.
     * @return the persisted entity.
     */
    public Optional<ProfileBiz> partialUpdate(ProfileBiz profileBiz) {
        log.debug("Request to partially update ProfileBiz : {}", profileBiz);

        return profileBizRepository
            .findById(profileBiz.getId())
            .map(existingProfileBiz -> {
                if (profileBiz.getBizName() != null) {
                    existingProfileBiz.setBizName(profileBiz.getBizName());
                }
                if (profileBiz.getBizLogoBase64() != null) {
                    existingProfileBiz.setBizLogoBase64(profileBiz.getBizLogoBase64());
                }
                if (profileBiz.getBizPhotoBase64() != null) {
                    existingProfileBiz.setBizPhotoBase64(profileBiz.getBizPhotoBase64());
                }
                if (profileBiz.getBizAddress() != null) {
                    existingProfileBiz.setBizAddress(profileBiz.getBizAddress());
                }
                if (profileBiz.getBizLevel() != null) {
                    existingProfileBiz.setBizLevel(profileBiz.getBizLevel());
                }
                if (profileBiz.getBizEmail() != null) {
                    existingProfileBiz.setBizEmail(profileBiz.getBizEmail());
                }
                if (profileBiz.getBizPhoneNumber() != null) {
                    existingProfileBiz.setBizPhoneNumber(profileBiz.getBizPhoneNumber());
                }
                if (profileBiz.getBizPhoneCode() != null) {
                    existingProfileBiz.setBizPhoneCode(profileBiz.getBizPhoneCode());
                }
                if (profileBiz.getBizPhoneIsoCode() != null) {
                    existingProfileBiz.setBizPhoneIsoCode(profileBiz.getBizPhoneIsoCode());
                }
                if (profileBiz.getBizWebsite() != null) {
                    existingProfileBiz.setBizWebsite(profileBiz.getBizWebsite());
                }
                if (profileBiz.getBizDesc() != null) {
                    existingProfileBiz.setBizDesc(profileBiz.getBizDesc());
                }
                if (profileBiz.getEnable() != null) {
                    existingProfileBiz.setEnable(profileBiz.getEnable());
                }
                if (profileBiz.getCreatedByUid() != null) {
                    existingProfileBiz.setCreatedByUid(profileBiz.getCreatedByUid());
                }
                if (profileBiz.getUpdatedByUid() != null) {
                    existingProfileBiz.setUpdatedByUid(profileBiz.getUpdatedByUid());
                }
                if (profileBiz.getModifiedDate() != null) {
                    existingProfileBiz.setModifiedDate(profileBiz.getModifiedDate());
                }
                if (profileBiz.getCreatedDate() != null) {
                    existingProfileBiz.setCreatedDate(profileBiz.getCreatedDate());
                }

                return existingProfileBiz;
            })
            .map(profileBizRepository::save);
    }

    /**
     * Get all the profileBizs.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    @Transactional(readOnly = true)
    public Page<ProfileBiz> findAll(Pageable pageable) {
        log.debug("Request to get all ProfileBizs");
        return profileBizRepository.findAll(pageable);
    }

    /**
     * Get one profileBiz by id.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    @Transactional(readOnly = true)
    public Optional<ProfileBiz> findOne(Long id) {
        log.debug("Request to get ProfileBiz : {}", id);
        return profileBizRepository.findById(id);
    }

    /**
     * Delete the profileBiz by id.
     *
     * @param id the id of the entity.
     */
    public void delete(Long id) {
        log.debug("Request to delete ProfileBiz : {}", id);
        profileBizRepository.deleteById(id);
    }
}

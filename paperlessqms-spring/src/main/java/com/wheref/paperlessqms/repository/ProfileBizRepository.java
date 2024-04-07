package com.wheref.paperlessqms.repository;

import com.wheref.paperlessqms.domain.ProfileBiz;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the ProfileBiz entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ProfileBizRepository extends JpaRepository<ProfileBiz, Long>, JpaSpecificationExecutor<ProfileBiz> {}

package com.wheref.paperlessqms.repository;

import com.wheref.paperlessqms.domain.OpenHour;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the OpenHour entity.
 */
@SuppressWarnings("unused")
@Repository
public interface OpenHourRepository extends JpaRepository<OpenHour, Long>, JpaSpecificationExecutor<OpenHour> {}

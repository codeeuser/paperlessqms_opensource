package com.wheref.paperlessqms.repository;

import com.wheref.paperlessqms.domain.QueueService;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the QueueService entity.
 */
@SuppressWarnings("unused")
@Repository
public interface QueueServiceRepository extends JpaRepository<QueueService, Long>, JpaSpecificationExecutor<QueueService> {}

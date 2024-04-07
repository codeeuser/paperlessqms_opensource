package com.wheref.paperlessqms.repository;

import com.wheref.paperlessqms.domain.QueueTerminal;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the QueueTerminal entity.
 */
@SuppressWarnings("unused")
@Repository
public interface QueueTerminalRepository extends JpaRepository<QueueTerminal, Long>, JpaSpecificationExecutor<QueueTerminal> {}

package com.wheref.paperlessqms.repository;

import com.wheref.paperlessqms.domain.QueueDepartment;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the QueueDepartment entity.
 */
@SuppressWarnings("unused")
@Repository
public interface QueueDepartmentRepository extends JpaRepository<QueueDepartment, Long>, JpaSpecificationExecutor<QueueDepartment> {}

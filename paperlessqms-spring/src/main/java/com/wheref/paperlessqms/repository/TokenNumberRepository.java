package com.wheref.paperlessqms.repository;

import com.wheref.paperlessqms.domain.TokenNumber;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the TokenNumber entity.
 */
@SuppressWarnings("unused")
@Repository
public interface TokenNumberRepository extends JpaRepository<TokenNumber, Long>, JpaSpecificationExecutor<TokenNumber> {
    public TokenNumber findFirstByDepartmentIdAndServiceIdAndReset(Long departmentId, Long serviceId, Boolean reset);
}

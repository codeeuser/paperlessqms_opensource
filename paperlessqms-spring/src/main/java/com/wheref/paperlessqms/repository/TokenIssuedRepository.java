package com.wheref.paperlessqms.repository;

import com.wheref.paperlessqms.domain.TokenIssued;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the TokenIssued entity.
 */
@SuppressWarnings("unused")
@Repository
public interface TokenIssuedRepository extends JpaRepository<TokenIssued, Long>, JpaSpecificationExecutor<TokenIssued> {}

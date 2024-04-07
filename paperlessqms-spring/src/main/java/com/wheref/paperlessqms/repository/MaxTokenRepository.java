package com.wheref.paperlessqms.repository;

import com.wheref.paperlessqms.domain.MaxToken;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

/**
 * Spring Data JPA repository for the MaxToken entity.
 */
@SuppressWarnings("unused")
@Repository
public interface MaxTokenRepository extends JpaRepository<MaxToken, Long>, JpaSpecificationExecutor<MaxToken> {}

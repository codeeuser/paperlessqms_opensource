package com.wheref.paperlessqms.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A MaxToken.
 */
@Entity
@Table(name = "max_token", indexes = { @Index(name = "fn_profile_biz_id", columnList = "profileBizId") })
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class MaxToken implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    @Column(name = "id")
    private Long id;

    @NotNull
    @Column(name = "profile_biz_id", nullable = false)
    private Long profileBizId;

    @NotNull
    @Column(name = "max_token", nullable = false)
    private Integer maxToken;

    @NotNull
    @Column(name = "day_num", nullable = false)
    private Integer dayNum;

    @Column(name = "modified_date")
    private Long modifiedDate;

    @Column(name = "created_date")
    private Long createdDate;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public MaxToken id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProfileBizId() {
        return this.profileBizId;
    }

    public MaxToken profileBizId(Long profileBizId) {
        this.setProfileBizId(profileBizId);
        return this;
    }

    public void setProfileBizId(Long profileBizId) {
        this.profileBizId = profileBizId;
    }

    public Integer getMaxToken() {
        return this.maxToken;
    }

    public MaxToken maxToken(Integer maxToken) {
        this.setMaxToken(maxToken);
        return this;
    }

    public void setMaxToken(Integer maxToken) {
        this.maxToken = maxToken;
    }

    public Integer getDayNum() {
        return this.dayNum;
    }

    public MaxToken dayNum(Integer dayNum) {
        this.setDayNum(dayNum);
        return this;
    }

    public void setDayNum(Integer dayNum) {
        this.dayNum = dayNum;
    }

    public Long getModifiedDate() {
        return this.modifiedDate;
    }

    public MaxToken modifiedDate(Long modifiedDate) {
        this.setModifiedDate(modifiedDate);
        return this;
    }

    public void setModifiedDate(Long modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public Long getCreatedDate() {
        return this.createdDate;
    }

    public MaxToken createdDate(Long createdDate) {
        this.setCreatedDate(createdDate);
        return this;
    }

    public void setCreatedDate(Long createdDate) {
        this.createdDate = createdDate;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof MaxToken)) {
            return false;
        }
        return getId() != null && getId().equals(((MaxToken) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "MaxToken{" +
            "id=" + getId() +
            ", profileBizId=" + getProfileBizId() +
            ", maxToken=" + getMaxToken() +
            ", dayNum=" + getDayNum() +
            ", modifiedDate=" + getModifiedDate() +
            ", createdDate=" + getCreatedDate() +
            "}";
    }
}

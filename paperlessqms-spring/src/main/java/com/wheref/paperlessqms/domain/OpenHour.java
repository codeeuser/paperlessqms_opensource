package com.wheref.paperlessqms.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A OpenHour.
 */
@Entity
@Table(name = "open_hour", indexes = { @Index(name = "fn_profile_biz_id", columnList = "profileBizId") })
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class OpenHour implements Serializable {

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
    @Column(name = "start_hour", nullable = false)
    private Integer startHour;

    @NotNull
    @Column(name = "start_min", nullable = false)
    private Integer startMin;

    @NotNull
    @Column(name = "end_hour", nullable = false)
    private Integer endHour;

    @NotNull
    @Column(name = "end_min", nullable = false)
    private Integer endMin;

    @NotNull
    @Column(name = "day_num", nullable = false)
    private Integer dayNum;

    @Column(name = "enable")
    private Boolean enable;

    @Column(name = "modified_date")
    private Long modifiedDate;

    @Column(name = "created_date")
    private Long createdDate;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public OpenHour id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProfileBizId() {
        return this.profileBizId;
    }

    public OpenHour profileBizId(Long profileBizId) {
        this.setProfileBizId(profileBizId);
        return this;
    }

    public void setProfileBizId(Long profileBizId) {
        this.profileBizId = profileBizId;
    }

    public Integer getStartHour() {
        return this.startHour;
    }

    public OpenHour startHour(Integer startHour) {
        this.setStartHour(startHour);
        return this;
    }

    public void setStartHour(Integer startHour) {
        this.startHour = startHour;
    }

    public Integer getStartMin() {
        return this.startMin;
    }

    public OpenHour startMin(Integer startMin) {
        this.setStartMin(startMin);
        return this;
    }

    public void setStartMin(Integer startMin) {
        this.startMin = startMin;
    }

    public Integer getEndHour() {
        return this.endHour;
    }

    public OpenHour endHour(Integer endHour) {
        this.setEndHour(endHour);
        return this;
    }

    public void setEndHour(Integer endHour) {
        this.endHour = endHour;
    }

    public Integer getEndMin() {
        return this.endMin;
    }

    public OpenHour endMin(Integer endMin) {
        this.setEndMin(endMin);
        return this;
    }

    public void setEndMin(Integer endMin) {
        this.endMin = endMin;
    }

    public Integer getDayNum() {
        return this.dayNum;
    }

    public OpenHour dayNum(Integer dayNum) {
        this.setDayNum(dayNum);
        return this;
    }

    public void setDayNum(Integer dayNum) {
        this.dayNum = dayNum;
    }

    public Boolean getEnable() {
        return this.enable;
    }

    public OpenHour enable(Boolean enable) {
        this.setEnable(enable);
        return this;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    public Long getModifiedDate() {
        return this.modifiedDate;
    }

    public OpenHour modifiedDate(Long modifiedDate) {
        this.setModifiedDate(modifiedDate);
        return this;
    }

    public void setModifiedDate(Long modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public Long getCreatedDate() {
        return this.createdDate;
    }

    public OpenHour createdDate(Long createdDate) {
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
        if (!(o instanceof OpenHour)) {
            return false;
        }
        return getId() != null && getId().equals(((OpenHour) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "OpenHour{" +
            "id=" + getId() +
            ", profileBizId=" + getProfileBizId() +
            ", startHour=" + getStartHour() +
            ", startMin=" + getStartMin() +
            ", endHour=" + getEndHour() +
            ", endMin=" + getEndMin() +
            ", dayNum=" + getDayNum() +
            ", enable='" + getEnable() + "'" +
            ", modifiedDate=" + getModifiedDate() +
            ", createdDate=" + getCreatedDate() +
            "}";
    }
}

package com.wheref.paperlessqms.service.criteria;

import java.io.Serializable;
import java.util.Objects;
import org.springdoc.core.annotations.ParameterObject;
import tech.jhipster.service.Criteria;
import tech.jhipster.service.filter.*;

/**
 * Criteria class for the {@link com.wheref.paperlessqms.domain.MaxToken} entity. This class is used
 * in {@link com.wheref.paperlessqms.web.rest.MaxTokenResource} to receive all the possible filtering options from
 * the Http GET request parameters.
 * For example the following could be a valid request:
 * {@code /max-tokens?id.greaterThan=5&attr1.contains=something&attr2.specified=false}
 * As Spring is unable to properly convert the types, unless specific {@link Filter} class are used, we need to use
 * fix type specific filters.
 */
@ParameterObject
@SuppressWarnings("common-java:DuplicatedBlocks")
public class MaxTokenCriteria implements Serializable, Criteria {

    private static final long serialVersionUID = 1L;

    private LongFilter id;

    private LongFilter profileBizId;

    private IntegerFilter maxToken;

    private IntegerFilter dayNum;

    private LongFilter modifiedDate;

    private LongFilter createdDate;

    private Boolean distinct;

    public MaxTokenCriteria() {}

    public MaxTokenCriteria(MaxTokenCriteria other) {
        this.id = other.id == null ? null : other.id.copy();
        this.profileBizId = other.profileBizId == null ? null : other.profileBizId.copy();
        this.maxToken = other.maxToken == null ? null : other.maxToken.copy();
        this.dayNum = other.dayNum == null ? null : other.dayNum.copy();
        this.modifiedDate = other.modifiedDate == null ? null : other.modifiedDate.copy();
        this.createdDate = other.createdDate == null ? null : other.createdDate.copy();
        this.distinct = other.distinct;
    }

    @Override
    public MaxTokenCriteria copy() {
        return new MaxTokenCriteria(this);
    }

    public LongFilter getId() {
        return id;
    }

    public LongFilter id() {
        if (id == null) {
            id = new LongFilter();
        }
        return id;
    }

    public void setId(LongFilter id) {
        this.id = id;
    }

    public LongFilter getProfileBizId() {
        return profileBizId;
    }

    public LongFilter profileBizId() {
        if (profileBizId == null) {
            profileBizId = new LongFilter();
        }
        return profileBizId;
    }

    public void setProfileBizId(LongFilter profileBizId) {
        this.profileBizId = profileBizId;
    }

    public IntegerFilter getMaxToken() {
        return maxToken;
    }

    public IntegerFilter maxToken() {
        if (maxToken == null) {
            maxToken = new IntegerFilter();
        }
        return maxToken;
    }

    public void setMaxToken(IntegerFilter maxToken) {
        this.maxToken = maxToken;
    }

    public IntegerFilter getDayNum() {
        return dayNum;
    }

    public IntegerFilter dayNum() {
        if (dayNum == null) {
            dayNum = new IntegerFilter();
        }
        return dayNum;
    }

    public void setDayNum(IntegerFilter dayNum) {
        this.dayNum = dayNum;
    }

    public LongFilter getModifiedDate() {
        return modifiedDate;
    }

    public LongFilter modifiedDate() {
        if (modifiedDate == null) {
            modifiedDate = new LongFilter();
        }
        return modifiedDate;
    }

    public void setModifiedDate(LongFilter modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public LongFilter getCreatedDate() {
        return createdDate;
    }

    public LongFilter createdDate() {
        if (createdDate == null) {
            createdDate = new LongFilter();
        }
        return createdDate;
    }

    public void setCreatedDate(LongFilter createdDate) {
        this.createdDate = createdDate;
    }

    public Boolean getDistinct() {
        return distinct;
    }

    public void setDistinct(Boolean distinct) {
        this.distinct = distinct;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        final MaxTokenCriteria that = (MaxTokenCriteria) o;
        return (
            Objects.equals(id, that.id) &&
            Objects.equals(profileBizId, that.profileBizId) &&
            Objects.equals(maxToken, that.maxToken) &&
            Objects.equals(dayNum, that.dayNum) &&
            Objects.equals(modifiedDate, that.modifiedDate) &&
            Objects.equals(createdDate, that.createdDate) &&
            Objects.equals(distinct, that.distinct)
        );
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, profileBizId, maxToken, dayNum, modifiedDate, createdDate, distinct);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "MaxTokenCriteria{" +
            (id != null ? "id=" + id + ", " : "") +
            (profileBizId != null ? "profileBizId=" + profileBizId + ", " : "") +
            (maxToken != null ? "maxToken=" + maxToken + ", " : "") +
            (dayNum != null ? "dayNum=" + dayNum + ", " : "") +
            (modifiedDate != null ? "modifiedDate=" + modifiedDate + ", " : "") +
            (createdDate != null ? "createdDate=" + createdDate + ", " : "") +
            (distinct != null ? "distinct=" + distinct + ", " : "") +
            "}";
    }
}

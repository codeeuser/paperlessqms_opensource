package com.wheref.paperlessqms.service.criteria;

import java.io.Serializable;
import java.util.Objects;
import org.springdoc.core.annotations.ParameterObject;
import tech.jhipster.service.Criteria;
import tech.jhipster.service.filter.*;

/**
 * Criteria class for the {@link com.wheref.paperlessqms.domain.OpenHour} entity. This class is used
 * in {@link com.wheref.paperlessqms.web.rest.OpenHourResource} to receive all the possible filtering options from
 * the Http GET request parameters.
 * For example the following could be a valid request:
 * {@code /open-hours?id.greaterThan=5&attr1.contains=something&attr2.specified=false}
 * As Spring is unable to properly convert the types, unless specific {@link Filter} class are used, we need to use
 * fix type specific filters.
 */
@ParameterObject
@SuppressWarnings("common-java:DuplicatedBlocks")
public class OpenHourCriteria implements Serializable, Criteria {

    private static final long serialVersionUID = 1L;

    private LongFilter id;

    private LongFilter profileBizId;

    private IntegerFilter startHour;

    private IntegerFilter startMin;

    private IntegerFilter endHour;

    private IntegerFilter endMin;

    private IntegerFilter dayNum;

    private BooleanFilter enable;

    private LongFilter modifiedDate;

    private LongFilter createdDate;

    private Boolean distinct;

    public OpenHourCriteria() {}

    public OpenHourCriteria(OpenHourCriteria other) {
        this.id = other.id == null ? null : other.id.copy();
        this.profileBizId = other.profileBizId == null ? null : other.profileBizId.copy();
        this.startHour = other.startHour == null ? null : other.startHour.copy();
        this.startMin = other.startMin == null ? null : other.startMin.copy();
        this.endHour = other.endHour == null ? null : other.endHour.copy();
        this.endMin = other.endMin == null ? null : other.endMin.copy();
        this.dayNum = other.dayNum == null ? null : other.dayNum.copy();
        this.enable = other.enable == null ? null : other.enable.copy();
        this.modifiedDate = other.modifiedDate == null ? null : other.modifiedDate.copy();
        this.createdDate = other.createdDate == null ? null : other.createdDate.copy();
        this.distinct = other.distinct;
    }

    @Override
    public OpenHourCriteria copy() {
        return new OpenHourCriteria(this);
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

    public IntegerFilter getStartHour() {
        return startHour;
    }

    public IntegerFilter startHour() {
        if (startHour == null) {
            startHour = new IntegerFilter();
        }
        return startHour;
    }

    public void setStartHour(IntegerFilter startHour) {
        this.startHour = startHour;
    }

    public IntegerFilter getStartMin() {
        return startMin;
    }

    public IntegerFilter startMin() {
        if (startMin == null) {
            startMin = new IntegerFilter();
        }
        return startMin;
    }

    public void setStartMin(IntegerFilter startMin) {
        this.startMin = startMin;
    }

    public IntegerFilter getEndHour() {
        return endHour;
    }

    public IntegerFilter endHour() {
        if (endHour == null) {
            endHour = new IntegerFilter();
        }
        return endHour;
    }

    public void setEndHour(IntegerFilter endHour) {
        this.endHour = endHour;
    }

    public IntegerFilter getEndMin() {
        return endMin;
    }

    public IntegerFilter endMin() {
        if (endMin == null) {
            endMin = new IntegerFilter();
        }
        return endMin;
    }

    public void setEndMin(IntegerFilter endMin) {
        this.endMin = endMin;
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

    public BooleanFilter getEnable() {
        return enable;
    }

    public BooleanFilter enable() {
        if (enable == null) {
            enable = new BooleanFilter();
        }
        return enable;
    }

    public void setEnable(BooleanFilter enable) {
        this.enable = enable;
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
        final OpenHourCriteria that = (OpenHourCriteria) o;
        return (
            Objects.equals(id, that.id) &&
            Objects.equals(profileBizId, that.profileBizId) &&
            Objects.equals(startHour, that.startHour) &&
            Objects.equals(startMin, that.startMin) &&
            Objects.equals(endHour, that.endHour) &&
            Objects.equals(endMin, that.endMin) &&
            Objects.equals(dayNum, that.dayNum) &&
            Objects.equals(enable, that.enable) &&
            Objects.equals(modifiedDate, that.modifiedDate) &&
            Objects.equals(createdDate, that.createdDate) &&
            Objects.equals(distinct, that.distinct)
        );
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, profileBizId, startHour, startMin, endHour, endMin, dayNum, enable, modifiedDate, createdDate, distinct);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "OpenHourCriteria{" +
            (id != null ? "id=" + id + ", " : "") +
            (profileBizId != null ? "profileBizId=" + profileBizId + ", " : "") +
            (startHour != null ? "startHour=" + startHour + ", " : "") +
            (startMin != null ? "startMin=" + startMin + ", " : "") +
            (endHour != null ? "endHour=" + endHour + ", " : "") +
            (endMin != null ? "endMin=" + endMin + ", " : "") +
            (dayNum != null ? "dayNum=" + dayNum + ", " : "") +
            (enable != null ? "enable=" + enable + ", " : "") +
            (modifiedDate != null ? "modifiedDate=" + modifiedDate + ", " : "") +
            (createdDate != null ? "createdDate=" + createdDate + ", " : "") +
            (distinct != null ? "distinct=" + distinct + ", " : "") +
            "}";
    }
}

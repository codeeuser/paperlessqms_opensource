package com.wheref.paperlessqms.service.criteria;

import java.io.Serializable;
import java.util.Objects;
import org.springdoc.core.annotations.ParameterObject;
import tech.jhipster.service.Criteria;
import tech.jhipster.service.filter.*;

/**
 * Criteria class for the {@link com.wheref.paperlessqms.domain.QueueTerminal} entity. This class is used
 * in {@link com.wheref.paperlessqms.web.rest.QueueTerminalResource} to receive all the possible filtering options from
 * the Http GET request parameters.
 * For example the following could be a valid request:
 * {@code /queue-terminals?id.greaterThan=5&attr1.contains=something&attr2.specified=false}
 * As Spring is unable to properly convert the types, unless specific {@link Filter} class are used, we need to use
 * fix type specific filters.
 */
@ParameterObject
@SuppressWarnings("common-java:DuplicatedBlocks")
public class QueueTerminalCriteria implements Serializable, Criteria {

    private static final long serialVersionUID = 1L;

    private LongFilter id;

    private LongFilter profileBizId;

    private StringFilter name;

    private BooleanFilter enable;

    private IntegerFilter orderNum;

    private LongFilter createdDate;

    private LongFilter modifiedDate;

    private LongFilter queueDepartmentId;

    private LongFilter agentId;

    private Boolean distinct;

    public QueueTerminalCriteria() {}

    public QueueTerminalCriteria(QueueTerminalCriteria other) {
        this.id = other.id == null ? null : other.id.copy();
        this.profileBizId = other.profileBizId == null ? null : other.profileBizId.copy();
        this.name = other.name == null ? null : other.name.copy();
        this.enable = other.enable == null ? null : other.enable.copy();
        this.orderNum = other.orderNum == null ? null : other.orderNum.copy();
        this.createdDate = other.createdDate == null ? null : other.createdDate.copy();
        this.modifiedDate = other.modifiedDate == null ? null : other.modifiedDate.copy();
        this.queueDepartmentId = other.queueDepartmentId == null ? null : other.queueDepartmentId.copy();
        this.agentId = other.agentId == null ? null : other.agentId.copy();
        this.distinct = other.distinct;
    }

    @Override
    public QueueTerminalCriteria copy() {
        return new QueueTerminalCriteria(this);
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

    public StringFilter getName() {
        return name;
    }

    public StringFilter name() {
        if (name == null) {
            name = new StringFilter();
        }
        return name;
    }

    public void setName(StringFilter name) {
        this.name = name;
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

    public IntegerFilter getOrderNum() {
        return orderNum;
    }

    public IntegerFilter orderNum() {
        if (orderNum == null) {
            orderNum = new IntegerFilter();
        }
        return orderNum;
    }

    public void setOrderNum(IntegerFilter orderNum) {
        this.orderNum = orderNum;
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

    public LongFilter getQueueDepartmentId() {
        return queueDepartmentId;
    }

    public LongFilter queueDepartmentId() {
        if (queueDepartmentId == null) {
            queueDepartmentId = new LongFilter();
        }
        return queueDepartmentId;
    }

    public void setQueueDepartmentId(LongFilter queueDepartmentId) {
        this.queueDepartmentId = queueDepartmentId;
    }

    public LongFilter getAgentId() {
        return agentId;
    }

    public LongFilter agentId() {
        if (agentId == null) {
            agentId = new LongFilter();
        }
        return agentId;
    }

    public void setAgentId(LongFilter agentId) {
        this.agentId = agentId;
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
        final QueueTerminalCriteria that = (QueueTerminalCriteria) o;
        return (
            Objects.equals(id, that.id) &&
            Objects.equals(profileBizId, that.profileBizId) &&
            Objects.equals(name, that.name) &&
            Objects.equals(enable, that.enable) &&
            Objects.equals(orderNum, that.orderNum) &&
            Objects.equals(createdDate, that.createdDate) &&
            Objects.equals(modifiedDate, that.modifiedDate) &&
            Objects.equals(queueDepartmentId, that.queueDepartmentId) &&
            Objects.equals(agentId, that.agentId) &&
            Objects.equals(distinct, that.distinct)
        );
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, profileBizId, name, enable, orderNum, createdDate, modifiedDate, queueDepartmentId, agentId, distinct);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "QueueTerminalCriteria{" +
            (id != null ? "id=" + id + ", " : "") +
            (profileBizId != null ? "profileBizId=" + profileBizId + ", " : "") +
            (name != null ? "name=" + name + ", " : "") +
            (enable != null ? "enable=" + enable + ", " : "") +
            (orderNum != null ? "orderNum=" + orderNum + ", " : "") +
            (createdDate != null ? "createdDate=" + createdDate + ", " : "") +
            (modifiedDate != null ? "modifiedDate=" + modifiedDate + ", " : "") +
            (queueDepartmentId != null ? "queueDepartmentId=" + queueDepartmentId + ", " : "") +
            (agentId != null ? "agentId=" + agentId + ", " : "") +
            (distinct != null ? "distinct=" + distinct + ", " : "") +
            "}";
    }
}

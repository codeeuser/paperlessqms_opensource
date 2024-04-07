package com.wheref.paperlessqms.service.criteria;

import java.io.Serializable;
import java.util.Objects;
import org.springdoc.core.annotations.ParameterObject;
import tech.jhipster.service.Criteria;
import tech.jhipster.service.filter.*;

/**
 * Criteria class for the {@link com.wheref.paperlessqms.domain.Agent} entity. This class is used
 * in {@link com.wheref.paperlessqms.web.rest.AgentResource} to receive all the possible filtering options from
 * the Http GET request parameters.
 * For example the following could be a valid request:
 * {@code /agents?id.greaterThan=5&attr1.contains=something&attr2.specified=false}
 * As Spring is unable to properly convert the types, unless specific {@link Filter} class are used, we need to use
 * fix type specific filters.
 */
@ParameterObject
@SuppressWarnings("common-java:DuplicatedBlocks")
public class AgentCriteria implements Serializable, Criteria {

    private static final long serialVersionUID = 1L;

    private LongFilter id;

    private LongFilter profileBizId;

    private LongFilter uid;

    private StringFilter login;

    private StringFilter email;

    private LongFilter updateUid;

    private BooleanFilter enable;

    private IntegerFilter orderNum;

    private LongFilter createdDate;

    private LongFilter modifiedDate;

    private LongFilter queueTerminalId;

    private LongFilter queueDepartmentId;

    private Boolean distinct;

    public AgentCriteria() {}

    public AgentCriteria(AgentCriteria other) {
        this.id = other.id == null ? null : other.id.copy();
        this.profileBizId = other.profileBizId == null ? null : other.profileBizId.copy();
        this.uid = other.uid == null ? null : other.uid.copy();
        this.login = other.login == null ? null : other.login.copy();
        this.email = other.email == null ? null : other.email.copy();
        this.updateUid = other.updateUid == null ? null : other.updateUid.copy();
        this.enable = other.enable == null ? null : other.enable.copy();
        this.orderNum = other.orderNum == null ? null : other.orderNum.copy();
        this.createdDate = other.createdDate == null ? null : other.createdDate.copy();
        this.modifiedDate = other.modifiedDate == null ? null : other.modifiedDate.copy();
        this.queueTerminalId = other.queueTerminalId == null ? null : other.queueTerminalId.copy();
        this.queueDepartmentId = other.queueDepartmentId == null ? null : other.queueDepartmentId.copy();
        this.distinct = other.distinct;
    }

    @Override
    public AgentCriteria copy() {
        return new AgentCriteria(this);
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

    public LongFilter getUid() {
        return uid;
    }

    public LongFilter uid() {
        if (uid == null) {
            uid = new LongFilter();
        }
        return uid;
    }

    public void setUid(LongFilter uid) {
        this.uid = uid;
    }

    public StringFilter getLogin() {
        return login;
    }

    public StringFilter login() {
        if (login == null) {
            login = new StringFilter();
        }
        return login;
    }

    public void setLogin(StringFilter login) {
        this.login = login;
    }

    public StringFilter getEmail() {
        return email;
    }

    public StringFilter email() {
        if (email == null) {
            email = new StringFilter();
        }
        return email;
    }

    public void setEmail(StringFilter email) {
        this.email = email;
    }

    public LongFilter getUpdateUid() {
        return updateUid;
    }

    public LongFilter updateUid() {
        if (updateUid == null) {
            updateUid = new LongFilter();
        }
        return updateUid;
    }

    public void setUpdateUid(LongFilter updateUid) {
        this.updateUid = updateUid;
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

    public LongFilter getQueueTerminalId() {
        return queueTerminalId;
    }

    public LongFilter queueTerminalId() {
        if (queueTerminalId == null) {
            queueTerminalId = new LongFilter();
        }
        return queueTerminalId;
    }

    public void setQueueTerminalId(LongFilter queueTerminalId) {
        this.queueTerminalId = queueTerminalId;
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
        final AgentCriteria that = (AgentCriteria) o;
        return (
            Objects.equals(id, that.id) &&
            Objects.equals(profileBizId, that.profileBizId) &&
            Objects.equals(uid, that.uid) &&
            Objects.equals(login, that.login) &&
            Objects.equals(email, that.email) &&
            Objects.equals(updateUid, that.updateUid) &&
            Objects.equals(enable, that.enable) &&
            Objects.equals(orderNum, that.orderNum) &&
            Objects.equals(createdDate, that.createdDate) &&
            Objects.equals(modifiedDate, that.modifiedDate) &&
            Objects.equals(queueTerminalId, that.queueTerminalId) &&
            Objects.equals(queueDepartmentId, that.queueDepartmentId) &&
            Objects.equals(distinct, that.distinct)
        );
    }

    @Override
    public int hashCode() {
        return Objects.hash(
            id,
            profileBizId,
            uid,
            login,
            email,
            updateUid,
            enable,
            orderNum,
            createdDate,
            modifiedDate,
            queueTerminalId,
            queueDepartmentId,
            distinct
        );
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "AgentCriteria{" +
            (id != null ? "id=" + id + ", " : "") +
            (profileBizId != null ? "profileBizId=" + profileBizId + ", " : "") +
            (uid != null ? "uid=" + uid + ", " : "") +
            (login != null ? "login=" + login + ", " : "") +
            (email != null ? "email=" + email + ", " : "") +
            (updateUid != null ? "updateUid=" + updateUid + ", " : "") +
            (enable != null ? "enable=" + enable + ", " : "") +
            (orderNum != null ? "orderNum=" + orderNum + ", " : "") +
            (createdDate != null ? "createdDate=" + createdDate + ", " : "") +
            (modifiedDate != null ? "modifiedDate=" + modifiedDate + ", " : "") +
            (queueTerminalId != null ? "queueTerminalId=" + queueTerminalId + ", " : "") +
            (queueDepartmentId != null ? "queueDepartmentId=" + queueDepartmentId + ", " : "") +
            (distinct != null ? "distinct=" + distinct + ", " : "") +
            "}";
    }
}

package com.wheref.paperlessqms.service.criteria;

import java.io.Serializable;
import java.util.Objects;
import org.springdoc.core.annotations.ParameterObject;
import tech.jhipster.service.Criteria;
import tech.jhipster.service.filter.*;

/**
 * Criteria class for the {@link com.wheref.paperlessqms.domain.ProfileBiz} entity. This class is used
 * in {@link com.wheref.paperlessqms.web.rest.ProfileBizResource} to receive all the possible filtering options from
 * the Http GET request parameters.
 * For example the following could be a valid request:
 * {@code /profile-bizs?id.greaterThan=5&attr1.contains=something&attr2.specified=false}
 * As Spring is unable to properly convert the types, unless specific {@link Filter} class are used, we need to use
 * fix type specific filters.
 */
@ParameterObject
@SuppressWarnings("common-java:DuplicatedBlocks")
public class ProfileBizCriteria implements Serializable, Criteria {

    private static final long serialVersionUID = 1L;

    private LongFilter id;

    private StringFilter bizName;

    private StringFilter bizAddress;

    private IntegerFilter bizLevel;

    private StringFilter bizEmail;

    private StringFilter bizPhoneNumber;

    private StringFilter bizPhoneCode;

    private StringFilter bizPhoneIsoCode;

    private StringFilter bizWebsite;

    private StringFilter bizDesc;

    private BooleanFilter enable;

    private LongFilter createdByUid;

    private LongFilter updatedByUid;

    private LongFilter modifiedDate;

    private LongFilter createdDate;

    private Boolean distinct;

    public ProfileBizCriteria() {}

    public ProfileBizCriteria(ProfileBizCriteria other) {
        this.id = other.id == null ? null : other.id.copy();
        this.bizName = other.bizName == null ? null : other.bizName.copy();
        this.bizAddress = other.bizAddress == null ? null : other.bizAddress.copy();
        this.bizLevel = other.bizLevel == null ? null : other.bizLevel.copy();
        this.bizEmail = other.bizEmail == null ? null : other.bizEmail.copy();
        this.bizPhoneNumber = other.bizPhoneNumber == null ? null : other.bizPhoneNumber.copy();
        this.bizPhoneCode = other.bizPhoneCode == null ? null : other.bizPhoneCode.copy();
        this.bizPhoneIsoCode = other.bizPhoneIsoCode == null ? null : other.bizPhoneIsoCode.copy();
        this.bizWebsite = other.bizWebsite == null ? null : other.bizWebsite.copy();
        this.bizDesc = other.bizDesc == null ? null : other.bizDesc.copy();
        this.enable = other.enable == null ? null : other.enable.copy();
        this.createdByUid = other.createdByUid == null ? null : other.createdByUid.copy();
        this.updatedByUid = other.updatedByUid == null ? null : other.updatedByUid.copy();
        this.modifiedDate = other.modifiedDate == null ? null : other.modifiedDate.copy();
        this.createdDate = other.createdDate == null ? null : other.createdDate.copy();
        this.distinct = other.distinct;
    }

    @Override
    public ProfileBizCriteria copy() {
        return new ProfileBizCriteria(this);
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

    public StringFilter getBizName() {
        return bizName;
    }

    public StringFilter bizName() {
        if (bizName == null) {
            bizName = new StringFilter();
        }
        return bizName;
    }

    public void setBizName(StringFilter bizName) {
        this.bizName = bizName;
    }

    public StringFilter getBizAddress() {
        return bizAddress;
    }

    public StringFilter bizAddress() {
        if (bizAddress == null) {
            bizAddress = new StringFilter();
        }
        return bizAddress;
    }

    public void setBizAddress(StringFilter bizAddress) {
        this.bizAddress = bizAddress;
    }

    public IntegerFilter getBizLevel() {
        return bizLevel;
    }

    public IntegerFilter bizLevel() {
        if (bizLevel == null) {
            bizLevel = new IntegerFilter();
        }
        return bizLevel;
    }

    public void setBizLevel(IntegerFilter bizLevel) {
        this.bizLevel = bizLevel;
    }

    public StringFilter getBizEmail() {
        return bizEmail;
    }

    public StringFilter bizEmail() {
        if (bizEmail == null) {
            bizEmail = new StringFilter();
        }
        return bizEmail;
    }

    public void setBizEmail(StringFilter bizEmail) {
        this.bizEmail = bizEmail;
    }

    public StringFilter getBizPhoneNumber() {
        return bizPhoneNumber;
    }

    public StringFilter bizPhoneNumber() {
        if (bizPhoneNumber == null) {
            bizPhoneNumber = new StringFilter();
        }
        return bizPhoneNumber;
    }

    public void setBizPhoneNumber(StringFilter bizPhoneNumber) {
        this.bizPhoneNumber = bizPhoneNumber;
    }

    public StringFilter getBizPhoneCode() {
        return bizPhoneCode;
    }

    public StringFilter bizPhoneCode() {
        if (bizPhoneCode == null) {
            bizPhoneCode = new StringFilter();
        }
        return bizPhoneCode;
    }

    public void setBizPhoneCode(StringFilter bizPhoneCode) {
        this.bizPhoneCode = bizPhoneCode;
    }

    public StringFilter getBizPhoneIsoCode() {
        return bizPhoneIsoCode;
    }

    public StringFilter bizPhoneIsoCode() {
        if (bizPhoneIsoCode == null) {
            bizPhoneIsoCode = new StringFilter();
        }
        return bizPhoneIsoCode;
    }

    public void setBizPhoneIsoCode(StringFilter bizPhoneIsoCode) {
        this.bizPhoneIsoCode = bizPhoneIsoCode;
    }

    public StringFilter getBizWebsite() {
        return bizWebsite;
    }

    public StringFilter bizWebsite() {
        if (bizWebsite == null) {
            bizWebsite = new StringFilter();
        }
        return bizWebsite;
    }

    public void setBizWebsite(StringFilter bizWebsite) {
        this.bizWebsite = bizWebsite;
    }

    public StringFilter getBizDesc() {
        return bizDesc;
    }

    public StringFilter bizDesc() {
        if (bizDesc == null) {
            bizDesc = new StringFilter();
        }
        return bizDesc;
    }

    public void setBizDesc(StringFilter bizDesc) {
        this.bizDesc = bizDesc;
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

    public LongFilter getCreatedByUid() {
        return createdByUid;
    }

    public LongFilter createdByUid() {
        if (createdByUid == null) {
            createdByUid = new LongFilter();
        }
        return createdByUid;
    }

    public void setCreatedByUid(LongFilter createdByUid) {
        this.createdByUid = createdByUid;
    }

    public LongFilter getUpdatedByUid() {
        return updatedByUid;
    }

    public LongFilter updatedByUid() {
        if (updatedByUid == null) {
            updatedByUid = new LongFilter();
        }
        return updatedByUid;
    }

    public void setUpdatedByUid(LongFilter updatedByUid) {
        this.updatedByUid = updatedByUid;
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
        final ProfileBizCriteria that = (ProfileBizCriteria) o;
        return (
            Objects.equals(id, that.id) &&
            Objects.equals(bizName, that.bizName) &&
            Objects.equals(bizAddress, that.bizAddress) &&
            Objects.equals(bizLevel, that.bizLevel) &&
            Objects.equals(bizEmail, that.bizEmail) &&
            Objects.equals(bizPhoneNumber, that.bizPhoneNumber) &&
            Objects.equals(bizPhoneCode, that.bizPhoneCode) &&
            Objects.equals(bizPhoneIsoCode, that.bizPhoneIsoCode) &&
            Objects.equals(bizWebsite, that.bizWebsite) &&
            Objects.equals(bizDesc, that.bizDesc) &&
            Objects.equals(enable, that.enable) &&
            Objects.equals(createdByUid, that.createdByUid) &&
            Objects.equals(updatedByUid, that.updatedByUid) &&
            Objects.equals(modifiedDate, that.modifiedDate) &&
            Objects.equals(createdDate, that.createdDate) &&
            Objects.equals(distinct, that.distinct)
        );
    }

    @Override
    public int hashCode() {
        return Objects.hash(
            id,
            bizName,
            bizAddress,
            bizLevel,
            bizEmail,
            bizPhoneNumber,
            bizPhoneCode,
            bizPhoneIsoCode,
            bizWebsite,
            bizDesc,
            enable,
            createdByUid,
            updatedByUid,
            modifiedDate,
            createdDate,
            distinct
        );
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "ProfileBizCriteria{" +
            (id != null ? "id=" + id + ", " : "") +
            (bizName != null ? "bizName=" + bizName + ", " : "") +
            (bizAddress != null ? "bizAddress=" + bizAddress + ", " : "") +
            (bizLevel != null ? "bizLevel=" + bizLevel + ", " : "") +
            (bizEmail != null ? "bizEmail=" + bizEmail + ", " : "") +
            (bizPhoneNumber != null ? "bizPhoneNumber=" + bizPhoneNumber + ", " : "") +
            (bizPhoneCode != null ? "bizPhoneCode=" + bizPhoneCode + ", " : "") +
            (bizPhoneIsoCode != null ? "bizPhoneIsoCode=" + bizPhoneIsoCode + ", " : "") +
            (bizWebsite != null ? "bizWebsite=" + bizWebsite + ", " : "") +
            (bizDesc != null ? "bizDesc=" + bizDesc + ", " : "") +
            (enable != null ? "enable=" + enable + ", " : "") +
            (createdByUid != null ? "createdByUid=" + createdByUid + ", " : "") +
            (updatedByUid != null ? "updatedByUid=" + updatedByUid + ", " : "") +
            (modifiedDate != null ? "modifiedDate=" + modifiedDate + ", " : "") +
            (createdDate != null ? "createdDate=" + createdDate + ", " : "") +
            (distinct != null ? "distinct=" + distinct + ", " : "") +
            "}";
    }
}

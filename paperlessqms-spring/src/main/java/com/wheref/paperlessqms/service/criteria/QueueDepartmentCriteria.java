package com.wheref.paperlessqms.service.criteria;

import java.io.Serializable;
import java.util.Objects;
import org.springdoc.core.annotations.ParameterObject;
import tech.jhipster.service.Criteria;
import tech.jhipster.service.filter.*;

/**
 * Criteria class for the {@link com.wheref.paperlessqms.domain.QueueDepartment} entity. This class is used
 * in {@link com.wheref.paperlessqms.web.rest.QueueDepartmentResource} to receive all the possible filtering options from
 * the Http GET request parameters.
 * For example the following could be a valid request:
 * {@code /queue-departments?id.greaterThan=5&attr1.contains=something&attr2.specified=false}
 * As Spring is unable to properly convert the types, unless specific {@link Filter} class are used, we need to use
 * fix type specific filters.
 */
@ParameterObject
@SuppressWarnings("common-java:DuplicatedBlocks")
public class QueueDepartmentCriteria implements Serializable, Criteria {

    private static final long serialVersionUID = 1L;

    private LongFilter id;

    private LongFilter profileBizId;

    private StringFilter bizName;

    private StringFilter bizCategoryName;

    private StringFilter name;

    private StringFilter desc;

    private DoubleFilter lat;

    private DoubleFilter lng;

    private IntegerFilter timeZone;

    private IntegerFilter threshold;

    private IntegerFilter nearbyRange;

    private IntegerFilter tokenTimeoutMin;

    private BooleanFilter selected;

    private BooleanFilter enable;

    private IntegerFilter orderNum;

    private StringFilter currencySymbol;

    private StringFilter lenMetric;

    private StringFilter currencyCode;

    private StringFilter bannerName;

    private LongFilter createdDate;

    private LongFilter modifiedDate;

    private LongFilter agentId;

    private LongFilter queueTerminalId;

    private LongFilter queueServiceId;

    private Boolean distinct;

    public QueueDepartmentCriteria() {}

    public QueueDepartmentCriteria(QueueDepartmentCriteria other) {
        this.id = other.id == null ? null : other.id.copy();
        this.profileBizId = other.profileBizId == null ? null : other.profileBizId.copy();
        this.bizName = other.bizName == null ? null : other.bizName.copy();
        this.bizCategoryName = other.bizCategoryName == null ? null : other.bizCategoryName.copy();
        this.name = other.name == null ? null : other.name.copy();
        this.desc = other.desc == null ? null : other.desc.copy();
        this.lat = other.lat == null ? null : other.lat.copy();
        this.lng = other.lng == null ? null : other.lng.copy();
        this.timeZone = other.timeZone == null ? null : other.timeZone.copy();
        this.threshold = other.threshold == null ? null : other.threshold.copy();
        this.nearbyRange = other.nearbyRange == null ? null : other.nearbyRange.copy();
        this.tokenTimeoutMin = other.tokenTimeoutMin == null ? null : other.tokenTimeoutMin.copy();
        this.selected = other.selected == null ? null : other.selected.copy();
        this.enable = other.enable == null ? null : other.enable.copy();
        this.orderNum = other.orderNum == null ? null : other.orderNum.copy();
        this.currencySymbol = other.currencySymbol == null ? null : other.currencySymbol.copy();
        this.lenMetric = other.lenMetric == null ? null : other.lenMetric.copy();
        this.currencyCode = other.currencyCode == null ? null : other.currencyCode.copy();
        this.bannerName = other.bannerName == null ? null : other.bannerName.copy();
        this.createdDate = other.createdDate == null ? null : other.createdDate.copy();
        this.modifiedDate = other.modifiedDate == null ? null : other.modifiedDate.copy();
        this.agentId = other.agentId == null ? null : other.agentId.copy();
        this.queueTerminalId = other.queueTerminalId == null ? null : other.queueTerminalId.copy();
        this.queueServiceId = other.queueServiceId == null ? null : other.queueServiceId.copy();
        this.distinct = other.distinct;
    }

    @Override
    public QueueDepartmentCriteria copy() {
        return new QueueDepartmentCriteria(this);
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

    public StringFilter getBizCategoryName() {
        return bizCategoryName;
    }

    public StringFilter bizCategoryName() {
        if (bizCategoryName == null) {
            bizCategoryName = new StringFilter();
        }
        return bizCategoryName;
    }

    public void setBizCategoryName(StringFilter bizCategoryName) {
        this.bizCategoryName = bizCategoryName;
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

    public StringFilter getDesc() {
        return desc;
    }

    public StringFilter desc() {
        if (desc == null) {
            desc = new StringFilter();
        }
        return desc;
    }

    public void setDesc(StringFilter desc) {
        this.desc = desc;
    }

    public DoubleFilter getLat() {
        return lat;
    }

    public DoubleFilter lat() {
        if (lat == null) {
            lat = new DoubleFilter();
        }
        return lat;
    }

    public void setLat(DoubleFilter lat) {
        this.lat = lat;
    }

    public DoubleFilter getLng() {
        return lng;
    }

    public DoubleFilter lng() {
        if (lng == null) {
            lng = new DoubleFilter();
        }
        return lng;
    }

    public void setLng(DoubleFilter lng) {
        this.lng = lng;
    }

    public IntegerFilter getTimeZone() {
        return timeZone;
    }

    public IntegerFilter timeZone() {
        if (timeZone == null) {
            timeZone = new IntegerFilter();
        }
        return timeZone;
    }

    public void setTimeZone(IntegerFilter timeZone) {
        this.timeZone = timeZone;
    }

    public IntegerFilter getThreshold() {
        return threshold;
    }

    public IntegerFilter threshold() {
        if (threshold == null) {
            threshold = new IntegerFilter();
        }
        return threshold;
    }

    public void setThreshold(IntegerFilter threshold) {
        this.threshold = threshold;
    }

    public IntegerFilter getNearbyRange() {
        return nearbyRange;
    }

    public IntegerFilter nearbyRange() {
        if (nearbyRange == null) {
            nearbyRange = new IntegerFilter();
        }
        return nearbyRange;
    }

    public void setNearbyRange(IntegerFilter nearbyRange) {
        this.nearbyRange = nearbyRange;
    }

    public IntegerFilter getTokenTimeoutMin() {
        return tokenTimeoutMin;
    }

    public IntegerFilter tokenTimeoutMin() {
        if (tokenTimeoutMin == null) {
            tokenTimeoutMin = new IntegerFilter();
        }
        return tokenTimeoutMin;
    }

    public void setTokenTimeoutMin(IntegerFilter tokenTimeoutMin) {
        this.tokenTimeoutMin = tokenTimeoutMin;
    }

    public BooleanFilter getSelected() {
        return selected;
    }

    public BooleanFilter selected() {
        if (selected == null) {
            selected = new BooleanFilter();
        }
        return selected;
    }

    public void setSelected(BooleanFilter selected) {
        this.selected = selected;
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

    public StringFilter getCurrencySymbol() {
        return currencySymbol;
    }

    public StringFilter currencySymbol() {
        if (currencySymbol == null) {
            currencySymbol = new StringFilter();
        }
        return currencySymbol;
    }

    public void setCurrencySymbol(StringFilter currencySymbol) {
        this.currencySymbol = currencySymbol;
    }

    public StringFilter getLenMetric() {
        return lenMetric;
    }

    public StringFilter lenMetric() {
        if (lenMetric == null) {
            lenMetric = new StringFilter();
        }
        return lenMetric;
    }

    public void setLenMetric(StringFilter lenMetric) {
        this.lenMetric = lenMetric;
    }

    public StringFilter getCurrencyCode() {
        return currencyCode;
    }

    public StringFilter currencyCode() {
        if (currencyCode == null) {
            currencyCode = new StringFilter();
        }
        return currencyCode;
    }

    public void setCurrencyCode(StringFilter currencyCode) {
        this.currencyCode = currencyCode;
    }

    public StringFilter getBannerName() {
        return bannerName;
    }

    public StringFilter bannerName() {
        if (bannerName == null) {
            bannerName = new StringFilter();
        }
        return bannerName;
    }

    public void setBannerName(StringFilter bannerName) {
        this.bannerName = bannerName;
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

    public LongFilter getQueueServiceId() {
        return queueServiceId;
    }

    public LongFilter queueServiceId() {
        if (queueServiceId == null) {
            queueServiceId = new LongFilter();
        }
        return queueServiceId;
    }

    public void setQueueServiceId(LongFilter queueServiceId) {
        this.queueServiceId = queueServiceId;
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
        final QueueDepartmentCriteria that = (QueueDepartmentCriteria) o;
        return (
            Objects.equals(id, that.id) &&
            Objects.equals(profileBizId, that.profileBizId) &&
            Objects.equals(bizName, that.bizName) &&
            Objects.equals(bizCategoryName, that.bizCategoryName) &&
            Objects.equals(name, that.name) &&
            Objects.equals(desc, that.desc) &&
            Objects.equals(lat, that.lat) &&
            Objects.equals(lng, that.lng) &&
            Objects.equals(timeZone, that.timeZone) &&
            Objects.equals(threshold, that.threshold) &&
            Objects.equals(nearbyRange, that.nearbyRange) &&
            Objects.equals(tokenTimeoutMin, that.tokenTimeoutMin) &&
            Objects.equals(selected, that.selected) &&
            Objects.equals(enable, that.enable) &&
            Objects.equals(orderNum, that.orderNum) &&
            Objects.equals(currencySymbol, that.currencySymbol) &&
            Objects.equals(lenMetric, that.lenMetric) &&
            Objects.equals(currencyCode, that.currencyCode) &&
            Objects.equals(bannerName, that.bannerName) &&
            Objects.equals(createdDate, that.createdDate) &&
            Objects.equals(modifiedDate, that.modifiedDate) &&
            Objects.equals(agentId, that.agentId) &&
            Objects.equals(queueTerminalId, that.queueTerminalId) &&
            Objects.equals(queueServiceId, that.queueServiceId) &&
            Objects.equals(distinct, that.distinct)
        );
    }

    @Override
    public int hashCode() {
        return Objects.hash(
            id,
            profileBizId,
            bizName,
            bizCategoryName,
            name,
            desc,
            lat,
            lng,
            timeZone,
            threshold,
            nearbyRange,
            tokenTimeoutMin,
            selected,
            enable,
            orderNum,
            currencySymbol,
            lenMetric,
            currencyCode,
            bannerName,
            createdDate,
            modifiedDate,
            agentId,
            queueTerminalId,
            queueServiceId,
            distinct
        );
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "QueueDepartmentCriteria{" +
            (id != null ? "id=" + id + ", " : "") +
            (profileBizId != null ? "profileBizId=" + profileBizId + ", " : "") +
            (bizName != null ? "bizName=" + bizName + ", " : "") +
            (bizCategoryName != null ? "bizCategoryName=" + bizCategoryName + ", " : "") +
            (name != null ? "name=" + name + ", " : "") +
            (desc != null ? "desc=" + desc + ", " : "") +
            (lat != null ? "lat=" + lat + ", " : "") +
            (lng != null ? "lng=" + lng + ", " : "") +
            (timeZone != null ? "timeZone=" + timeZone + ", " : "") +
            (threshold != null ? "threshold=" + threshold + ", " : "") +
            (nearbyRange != null ? "nearbyRange=" + nearbyRange + ", " : "") +
            (tokenTimeoutMin != null ? "tokenTimeoutMin=" + tokenTimeoutMin + ", " : "") +
            (selected != null ? "selected=" + selected + ", " : "") +
            (enable != null ? "enable=" + enable + ", " : "") +
            (orderNum != null ? "orderNum=" + orderNum + ", " : "") +
            (currencySymbol != null ? "currencySymbol=" + currencySymbol + ", " : "") +
            (lenMetric != null ? "lenMetric=" + lenMetric + ", " : "") +
            (currencyCode != null ? "currencyCode=" + currencyCode + ", " : "") +
            (bannerName != null ? "bannerName=" + bannerName + ", " : "") +
            (createdDate != null ? "createdDate=" + createdDate + ", " : "") +
            (modifiedDate != null ? "modifiedDate=" + modifiedDate + ", " : "") +
            (agentId != null ? "agentId=" + agentId + ", " : "") +
            (queueTerminalId != null ? "queueTerminalId=" + queueTerminalId + ", " : "") +
            (queueServiceId != null ? "queueServiceId=" + queueServiceId + ", " : "") +
            (distinct != null ? "distinct=" + distinct + ", " : "") +
            "}";
    }
}

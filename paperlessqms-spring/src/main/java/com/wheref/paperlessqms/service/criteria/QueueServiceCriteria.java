package com.wheref.paperlessqms.service.criteria;

import java.io.Serializable;
import java.util.Objects;
import org.springdoc.core.annotations.ParameterObject;
import tech.jhipster.service.Criteria;
import tech.jhipster.service.filter.*;

/**
 * Criteria class for the {@link com.wheref.paperlessqms.domain.QueueService} entity. This class is used
 * in {@link com.wheref.paperlessqms.web.rest.QueueServiceResource} to receive all the possible filtering options from
 * the Http GET request parameters.
 * For example the following could be a valid request:
 * {@code /queue-services?id.greaterThan=5&attr1.contains=something&attr2.specified=false}
 * As Spring is unable to properly convert the types, unless specific {@link Filter} class are used, we need to use
 * fix type specific filters.
 */
@ParameterObject
@SuppressWarnings("common-java:DuplicatedBlocks")
public class QueueServiceCriteria implements Serializable, Criteria {

    private static final long serialVersionUID = 1L;

    private LongFilter id;

    private LongFilter profileBizId;

    private StringFilter name;

    private StringFilter type;

    private StringFilter letter;

    private IntegerFilter start;

    private StringFilter desc;

    private BooleanFilter enable;

    private IntegerFilter orderNum;

    private BooleanFilter enableCatalog;

    private LongFilter createdDate;

    private LongFilter modifiedDate;

    private LongFilter queueDepartmentId;

    private Boolean distinct;

    public QueueServiceCriteria() {}

    public QueueServiceCriteria(QueueServiceCriteria other) {
        this.id = other.id == null ? null : other.id.copy();
        this.profileBizId = other.profileBizId == null ? null : other.profileBizId.copy();
        this.name = other.name == null ? null : other.name.copy();
        this.type = other.type == null ? null : other.type.copy();
        this.letter = other.letter == null ? null : other.letter.copy();
        this.start = other.start == null ? null : other.start.copy();
        this.desc = other.desc == null ? null : other.desc.copy();
        this.enable = other.enable == null ? null : other.enable.copy();
        this.orderNum = other.orderNum == null ? null : other.orderNum.copy();
        this.enableCatalog = other.enableCatalog == null ? null : other.enableCatalog.copy();
        this.createdDate = other.createdDate == null ? null : other.createdDate.copy();
        this.modifiedDate = other.modifiedDate == null ? null : other.modifiedDate.copy();
        this.queueDepartmentId = other.queueDepartmentId == null ? null : other.queueDepartmentId.copy();
        this.distinct = other.distinct;
    }

    @Override
    public QueueServiceCriteria copy() {
        return new QueueServiceCriteria(this);
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

    public StringFilter getType() {
        return type;
    }

    public StringFilter type() {
        if (type == null) {
            type = new StringFilter();
        }
        return type;
    }

    public void setType(StringFilter type) {
        this.type = type;
    }

    public StringFilter getLetter() {
        return letter;
    }

    public StringFilter letter() {
        if (letter == null) {
            letter = new StringFilter();
        }
        return letter;
    }

    public void setLetter(StringFilter letter) {
        this.letter = letter;
    }

    public IntegerFilter getStart() {
        return start;
    }

    public IntegerFilter start() {
        if (start == null) {
            start = new IntegerFilter();
        }
        return start;
    }

    public void setStart(IntegerFilter start) {
        this.start = start;
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

    public BooleanFilter getEnableCatalog() {
        return enableCatalog;
    }

    public BooleanFilter enableCatalog() {
        if (enableCatalog == null) {
            enableCatalog = new BooleanFilter();
        }
        return enableCatalog;
    }

    public void setEnableCatalog(BooleanFilter enableCatalog) {
        this.enableCatalog = enableCatalog;
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
        final QueueServiceCriteria that = (QueueServiceCriteria) o;
        return (
            Objects.equals(id, that.id) &&
            Objects.equals(profileBizId, that.profileBizId) &&
            Objects.equals(name, that.name) &&
            Objects.equals(type, that.type) &&
            Objects.equals(letter, that.letter) &&
            Objects.equals(start, that.start) &&
            Objects.equals(desc, that.desc) &&
            Objects.equals(enable, that.enable) &&
            Objects.equals(orderNum, that.orderNum) &&
            Objects.equals(enableCatalog, that.enableCatalog) &&
            Objects.equals(createdDate, that.createdDate) &&
            Objects.equals(modifiedDate, that.modifiedDate) &&
            Objects.equals(queueDepartmentId, that.queueDepartmentId) &&
            Objects.equals(distinct, that.distinct)
        );
    }

    @Override
    public int hashCode() {
        return Objects.hash(
            id,
            profileBizId,
            name,
            type,
            letter,
            start,
            desc,
            enable,
            orderNum,
            enableCatalog,
            createdDate,
            modifiedDate,
            queueDepartmentId,
            distinct
        );
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "QueueServiceCriteria{" +
            (id != null ? "id=" + id + ", " : "") +
            (profileBizId != null ? "profileBizId=" + profileBizId + ", " : "") +
            (name != null ? "name=" + name + ", " : "") +
            (type != null ? "type=" + type + ", " : "") +
            (letter != null ? "letter=" + letter + ", " : "") +
            (start != null ? "start=" + start + ", " : "") +
            (desc != null ? "desc=" + desc + ", " : "") +
            (enable != null ? "enable=" + enable + ", " : "") +
            (orderNum != null ? "orderNum=" + orderNum + ", " : "") +
            (enableCatalog != null ? "enableCatalog=" + enableCatalog + ", " : "") +
            (createdDate != null ? "createdDate=" + createdDate + ", " : "") +
            (modifiedDate != null ? "modifiedDate=" + modifiedDate + ", " : "") +
            (queueDepartmentId != null ? "queueDepartmentId=" + queueDepartmentId + ", " : "") +
            (distinct != null ? "distinct=" + distinct + ", " : "") +
            "}";
    }
}

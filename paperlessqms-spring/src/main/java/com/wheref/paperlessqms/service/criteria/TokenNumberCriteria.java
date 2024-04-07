package com.wheref.paperlessqms.service.criteria;

import java.io.Serializable;
import java.util.Objects;
import org.springdoc.core.annotations.ParameterObject;
import tech.jhipster.service.Criteria;
import tech.jhipster.service.filter.*;

/**
 * Criteria class for the {@link com.wheref.paperlessqms.domain.TokenNumber} entity. This class is used
 * in {@link com.wheref.paperlessqms.web.rest.TokenNumberResource} to receive all the possible filtering options from
 * the Http GET request parameters.
 * For example the following could be a valid request:
 * {@code /token-numbers?id.greaterThan=5&attr1.contains=something&attr2.specified=false}
 * As Spring is unable to properly convert the types, unless specific {@link Filter} class are used, we need to use
 * fix type specific filters.
 */
@ParameterObject
@SuppressWarnings("common-java:DuplicatedBlocks")
public class TokenNumberCriteria implements Serializable, Criteria {

    private static final long serialVersionUID = 1L;

    private LongFilter id;

    private LongFilter number;

    private LongFilter departmentId;

    private LongFilter serviceId;

    private BooleanFilter reset;

    private Boolean distinct;

    public TokenNumberCriteria() {}

    public TokenNumberCriteria(TokenNumberCriteria other) {
        this.id = other.id == null ? null : other.id.copy();
        this.number = other.number == null ? null : other.number.copy();
        this.departmentId = other.departmentId == null ? null : other.departmentId.copy();
        this.serviceId = other.serviceId == null ? null : other.serviceId.copy();
        this.reset = other.reset == null ? null : other.reset.copy();
        this.distinct = other.distinct;
    }

    @Override
    public TokenNumberCriteria copy() {
        return new TokenNumberCriteria(this);
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

    public LongFilter getNumber() {
        return number;
    }

    public LongFilter number() {
        if (number == null) {
            number = new LongFilter();
        }
        return number;
    }

    public void setNumber(LongFilter number) {
        this.number = number;
    }

    public LongFilter getDepartmentId() {
        return departmentId;
    }

    public LongFilter departmentId() {
        if (departmentId == null) {
            departmentId = new LongFilter();
        }
        return departmentId;
    }

    public void setDepartmentId(LongFilter departmentId) {
        this.departmentId = departmentId;
    }

    public LongFilter getServiceId() {
        return serviceId;
    }

    public LongFilter serviceId() {
        if (serviceId == null) {
            serviceId = new LongFilter();
        }
        return serviceId;
    }

    public void setServiceId(LongFilter serviceId) {
        this.serviceId = serviceId;
    }

    public BooleanFilter getReset() {
        return reset;
    }

    public BooleanFilter reset() {
        if (reset == null) {
            reset = new BooleanFilter();
        }
        return reset;
    }

    public void setReset(BooleanFilter reset) {
        this.reset = reset;
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
        final TokenNumberCriteria that = (TokenNumberCriteria) o;
        return (
            Objects.equals(id, that.id) &&
            Objects.equals(number, that.number) &&
            Objects.equals(departmentId, that.departmentId) &&
            Objects.equals(serviceId, that.serviceId) &&
            Objects.equals(reset, that.reset) &&
            Objects.equals(distinct, that.distinct)
        );
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, number, departmentId, serviceId, reset, distinct);
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "TokenNumberCriteria{" +
            (id != null ? "id=" + id + ", " : "") +
            (number != null ? "number=" + number + ", " : "") +
            (departmentId != null ? "departmentId=" + departmentId + ", " : "") +
            (serviceId != null ? "serviceId=" + serviceId + ", " : "") +
            (reset != null ? "reset=" + reset + ", " : "") +
            (distinct != null ? "distinct=" + distinct + ", " : "") +
            "}";
    }
}

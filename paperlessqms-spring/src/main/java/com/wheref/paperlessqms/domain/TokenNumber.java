package com.wheref.paperlessqms.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A TokenNumber.
 */
@Entity
@Table(name = "token_number", indexes = { @Index(name = "fn_department_service_id", columnList = "departmentId,serviceId") })
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class TokenNumber implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    @Column(name = "id")
    private Long id;

    @Version
    @Column(name = "number")
    private Long number;

    @Column(name = "department_id")
    private Long departmentId;

    @Column(name = "service_id")
    private Long serviceId;

    @Column(name = "reset")
    private Boolean reset;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public TokenNumber id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getNumber() {
        return this.number;
    }

    public TokenNumber number(Long number) {
        this.setNumber(number);
        return this;
    }

    public void setNumber(Long number) {
        this.number = number;
    }

    public Long getDepartmentId() {
        return this.departmentId;
    }

    public TokenNumber departmentId(Long departmentId) {
        this.setDepartmentId(departmentId);
        return this;
    }

    public void setDepartmentId(Long departmentId) {
        this.departmentId = departmentId;
    }

    public Long getServiceId() {
        return this.serviceId;
    }

    public TokenNumber serviceId(Long serviceId) {
        this.setServiceId(serviceId);
        return this;
    }

    public void setServiceId(Long serviceId) {
        this.serviceId = serviceId;
    }

    public Boolean getReset() {
        return this.reset;
    }

    public TokenNumber reset(Boolean reset) {
        this.setReset(reset);
        return this;
    }

    public void setReset(Boolean reset) {
        this.reset = reset;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof TokenNumber)) {
            return false;
        }
        return getId() != null && getId().equals(((TokenNumber) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "TokenNumber{" +
            "id=" + getId() +
            ", number=" + getNumber() +
            ", departmentId=" + getDepartmentId() +
            ", serviceId=" + getServiceId() +
            ", reset='" + getReset() + "'" +
            "}";
    }
}

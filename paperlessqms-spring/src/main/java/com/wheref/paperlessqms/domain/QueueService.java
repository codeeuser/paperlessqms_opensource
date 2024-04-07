package com.wheref.paperlessqms.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A QueueService.
 */
@Entity
@Table(name = "queue_service", indexes = { @Index(name = "fn_profile_biz_id", columnList = "profileBizId") })
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class QueueService implements Serializable {

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
    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "type")
    private String type;

    @Column(name = "letter")
    private String letter;

    @Column(name = "start")
    private Integer start;

    @Column(name = "qms_desc")
    private String desc;

    @Column(name = "enable")
    private Boolean enable;

    @Column(name = "order_num")
    private Integer orderNum;

    @Column(name = "enable_catalog")
    private Boolean enableCatalog;

    @Column(name = "created_date")
    private Long createdDate;

    @Column(name = "modified_date")
    private Long modifiedDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnoreProperties(value = { "agents", "queueTerminals", "queueServices" }, allowSetters = true)
    private QueueDepartment queueDepartment;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public QueueService id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProfileBizId() {
        return this.profileBizId;
    }

    public QueueService profileBizId(Long profileBizId) {
        this.setProfileBizId(profileBizId);
        return this;
    }

    public void setProfileBizId(Long profileBizId) {
        this.profileBizId = profileBizId;
    }

    public String getName() {
        return this.name;
    }

    public QueueService name(String name) {
        this.setName(name);
        return this;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return this.type;
    }

    public QueueService type(String type) {
        this.setType(type);
        return this;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getLetter() {
        return this.letter;
    }

    public QueueService letter(String letter) {
        this.setLetter(letter);
        return this;
    }

    public void setLetter(String letter) {
        this.letter = letter;
    }

    public Integer getStart() {
        return this.start;
    }

    public QueueService start(Integer start) {
        this.setStart(start);
        return this;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public String getDesc() {
        return this.desc;
    }

    public QueueService desc(String desc) {
        this.setDesc(desc);
        return this;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Boolean getEnable() {
        return this.enable;
    }

    public QueueService enable(Boolean enable) {
        this.setEnable(enable);
        return this;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    public Integer getOrderNum() {
        return this.orderNum;
    }

    public QueueService orderNum(Integer orderNum) {
        this.setOrderNum(orderNum);
        return this;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    public Boolean getEnableCatalog() {
        return this.enableCatalog;
    }

    public QueueService enableCatalog(Boolean enableCatalog) {
        this.setEnableCatalog(enableCatalog);
        return this;
    }

    public void setEnableCatalog(Boolean enableCatalog) {
        this.enableCatalog = enableCatalog;
    }

    public Long getCreatedDate() {
        return this.createdDate;
    }

    public QueueService createdDate(Long createdDate) {
        this.setCreatedDate(createdDate);
        return this;
    }

    public void setCreatedDate(Long createdDate) {
        this.createdDate = createdDate;
    }

    public Long getModifiedDate() {
        return this.modifiedDate;
    }

    public QueueService modifiedDate(Long modifiedDate) {
        this.setModifiedDate(modifiedDate);
        return this;
    }

    public void setModifiedDate(Long modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public QueueDepartment getQueueDepartment() {
        return this.queueDepartment;
    }

    public void setQueueDepartment(QueueDepartment queueDepartment) {
        this.queueDepartment = queueDepartment;
    }

    public QueueService queueDepartment(QueueDepartment queueDepartment) {
        this.setQueueDepartment(queueDepartment);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof QueueService)) {
            return false;
        }
        return getId() != null && getId().equals(((QueueService) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "QueueService{" +
            "id=" + getId() +
            ", profileBizId=" + getProfileBizId() +
            ", name='" + getName() + "'" +
            ", type='" + getType() + "'" +
            ", letter='" + getLetter() + "'" +
            ", start=" + getStart() +
            ", desc='" + getDesc() + "'" +
            ", enable='" + getEnable() + "'" +
            ", orderNum=" + getOrderNum() +
            ", enableCatalog='" + getEnableCatalog() + "'" +
            ", createdDate=" + getCreatedDate() +
            ", modifiedDate=" + getModifiedDate() +
            "}";
    }
}

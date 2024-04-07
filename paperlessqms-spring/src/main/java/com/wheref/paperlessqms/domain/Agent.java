package com.wheref.paperlessqms.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A Agent.
 */
@Entity
@Table(name = "agent", indexes = { @Index(name = "fn_profile_biz_id", columnList = "profileBizId") })
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class Agent implements Serializable {

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
    @Column(name = "uid", nullable = false)
    private Long uid;

    @NotNull
    @Column(name = "login", nullable = false)
    private String login;

    @NotNull
    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "update_uid")
    private Long updateUid;

    @Column(name = "enable")
    private Boolean enable;

    @Column(name = "order_num")
    private Integer orderNum;

    @Column(name = "created_date")
    private Long createdDate;

    @Column(name = "modified_date")
    private Long modifiedDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnoreProperties(value = { "queueDepartment", "agents" }, allowSetters = true)
    private QueueTerminal queueTerminal;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnoreProperties(value = { "agents", "queueTerminals", "queueServices" }, allowSetters = true)
    private QueueDepartment queueDepartment;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public Agent id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProfileBizId() {
        return this.profileBizId;
    }

    public Agent profileBizId(Long profileBizId) {
        this.setProfileBizId(profileBizId);
        return this;
    }

    public void setProfileBizId(Long profileBizId) {
        this.profileBizId = profileBizId;
    }

    public Long getUid() {
        return this.uid;
    }

    public Agent uid(Long uid) {
        this.setUid(uid);
        return this;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public String getLogin() {
        return this.login;
    }

    public Agent login(String login) {
        this.setLogin(login);
        return this;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getEmail() {
        return this.email;
    }

    public Agent email(String email) {
        this.setEmail(email);
        return this;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Long getUpdateUid() {
        return this.updateUid;
    }

    public Agent updateUid(Long updateUid) {
        this.setUpdateUid(updateUid);
        return this;
    }

    public void setUpdateUid(Long updateUid) {
        this.updateUid = updateUid;
    }

    public Boolean getEnable() {
        return this.enable;
    }

    public Agent enable(Boolean enable) {
        this.setEnable(enable);
        return this;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    public Integer getOrderNum() {
        return this.orderNum;
    }

    public Agent orderNum(Integer orderNum) {
        this.setOrderNum(orderNum);
        return this;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    public Long getCreatedDate() {
        return this.createdDate;
    }

    public Agent createdDate(Long createdDate) {
        this.setCreatedDate(createdDate);
        return this;
    }

    public void setCreatedDate(Long createdDate) {
        this.createdDate = createdDate;
    }

    public Long getModifiedDate() {
        return this.modifiedDate;
    }

    public Agent modifiedDate(Long modifiedDate) {
        this.setModifiedDate(modifiedDate);
        return this;
    }

    public void setModifiedDate(Long modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public QueueTerminal getQueueTerminal() {
        return this.queueTerminal;
    }

    public void setQueueTerminal(QueueTerminal queueTerminal) {
        this.queueTerminal = queueTerminal;
    }

    public Agent queueTerminal(QueueTerminal queueTerminal) {
        this.setQueueTerminal(queueTerminal);
        return this;
    }

    public QueueDepartment getQueueDepartment() {
        return this.queueDepartment;
    }

    public void setQueueDepartment(QueueDepartment queueDepartment) {
        this.queueDepartment = queueDepartment;
    }

    public Agent queueDepartment(QueueDepartment queueDepartment) {
        this.setQueueDepartment(queueDepartment);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Agent)) {
            return false;
        }
        return getId() != null && getId().equals(((Agent) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "Agent{" +
            "id=" + getId() +
            ", profileBizId=" + getProfileBizId() +
            ", uid=" + getUid() +
            ", login='" + getLogin() + "'" +
            ", email='" + getEmail() + "'" +
            ", updateUid=" + getUpdateUid() +
            ", enable='" + getEnable() + "'" +
            ", orderNum=" + getOrderNum() +
            ", createdDate=" + getCreatedDate() +
            ", modifiedDate=" + getModifiedDate() +
            "}";
    }
}

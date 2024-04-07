package com.wheref.paperlessqms.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A QueueTerminal.
 */
@Entity
@Table(name = "queue_terminal", indexes = { @Index(name = "fn_profile_biz_id", columnList = "profileBizId") })
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class QueueTerminal implements Serializable {

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

    @Column(name = "enable")
    private Boolean enable;

    @Column(name = "order_num")
    private Integer orderNum;

    @Column(name = "created_date")
    private Long createdDate;

    @Column(name = "modified_date")
    private Long modifiedDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonIgnoreProperties(value = { "agents", "queueTerminals", "queueServices" }, allowSetters = true)
    private QueueDepartment queueDepartment;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "queueTerminal")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    @JsonIgnoreProperties(value = { "queueTerminal", "queueDepartment" }, allowSetters = true)
    private Set<Agent> agents = new HashSet<>();

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public QueueTerminal id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProfileBizId() {
        return this.profileBizId;
    }

    public QueueTerminal profileBizId(Long profileBizId) {
        this.setProfileBizId(profileBizId);
        return this;
    }

    public void setProfileBizId(Long profileBizId) {
        this.profileBizId = profileBizId;
    }

    public String getName() {
        return this.name;
    }

    public QueueTerminal name(String name) {
        this.setName(name);
        return this;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getEnable() {
        return this.enable;
    }

    public QueueTerminal enable(Boolean enable) {
        this.setEnable(enable);
        return this;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    public Integer getOrderNum() {
        return this.orderNum;
    }

    public QueueTerminal orderNum(Integer orderNum) {
        this.setOrderNum(orderNum);
        return this;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    public Long getCreatedDate() {
        return this.createdDate;
    }

    public QueueTerminal createdDate(Long createdDate) {
        this.setCreatedDate(createdDate);
        return this;
    }

    public void setCreatedDate(Long createdDate) {
        this.createdDate = createdDate;
    }

    public Long getModifiedDate() {
        return this.modifiedDate;
    }

    public QueueTerminal modifiedDate(Long modifiedDate) {
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

    public QueueTerminal queueDepartment(QueueDepartment queueDepartment) {
        this.setQueueDepartment(queueDepartment);
        return this;
    }

    public Set<Agent> getAgents() {
        return this.agents;
    }

    public void setAgents(Set<Agent> agents) {
        if (this.agents != null) {
            this.agents.forEach(i -> i.setQueueTerminal(null));
        }
        if (agents != null) {
            agents.forEach(i -> i.setQueueTerminal(this));
        }
        this.agents = agents;
    }

    public QueueTerminal agents(Set<Agent> agents) {
        this.setAgents(agents);
        return this;
    }

    public QueueTerminal addAgent(Agent agent) {
        this.agents.add(agent);
        agent.setQueueTerminal(this);
        return this;
    }

    public QueueTerminal removeAgent(Agent agent) {
        this.agents.remove(agent);
        agent.setQueueTerminal(null);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof QueueTerminal)) {
            return false;
        }
        return getId() != null && getId().equals(((QueueTerminal) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "QueueTerminal{" +
            "id=" + getId() +
            ", profileBizId=" + getProfileBizId() +
            ", name='" + getName() + "'" +
            ", enable='" + getEnable() + "'" +
            ", orderNum=" + getOrderNum() +
            ", createdDate=" + getCreatedDate() +
            ", modifiedDate=" + getModifiedDate() +
            "}";
    }
}

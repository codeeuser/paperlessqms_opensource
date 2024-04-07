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
 * A QueueDepartment.
 */
@Entity
@Table(name = "queue_department", indexes = { @Index(name = "fn_profile_biz_id", columnList = "profileBizId") })
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class QueueDepartment implements Serializable {

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
    @Column(name = "biz_name", nullable = false)
    private String bizName;

    @Column(name = "biz_category_name")
    private String bizCategoryName;

    @NotNull
    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "qms_desc")
    private String desc;

    @Column(name = "lat")
    private Double lat;

    @Column(name = "lng")
    private Double lng;

    @Column(name = "time_zone")
    private Integer timeZone;

    @Column(name = "threshold")
    private Integer threshold;

    @Column(name = "nearby_range")
    private Integer nearbyRange;

    @Column(name = "token_timeout_min")
    private Integer tokenTimeoutMin;

    @Column(name = "selected")
    private Boolean selected;

    @Column(name = "enable")
    private Boolean enable;

    @Column(name = "order_num")
    private Integer orderNum;

    @Column(name = "currency_symbol")
    private String currencySymbol;

    @Column(name = "len_metric")
    private String lenMetric;

    @Column(name = "currency_code")
    private String currencyCode;

    @Column(name = "banner_name")
    private String bannerName;

    @Column(name = "created_date")
    private Long createdDate;

    @Column(name = "modified_date")
    private Long modifiedDate;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "queueDepartment")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    @JsonIgnoreProperties(value = { "queueTerminal", "queueDepartment" }, allowSetters = true)
    private Set<Agent> agents = new HashSet<>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "queueDepartment")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    @JsonIgnoreProperties(value = { "queueDepartment", "agents" }, allowSetters = true)
    private Set<QueueTerminal> queueTerminals = new HashSet<>();

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "queueDepartment")
    @Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
    @JsonIgnoreProperties(value = { "queueDepartment" }, allowSetters = true)
    private Set<QueueService> queueServices = new HashSet<>();

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public QueueDepartment id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getProfileBizId() {
        return this.profileBizId;
    }

    public QueueDepartment profileBizId(Long profileBizId) {
        this.setProfileBizId(profileBizId);
        return this;
    }

    public void setProfileBizId(Long profileBizId) {
        this.profileBizId = profileBizId;
    }

    public String getBizName() {
        return this.bizName;
    }

    public QueueDepartment bizName(String bizName) {
        this.setBizName(bizName);
        return this;
    }

    public void setBizName(String bizName) {
        this.bizName = bizName;
    }

    public String getBizCategoryName() {
        return this.bizCategoryName;
    }

    public QueueDepartment bizCategoryName(String bizCategoryName) {
        this.setBizCategoryName(bizCategoryName);
        return this;
    }

    public void setBizCategoryName(String bizCategoryName) {
        this.bizCategoryName = bizCategoryName;
    }

    public String getName() {
        return this.name;
    }

    public QueueDepartment name(String name) {
        this.setName(name);
        return this;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDesc() {
        return this.desc;
    }

    public QueueDepartment desc(String desc) {
        this.setDesc(desc);
        return this;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Double getLat() {
        return this.lat;
    }

    public QueueDepartment lat(Double lat) {
        this.setLat(lat);
        return this;
    }

    public void setLat(Double lat) {
        this.lat = lat;
    }

    public Double getLng() {
        return this.lng;
    }

    public QueueDepartment lng(Double lng) {
        this.setLng(lng);
        return this;
    }

    public void setLng(Double lng) {
        this.lng = lng;
    }

    public Integer getTimeZone() {
        return this.timeZone;
    }

    public QueueDepartment timeZone(Integer timeZone) {
        this.setTimeZone(timeZone);
        return this;
    }

    public void setTimeZone(Integer timeZone) {
        this.timeZone = timeZone;
    }

    public Integer getThreshold() {
        return this.threshold;
    }

    public QueueDepartment threshold(Integer threshold) {
        this.setThreshold(threshold);
        return this;
    }

    public void setThreshold(Integer threshold) {
        this.threshold = threshold;
    }

    public Integer getNearbyRange() {
        return this.nearbyRange;
    }

    public QueueDepartment nearbyRange(Integer nearbyRange) {
        this.setNearbyRange(nearbyRange);
        return this;
    }

    public void setNearbyRange(Integer nearbyRange) {
        this.nearbyRange = nearbyRange;
    }

    public Integer getTokenTimeoutMin() {
        return this.tokenTimeoutMin;
    }

    public QueueDepartment tokenTimeoutMin(Integer tokenTimeoutMin) {
        this.setTokenTimeoutMin(tokenTimeoutMin);
        return this;
    }

    public void setTokenTimeoutMin(Integer tokenTimeoutMin) {
        this.tokenTimeoutMin = tokenTimeoutMin;
    }

    public Boolean getSelected() {
        return this.selected;
    }

    public QueueDepartment selected(Boolean selected) {
        this.setSelected(selected);
        return this;
    }

    public void setSelected(Boolean selected) {
        this.selected = selected;
    }

    public Boolean getEnable() {
        return this.enable;
    }

    public QueueDepartment enable(Boolean enable) {
        this.setEnable(enable);
        return this;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    public Integer getOrderNum() {
        return this.orderNum;
    }

    public QueueDepartment orderNum(Integer orderNum) {
        this.setOrderNum(orderNum);
        return this;
    }

    public void setOrderNum(Integer orderNum) {
        this.orderNum = orderNum;
    }

    public String getCurrencySymbol() {
        return this.currencySymbol;
    }

    public QueueDepartment currencySymbol(String currencySymbol) {
        this.setCurrencySymbol(currencySymbol);
        return this;
    }

    public void setCurrencySymbol(String currencySymbol) {
        this.currencySymbol = currencySymbol;
    }

    public String getLenMetric() {
        return this.lenMetric;
    }

    public QueueDepartment lenMetric(String lenMetric) {
        this.setLenMetric(lenMetric);
        return this;
    }

    public void setLenMetric(String lenMetric) {
        this.lenMetric = lenMetric;
    }

    public String getCurrencyCode() {
        return this.currencyCode;
    }

    public QueueDepartment currencyCode(String currencyCode) {
        this.setCurrencyCode(currencyCode);
        return this;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public String getBannerName() {
        return this.bannerName;
    }

    public QueueDepartment bannerName(String bannerName) {
        this.setBannerName(bannerName);
        return this;
    }

    public void setBannerName(String bannerName) {
        this.bannerName = bannerName;
    }

    public Long getCreatedDate() {
        return this.createdDate;
    }

    public QueueDepartment createdDate(Long createdDate) {
        this.setCreatedDate(createdDate);
        return this;
    }

    public void setCreatedDate(Long createdDate) {
        this.createdDate = createdDate;
    }

    public Long getModifiedDate() {
        return this.modifiedDate;
    }

    public QueueDepartment modifiedDate(Long modifiedDate) {
        this.setModifiedDate(modifiedDate);
        return this;
    }

    public void setModifiedDate(Long modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public Set<Agent> getAgents() {
        return this.agents;
    }

    public void setAgents(Set<Agent> agents) {
        if (this.agents != null) {
            this.agents.forEach(i -> i.setQueueDepartment(null));
        }
        if (agents != null) {
            agents.forEach(i -> i.setQueueDepartment(this));
        }
        this.agents = agents;
    }

    public QueueDepartment agents(Set<Agent> agents) {
        this.setAgents(agents);
        return this;
    }

    public QueueDepartment addAgent(Agent agent) {
        this.agents.add(agent);
        agent.setQueueDepartment(this);
        return this;
    }

    public QueueDepartment removeAgent(Agent agent) {
        this.agents.remove(agent);
        agent.setQueueDepartment(null);
        return this;
    }

    public Set<QueueTerminal> getQueueTerminals() {
        return this.queueTerminals;
    }

    public void setQueueTerminals(Set<QueueTerminal> queueTerminals) {
        if (this.queueTerminals != null) {
            this.queueTerminals.forEach(i -> i.setQueueDepartment(null));
        }
        if (queueTerminals != null) {
            queueTerminals.forEach(i -> i.setQueueDepartment(this));
        }
        this.queueTerminals = queueTerminals;
    }

    public QueueDepartment queueTerminals(Set<QueueTerminal> queueTerminals) {
        this.setQueueTerminals(queueTerminals);
        return this;
    }

    public QueueDepartment addQueueTerminal(QueueTerminal queueTerminal) {
        this.queueTerminals.add(queueTerminal);
        queueTerminal.setQueueDepartment(this);
        return this;
    }

    public QueueDepartment removeQueueTerminal(QueueTerminal queueTerminal) {
        this.queueTerminals.remove(queueTerminal);
        queueTerminal.setQueueDepartment(null);
        return this;
    }

    public Set<QueueService> getQueueServices() {
        return this.queueServices;
    }

    public void setQueueServices(Set<QueueService> queueServices) {
        if (this.queueServices != null) {
            this.queueServices.forEach(i -> i.setQueueDepartment(null));
        }
        if (queueServices != null) {
            queueServices.forEach(i -> i.setQueueDepartment(this));
        }
        this.queueServices = queueServices;
    }

    public QueueDepartment queueServices(Set<QueueService> queueServices) {
        this.setQueueServices(queueServices);
        return this;
    }

    public QueueDepartment addQueueService(QueueService queueService) {
        this.queueServices.add(queueService);
        queueService.setQueueDepartment(this);
        return this;
    }

    public QueueDepartment removeQueueService(QueueService queueService) {
        this.queueServices.remove(queueService);
        queueService.setQueueDepartment(null);
        return this;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof QueueDepartment)) {
            return false;
        }
        return getId() != null && getId().equals(((QueueDepartment) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "QueueDepartment{" +
            "id=" + getId() +
            ", profileBizId=" + getProfileBizId() +
            ", bizName='" + getBizName() + "'" +
            ", bizCategoryName='" + getBizCategoryName() + "'" +
            ", name='" + getName() + "'" +
            ", desc='" + getDesc() + "'" +
            ", lat=" + getLat() +
            ", lng=" + getLng() +
            ", timeZone=" + getTimeZone() +
            ", threshold=" + getThreshold() +
            ", nearbyRange=" + getNearbyRange() +
            ", tokenTimeoutMin=" + getTokenTimeoutMin() +
            ", selected='" + getSelected() + "'" +
            ", enable='" + getEnable() + "'" +
            ", orderNum=" + getOrderNum() +
            ", currencySymbol='" + getCurrencySymbol() + "'" +
            ", lenMetric='" + getLenMetric() + "'" +
            ", currencyCode='" + getCurrencyCode() + "'" +
            ", bannerName='" + getBannerName() + "'" +
            ", createdDate=" + getCreatedDate() +
            ", modifiedDate=" + getModifiedDate() +
            "}";
    }
}

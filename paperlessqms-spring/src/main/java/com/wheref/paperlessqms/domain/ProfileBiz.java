package com.wheref.paperlessqms.domain;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.io.Serializable;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A ProfileBiz.
 */
@Entity
@Table(name = "profile_biz", indexes = { @Index(name = "fn_created_by_uid", columnList = "createdByUid") })
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class ProfileBiz implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    @Column(name = "id")
    private Long id;

    @NotNull
    @Column(name = "biz_name", nullable = false)
    private String bizName;

    @Lob
    @Column(name = "biz_logo_base_64")
    private String bizLogoBase64;

    @Lob
    @Column(name = "biz_photo_base_64")
    private String bizPhotoBase64;

    @Column(name = "biz_address")
    private String bizAddress;

    @Column(name = "biz_level")
    private Integer bizLevel;

    @Column(name = "biz_email")
    private String bizEmail;

    @Column(name = "biz_phone_number")
    private String bizPhoneNumber;

    @Column(name = "biz_phone_code")
    private String bizPhoneCode;

    @Column(name = "biz_phone_iso_code")
    private String bizPhoneIsoCode;

    @Column(name = "biz_website")
    private String bizWebsite;

    @Column(name = "biz_desc")
    private String bizDesc;

    @Column(name = "enable")
    private Boolean enable;

    @Column(name = "created_by_uid")
    private Long createdByUid;

    @Column(name = "updated_by_uid")
    private Long updatedByUid;

    @Column(name = "modified_date")
    private Long modifiedDate;

    @Column(name = "created_date")
    private Long createdDate;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public ProfileBiz id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBizName() {
        return this.bizName;
    }

    public ProfileBiz bizName(String bizName) {
        this.setBizName(bizName);
        return this;
    }

    public void setBizName(String bizName) {
        this.bizName = bizName;
    }

    public String getBizLogoBase64() {
        return this.bizLogoBase64;
    }

    public ProfileBiz bizLogoBase64(String bizLogoBase64) {
        this.setBizLogoBase64(bizLogoBase64);
        return this;
    }

    public void setBizLogoBase64(String bizLogoBase64) {
        this.bizLogoBase64 = bizLogoBase64;
    }

    public String getBizPhotoBase64() {
        return this.bizPhotoBase64;
    }

    public ProfileBiz bizPhotoBase64(String bizPhotoBase64) {
        this.setBizPhotoBase64(bizPhotoBase64);
        return this;
    }

    public void setBizPhotoBase64(String bizPhotoBase64) {
        this.bizPhotoBase64 = bizPhotoBase64;
    }

    public String getBizAddress() {
        return this.bizAddress;
    }

    public ProfileBiz bizAddress(String bizAddress) {
        this.setBizAddress(bizAddress);
        return this;
    }

    public void setBizAddress(String bizAddress) {
        this.bizAddress = bizAddress;
    }

    public Integer getBizLevel() {
        return this.bizLevel;
    }

    public ProfileBiz bizLevel(Integer bizLevel) {
        this.setBizLevel(bizLevel);
        return this;
    }

    public void setBizLevel(Integer bizLevel) {
        this.bizLevel = bizLevel;
    }

    public String getBizEmail() {
        return this.bizEmail;
    }

    public ProfileBiz bizEmail(String bizEmail) {
        this.setBizEmail(bizEmail);
        return this;
    }

    public void setBizEmail(String bizEmail) {
        this.bizEmail = bizEmail;
    }

    public String getBizPhoneNumber() {
        return this.bizPhoneNumber;
    }

    public ProfileBiz bizPhoneNumber(String bizPhoneNumber) {
        this.setBizPhoneNumber(bizPhoneNumber);
        return this;
    }

    public void setBizPhoneNumber(String bizPhoneNumber) {
        this.bizPhoneNumber = bizPhoneNumber;
    }

    public String getBizPhoneCode() {
        return this.bizPhoneCode;
    }

    public ProfileBiz bizPhoneCode(String bizPhoneCode) {
        this.setBizPhoneCode(bizPhoneCode);
        return this;
    }

    public void setBizPhoneCode(String bizPhoneCode) {
        this.bizPhoneCode = bizPhoneCode;
    }

    public String getBizPhoneIsoCode() {
        return this.bizPhoneIsoCode;
    }

    public ProfileBiz bizPhoneIsoCode(String bizPhoneIsoCode) {
        this.setBizPhoneIsoCode(bizPhoneIsoCode);
        return this;
    }

    public void setBizPhoneIsoCode(String bizPhoneIsoCode) {
        this.bizPhoneIsoCode = bizPhoneIsoCode;
    }

    public String getBizWebsite() {
        return this.bizWebsite;
    }

    public ProfileBiz bizWebsite(String bizWebsite) {
        this.setBizWebsite(bizWebsite);
        return this;
    }

    public void setBizWebsite(String bizWebsite) {
        this.bizWebsite = bizWebsite;
    }

    public String getBizDesc() {
        return this.bizDesc;
    }

    public ProfileBiz bizDesc(String bizDesc) {
        this.setBizDesc(bizDesc);
        return this;
    }

    public void setBizDesc(String bizDesc) {
        this.bizDesc = bizDesc;
    }

    public Boolean getEnable() {
        return this.enable;
    }

    public ProfileBiz enable(Boolean enable) {
        this.setEnable(enable);
        return this;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

    public Long getCreatedByUid() {
        return this.createdByUid;
    }

    public ProfileBiz createdByUid(Long createdByUid) {
        this.setCreatedByUid(createdByUid);
        return this;
    }

    public void setCreatedByUid(Long createdByUid) {
        this.createdByUid = createdByUid;
    }

    public Long getUpdatedByUid() {
        return this.updatedByUid;
    }

    public ProfileBiz updatedByUid(Long updatedByUid) {
        this.setUpdatedByUid(updatedByUid);
        return this;
    }

    public void setUpdatedByUid(Long updatedByUid) {
        this.updatedByUid = updatedByUid;
    }

    public Long getModifiedDate() {
        return this.modifiedDate;
    }

    public ProfileBiz modifiedDate(Long modifiedDate) {
        this.setModifiedDate(modifiedDate);
        return this;
    }

    public void setModifiedDate(Long modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public Long getCreatedDate() {
        return this.createdDate;
    }

    public ProfileBiz createdDate(Long createdDate) {
        this.setCreatedDate(createdDate);
        return this;
    }

    public void setCreatedDate(Long createdDate) {
        this.createdDate = createdDate;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ProfileBiz)) {
            return false;
        }
        return getId() != null && getId().equals(((ProfileBiz) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "ProfileBiz{" +
            "id=" + getId() +
            ", bizName='" + getBizName() + "'" +
            ", bizLogoBase64='" + getBizLogoBase64() + "'" +
            ", bizPhotoBase64='" + getBizPhotoBase64() + "'" +
            ", bizAddress='" + getBizAddress() + "'" +
            ", bizLevel=" + getBizLevel() +
            ", bizEmail='" + getBizEmail() + "'" +
            ", bizPhoneNumber='" + getBizPhoneNumber() + "'" +
            ", bizPhoneCode='" + getBizPhoneCode() + "'" +
            ", bizPhoneIsoCode='" + getBizPhoneIsoCode() + "'" +
            ", bizWebsite='" + getBizWebsite() + "'" +
            ", bizDesc='" + getBizDesc() + "'" +
            ", enable='" + getEnable() + "'" +
            ", createdByUid=" + getCreatedByUid() +
            ", updatedByUid=" + getUpdatedByUid() +
            ", modifiedDate=" + getModifiedDate() +
            ", createdDate=" + getCreatedDate() +
            "}";
    }
}

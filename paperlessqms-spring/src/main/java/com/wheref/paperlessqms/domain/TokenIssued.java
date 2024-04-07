package com.wheref.paperlessqms.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import java.io.Serializable;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

/**
 * A TokenIssued.
 */
@Entity
@Table(
    name = "token_issued",
    indexes = {
        @Index(name = "fn_profile_biz_id", columnList = "profileBizId"),
        @Index(name = "fn_department_id_id", columnList = "departmentId"),
        @Index(name = "fn_service_id", columnList = "serviceId"),
        @Index(name = "fn_terminal_id", columnList = "terminalId"),
    }
)
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE)
@SuppressWarnings("common-java:DuplicatedBlocks")
public class TokenIssued implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    @Column(name = "id")
    private Long id;

    @NotNull
    @Column(name = "uid", nullable = false)
    private Long uid;

    @Column(name = "profile_biz_id")
    private Long profileBizId;

    @Column(name = "phone_number")
    private String phoneNumber;

    @Column(name = "phone_iso_code")
    private String phoneIsoCode;

    @Column(name = "phone_code")
    private String phoneCode;

    @Column(name = "user_email")
    private String userEmail;

    @Column(name = "user_first_name")
    private String userFirstName;

    @Column(name = "user_last_name")
    private String userLastName;

    @Column(name = "token_letter")
    private String tokenLetter;

    @Column(name = "token_number")
    private Integer tokenNumber;

    @Column(name = "service_name")
    private String serviceName;

    @Column(name = "service_id")
    private Long serviceId;

    @Column(name = "terminal_name")
    private String terminalName;

    @Column(name = "terminal_id")
    private Long terminalId;

    @Column(name = "org_terminal_name")
    private String orgTerminalName;

    @Column(name = "org_terminal_id")
    private Long orgTerminalId;

    @Column(name = "status_name")
    private String statusName;

    @Column(name = "status_code")
    private Integer statusCode;

    @Column(name = "is_pending")
    private Boolean isPending;

    @Column(name = "is_queue")
    private Boolean isQueue;

    @Column(name = "is_reject")
    private Boolean isReject;

    @Column(name = "is_absent")
    private Boolean isAbsent;

    @Column(name = "is_cancel")
    private Boolean isCancel;

    @Column(name = "is_recall")
    private Boolean isRecall;

    @Column(name = "is_completed")
    private Boolean isCompleted;

    @Column(name = "is_timeout")
    private Boolean isTimeout;

    @Column(name = "assigned_date")
    private Long assignedDate;

    @Column(name = "assigned_year")
    private Integer assignedYear;

    @Column(name = "assigned_month")
    private Integer assignedMonth;

    @Column(name = "assigned_day")
    private Integer assignedDay;

    @Column(name = "assigned_hour")
    private Integer assignedHour;

    @Column(name = "assigned_min")
    private Integer assignedMin;

    @Column(name = "assigned_time_zone_offset")
    private Integer assignedTimeZoneOffset;

    @Column(name = "assigned_time_zone_name")
    private String assignedTimeZoneName;

    @Column(name = "assigned_now")
    private String assignedNow;

    @Column(name = "assigned_uid")
    private Long assignedUid;

    @Column(name = "completed_year")
    private Integer completedYear;

    @Column(name = "completed_month")
    private Integer completedMonth;

    @Column(name = "completed_day")
    private Integer completedDay;

    @Column(name = "completed_hour")
    private Integer completedHour;

    @Column(name = "completed_min")
    private Integer completedMin;

    @Column(name = "completed_time_zone_offset")
    private Integer completedTimeZoneOffset;

    @Column(name = "completed_time_zone_name")
    private String completedTimeZoneName;

    @Column(name = "completed_now")
    private String completedNow;

    @Column(name = "completed_date")
    private Long completedDate;

    @Column(name = "completed_uid")
    private Long completedUid;

    @Column(name = "created_year")
    private Integer createdYear;

    @Column(name = "created_month")
    private Integer createdMonth;

    @Column(name = "created_day")
    private Integer createdDay;

    @Column(name = "created_hour")
    private Integer createdHour;

    @Column(name = "created_min")
    private Integer createdMin;

    @Column(name = "created_time_zone_offset")
    private Integer createdTimeZoneOffset;

    @Column(name = "created_time_zone_name")
    private String createdTimeZoneName;

    @Column(name = "created_now")
    private String createdNow;

    @Column(name = "created_date")
    private Long createdDate;

    @Column(name = "modified_year")
    private Integer modifiedYear;

    @Column(name = "modified_month")
    private Integer modifiedMonth;

    @Column(name = "modified_day")
    private Integer modifiedDay;

    @Column(name = "modified_hour")
    private Integer modifiedHour;

    @Column(name = "modified_min")
    private Integer modifiedMin;

    @Column(name = "modified_time_zone_offset")
    private Integer modifiedTimeZoneOffset;

    @Column(name = "modified_time_zone_name")
    private String modifiedTimeZoneName;

    @Column(name = "modified_now")
    private String modifiedNow;

    @Column(name = "modified_date")
    private Long modifiedDate;

    @Column(name = "transfered_year")
    private Integer transferedYear;

    @Column(name = "transfered_month")
    private Integer transferedMonth;

    @Column(name = "transfered_day")
    private Integer transferedDay;

    @Column(name = "transfered_hour")
    private Integer transferedHour;

    @Column(name = "transfered_min")
    private Integer transferedMin;

    @Column(name = "transfered_date")
    private Long transferedDate;

    @Column(name = "transfered_time_zone_offset")
    private Integer transferedTimeZoneOffset;

    @Column(name = "transfered_time_zone_name")
    private String transferedTimeZoneName;

    @Column(name = "transfered_now")
    private String transferedNow;

    @Column(name = "transfered_uid")
    private Long transferedUid;

    @Column(name = "issued_from")
    private String issuedFrom;

    @Column(name = "department_id")
    private Long departmentId;

    @Column(name = "department_name")
    private String departmentName;

    @Column(name = "biz_name")
    private String bizName;

    @Column(name = "rating")
    private Double rating;

    @Column(name = "feedback")
    private String feedback;

    @Column(name = "sms_coming_count")
    private Integer smsComingCount;

    @Column(name = "push_coming_count")
    private Integer pushComingCount;

    @Column(name = "order_id")
    private String orderId;

    @Column(name = "reset")
    private Boolean reset;

    @Column(name = "reset_date")
    private Long resetDate;

    @Column(name = "reset_uid")
    private Long resetUid;

    // jhipster-needle-entity-add-field - JHipster will add fields here

    public Long getId() {
        return this.id;
    }

    public TokenIssued id(Long id) {
        this.setId(id);
        return this;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUid() {
        return this.uid;
    }

    public TokenIssued uid(Long uid) {
        this.setUid(uid);
        return this;
    }

    public void setUid(Long uid) {
        this.uid = uid;
    }

    public Long getProfileBizId() {
        return this.profileBizId;
    }

    public TokenIssued profileBizId(Long profileBizId) {
        this.setProfileBizId(profileBizId);
        return this;
    }

    public void setProfileBizId(Long profileBizId) {
        this.profileBizId = profileBizId;
    }

    public String getPhoneNumber() {
        return this.phoneNumber;
    }

    public TokenIssued phoneNumber(String phoneNumber) {
        this.setPhoneNumber(phoneNumber);
        return this;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPhoneIsoCode() {
        return this.phoneIsoCode;
    }

    public TokenIssued phoneIsoCode(String phoneIsoCode) {
        this.setPhoneIsoCode(phoneIsoCode);
        return this;
    }

    public void setPhoneIsoCode(String phoneIsoCode) {
        this.phoneIsoCode = phoneIsoCode;
    }

    public String getPhoneCode() {
        return this.phoneCode;
    }

    public TokenIssued phoneCode(String phoneCode) {
        this.setPhoneCode(phoneCode);
        return this;
    }

    public void setPhoneCode(String phoneCode) {
        this.phoneCode = phoneCode;
    }

    public String getUserEmail() {
        return this.userEmail;
    }

    public TokenIssued userEmail(String userEmail) {
        this.setUserEmail(userEmail);
        return this;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserFirstName() {
        return this.userFirstName;
    }

    public TokenIssued userFirstName(String userFirstName) {
        this.setUserFirstName(userFirstName);
        return this;
    }

    public void setUserFirstName(String userFirstName) {
        this.userFirstName = userFirstName;
    }

    public String getUserLastName() {
        return this.userLastName;
    }

    public TokenIssued userLastName(String userLastName) {
        this.setUserLastName(userLastName);
        return this;
    }

    public void setUserLastName(String userLastName) {
        this.userLastName = userLastName;
    }

    public String getTokenLetter() {
        return this.tokenLetter;
    }

    public TokenIssued tokenLetter(String tokenLetter) {
        this.setTokenLetter(tokenLetter);
        return this;
    }

    public void setTokenLetter(String tokenLetter) {
        this.tokenLetter = tokenLetter;
    }

    public Integer getTokenNumber() {
        return this.tokenNumber;
    }

    public TokenIssued tokenNumber(Integer tokenNumber) {
        this.setTokenNumber(tokenNumber);
        return this;
    }

    public void setTokenNumber(Integer tokenNumber) {
        this.tokenNumber = tokenNumber;
    }

    public String getServiceName() {
        return this.serviceName;
    }

    public TokenIssued serviceName(String serviceName) {
        this.setServiceName(serviceName);
        return this;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public Long getServiceId() {
        return this.serviceId;
    }

    public TokenIssued serviceId(Long serviceId) {
        this.setServiceId(serviceId);
        return this;
    }

    public void setServiceId(Long serviceId) {
        this.serviceId = serviceId;
    }

    public String getTerminalName() {
        return this.terminalName;
    }

    public TokenIssued terminalName(String terminalName) {
        this.setTerminalName(terminalName);
        return this;
    }

    public void setTerminalName(String terminalName) {
        this.terminalName = terminalName;
    }

    public Long getTerminalId() {
        return this.terminalId;
    }

    public TokenIssued terminalId(Long terminalId) {
        this.setTerminalId(terminalId);
        return this;
    }

    public void setTerminalId(Long terminalId) {
        this.terminalId = terminalId;
    }

    public String getOrgTerminalName() {
        return this.orgTerminalName;
    }

    public TokenIssued orgTerminalName(String orgTerminalName) {
        this.setOrgTerminalName(orgTerminalName);
        return this;
    }

    public void setOrgTerminalName(String orgTerminalName) {
        this.orgTerminalName = orgTerminalName;
    }

    public Long getOrgTerminalId() {
        return this.orgTerminalId;
    }

    public TokenIssued orgTerminalId(Long orgTerminalId) {
        this.setOrgTerminalId(orgTerminalId);
        return this;
    }

    public void setOrgTerminalId(Long orgTerminalId) {
        this.orgTerminalId = orgTerminalId;
    }

    public String getStatusName() {
        return this.statusName;
    }

    public TokenIssued statusName(String statusName) {
        this.setStatusName(statusName);
        return this;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public Integer getStatusCode() {
        return this.statusCode;
    }

    public TokenIssued statusCode(Integer statusCode) {
        this.setStatusCode(statusCode);
        return this;
    }

    public void setStatusCode(Integer statusCode) {
        this.statusCode = statusCode;
    }

    public Boolean getIsPending() {
        return this.isPending;
    }

    public TokenIssued isPending(Boolean isPending) {
        this.setIsPending(isPending);
        return this;
    }

    public void setIsPending(Boolean isPending) {
        this.isPending = isPending;
    }

    public Boolean getIsQueue() {
        return this.isQueue;
    }

    public TokenIssued isQueue(Boolean isQueue) {
        this.setIsQueue(isQueue);
        return this;
    }

    public void setIsQueue(Boolean isQueue) {
        this.isQueue = isQueue;
    }

    public Boolean getIsReject() {
        return this.isReject;
    }

    public TokenIssued isReject(Boolean isReject) {
        this.setIsReject(isReject);
        return this;
    }

    public void setIsReject(Boolean isReject) {
        this.isReject = isReject;
    }

    public Boolean getIsAbsent() {
        return this.isAbsent;
    }

    public TokenIssued isAbsent(Boolean isAbsent) {
        this.setIsAbsent(isAbsent);
        return this;
    }

    public void setIsAbsent(Boolean isAbsent) {
        this.isAbsent = isAbsent;
    }

    public Boolean getIsCancel() {
        return this.isCancel;
    }

    public TokenIssued isCancel(Boolean isCancel) {
        this.setIsCancel(isCancel);
        return this;
    }

    public void setIsCancel(Boolean isCancel) {
        this.isCancel = isCancel;
    }

    public Boolean getIsRecall() {
        return this.isRecall;
    }

    public TokenIssued isRecall(Boolean isRecall) {
        this.setIsRecall(isRecall);
        return this;
    }

    public void setIsRecall(Boolean isRecall) {
        this.isRecall = isRecall;
    }

    public Boolean getIsCompleted() {
        return this.isCompleted;
    }

    public TokenIssued isCompleted(Boolean isCompleted) {
        this.setIsCompleted(isCompleted);
        return this;
    }

    public void setIsCompleted(Boolean isCompleted) {
        this.isCompleted = isCompleted;
    }

    public Boolean getIsTimeout() {
        return this.isTimeout;
    }

    public TokenIssued isTimeout(Boolean isTimeout) {
        this.setIsTimeout(isTimeout);
        return this;
    }

    public void setIsTimeout(Boolean isTimeout) {
        this.isTimeout = isTimeout;
    }

    public Long getAssignedDate() {
        return this.assignedDate;
    }

    public TokenIssued assignedDate(Long assignedDate) {
        this.setAssignedDate(assignedDate);
        return this;
    }

    public void setAssignedDate(Long assignedDate) {
        this.assignedDate = assignedDate;
    }

    public Integer getAssignedYear() {
        return this.assignedYear;
    }

    public TokenIssued assignedYear(Integer assignedYear) {
        this.setAssignedYear(assignedYear);
        return this;
    }

    public void setAssignedYear(Integer assignedYear) {
        this.assignedYear = assignedYear;
    }

    public Integer getAssignedMonth() {
        return this.assignedMonth;
    }

    public TokenIssued assignedMonth(Integer assignedMonth) {
        this.setAssignedMonth(assignedMonth);
        return this;
    }

    public void setAssignedMonth(Integer assignedMonth) {
        this.assignedMonth = assignedMonth;
    }

    public Integer getAssignedDay() {
        return this.assignedDay;
    }

    public TokenIssued assignedDay(Integer assignedDay) {
        this.setAssignedDay(assignedDay);
        return this;
    }

    public void setAssignedDay(Integer assignedDay) {
        this.assignedDay = assignedDay;
    }

    public Integer getAssignedHour() {
        return this.assignedHour;
    }

    public TokenIssued assignedHour(Integer assignedHour) {
        this.setAssignedHour(assignedHour);
        return this;
    }

    public void setAssignedHour(Integer assignedHour) {
        this.assignedHour = assignedHour;
    }

    public Integer getAssignedMin() {
        return this.assignedMin;
    }

    public TokenIssued assignedMin(Integer assignedMin) {
        this.setAssignedMin(assignedMin);
        return this;
    }

    public void setAssignedMin(Integer assignedMin) {
        this.assignedMin = assignedMin;
    }

    public Integer getAssignedTimeZoneOffset() {
        return this.assignedTimeZoneOffset;
    }

    public TokenIssued assignedTimeZoneOffset(Integer assignedTimeZoneOffset) {
        this.setAssignedTimeZoneOffset(assignedTimeZoneOffset);
        return this;
    }

    public void setAssignedTimeZoneOffset(Integer assignedTimeZoneOffset) {
        this.assignedTimeZoneOffset = assignedTimeZoneOffset;
    }

    public String getAssignedTimeZoneName() {
        return this.assignedTimeZoneName;
    }

    public TokenIssued assignedTimeZoneName(String assignedTimeZoneName) {
        this.setAssignedTimeZoneName(assignedTimeZoneName);
        return this;
    }

    public void setAssignedTimeZoneName(String assignedTimeZoneName) {
        this.assignedTimeZoneName = assignedTimeZoneName;
    }

    public String getAssignedNow() {
        return this.assignedNow;
    }

    public TokenIssued assignedNow(String assignedNow) {
        this.setAssignedNow(assignedNow);
        return this;
    }

    public void setAssignedNow(String assignedNow) {
        this.assignedNow = assignedNow;
    }

    public Long getAssignedUid() {
        return this.assignedUid;
    }

    public TokenIssued assignedUid(Long assignedUid) {
        this.setAssignedUid(assignedUid);
        return this;
    }

    public void setAssignedUid(Long assignedUid) {
        this.assignedUid = assignedUid;
    }

    public Integer getCompletedYear() {
        return this.completedYear;
    }

    public TokenIssued completedYear(Integer completedYear) {
        this.setCompletedYear(completedYear);
        return this;
    }

    public void setCompletedYear(Integer completedYear) {
        this.completedYear = completedYear;
    }

    public Integer getCompletedMonth() {
        return this.completedMonth;
    }

    public TokenIssued completedMonth(Integer completedMonth) {
        this.setCompletedMonth(completedMonth);
        return this;
    }

    public void setCompletedMonth(Integer completedMonth) {
        this.completedMonth = completedMonth;
    }

    public Integer getCompletedDay() {
        return this.completedDay;
    }

    public TokenIssued completedDay(Integer completedDay) {
        this.setCompletedDay(completedDay);
        return this;
    }

    public void setCompletedDay(Integer completedDay) {
        this.completedDay = completedDay;
    }

    public Integer getCompletedHour() {
        return this.completedHour;
    }

    public TokenIssued completedHour(Integer completedHour) {
        this.setCompletedHour(completedHour);
        return this;
    }

    public void setCompletedHour(Integer completedHour) {
        this.completedHour = completedHour;
    }

    public Integer getCompletedMin() {
        return this.completedMin;
    }

    public TokenIssued completedMin(Integer completedMin) {
        this.setCompletedMin(completedMin);
        return this;
    }

    public void setCompletedMin(Integer completedMin) {
        this.completedMin = completedMin;
    }

    public Integer getCompletedTimeZoneOffset() {
        return this.completedTimeZoneOffset;
    }

    public TokenIssued completedTimeZoneOffset(Integer completedTimeZoneOffset) {
        this.setCompletedTimeZoneOffset(completedTimeZoneOffset);
        return this;
    }

    public void setCompletedTimeZoneOffset(Integer completedTimeZoneOffset) {
        this.completedTimeZoneOffset = completedTimeZoneOffset;
    }

    public String getCompletedTimeZoneName() {
        return this.completedTimeZoneName;
    }

    public TokenIssued completedTimeZoneName(String completedTimeZoneName) {
        this.setCompletedTimeZoneName(completedTimeZoneName);
        return this;
    }

    public void setCompletedTimeZoneName(String completedTimeZoneName) {
        this.completedTimeZoneName = completedTimeZoneName;
    }

    public String getCompletedNow() {
        return this.completedNow;
    }

    public TokenIssued completedNow(String completedNow) {
        this.setCompletedNow(completedNow);
        return this;
    }

    public void setCompletedNow(String completedNow) {
        this.completedNow = completedNow;
    }

    public Long getCompletedDate() {
        return this.completedDate;
    }

    public TokenIssued completedDate(Long completedDate) {
        this.setCompletedDate(completedDate);
        return this;
    }

    public void setCompletedDate(Long completedDate) {
        this.completedDate = completedDate;
    }

    public Long getCompletedUid() {
        return this.completedUid;
    }

    public TokenIssued completedUid(Long completedUid) {
        this.setCompletedUid(completedUid);
        return this;
    }

    public void setCompletedUid(Long completedUid) {
        this.completedUid = completedUid;
    }

    public Integer getCreatedYear() {
        return this.createdYear;
    }

    public TokenIssued createdYear(Integer createdYear) {
        this.setCreatedYear(createdYear);
        return this;
    }

    public void setCreatedYear(Integer createdYear) {
        this.createdYear = createdYear;
    }

    public Integer getCreatedMonth() {
        return this.createdMonth;
    }

    public TokenIssued createdMonth(Integer createdMonth) {
        this.setCreatedMonth(createdMonth);
        return this;
    }

    public void setCreatedMonth(Integer createdMonth) {
        this.createdMonth = createdMonth;
    }

    public Integer getCreatedDay() {
        return this.createdDay;
    }

    public TokenIssued createdDay(Integer createdDay) {
        this.setCreatedDay(createdDay);
        return this;
    }

    public void setCreatedDay(Integer createdDay) {
        this.createdDay = createdDay;
    }

    public Integer getCreatedHour() {
        return this.createdHour;
    }

    public TokenIssued createdHour(Integer createdHour) {
        this.setCreatedHour(createdHour);
        return this;
    }

    public void setCreatedHour(Integer createdHour) {
        this.createdHour = createdHour;
    }

    public Integer getCreatedMin() {
        return this.createdMin;
    }

    public TokenIssued createdMin(Integer createdMin) {
        this.setCreatedMin(createdMin);
        return this;
    }

    public void setCreatedMin(Integer createdMin) {
        this.createdMin = createdMin;
    }

    public Integer getCreatedTimeZoneOffset() {
        return this.createdTimeZoneOffset;
    }

    public TokenIssued createdTimeZoneOffset(Integer createdTimeZoneOffset) {
        this.setCreatedTimeZoneOffset(createdTimeZoneOffset);
        return this;
    }

    public void setCreatedTimeZoneOffset(Integer createdTimeZoneOffset) {
        this.createdTimeZoneOffset = createdTimeZoneOffset;
    }

    public String getCreatedTimeZoneName() {
        return this.createdTimeZoneName;
    }

    public TokenIssued createdTimeZoneName(String createdTimeZoneName) {
        this.setCreatedTimeZoneName(createdTimeZoneName);
        return this;
    }

    public void setCreatedTimeZoneName(String createdTimeZoneName) {
        this.createdTimeZoneName = createdTimeZoneName;
    }

    public String getCreatedNow() {
        return this.createdNow;
    }

    public TokenIssued createdNow(String createdNow) {
        this.setCreatedNow(createdNow);
        return this;
    }

    public void setCreatedNow(String createdNow) {
        this.createdNow = createdNow;
    }

    public Long getCreatedDate() {
        return this.createdDate;
    }

    public TokenIssued createdDate(Long createdDate) {
        this.setCreatedDate(createdDate);
        return this;
    }

    public void setCreatedDate(Long createdDate) {
        this.createdDate = createdDate;
    }

    public Integer getModifiedYear() {
        return this.modifiedYear;
    }

    public TokenIssued modifiedYear(Integer modifiedYear) {
        this.setModifiedYear(modifiedYear);
        return this;
    }

    public void setModifiedYear(Integer modifiedYear) {
        this.modifiedYear = modifiedYear;
    }

    public Integer getModifiedMonth() {
        return this.modifiedMonth;
    }

    public TokenIssued modifiedMonth(Integer modifiedMonth) {
        this.setModifiedMonth(modifiedMonth);
        return this;
    }

    public void setModifiedMonth(Integer modifiedMonth) {
        this.modifiedMonth = modifiedMonth;
    }

    public Integer getModifiedDay() {
        return this.modifiedDay;
    }

    public TokenIssued modifiedDay(Integer modifiedDay) {
        this.setModifiedDay(modifiedDay);
        return this;
    }

    public void setModifiedDay(Integer modifiedDay) {
        this.modifiedDay = modifiedDay;
    }

    public Integer getModifiedHour() {
        return this.modifiedHour;
    }

    public TokenIssued modifiedHour(Integer modifiedHour) {
        this.setModifiedHour(modifiedHour);
        return this;
    }

    public void setModifiedHour(Integer modifiedHour) {
        this.modifiedHour = modifiedHour;
    }

    public Integer getModifiedMin() {
        return this.modifiedMin;
    }

    public TokenIssued modifiedMin(Integer modifiedMin) {
        this.setModifiedMin(modifiedMin);
        return this;
    }

    public void setModifiedMin(Integer modifiedMin) {
        this.modifiedMin = modifiedMin;
    }

    public Integer getModifiedTimeZoneOffset() {
        return this.modifiedTimeZoneOffset;
    }

    public TokenIssued modifiedTimeZoneOffset(Integer modifiedTimeZoneOffset) {
        this.setModifiedTimeZoneOffset(modifiedTimeZoneOffset);
        return this;
    }

    public void setModifiedTimeZoneOffset(Integer modifiedTimeZoneOffset) {
        this.modifiedTimeZoneOffset = modifiedTimeZoneOffset;
    }

    public String getModifiedTimeZoneName() {
        return this.modifiedTimeZoneName;
    }

    public TokenIssued modifiedTimeZoneName(String modifiedTimeZoneName) {
        this.setModifiedTimeZoneName(modifiedTimeZoneName);
        return this;
    }

    public void setModifiedTimeZoneName(String modifiedTimeZoneName) {
        this.modifiedTimeZoneName = modifiedTimeZoneName;
    }

    public String getModifiedNow() {
        return this.modifiedNow;
    }

    public TokenIssued modifiedNow(String modifiedNow) {
        this.setModifiedNow(modifiedNow);
        return this;
    }

    public void setModifiedNow(String modifiedNow) {
        this.modifiedNow = modifiedNow;
    }

    public Long getModifiedDate() {
        return this.modifiedDate;
    }

    public TokenIssued modifiedDate(Long modifiedDate) {
        this.setModifiedDate(modifiedDate);
        return this;
    }

    public void setModifiedDate(Long modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public Integer getTransferedYear() {
        return this.transferedYear;
    }

    public TokenIssued transferedYear(Integer transferedYear) {
        this.setTransferedYear(transferedYear);
        return this;
    }

    public void setTransferedYear(Integer transferedYear) {
        this.transferedYear = transferedYear;
    }

    public Integer getTransferedMonth() {
        return this.transferedMonth;
    }

    public TokenIssued transferedMonth(Integer transferedMonth) {
        this.setTransferedMonth(transferedMonth);
        return this;
    }

    public void setTransferedMonth(Integer transferedMonth) {
        this.transferedMonth = transferedMonth;
    }

    public Integer getTransferedDay() {
        return this.transferedDay;
    }

    public TokenIssued transferedDay(Integer transferedDay) {
        this.setTransferedDay(transferedDay);
        return this;
    }

    public void setTransferedDay(Integer transferedDay) {
        this.transferedDay = transferedDay;
    }

    public Integer getTransferedHour() {
        return this.transferedHour;
    }

    public TokenIssued transferedHour(Integer transferedHour) {
        this.setTransferedHour(transferedHour);
        return this;
    }

    public void setTransferedHour(Integer transferedHour) {
        this.transferedHour = transferedHour;
    }

    public Integer getTransferedMin() {
        return this.transferedMin;
    }

    public TokenIssued transferedMin(Integer transferedMin) {
        this.setTransferedMin(transferedMin);
        return this;
    }

    public void setTransferedMin(Integer transferedMin) {
        this.transferedMin = transferedMin;
    }

    public Long getTransferedDate() {
        return this.transferedDate;
    }

    public TokenIssued transferedDate(Long transferedDate) {
        this.setTransferedDate(transferedDate);
        return this;
    }

    public void setTransferedDate(Long transferedDate) {
        this.transferedDate = transferedDate;
    }

    public Integer getTransferedTimeZoneOffset() {
        return this.transferedTimeZoneOffset;
    }

    public TokenIssued transferedTimeZoneOffset(Integer transferedTimeZoneOffset) {
        this.setTransferedTimeZoneOffset(transferedTimeZoneOffset);
        return this;
    }

    public void setTransferedTimeZoneOffset(Integer transferedTimeZoneOffset) {
        this.transferedTimeZoneOffset = transferedTimeZoneOffset;
    }

    public String getTransferedTimeZoneName() {
        return this.transferedTimeZoneName;
    }

    public TokenIssued transferedTimeZoneName(String transferedTimeZoneName) {
        this.setTransferedTimeZoneName(transferedTimeZoneName);
        return this;
    }

    public void setTransferedTimeZoneName(String transferedTimeZoneName) {
        this.transferedTimeZoneName = transferedTimeZoneName;
    }

    public String getTransferedNow() {
        return this.transferedNow;
    }

    public TokenIssued transferedNow(String transferedNow) {
        this.setTransferedNow(transferedNow);
        return this;
    }

    public void setTransferedNow(String transferedNow) {
        this.transferedNow = transferedNow;
    }

    public Long getTransferedUid() {
        return this.transferedUid;
    }

    public TokenIssued transferedUid(Long transferedUid) {
        this.setTransferedUid(transferedUid);
        return this;
    }

    public void setTransferedUid(Long transferedUid) {
        this.transferedUid = transferedUid;
    }

    public String getIssuedFrom() {
        return this.issuedFrom;
    }

    public TokenIssued issuedFrom(String issuedFrom) {
        this.setIssuedFrom(issuedFrom);
        return this;
    }

    public void setIssuedFrom(String issuedFrom) {
        this.issuedFrom = issuedFrom;
    }

    public Long getDepartmentId() {
        return this.departmentId;
    }

    public TokenIssued departmentId(Long departmentId) {
        this.setDepartmentId(departmentId);
        return this;
    }

    public void setDepartmentId(Long departmentId) {
        this.departmentId = departmentId;
    }

    public String getDepartmentName() {
        return this.departmentName;
    }

    public TokenIssued departmentName(String departmentName) {
        this.setDepartmentName(departmentName);
        return this;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getBizName() {
        return this.bizName;
    }

    public TokenIssued bizName(String bizName) {
        this.setBizName(bizName);
        return this;
    }

    public void setBizName(String bizName) {
        this.bizName = bizName;
    }

    public Double getRating() {
        return this.rating;
    }

    public TokenIssued rating(Double rating) {
        this.setRating(rating);
        return this;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public String getFeedback() {
        return this.feedback;
    }

    public TokenIssued feedback(String feedback) {
        this.setFeedback(feedback);
        return this;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public Integer getSmsComingCount() {
        return this.smsComingCount;
    }

    public TokenIssued smsComingCount(Integer smsComingCount) {
        this.setSmsComingCount(smsComingCount);
        return this;
    }

    public void setSmsComingCount(Integer smsComingCount) {
        this.smsComingCount = smsComingCount;
    }

    public Integer getPushComingCount() {
        return this.pushComingCount;
    }

    public TokenIssued pushComingCount(Integer pushComingCount) {
        this.setPushComingCount(pushComingCount);
        return this;
    }

    public void setPushComingCount(Integer pushComingCount) {
        this.pushComingCount = pushComingCount;
    }

    public String getOrderId() {
        return this.orderId;
    }

    public TokenIssued orderId(String orderId) {
        this.setOrderId(orderId);
        return this;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public Boolean getReset() {
        return this.reset;
    }

    public TokenIssued reset(Boolean reset) {
        this.setReset(reset);
        return this;
    }

    public void setReset(Boolean reset) {
        this.reset = reset;
    }

    public Long getResetDate() {
        return this.resetDate;
    }

    public TokenIssued resetDate(Long resetDate) {
        this.setResetDate(resetDate);
        return this;
    }

    public void setResetDate(Long resetDate) {
        this.resetDate = resetDate;
    }

    public Long getResetUid() {
        return this.resetUid;
    }

    public TokenIssued resetUid(Long resetUid) {
        this.setResetUid(resetUid);
        return this;
    }

    public void setResetUid(Long resetUid) {
        this.resetUid = resetUid;
    }

    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof TokenIssued)) {
            return false;
        }
        return getId() != null && getId().equals(((TokenIssued) o).getId());
    }

    @Override
    public int hashCode() {
        // see https://vladmihalcea.com/how-to-implement-equals-and-hashcode-using-the-jpa-entity-identifier/
        return getClass().hashCode();
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "TokenIssued{" +
            "id=" + getId() +
            ", uid=" + getUid() +
            ", profileBizId=" + getProfileBizId() +
            ", phoneNumber='" + getPhoneNumber() + "'" +
            ", phoneIsoCode='" + getPhoneIsoCode() + "'" +
            ", phoneCode='" + getPhoneCode() + "'" +
            ", userEmail='" + getUserEmail() + "'" +
            ", userFirstName='" + getUserFirstName() + "'" +
            ", userLastName='" + getUserLastName() + "'" +
            ", tokenLetter='" + getTokenLetter() + "'" +
            ", tokenNumber=" + getTokenNumber() +
            ", serviceName='" + getServiceName() + "'" +
            ", serviceId=" + getServiceId() +
            ", terminalName='" + getTerminalName() + "'" +
            ", terminalId=" + getTerminalId() +
            ", orgTerminalName='" + getOrgTerminalName() + "'" +
            ", orgTerminalId=" + getOrgTerminalId() +
            ", statusName='" + getStatusName() + "'" +
            ", statusCode=" + getStatusCode() +
            ", isPending='" + getIsPending() + "'" +
            ", isQueue='" + getIsQueue() + "'" +
            ", isReject='" + getIsReject() + "'" +
            ", isAbsent='" + getIsAbsent() + "'" +
            ", isCancel='" + getIsCancel() + "'" +
            ", isRecall='" + getIsRecall() + "'" +
            ", isCompleted='" + getIsCompleted() + "'" +
            ", isTimeout='" + getIsTimeout() + "'" +
            ", assignedDate=" + getAssignedDate() +
            ", assignedYear=" + getAssignedYear() +
            ", assignedMonth=" + getAssignedMonth() +
            ", assignedDay=" + getAssignedDay() +
            ", assignedHour=" + getAssignedHour() +
            ", assignedMin=" + getAssignedMin() +
            ", assignedTimeZoneOffset=" + getAssignedTimeZoneOffset() +
            ", assignedTimeZoneName='" + getAssignedTimeZoneName() + "'" +
            ", assignedNow='" + getAssignedNow() + "'" +
            ", assignedUid=" + getAssignedUid() +
            ", completedYear=" + getCompletedYear() +
            ", completedMonth=" + getCompletedMonth() +
            ", completedDay=" + getCompletedDay() +
            ", completedHour=" + getCompletedHour() +
            ", completedMin=" + getCompletedMin() +
            ", completedTimeZoneOffset=" + getCompletedTimeZoneOffset() +
            ", completedTimeZoneName='" + getCompletedTimeZoneName() + "'" +
            ", completedNow='" + getCompletedNow() + "'" +
            ", completedDate=" + getCompletedDate() +
            ", completedUid=" + getCompletedUid() +
            ", createdYear=" + getCreatedYear() +
            ", createdMonth=" + getCreatedMonth() +
            ", createdDay=" + getCreatedDay() +
            ", createdHour=" + getCreatedHour() +
            ", createdMin=" + getCreatedMin() +
            ", createdTimeZoneOffset=" + getCreatedTimeZoneOffset() +
            ", createdTimeZoneName='" + getCreatedTimeZoneName() + "'" +
            ", createdNow='" + getCreatedNow() + "'" +
            ", createdDate=" + getCreatedDate() +
            ", modifiedYear=" + getModifiedYear() +
            ", modifiedMonth=" + getModifiedMonth() +
            ", modifiedDay=" + getModifiedDay() +
            ", modifiedHour=" + getModifiedHour() +
            ", modifiedMin=" + getModifiedMin() +
            ", modifiedTimeZoneOffset=" + getModifiedTimeZoneOffset() +
            ", modifiedTimeZoneName='" + getModifiedTimeZoneName() + "'" +
            ", modifiedNow='" + getModifiedNow() + "'" +
            ", modifiedDate=" + getModifiedDate() +
            ", transferedYear=" + getTransferedYear() +
            ", transferedMonth=" + getTransferedMonth() +
            ", transferedDay=" + getTransferedDay() +
            ", transferedHour=" + getTransferedHour() +
            ", transferedMin=" + getTransferedMin() +
            ", transferedDate=" + getTransferedDate() +
            ", transferedTimeZoneOffset=" + getTransferedTimeZoneOffset() +
            ", transferedTimeZoneName='" + getTransferedTimeZoneName() + "'" +
            ", transferedNow='" + getTransferedNow() + "'" +
            ", transferedUid=" + getTransferedUid() +
            ", issuedFrom='" + getIssuedFrom() + "'" +
            ", departmentId=" + getDepartmentId() +
            ", departmentName='" + getDepartmentName() + "'" +
            ", bizName='" + getBizName() + "'" +
            ", rating=" + getRating() +
            ", feedback='" + getFeedback() + "'" +
            ", smsComingCount=" + getSmsComingCount() +
            ", pushComingCount=" + getPushComingCount() +
            ", orderId='" + getOrderId() + "'" +
            ", reset='" + getReset() + "'" +
            ", resetDate=" + getResetDate() +
            ", resetUid=" + getResetUid() +
            "}";
    }
}

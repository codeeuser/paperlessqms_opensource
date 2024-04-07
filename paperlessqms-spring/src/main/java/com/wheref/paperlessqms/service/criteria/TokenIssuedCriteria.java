package com.wheref.paperlessqms.service.criteria;

import java.io.Serializable;
import java.util.Objects;
import org.springdoc.core.annotations.ParameterObject;
import tech.jhipster.service.Criteria;
import tech.jhipster.service.filter.*;

/**
 * Criteria class for the {@link com.wheref.paperlessqms.domain.TokenIssued} entity. This class is used
 * in {@link com.wheref.paperlessqms.web.rest.TokenIssuedResource} to receive all the possible filtering options from
 * the Http GET request parameters.
 * For example the following could be a valid request:
 * {@code /token-issueds?id.greaterThan=5&attr1.contains=something&attr2.specified=false}
 * As Spring is unable to properly convert the types, unless specific {@link Filter} class are used, we need to use
 * fix type specific filters.
 */
@ParameterObject
@SuppressWarnings("common-java:DuplicatedBlocks")
public class TokenIssuedCriteria implements Serializable, Criteria {

    private static final long serialVersionUID = 1L;

    private LongFilter id;

    private LongFilter uid;

    private LongFilter profileBizId;

    private StringFilter phoneNumber;

    private StringFilter phoneIsoCode;

    private StringFilter phoneCode;

    private StringFilter userEmail;

    private StringFilter userFirstName;

    private StringFilter userLastName;

    private StringFilter tokenLetter;

    private IntegerFilter tokenNumber;

    private StringFilter serviceName;

    private LongFilter serviceId;

    private StringFilter terminalName;

    private LongFilter terminalId;

    private StringFilter orgTerminalName;

    private LongFilter orgTerminalId;

    private StringFilter statusName;

    private IntegerFilter statusCode;

    private BooleanFilter isPending;

    private BooleanFilter isQueue;

    private BooleanFilter isReject;

    private BooleanFilter isAbsent;

    private BooleanFilter isCancel;

    private BooleanFilter isRecall;

    private BooleanFilter isCompleted;

    private BooleanFilter isTimeout;

    private LongFilter assignedDate;

    private IntegerFilter assignedYear;

    private IntegerFilter assignedMonth;

    private IntegerFilter assignedDay;

    private IntegerFilter assignedHour;

    private IntegerFilter assignedMin;

    private IntegerFilter assignedTimeZoneOffset;

    private StringFilter assignedTimeZoneName;

    private StringFilter assignedNow;

    private LongFilter assignedUid;

    private IntegerFilter completedYear;

    private IntegerFilter completedMonth;

    private IntegerFilter completedDay;

    private IntegerFilter completedHour;

    private IntegerFilter completedMin;

    private IntegerFilter completedTimeZoneOffset;

    private StringFilter completedTimeZoneName;

    private StringFilter completedNow;

    private LongFilter completedDate;

    private LongFilter completedUid;

    private IntegerFilter createdYear;

    private IntegerFilter createdMonth;

    private IntegerFilter createdDay;

    private IntegerFilter createdHour;

    private IntegerFilter createdMin;

    private IntegerFilter createdTimeZoneOffset;

    private StringFilter createdTimeZoneName;

    private StringFilter createdNow;

    private LongFilter createdDate;

    private IntegerFilter modifiedYear;

    private IntegerFilter modifiedMonth;

    private IntegerFilter modifiedDay;

    private IntegerFilter modifiedHour;

    private IntegerFilter modifiedMin;

    private IntegerFilter modifiedTimeZoneOffset;

    private StringFilter modifiedTimeZoneName;

    private StringFilter modifiedNow;

    private LongFilter modifiedDate;

    private IntegerFilter transferedYear;

    private IntegerFilter transferedMonth;

    private IntegerFilter transferedDay;

    private IntegerFilter transferedHour;

    private IntegerFilter transferedMin;

    private LongFilter transferedDate;

    private IntegerFilter transferedTimeZoneOffset;

    private StringFilter transferedTimeZoneName;

    private StringFilter transferedNow;

    private LongFilter transferedUid;

    private StringFilter issuedFrom;

    private LongFilter departmentId;

    private StringFilter departmentName;

    private StringFilter bizName;

    private DoubleFilter rating;

    private StringFilter feedback;

    private IntegerFilter smsComingCount;

    private IntegerFilter pushComingCount;

    private StringFilter orderId;

    private BooleanFilter reset;

    private LongFilter resetDate;

    private LongFilter resetUid;

    private Boolean distinct;

    public TokenIssuedCriteria() {}

    public TokenIssuedCriteria(TokenIssuedCriteria other) {
        this.id = other.id == null ? null : other.id.copy();
        this.uid = other.uid == null ? null : other.uid.copy();
        this.profileBizId = other.profileBizId == null ? null : other.profileBizId.copy();
        this.phoneNumber = other.phoneNumber == null ? null : other.phoneNumber.copy();
        this.phoneIsoCode = other.phoneIsoCode == null ? null : other.phoneIsoCode.copy();
        this.phoneCode = other.phoneCode == null ? null : other.phoneCode.copy();
        this.userEmail = other.userEmail == null ? null : other.userEmail.copy();
        this.userFirstName = other.userFirstName == null ? null : other.userFirstName.copy();
        this.userLastName = other.userLastName == null ? null : other.userLastName.copy();
        this.tokenLetter = other.tokenLetter == null ? null : other.tokenLetter.copy();
        this.tokenNumber = other.tokenNumber == null ? null : other.tokenNumber.copy();
        this.serviceName = other.serviceName == null ? null : other.serviceName.copy();
        this.serviceId = other.serviceId == null ? null : other.serviceId.copy();
        this.terminalName = other.terminalName == null ? null : other.terminalName.copy();
        this.terminalId = other.terminalId == null ? null : other.terminalId.copy();
        this.orgTerminalName = other.orgTerminalName == null ? null : other.orgTerminalName.copy();
        this.orgTerminalId = other.orgTerminalId == null ? null : other.orgTerminalId.copy();
        this.statusName = other.statusName == null ? null : other.statusName.copy();
        this.statusCode = other.statusCode == null ? null : other.statusCode.copy();
        this.isPending = other.isPending == null ? null : other.isPending.copy();
        this.isQueue = other.isQueue == null ? null : other.isQueue.copy();
        this.isReject = other.isReject == null ? null : other.isReject.copy();
        this.isAbsent = other.isAbsent == null ? null : other.isAbsent.copy();
        this.isCancel = other.isCancel == null ? null : other.isCancel.copy();
        this.isRecall = other.isRecall == null ? null : other.isRecall.copy();
        this.isCompleted = other.isCompleted == null ? null : other.isCompleted.copy();
        this.isTimeout = other.isTimeout == null ? null : other.isTimeout.copy();
        this.assignedDate = other.assignedDate == null ? null : other.assignedDate.copy();
        this.assignedYear = other.assignedYear == null ? null : other.assignedYear.copy();
        this.assignedMonth = other.assignedMonth == null ? null : other.assignedMonth.copy();
        this.assignedDay = other.assignedDay == null ? null : other.assignedDay.copy();
        this.assignedHour = other.assignedHour == null ? null : other.assignedHour.copy();
        this.assignedMin = other.assignedMin == null ? null : other.assignedMin.copy();
        this.assignedTimeZoneOffset = other.assignedTimeZoneOffset == null ? null : other.assignedTimeZoneOffset.copy();
        this.assignedTimeZoneName = other.assignedTimeZoneName == null ? null : other.assignedTimeZoneName.copy();
        this.assignedNow = other.assignedNow == null ? null : other.assignedNow.copy();
        this.assignedUid = other.assignedUid == null ? null : other.assignedUid.copy();
        this.completedYear = other.completedYear == null ? null : other.completedYear.copy();
        this.completedMonth = other.completedMonth == null ? null : other.completedMonth.copy();
        this.completedDay = other.completedDay == null ? null : other.completedDay.copy();
        this.completedHour = other.completedHour == null ? null : other.completedHour.copy();
        this.completedMin = other.completedMin == null ? null : other.completedMin.copy();
        this.completedTimeZoneOffset = other.completedTimeZoneOffset == null ? null : other.completedTimeZoneOffset.copy();
        this.completedTimeZoneName = other.completedTimeZoneName == null ? null : other.completedTimeZoneName.copy();
        this.completedNow = other.completedNow == null ? null : other.completedNow.copy();
        this.completedDate = other.completedDate == null ? null : other.completedDate.copy();
        this.completedUid = other.completedUid == null ? null : other.completedUid.copy();
        this.createdYear = other.createdYear == null ? null : other.createdYear.copy();
        this.createdMonth = other.createdMonth == null ? null : other.createdMonth.copy();
        this.createdDay = other.createdDay == null ? null : other.createdDay.copy();
        this.createdHour = other.createdHour == null ? null : other.createdHour.copy();
        this.createdMin = other.createdMin == null ? null : other.createdMin.copy();
        this.createdTimeZoneOffset = other.createdTimeZoneOffset == null ? null : other.createdTimeZoneOffset.copy();
        this.createdTimeZoneName = other.createdTimeZoneName == null ? null : other.createdTimeZoneName.copy();
        this.createdNow = other.createdNow == null ? null : other.createdNow.copy();
        this.createdDate = other.createdDate == null ? null : other.createdDate.copy();
        this.modifiedYear = other.modifiedYear == null ? null : other.modifiedYear.copy();
        this.modifiedMonth = other.modifiedMonth == null ? null : other.modifiedMonth.copy();
        this.modifiedDay = other.modifiedDay == null ? null : other.modifiedDay.copy();
        this.modifiedHour = other.modifiedHour == null ? null : other.modifiedHour.copy();
        this.modifiedMin = other.modifiedMin == null ? null : other.modifiedMin.copy();
        this.modifiedTimeZoneOffset = other.modifiedTimeZoneOffset == null ? null : other.modifiedTimeZoneOffset.copy();
        this.modifiedTimeZoneName = other.modifiedTimeZoneName == null ? null : other.modifiedTimeZoneName.copy();
        this.modifiedNow = other.modifiedNow == null ? null : other.modifiedNow.copy();
        this.modifiedDate = other.modifiedDate == null ? null : other.modifiedDate.copy();
        this.transferedYear = other.transferedYear == null ? null : other.transferedYear.copy();
        this.transferedMonth = other.transferedMonth == null ? null : other.transferedMonth.copy();
        this.transferedDay = other.transferedDay == null ? null : other.transferedDay.copy();
        this.transferedHour = other.transferedHour == null ? null : other.transferedHour.copy();
        this.transferedMin = other.transferedMin == null ? null : other.transferedMin.copy();
        this.transferedDate = other.transferedDate == null ? null : other.transferedDate.copy();
        this.transferedTimeZoneOffset = other.transferedTimeZoneOffset == null ? null : other.transferedTimeZoneOffset.copy();
        this.transferedTimeZoneName = other.transferedTimeZoneName == null ? null : other.transferedTimeZoneName.copy();
        this.transferedNow = other.transferedNow == null ? null : other.transferedNow.copy();
        this.transferedUid = other.transferedUid == null ? null : other.transferedUid.copy();
        this.issuedFrom = other.issuedFrom == null ? null : other.issuedFrom.copy();
        this.departmentId = other.departmentId == null ? null : other.departmentId.copy();
        this.departmentName = other.departmentName == null ? null : other.departmentName.copy();
        this.bizName = other.bizName == null ? null : other.bizName.copy();
        this.rating = other.rating == null ? null : other.rating.copy();
        this.feedback = other.feedback == null ? null : other.feedback.copy();
        this.smsComingCount = other.smsComingCount == null ? null : other.smsComingCount.copy();
        this.pushComingCount = other.pushComingCount == null ? null : other.pushComingCount.copy();
        this.orderId = other.orderId == null ? null : other.orderId.copy();
        this.reset = other.reset == null ? null : other.reset.copy();
        this.resetDate = other.resetDate == null ? null : other.resetDate.copy();
        this.resetUid = other.resetUid == null ? null : other.resetUid.copy();
        this.distinct = other.distinct;
    }

    @Override
    public TokenIssuedCriteria copy() {
        return new TokenIssuedCriteria(this);
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

    public LongFilter getUid() {
        return uid;
    }

    public LongFilter uid() {
        if (uid == null) {
            uid = new LongFilter();
        }
        return uid;
    }

    public void setUid(LongFilter uid) {
        this.uid = uid;
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

    public StringFilter getPhoneNumber() {
        return phoneNumber;
    }

    public StringFilter phoneNumber() {
        if (phoneNumber == null) {
            phoneNumber = new StringFilter();
        }
        return phoneNumber;
    }

    public void setPhoneNumber(StringFilter phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public StringFilter getPhoneIsoCode() {
        return phoneIsoCode;
    }

    public StringFilter phoneIsoCode() {
        if (phoneIsoCode == null) {
            phoneIsoCode = new StringFilter();
        }
        return phoneIsoCode;
    }

    public void setPhoneIsoCode(StringFilter phoneIsoCode) {
        this.phoneIsoCode = phoneIsoCode;
    }

    public StringFilter getPhoneCode() {
        return phoneCode;
    }

    public StringFilter phoneCode() {
        if (phoneCode == null) {
            phoneCode = new StringFilter();
        }
        return phoneCode;
    }

    public void setPhoneCode(StringFilter phoneCode) {
        this.phoneCode = phoneCode;
    }

    public StringFilter getUserEmail() {
        return userEmail;
    }

    public StringFilter userEmail() {
        if (userEmail == null) {
            userEmail = new StringFilter();
        }
        return userEmail;
    }

    public void setUserEmail(StringFilter userEmail) {
        this.userEmail = userEmail;
    }

    public StringFilter getUserFirstName() {
        return userFirstName;
    }

    public StringFilter userFirstName() {
        if (userFirstName == null) {
            userFirstName = new StringFilter();
        }
        return userFirstName;
    }

    public void setUserFirstName(StringFilter userFirstName) {
        this.userFirstName = userFirstName;
    }

    public StringFilter getUserLastName() {
        return userLastName;
    }

    public StringFilter userLastName() {
        if (userLastName == null) {
            userLastName = new StringFilter();
        }
        return userLastName;
    }

    public void setUserLastName(StringFilter userLastName) {
        this.userLastName = userLastName;
    }

    public StringFilter getTokenLetter() {
        return tokenLetter;
    }

    public StringFilter tokenLetter() {
        if (tokenLetter == null) {
            tokenLetter = new StringFilter();
        }
        return tokenLetter;
    }

    public void setTokenLetter(StringFilter tokenLetter) {
        this.tokenLetter = tokenLetter;
    }

    public IntegerFilter getTokenNumber() {
        return tokenNumber;
    }

    public IntegerFilter tokenNumber() {
        if (tokenNumber == null) {
            tokenNumber = new IntegerFilter();
        }
        return tokenNumber;
    }

    public void setTokenNumber(IntegerFilter tokenNumber) {
        this.tokenNumber = tokenNumber;
    }

    public StringFilter getServiceName() {
        return serviceName;
    }

    public StringFilter serviceName() {
        if (serviceName == null) {
            serviceName = new StringFilter();
        }
        return serviceName;
    }

    public void setServiceName(StringFilter serviceName) {
        this.serviceName = serviceName;
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

    public StringFilter getTerminalName() {
        return terminalName;
    }

    public StringFilter terminalName() {
        if (terminalName == null) {
            terminalName = new StringFilter();
        }
        return terminalName;
    }

    public void setTerminalName(StringFilter terminalName) {
        this.terminalName = terminalName;
    }

    public LongFilter getTerminalId() {
        return terminalId;
    }

    public LongFilter terminalId() {
        if (terminalId == null) {
            terminalId = new LongFilter();
        }
        return terminalId;
    }

    public void setTerminalId(LongFilter terminalId) {
        this.terminalId = terminalId;
    }

    public StringFilter getOrgTerminalName() {
        return orgTerminalName;
    }

    public StringFilter orgTerminalName() {
        if (orgTerminalName == null) {
            orgTerminalName = new StringFilter();
        }
        return orgTerminalName;
    }

    public void setOrgTerminalName(StringFilter orgTerminalName) {
        this.orgTerminalName = orgTerminalName;
    }

    public LongFilter getOrgTerminalId() {
        return orgTerminalId;
    }

    public LongFilter orgTerminalId() {
        if (orgTerminalId == null) {
            orgTerminalId = new LongFilter();
        }
        return orgTerminalId;
    }

    public void setOrgTerminalId(LongFilter orgTerminalId) {
        this.orgTerminalId = orgTerminalId;
    }

    public StringFilter getStatusName() {
        return statusName;
    }

    public StringFilter statusName() {
        if (statusName == null) {
            statusName = new StringFilter();
        }
        return statusName;
    }

    public void setStatusName(StringFilter statusName) {
        this.statusName = statusName;
    }

    public IntegerFilter getStatusCode() {
        return statusCode;
    }

    public IntegerFilter statusCode() {
        if (statusCode == null) {
            statusCode = new IntegerFilter();
        }
        return statusCode;
    }

    public void setStatusCode(IntegerFilter statusCode) {
        this.statusCode = statusCode;
    }

    public BooleanFilter getIsPending() {
        return isPending;
    }

    public BooleanFilter isPending() {
        if (isPending == null) {
            isPending = new BooleanFilter();
        }
        return isPending;
    }

    public void setIsPending(BooleanFilter isPending) {
        this.isPending = isPending;
    }

    public BooleanFilter getIsQueue() {
        return isQueue;
    }

    public BooleanFilter isQueue() {
        if (isQueue == null) {
            isQueue = new BooleanFilter();
        }
        return isQueue;
    }

    public void setIsQueue(BooleanFilter isQueue) {
        this.isQueue = isQueue;
    }

    public BooleanFilter getIsReject() {
        return isReject;
    }

    public BooleanFilter isReject() {
        if (isReject == null) {
            isReject = new BooleanFilter();
        }
        return isReject;
    }

    public void setIsReject(BooleanFilter isReject) {
        this.isReject = isReject;
    }

    public BooleanFilter getIsAbsent() {
        return isAbsent;
    }

    public BooleanFilter isAbsent() {
        if (isAbsent == null) {
            isAbsent = new BooleanFilter();
        }
        return isAbsent;
    }

    public void setIsAbsent(BooleanFilter isAbsent) {
        this.isAbsent = isAbsent;
    }

    public BooleanFilter getIsCancel() {
        return isCancel;
    }

    public BooleanFilter isCancel() {
        if (isCancel == null) {
            isCancel = new BooleanFilter();
        }
        return isCancel;
    }

    public void setIsCancel(BooleanFilter isCancel) {
        this.isCancel = isCancel;
    }

    public BooleanFilter getIsRecall() {
        return isRecall;
    }

    public BooleanFilter isRecall() {
        if (isRecall == null) {
            isRecall = new BooleanFilter();
        }
        return isRecall;
    }

    public void setIsRecall(BooleanFilter isRecall) {
        this.isRecall = isRecall;
    }

    public BooleanFilter getIsCompleted() {
        return isCompleted;
    }

    public BooleanFilter isCompleted() {
        if (isCompleted == null) {
            isCompleted = new BooleanFilter();
        }
        return isCompleted;
    }

    public void setIsCompleted(BooleanFilter isCompleted) {
        this.isCompleted = isCompleted;
    }

    public BooleanFilter getIsTimeout() {
        return isTimeout;
    }

    public BooleanFilter isTimeout() {
        if (isTimeout == null) {
            isTimeout = new BooleanFilter();
        }
        return isTimeout;
    }

    public void setIsTimeout(BooleanFilter isTimeout) {
        this.isTimeout = isTimeout;
    }

    public LongFilter getAssignedDate() {
        return assignedDate;
    }

    public LongFilter assignedDate() {
        if (assignedDate == null) {
            assignedDate = new LongFilter();
        }
        return assignedDate;
    }

    public void setAssignedDate(LongFilter assignedDate) {
        this.assignedDate = assignedDate;
    }

    public IntegerFilter getAssignedYear() {
        return assignedYear;
    }

    public IntegerFilter assignedYear() {
        if (assignedYear == null) {
            assignedYear = new IntegerFilter();
        }
        return assignedYear;
    }

    public void setAssignedYear(IntegerFilter assignedYear) {
        this.assignedYear = assignedYear;
    }

    public IntegerFilter getAssignedMonth() {
        return assignedMonth;
    }

    public IntegerFilter assignedMonth() {
        if (assignedMonth == null) {
            assignedMonth = new IntegerFilter();
        }
        return assignedMonth;
    }

    public void setAssignedMonth(IntegerFilter assignedMonth) {
        this.assignedMonth = assignedMonth;
    }

    public IntegerFilter getAssignedDay() {
        return assignedDay;
    }

    public IntegerFilter assignedDay() {
        if (assignedDay == null) {
            assignedDay = new IntegerFilter();
        }
        return assignedDay;
    }

    public void setAssignedDay(IntegerFilter assignedDay) {
        this.assignedDay = assignedDay;
    }

    public IntegerFilter getAssignedHour() {
        return assignedHour;
    }

    public IntegerFilter assignedHour() {
        if (assignedHour == null) {
            assignedHour = new IntegerFilter();
        }
        return assignedHour;
    }

    public void setAssignedHour(IntegerFilter assignedHour) {
        this.assignedHour = assignedHour;
    }

    public IntegerFilter getAssignedMin() {
        return assignedMin;
    }

    public IntegerFilter assignedMin() {
        if (assignedMin == null) {
            assignedMin = new IntegerFilter();
        }
        return assignedMin;
    }

    public void setAssignedMin(IntegerFilter assignedMin) {
        this.assignedMin = assignedMin;
    }

    public IntegerFilter getAssignedTimeZoneOffset() {
        return assignedTimeZoneOffset;
    }

    public IntegerFilter assignedTimeZoneOffset() {
        if (assignedTimeZoneOffset == null) {
            assignedTimeZoneOffset = new IntegerFilter();
        }
        return assignedTimeZoneOffset;
    }

    public void setAssignedTimeZoneOffset(IntegerFilter assignedTimeZoneOffset) {
        this.assignedTimeZoneOffset = assignedTimeZoneOffset;
    }

    public StringFilter getAssignedTimeZoneName() {
        return assignedTimeZoneName;
    }

    public StringFilter assignedTimeZoneName() {
        if (assignedTimeZoneName == null) {
            assignedTimeZoneName = new StringFilter();
        }
        return assignedTimeZoneName;
    }

    public void setAssignedTimeZoneName(StringFilter assignedTimeZoneName) {
        this.assignedTimeZoneName = assignedTimeZoneName;
    }

    public StringFilter getAssignedNow() {
        return assignedNow;
    }

    public StringFilter assignedNow() {
        if (assignedNow == null) {
            assignedNow = new StringFilter();
        }
        return assignedNow;
    }

    public void setAssignedNow(StringFilter assignedNow) {
        this.assignedNow = assignedNow;
    }

    public LongFilter getAssignedUid() {
        return assignedUid;
    }

    public LongFilter assignedUid() {
        if (assignedUid == null) {
            assignedUid = new LongFilter();
        }
        return assignedUid;
    }

    public void setAssignedUid(LongFilter assignedUid) {
        this.assignedUid = assignedUid;
    }

    public IntegerFilter getCompletedYear() {
        return completedYear;
    }

    public IntegerFilter completedYear() {
        if (completedYear == null) {
            completedYear = new IntegerFilter();
        }
        return completedYear;
    }

    public void setCompletedYear(IntegerFilter completedYear) {
        this.completedYear = completedYear;
    }

    public IntegerFilter getCompletedMonth() {
        return completedMonth;
    }

    public IntegerFilter completedMonth() {
        if (completedMonth == null) {
            completedMonth = new IntegerFilter();
        }
        return completedMonth;
    }

    public void setCompletedMonth(IntegerFilter completedMonth) {
        this.completedMonth = completedMonth;
    }

    public IntegerFilter getCompletedDay() {
        return completedDay;
    }

    public IntegerFilter completedDay() {
        if (completedDay == null) {
            completedDay = new IntegerFilter();
        }
        return completedDay;
    }

    public void setCompletedDay(IntegerFilter completedDay) {
        this.completedDay = completedDay;
    }

    public IntegerFilter getCompletedHour() {
        return completedHour;
    }

    public IntegerFilter completedHour() {
        if (completedHour == null) {
            completedHour = new IntegerFilter();
        }
        return completedHour;
    }

    public void setCompletedHour(IntegerFilter completedHour) {
        this.completedHour = completedHour;
    }

    public IntegerFilter getCompletedMin() {
        return completedMin;
    }

    public IntegerFilter completedMin() {
        if (completedMin == null) {
            completedMin = new IntegerFilter();
        }
        return completedMin;
    }

    public void setCompletedMin(IntegerFilter completedMin) {
        this.completedMin = completedMin;
    }

    public IntegerFilter getCompletedTimeZoneOffset() {
        return completedTimeZoneOffset;
    }

    public IntegerFilter completedTimeZoneOffset() {
        if (completedTimeZoneOffset == null) {
            completedTimeZoneOffset = new IntegerFilter();
        }
        return completedTimeZoneOffset;
    }

    public void setCompletedTimeZoneOffset(IntegerFilter completedTimeZoneOffset) {
        this.completedTimeZoneOffset = completedTimeZoneOffset;
    }

    public StringFilter getCompletedTimeZoneName() {
        return completedTimeZoneName;
    }

    public StringFilter completedTimeZoneName() {
        if (completedTimeZoneName == null) {
            completedTimeZoneName = new StringFilter();
        }
        return completedTimeZoneName;
    }

    public void setCompletedTimeZoneName(StringFilter completedTimeZoneName) {
        this.completedTimeZoneName = completedTimeZoneName;
    }

    public StringFilter getCompletedNow() {
        return completedNow;
    }

    public StringFilter completedNow() {
        if (completedNow == null) {
            completedNow = new StringFilter();
        }
        return completedNow;
    }

    public void setCompletedNow(StringFilter completedNow) {
        this.completedNow = completedNow;
    }

    public LongFilter getCompletedDate() {
        return completedDate;
    }

    public LongFilter completedDate() {
        if (completedDate == null) {
            completedDate = new LongFilter();
        }
        return completedDate;
    }

    public void setCompletedDate(LongFilter completedDate) {
        this.completedDate = completedDate;
    }

    public LongFilter getCompletedUid() {
        return completedUid;
    }

    public LongFilter completedUid() {
        if (completedUid == null) {
            completedUid = new LongFilter();
        }
        return completedUid;
    }

    public void setCompletedUid(LongFilter completedUid) {
        this.completedUid = completedUid;
    }

    public IntegerFilter getCreatedYear() {
        return createdYear;
    }

    public IntegerFilter createdYear() {
        if (createdYear == null) {
            createdYear = new IntegerFilter();
        }
        return createdYear;
    }

    public void setCreatedYear(IntegerFilter createdYear) {
        this.createdYear = createdYear;
    }

    public IntegerFilter getCreatedMonth() {
        return createdMonth;
    }

    public IntegerFilter createdMonth() {
        if (createdMonth == null) {
            createdMonth = new IntegerFilter();
        }
        return createdMonth;
    }

    public void setCreatedMonth(IntegerFilter createdMonth) {
        this.createdMonth = createdMonth;
    }

    public IntegerFilter getCreatedDay() {
        return createdDay;
    }

    public IntegerFilter createdDay() {
        if (createdDay == null) {
            createdDay = new IntegerFilter();
        }
        return createdDay;
    }

    public void setCreatedDay(IntegerFilter createdDay) {
        this.createdDay = createdDay;
    }

    public IntegerFilter getCreatedHour() {
        return createdHour;
    }

    public IntegerFilter createdHour() {
        if (createdHour == null) {
            createdHour = new IntegerFilter();
        }
        return createdHour;
    }

    public void setCreatedHour(IntegerFilter createdHour) {
        this.createdHour = createdHour;
    }

    public IntegerFilter getCreatedMin() {
        return createdMin;
    }

    public IntegerFilter createdMin() {
        if (createdMin == null) {
            createdMin = new IntegerFilter();
        }
        return createdMin;
    }

    public void setCreatedMin(IntegerFilter createdMin) {
        this.createdMin = createdMin;
    }

    public IntegerFilter getCreatedTimeZoneOffset() {
        return createdTimeZoneOffset;
    }

    public IntegerFilter createdTimeZoneOffset() {
        if (createdTimeZoneOffset == null) {
            createdTimeZoneOffset = new IntegerFilter();
        }
        return createdTimeZoneOffset;
    }

    public void setCreatedTimeZoneOffset(IntegerFilter createdTimeZoneOffset) {
        this.createdTimeZoneOffset = createdTimeZoneOffset;
    }

    public StringFilter getCreatedTimeZoneName() {
        return createdTimeZoneName;
    }

    public StringFilter createdTimeZoneName() {
        if (createdTimeZoneName == null) {
            createdTimeZoneName = new StringFilter();
        }
        return createdTimeZoneName;
    }

    public void setCreatedTimeZoneName(StringFilter createdTimeZoneName) {
        this.createdTimeZoneName = createdTimeZoneName;
    }

    public StringFilter getCreatedNow() {
        return createdNow;
    }

    public StringFilter createdNow() {
        if (createdNow == null) {
            createdNow = new StringFilter();
        }
        return createdNow;
    }

    public void setCreatedNow(StringFilter createdNow) {
        this.createdNow = createdNow;
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

    public IntegerFilter getModifiedYear() {
        return modifiedYear;
    }

    public IntegerFilter modifiedYear() {
        if (modifiedYear == null) {
            modifiedYear = new IntegerFilter();
        }
        return modifiedYear;
    }

    public void setModifiedYear(IntegerFilter modifiedYear) {
        this.modifiedYear = modifiedYear;
    }

    public IntegerFilter getModifiedMonth() {
        return modifiedMonth;
    }

    public IntegerFilter modifiedMonth() {
        if (modifiedMonth == null) {
            modifiedMonth = new IntegerFilter();
        }
        return modifiedMonth;
    }

    public void setModifiedMonth(IntegerFilter modifiedMonth) {
        this.modifiedMonth = modifiedMonth;
    }

    public IntegerFilter getModifiedDay() {
        return modifiedDay;
    }

    public IntegerFilter modifiedDay() {
        if (modifiedDay == null) {
            modifiedDay = new IntegerFilter();
        }
        return modifiedDay;
    }

    public void setModifiedDay(IntegerFilter modifiedDay) {
        this.modifiedDay = modifiedDay;
    }

    public IntegerFilter getModifiedHour() {
        return modifiedHour;
    }

    public IntegerFilter modifiedHour() {
        if (modifiedHour == null) {
            modifiedHour = new IntegerFilter();
        }
        return modifiedHour;
    }

    public void setModifiedHour(IntegerFilter modifiedHour) {
        this.modifiedHour = modifiedHour;
    }

    public IntegerFilter getModifiedMin() {
        return modifiedMin;
    }

    public IntegerFilter modifiedMin() {
        if (modifiedMin == null) {
            modifiedMin = new IntegerFilter();
        }
        return modifiedMin;
    }

    public void setModifiedMin(IntegerFilter modifiedMin) {
        this.modifiedMin = modifiedMin;
    }

    public IntegerFilter getModifiedTimeZoneOffset() {
        return modifiedTimeZoneOffset;
    }

    public IntegerFilter modifiedTimeZoneOffset() {
        if (modifiedTimeZoneOffset == null) {
            modifiedTimeZoneOffset = new IntegerFilter();
        }
        return modifiedTimeZoneOffset;
    }

    public void setModifiedTimeZoneOffset(IntegerFilter modifiedTimeZoneOffset) {
        this.modifiedTimeZoneOffset = modifiedTimeZoneOffset;
    }

    public StringFilter getModifiedTimeZoneName() {
        return modifiedTimeZoneName;
    }

    public StringFilter modifiedTimeZoneName() {
        if (modifiedTimeZoneName == null) {
            modifiedTimeZoneName = new StringFilter();
        }
        return modifiedTimeZoneName;
    }

    public void setModifiedTimeZoneName(StringFilter modifiedTimeZoneName) {
        this.modifiedTimeZoneName = modifiedTimeZoneName;
    }

    public StringFilter getModifiedNow() {
        return modifiedNow;
    }

    public StringFilter modifiedNow() {
        if (modifiedNow == null) {
            modifiedNow = new StringFilter();
        }
        return modifiedNow;
    }

    public void setModifiedNow(StringFilter modifiedNow) {
        this.modifiedNow = modifiedNow;
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

    public IntegerFilter getTransferedYear() {
        return transferedYear;
    }

    public IntegerFilter transferedYear() {
        if (transferedYear == null) {
            transferedYear = new IntegerFilter();
        }
        return transferedYear;
    }

    public void setTransferedYear(IntegerFilter transferedYear) {
        this.transferedYear = transferedYear;
    }

    public IntegerFilter getTransferedMonth() {
        return transferedMonth;
    }

    public IntegerFilter transferedMonth() {
        if (transferedMonth == null) {
            transferedMonth = new IntegerFilter();
        }
        return transferedMonth;
    }

    public void setTransferedMonth(IntegerFilter transferedMonth) {
        this.transferedMonth = transferedMonth;
    }

    public IntegerFilter getTransferedDay() {
        return transferedDay;
    }

    public IntegerFilter transferedDay() {
        if (transferedDay == null) {
            transferedDay = new IntegerFilter();
        }
        return transferedDay;
    }

    public void setTransferedDay(IntegerFilter transferedDay) {
        this.transferedDay = transferedDay;
    }

    public IntegerFilter getTransferedHour() {
        return transferedHour;
    }

    public IntegerFilter transferedHour() {
        if (transferedHour == null) {
            transferedHour = new IntegerFilter();
        }
        return transferedHour;
    }

    public void setTransferedHour(IntegerFilter transferedHour) {
        this.transferedHour = transferedHour;
    }

    public IntegerFilter getTransferedMin() {
        return transferedMin;
    }

    public IntegerFilter transferedMin() {
        if (transferedMin == null) {
            transferedMin = new IntegerFilter();
        }
        return transferedMin;
    }

    public void setTransferedMin(IntegerFilter transferedMin) {
        this.transferedMin = transferedMin;
    }

    public LongFilter getTransferedDate() {
        return transferedDate;
    }

    public LongFilter transferedDate() {
        if (transferedDate == null) {
            transferedDate = new LongFilter();
        }
        return transferedDate;
    }

    public void setTransferedDate(LongFilter transferedDate) {
        this.transferedDate = transferedDate;
    }

    public IntegerFilter getTransferedTimeZoneOffset() {
        return transferedTimeZoneOffset;
    }

    public IntegerFilter transferedTimeZoneOffset() {
        if (transferedTimeZoneOffset == null) {
            transferedTimeZoneOffset = new IntegerFilter();
        }
        return transferedTimeZoneOffset;
    }

    public void setTransferedTimeZoneOffset(IntegerFilter transferedTimeZoneOffset) {
        this.transferedTimeZoneOffset = transferedTimeZoneOffset;
    }

    public StringFilter getTransferedTimeZoneName() {
        return transferedTimeZoneName;
    }

    public StringFilter transferedTimeZoneName() {
        if (transferedTimeZoneName == null) {
            transferedTimeZoneName = new StringFilter();
        }
        return transferedTimeZoneName;
    }

    public void setTransferedTimeZoneName(StringFilter transferedTimeZoneName) {
        this.transferedTimeZoneName = transferedTimeZoneName;
    }

    public StringFilter getTransferedNow() {
        return transferedNow;
    }

    public StringFilter transferedNow() {
        if (transferedNow == null) {
            transferedNow = new StringFilter();
        }
        return transferedNow;
    }

    public void setTransferedNow(StringFilter transferedNow) {
        this.transferedNow = transferedNow;
    }

    public LongFilter getTransferedUid() {
        return transferedUid;
    }

    public LongFilter transferedUid() {
        if (transferedUid == null) {
            transferedUid = new LongFilter();
        }
        return transferedUid;
    }

    public void setTransferedUid(LongFilter transferedUid) {
        this.transferedUid = transferedUid;
    }

    public StringFilter getIssuedFrom() {
        return issuedFrom;
    }

    public StringFilter issuedFrom() {
        if (issuedFrom == null) {
            issuedFrom = new StringFilter();
        }
        return issuedFrom;
    }

    public void setIssuedFrom(StringFilter issuedFrom) {
        this.issuedFrom = issuedFrom;
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

    public StringFilter getDepartmentName() {
        return departmentName;
    }

    public StringFilter departmentName() {
        if (departmentName == null) {
            departmentName = new StringFilter();
        }
        return departmentName;
    }

    public void setDepartmentName(StringFilter departmentName) {
        this.departmentName = departmentName;
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

    public DoubleFilter getRating() {
        return rating;
    }

    public DoubleFilter rating() {
        if (rating == null) {
            rating = new DoubleFilter();
        }
        return rating;
    }

    public void setRating(DoubleFilter rating) {
        this.rating = rating;
    }

    public StringFilter getFeedback() {
        return feedback;
    }

    public StringFilter feedback() {
        if (feedback == null) {
            feedback = new StringFilter();
        }
        return feedback;
    }

    public void setFeedback(StringFilter feedback) {
        this.feedback = feedback;
    }

    public IntegerFilter getSmsComingCount() {
        return smsComingCount;
    }

    public IntegerFilter smsComingCount() {
        if (smsComingCount == null) {
            smsComingCount = new IntegerFilter();
        }
        return smsComingCount;
    }

    public void setSmsComingCount(IntegerFilter smsComingCount) {
        this.smsComingCount = smsComingCount;
    }

    public IntegerFilter getPushComingCount() {
        return pushComingCount;
    }

    public IntegerFilter pushComingCount() {
        if (pushComingCount == null) {
            pushComingCount = new IntegerFilter();
        }
        return pushComingCount;
    }

    public void setPushComingCount(IntegerFilter pushComingCount) {
        this.pushComingCount = pushComingCount;
    }

    public StringFilter getOrderId() {
        return orderId;
    }

    public StringFilter orderId() {
        if (orderId == null) {
            orderId = new StringFilter();
        }
        return orderId;
    }

    public void setOrderId(StringFilter orderId) {
        this.orderId = orderId;
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

    public LongFilter getResetDate() {
        return resetDate;
    }

    public LongFilter resetDate() {
        if (resetDate == null) {
            resetDate = new LongFilter();
        }
        return resetDate;
    }

    public void setResetDate(LongFilter resetDate) {
        this.resetDate = resetDate;
    }

    public LongFilter getResetUid() {
        return resetUid;
    }

    public LongFilter resetUid() {
        if (resetUid == null) {
            resetUid = new LongFilter();
        }
        return resetUid;
    }

    public void setResetUid(LongFilter resetUid) {
        this.resetUid = resetUid;
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
        final TokenIssuedCriteria that = (TokenIssuedCriteria) o;
        return (
            Objects.equals(id, that.id) &&
            Objects.equals(uid, that.uid) &&
            Objects.equals(profileBizId, that.profileBizId) &&
            Objects.equals(phoneNumber, that.phoneNumber) &&
            Objects.equals(phoneIsoCode, that.phoneIsoCode) &&
            Objects.equals(phoneCode, that.phoneCode) &&
            Objects.equals(userEmail, that.userEmail) &&
            Objects.equals(userFirstName, that.userFirstName) &&
            Objects.equals(userLastName, that.userLastName) &&
            Objects.equals(tokenLetter, that.tokenLetter) &&
            Objects.equals(tokenNumber, that.tokenNumber) &&
            Objects.equals(serviceName, that.serviceName) &&
            Objects.equals(serviceId, that.serviceId) &&
            Objects.equals(terminalName, that.terminalName) &&
            Objects.equals(terminalId, that.terminalId) &&
            Objects.equals(orgTerminalName, that.orgTerminalName) &&
            Objects.equals(orgTerminalId, that.orgTerminalId) &&
            Objects.equals(statusName, that.statusName) &&
            Objects.equals(statusCode, that.statusCode) &&
            Objects.equals(isPending, that.isPending) &&
            Objects.equals(isQueue, that.isQueue) &&
            Objects.equals(isReject, that.isReject) &&
            Objects.equals(isAbsent, that.isAbsent) &&
            Objects.equals(isCancel, that.isCancel) &&
            Objects.equals(isRecall, that.isRecall) &&
            Objects.equals(isCompleted, that.isCompleted) &&
            Objects.equals(isTimeout, that.isTimeout) &&
            Objects.equals(assignedDate, that.assignedDate) &&
            Objects.equals(assignedYear, that.assignedYear) &&
            Objects.equals(assignedMonth, that.assignedMonth) &&
            Objects.equals(assignedDay, that.assignedDay) &&
            Objects.equals(assignedHour, that.assignedHour) &&
            Objects.equals(assignedMin, that.assignedMin) &&
            Objects.equals(assignedTimeZoneOffset, that.assignedTimeZoneOffset) &&
            Objects.equals(assignedTimeZoneName, that.assignedTimeZoneName) &&
            Objects.equals(assignedNow, that.assignedNow) &&
            Objects.equals(assignedUid, that.assignedUid) &&
            Objects.equals(completedYear, that.completedYear) &&
            Objects.equals(completedMonth, that.completedMonth) &&
            Objects.equals(completedDay, that.completedDay) &&
            Objects.equals(completedHour, that.completedHour) &&
            Objects.equals(completedMin, that.completedMin) &&
            Objects.equals(completedTimeZoneOffset, that.completedTimeZoneOffset) &&
            Objects.equals(completedTimeZoneName, that.completedTimeZoneName) &&
            Objects.equals(completedNow, that.completedNow) &&
            Objects.equals(completedDate, that.completedDate) &&
            Objects.equals(completedUid, that.completedUid) &&
            Objects.equals(createdYear, that.createdYear) &&
            Objects.equals(createdMonth, that.createdMonth) &&
            Objects.equals(createdDay, that.createdDay) &&
            Objects.equals(createdHour, that.createdHour) &&
            Objects.equals(createdMin, that.createdMin) &&
            Objects.equals(createdTimeZoneOffset, that.createdTimeZoneOffset) &&
            Objects.equals(createdTimeZoneName, that.createdTimeZoneName) &&
            Objects.equals(createdNow, that.createdNow) &&
            Objects.equals(createdDate, that.createdDate) &&
            Objects.equals(modifiedYear, that.modifiedYear) &&
            Objects.equals(modifiedMonth, that.modifiedMonth) &&
            Objects.equals(modifiedDay, that.modifiedDay) &&
            Objects.equals(modifiedHour, that.modifiedHour) &&
            Objects.equals(modifiedMin, that.modifiedMin) &&
            Objects.equals(modifiedTimeZoneOffset, that.modifiedTimeZoneOffset) &&
            Objects.equals(modifiedTimeZoneName, that.modifiedTimeZoneName) &&
            Objects.equals(modifiedNow, that.modifiedNow) &&
            Objects.equals(modifiedDate, that.modifiedDate) &&
            Objects.equals(transferedYear, that.transferedYear) &&
            Objects.equals(transferedMonth, that.transferedMonth) &&
            Objects.equals(transferedDay, that.transferedDay) &&
            Objects.equals(transferedHour, that.transferedHour) &&
            Objects.equals(transferedMin, that.transferedMin) &&
            Objects.equals(transferedDate, that.transferedDate) &&
            Objects.equals(transferedTimeZoneOffset, that.transferedTimeZoneOffset) &&
            Objects.equals(transferedTimeZoneName, that.transferedTimeZoneName) &&
            Objects.equals(transferedNow, that.transferedNow) &&
            Objects.equals(transferedUid, that.transferedUid) &&
            Objects.equals(issuedFrom, that.issuedFrom) &&
            Objects.equals(departmentId, that.departmentId) &&
            Objects.equals(departmentName, that.departmentName) &&
            Objects.equals(bizName, that.bizName) &&
            Objects.equals(rating, that.rating) &&
            Objects.equals(feedback, that.feedback) &&
            Objects.equals(smsComingCount, that.smsComingCount) &&
            Objects.equals(pushComingCount, that.pushComingCount) &&
            Objects.equals(orderId, that.orderId) &&
            Objects.equals(reset, that.reset) &&
            Objects.equals(resetDate, that.resetDate) &&
            Objects.equals(resetUid, that.resetUid) &&
            Objects.equals(distinct, that.distinct)
        );
    }

    @Override
    public int hashCode() {
        return Objects.hash(
            id,
            uid,
            profileBizId,
            phoneNumber,
            phoneIsoCode,
            phoneCode,
            userEmail,
            userFirstName,
            userLastName,
            tokenLetter,
            tokenNumber,
            serviceName,
            serviceId,
            terminalName,
            terminalId,
            orgTerminalName,
            orgTerminalId,
            statusName,
            statusCode,
            isPending,
            isQueue,
            isReject,
            isAbsent,
            isCancel,
            isRecall,
            isCompleted,
            isTimeout,
            assignedDate,
            assignedYear,
            assignedMonth,
            assignedDay,
            assignedHour,
            assignedMin,
            assignedTimeZoneOffset,
            assignedTimeZoneName,
            assignedNow,
            assignedUid,
            completedYear,
            completedMonth,
            completedDay,
            completedHour,
            completedMin,
            completedTimeZoneOffset,
            completedTimeZoneName,
            completedNow,
            completedDate,
            completedUid,
            createdYear,
            createdMonth,
            createdDay,
            createdHour,
            createdMin,
            createdTimeZoneOffset,
            createdTimeZoneName,
            createdNow,
            createdDate,
            modifiedYear,
            modifiedMonth,
            modifiedDay,
            modifiedHour,
            modifiedMin,
            modifiedTimeZoneOffset,
            modifiedTimeZoneName,
            modifiedNow,
            modifiedDate,
            transferedYear,
            transferedMonth,
            transferedDay,
            transferedHour,
            transferedMin,
            transferedDate,
            transferedTimeZoneOffset,
            transferedTimeZoneName,
            transferedNow,
            transferedUid,
            issuedFrom,
            departmentId,
            departmentName,
            bizName,
            rating,
            feedback,
            smsComingCount,
            pushComingCount,
            orderId,
            reset,
            resetDate,
            resetUid,
            distinct
        );
    }

    // prettier-ignore
    @Override
    public String toString() {
        return "TokenIssuedCriteria{" +
            (id != null ? "id=" + id + ", " : "") +
            (uid != null ? "uid=" + uid + ", " : "") +
            (profileBizId != null ? "profileBizId=" + profileBizId + ", " : "") +
            (phoneNumber != null ? "phoneNumber=" + phoneNumber + ", " : "") +
            (phoneIsoCode != null ? "phoneIsoCode=" + phoneIsoCode + ", " : "") +
            (phoneCode != null ? "phoneCode=" + phoneCode + ", " : "") +
            (userEmail != null ? "userEmail=" + userEmail + ", " : "") +
            (userFirstName != null ? "userFirstName=" + userFirstName + ", " : "") +
            (userLastName != null ? "userLastName=" + userLastName + ", " : "") +
            (tokenLetter != null ? "tokenLetter=" + tokenLetter + ", " : "") +
            (tokenNumber != null ? "tokenNumber=" + tokenNumber + ", " : "") +
            (serviceName != null ? "serviceName=" + serviceName + ", " : "") +
            (serviceId != null ? "serviceId=" + serviceId + ", " : "") +
            (terminalName != null ? "terminalName=" + terminalName + ", " : "") +
            (terminalId != null ? "terminalId=" + terminalId + ", " : "") +
            (orgTerminalName != null ? "orgTerminalName=" + orgTerminalName + ", " : "") +
            (orgTerminalId != null ? "orgTerminalId=" + orgTerminalId + ", " : "") +
            (statusName != null ? "statusName=" + statusName + ", " : "") +
            (statusCode != null ? "statusCode=" + statusCode + ", " : "") +
            (isPending != null ? "isPending=" + isPending + ", " : "") +
            (isQueue != null ? "isQueue=" + isQueue + ", " : "") +
            (isReject != null ? "isReject=" + isReject + ", " : "") +
            (isAbsent != null ? "isAbsent=" + isAbsent + ", " : "") +
            (isCancel != null ? "isCancel=" + isCancel + ", " : "") +
            (isRecall != null ? "isRecall=" + isRecall + ", " : "") +
            (isCompleted != null ? "isCompleted=" + isCompleted + ", " : "") +
            (isTimeout != null ? "isTimeout=" + isTimeout + ", " : "") +
            (assignedDate != null ? "assignedDate=" + assignedDate + ", " : "") +
            (assignedYear != null ? "assignedYear=" + assignedYear + ", " : "") +
            (assignedMonth != null ? "assignedMonth=" + assignedMonth + ", " : "") +
            (assignedDay != null ? "assignedDay=" + assignedDay + ", " : "") +
            (assignedHour != null ? "assignedHour=" + assignedHour + ", " : "") +
            (assignedMin != null ? "assignedMin=" + assignedMin + ", " : "") +
            (assignedTimeZoneOffset != null ? "assignedTimeZoneOffset=" + assignedTimeZoneOffset + ", " : "") +
            (assignedTimeZoneName != null ? "assignedTimeZoneName=" + assignedTimeZoneName + ", " : "") +
            (assignedNow != null ? "assignedNow=" + assignedNow + ", " : "") +
            (assignedUid != null ? "assignedUid=" + assignedUid + ", " : "") +
            (completedYear != null ? "completedYear=" + completedYear + ", " : "") +
            (completedMonth != null ? "completedMonth=" + completedMonth + ", " : "") +
            (completedDay != null ? "completedDay=" + completedDay + ", " : "") +
            (completedHour != null ? "completedHour=" + completedHour + ", " : "") +
            (completedMin != null ? "completedMin=" + completedMin + ", " : "") +
            (completedTimeZoneOffset != null ? "completedTimeZoneOffset=" + completedTimeZoneOffset + ", " : "") +
            (completedTimeZoneName != null ? "completedTimeZoneName=" + completedTimeZoneName + ", " : "") +
            (completedNow != null ? "completedNow=" + completedNow + ", " : "") +
            (completedDate != null ? "completedDate=" + completedDate + ", " : "") +
            (completedUid != null ? "completedUid=" + completedUid + ", " : "") +
            (createdYear != null ? "createdYear=" + createdYear + ", " : "") +
            (createdMonth != null ? "createdMonth=" + createdMonth + ", " : "") +
            (createdDay != null ? "createdDay=" + createdDay + ", " : "") +
            (createdHour != null ? "createdHour=" + createdHour + ", " : "") +
            (createdMin != null ? "createdMin=" + createdMin + ", " : "") +
            (createdTimeZoneOffset != null ? "createdTimeZoneOffset=" + createdTimeZoneOffset + ", " : "") +
            (createdTimeZoneName != null ? "createdTimeZoneName=" + createdTimeZoneName + ", " : "") +
            (createdNow != null ? "createdNow=" + createdNow + ", " : "") +
            (createdDate != null ? "createdDate=" + createdDate + ", " : "") +
            (modifiedYear != null ? "modifiedYear=" + modifiedYear + ", " : "") +
            (modifiedMonth != null ? "modifiedMonth=" + modifiedMonth + ", " : "") +
            (modifiedDay != null ? "modifiedDay=" + modifiedDay + ", " : "") +
            (modifiedHour != null ? "modifiedHour=" + modifiedHour + ", " : "") +
            (modifiedMin != null ? "modifiedMin=" + modifiedMin + ", " : "") +
            (modifiedTimeZoneOffset != null ? "modifiedTimeZoneOffset=" + modifiedTimeZoneOffset + ", " : "") +
            (modifiedTimeZoneName != null ? "modifiedTimeZoneName=" + modifiedTimeZoneName + ", " : "") +
            (modifiedNow != null ? "modifiedNow=" + modifiedNow + ", " : "") +
            (modifiedDate != null ? "modifiedDate=" + modifiedDate + ", " : "") +
            (transferedYear != null ? "transferedYear=" + transferedYear + ", " : "") +
            (transferedMonth != null ? "transferedMonth=" + transferedMonth + ", " : "") +
            (transferedDay != null ? "transferedDay=" + transferedDay + ", " : "") +
            (transferedHour != null ? "transferedHour=" + transferedHour + ", " : "") +
            (transferedMin != null ? "transferedMin=" + transferedMin + ", " : "") +
            (transferedDate != null ? "transferedDate=" + transferedDate + ", " : "") +
            (transferedTimeZoneOffset != null ? "transferedTimeZoneOffset=" + transferedTimeZoneOffset + ", " : "") +
            (transferedTimeZoneName != null ? "transferedTimeZoneName=" + transferedTimeZoneName + ", " : "") +
            (transferedNow != null ? "transferedNow=" + transferedNow + ", " : "") +
            (transferedUid != null ? "transferedUid=" + transferedUid + ", " : "") +
            (issuedFrom != null ? "issuedFrom=" + issuedFrom + ", " : "") +
            (departmentId != null ? "departmentId=" + departmentId + ", " : "") +
            (departmentName != null ? "departmentName=" + departmentName + ", " : "") +
            (bizName != null ? "bizName=" + bizName + ", " : "") +
            (rating != null ? "rating=" + rating + ", " : "") +
            (feedback != null ? "feedback=" + feedback + ", " : "") +
            (smsComingCount != null ? "smsComingCount=" + smsComingCount + ", " : "") +
            (pushComingCount != null ? "pushComingCount=" + pushComingCount + ", " : "") +
            (orderId != null ? "orderId=" + orderId + ", " : "") +
            (reset != null ? "reset=" + reset + ", " : "") +
            (resetDate != null ? "resetDate=" + resetDate + ", " : "") +
            (resetUid != null ? "resetUid=" + resetUid + ", " : "") +
            (distinct != null ? "distinct=" + distinct + ", " : "") +
            "}";
    }
}

package com.jojowonet.modules.order.entity;

import com.jojowonet.modules.fitting.form.Target;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.DateToStringUtils;
import com.jojowonet.modules.order.utils.StringUtil;
import com.jojowonet.modules.order.utils.WebPageFunUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "crm_order")
public class Order implements Serializable{

	private static Logger logger = Logger.getLogger(Order.class);

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private String number;
	private String orderType; 
	private String applianceCategory; 
	private String applianceBrand; 
	private String applianceModel; 
	private String applianceBarcode; 
	private Date applianceBuyTime; //家电购机时间
	private Integer applianceNum;//家电数量
	private String applianceMachineCode; 
	private Date createTime; //创建时间
	private String createBy; 
	private Date latestProcessTime; 
	private Date endTime; 
	private Date returnCardTime; 
	private Date recordAccountTime; 
	private Date callbackTime;
	private Date repairTime; 
	private Date payTime; 
	private String customerName;
	private String province;
	private String city;
	private String area;
	private String customerAddress; 
	private String customerMobile; 
	private String customerTelephone; 
	private String customerTelephone2; 
	private String customerLnglat; 
	private String customerType; 
	private Date promiseTime; 
	private String promiseLimit; 
	private String customerFeedback; 
	private String remarks; 
	private String origin; 
	private String serviceType; 
	private String level; 
	private String siteName; 
	private String employeId; 
	private String employeName; 
	private String messengerId; 
	private String messengerName; 
	private Date updateTime; 
	private String updateName; 
	private String warrantyType; 
	private String serviceMode; 
	private String malfunctionType; 
	private String malfunctionDescription; 
	private String malfunctionCause; 
	private String malfunctionCauseDescription;
	private String measures; 
	private String measuresDescription; 
	private String siteId; 
	private String latestProcess; 
	private String processDetail; 
	private String status; 
	private String canoper; 
	private Integer dropinCount; 
	private Integer rejectCount; 
	private Integer telCount; 
	private String returnCard; 
	private String whetherCollection; 
	private String fittingFlag; 
	private double serveCost; 
	private double auxiliaryCost; 
	private double warrantyCost; 
	private double confirmCost; 
	private double callbackCost; 
	private String callbackResult;
	private String review;
	private String reviewRemark;
	private String flag;
	private String flagDesc;
	private Date flagAlertDate;
	private String recordAccount;
	private String recordAccountBy;
	private String bdImgs;
	private String pleaseReferMall;
	private String parentSiteId;
	private String parentStatus;
	private String parentDipatchFlag;
	private String factoryNumber;
	private Integer seq;
	private Integer printTimes;

	private String repairRecordAccount;
	private Date repairRecordAccountTime;

	private String disableType;
	private String disableResource;
	private Date dispatchTime;
	private Date processTime;
	private Date dropInTime;

	//'一级网点工单状态：1.待派工 2.待二级网点接收 3.服务中 4 服务完成待回访 5已回访 6.已退回 7.暂不派工',8.取消
	public static final String PSTATUS_WAIT_DISPATCH = "1";
	public static final String PSTATUS_WAIT_RECV = "2";
	public static final String PSTATUS_SERVING = "3";
	public static final String PSTATUS_WAIT_CALLBACK = "4";
	public static final String PSTATUS_CALLBACK = "5";
	public static final String PSTATUS_REFUSED = "6";
	public static final String PSTATUS_PENDING = "7";
	public static final String PSTATUS_CANCEL = "8";

	public Order() {
		super();
		this.fittingFlag = "0";
		this.whetherCollection = "0";
		this.returnCard = "0";
		this.canoper = "1";
		this.createTime = new Date();
		this.orderType = "1";
		this.dropinCount = 0;
		this.rejectCount = 0;
		this.telCount = 0;
		this.serveCost = 0;
		this.auxiliaryCost =0;
		this.warrantyCost=0;
		this.confirmCost=0;
		this.callbackCost=0;
		this.applianceNum=1;
		this.review="0";
		this.recordAccount="0";
		this.printTimes=0;
		this.repairRecordAccount="0";
		this.disableType="0";
	}
	
	@Id
	@GeneratedValue(generator = "idGenerator")
	@GenericGenerator(name ="idGenerator" , strategy ="uuid")
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	public String getBdImgs() {
		return bdImgs;
	}

	public void setBdImgs(String bdImgs) {
		this.bdImgs = bdImgs;
	}
	

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getRecordAccount() {
		return recordAccount;
	}

	public void setRecordAccount(String recordAccount) {
		this.recordAccount = recordAccount;
	}

	public Integer getApplianceNum() {
		return applianceNum;
	}

	public void setApplianceNum(Integer applianceNum) {
		this.applianceNum = applianceNum;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public String getApplianceCategory() {
		return applianceCategory;
	}

	public void setApplianceCategory(String applianceCategory) {
		this.applianceCategory = applianceCategory;
	}

	public String getApplianceBrand() {
		return applianceBrand;
	}

	public void setApplianceBrand(String applianceBrand) {
		this.applianceBrand = applianceBrand;
	}

	public String getApplianceModel() {
		return applianceModel;
	}

	public void setApplianceModel(String applianceModel) {
		this.applianceModel = applianceModel;
	}

	public String getApplianceBarcode() {
		return applianceBarcode;
	}

	public void setApplianceBarcode(String applianceBarcode) {
		this.applianceBarcode = applianceBarcode;
	}

	public Date getApplianceBuyTime() {
		return applianceBuyTime;
	}

	public void setApplianceBuyTime(Date applianceBuyTime) {
		this.applianceBuyTime = applianceBuyTime;
	}

	public String getApplianceMachineCode() {
		return applianceMachineCode;
	}

	public void setApplianceMachineCode(String applianceMachineCode) {
		this.applianceMachineCode = applianceMachineCode;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}


	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public Date getLatestProcessTime() {
		return latestProcessTime;
	}

	public void setLatestProcessTime(Date latestProcessTime) {
		this.latestProcessTime = latestProcessTime;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public Date getReturnCardTime() {
		return returnCardTime;
	}

	public void setReturnCardTime(Date returnCardTime) {
		this.returnCardTime = returnCardTime;
	}

	public Date getCallbackTime() {
		return callbackTime;
	}

	public void setCallbackTime(Date callbackTime) {
		this.callbackTime = callbackTime;
	}

	public Date getRepairTime() {
		return repairTime;
	}

	public void setRepairTime(Date repairTime) {
		this.repairTime = repairTime;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerAddress() {
		return customerAddress;
	}

	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}

	public String getCustomerMobile() {
		return customerMobile;
	}

	public void setCustomerMobile(String customerMobile) {
		this.customerMobile = customerMobile;
	}

	public String getCustomerTelephone() {
		return customerTelephone;
	}

	public void setCustomerTelephone(String customerTelephone) {
		this.customerTelephone = customerTelephone;
	}

	public String getCustomerTelephone2() {
		return customerTelephone2;
	}

	public void setCustomerTelephone2(String customerTelephone2) {
		this.customerTelephone2 = customerTelephone2;
	}

	public String getCustomerLnglat() {
		return customerLnglat;
	}

	public void setCustomerLnglat(String customerLnglat) {
		this.customerLnglat = customerLnglat;
	}

	public Date getPromiseTime() {
		return promiseTime;
	}

	public void setPromiseTime(Date promiseTime) {
		this.promiseTime = promiseTime;
	}

	public String getPromiseLimit() {
		return promiseLimit;
	}

	public void setPromiseLimit(String promiseLimit) {
		this.promiseLimit = promiseLimit;
	}

	public String getCustomerFeedback() {
		return customerFeedback;
	}

	public void setCustomerFeedback(String customerFeedback) {
		this.customerFeedback = customerFeedback;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getOrigin() {
		return origin;
	}

	public void setOrigin(String origin) {
		this.origin = origin;
	}

	public String getServiceType() {
		return serviceType;
	}

	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getSiteName() {
		return siteName;
	}

	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}

	public String getEmployeId() {
		return employeId;
	}

	public void setEmployeId(String employeId) {
		this.employeId = employeId;
	}

	public String getEmployeName() {
		return employeName;
	}

	public void setEmployeName(String employeName) {
		this.employeName = employeName;
	}

	public String getMessengerId() {
		return messengerId;
	}

	public void setMessengerId(String messengerId) {
		this.messengerId = messengerId;
	}

	public String getMessengerName() {
		return messengerName;
	}

	public void setMessengerName(String messengerName) {
		this.messengerName = messengerName;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getUpdateName() {
		return updateName;
	}

	public void setUpdateName(String updateName) {
		this.updateName = updateName;
	}

	public String getWarrantyType() {
		return warrantyType;
	}

	public void setWarrantyType(String warrantyType) {
		this.warrantyType = warrantyType;
	}

	public String getServiceMode() {
		return serviceMode;
	}

	public void setServiceMode(String serviceMode) {
		this.serviceMode = serviceMode;
	}

	public String getMalfunctionType() {
		return malfunctionType;
	}

	public void setMalfunctionType(String malfunctionType) {
		this.malfunctionType = malfunctionType;
	}

	public String getMalfunctionDescription() {
		return malfunctionDescription;
	}

	public void setMalfunctionDescription(String malfunctionDescription) {
		this.malfunctionDescription = malfunctionDescription;
	}

	public String getMalfunctionCause() {
		return malfunctionCause;
	}

	public void setMalfunctionCause(String malfunctionCause) {
		this.malfunctionCause = malfunctionCause;
	}

	public String getMalfunctionCauseDescription() {
		return malfunctionCauseDescription;
	}

	public void setMalfunctionCauseDescription(String malfunctionCauseDescription) {
		this.malfunctionCauseDescription = malfunctionCauseDescription;
	}

	public String getMeasures() {
		return measures;
	}

	public void setMeasures(String measures) {
		this.measures = measures;
	}

	public String getMeasuresDescription() {
		return measuresDescription;
	}

	public void setMeasuresDescription(String measuresDescription) {
		this.measuresDescription = measuresDescription;
	}

/*	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "site_id")
	@NotFound(action = NotFoundAction.IGNORE)
	@NotNull*/
	public String getSiteId() {
		return siteId;
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public String getLatestProcess() {
		return latestProcess;
	}

	public void setLatestProcess(String latestProcess) {
		this.latestProcess = latestProcess;
	}

	public String getProcessDetail() {
		return processDetail;
	}

	public void setProcessDetail(String processDetail) {
		String oldProcessDetail = getProcessDetail();
		int newLen = processDetail == null ? 0 : processDetail.length();
		int oldLen = oldProcessDetail == null ? 0 : oldProcessDetail.length();
		if(newLen < oldLen) {
			logger.error(String.format("new process detail is less than old len,old=%s,new=%s", oldProcessDetail, processDetail), new Exception());
		}

		this.processDetail = processDetail;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCanoper() {
		return canoper;
	}

	public void setCanoper(String canoper) {
		this.canoper = canoper;
	}

	public Integer getDropinCount() {
		return dropinCount;
	}

	public void setDropinCount(Integer dropinCount) {
		this.dropinCount = dropinCount;
	}

	public Integer getRejectCount() {
		return rejectCount;
	}

	public void setRejectCount(Integer rejectCount) {
		this.rejectCount = rejectCount;
	}

	public Integer getTelCount() {
		return telCount;
	}

	public void setTelCount(Integer telCount) {
		this.telCount = telCount;
	}

	public String getReturnCard() {
		return returnCard;
	}

	public void setReturnCard(String returnCard) {
		this.returnCard = returnCard;
	}

	public String getWhetherCollection() {
		return whetherCollection;
	}

	public void setWhetherCollection(String whetherCollection) {
		this.whetherCollection = whetherCollection;
	}

	public String getFittingFlag() {
		return fittingFlag;
	}

	public void setFittingFlag(String fittingFlag) {
		this.fittingFlag = fittingFlag;
	}

	public double getServeCost() {
		return serveCost;
	}

	public void setServeCost(double serveCost) {
		this.serveCost = serveCost;
	}

	public double getAuxiliaryCost() {
		return auxiliaryCost;
	}

	public void setAuxiliaryCost(double auxiliaryCost) {
		this.auxiliaryCost = auxiliaryCost;
	}

	public double getWarrantyCost() {
		return warrantyCost;
	}

	public void setWarrantyCost(double warrantyCost) {
		this.warrantyCost = warrantyCost;
	}

	public double getConfirmCost() {
		return confirmCost;
	}

	public void setConfirmCost(double confirmCost) {
		this.confirmCost = confirmCost;
	}

	public String getCallbackResult() {
		return callbackResult;
	}

	public void setCallbackResult(String callbackResult) {
		this.callbackResult = callbackResult;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	@Transient
	public boolean getCanSettlement() {
		String status = getStatus();
		return "3".equals(status) || "4".equals(status) || "5".equals(status);
	}

	@Transient
	public boolean getCanVisit() {
		String status = getStatus();
		return "3".equals(status) || "4".equals(status) || "5".equals(status);
	}

	@SuppressWarnings("unchecked")
	public String allContacts() {
		List<String> contacts = new ArrayList<>();
		if (StringUtil.isNotBlank(getCustomerMobile())) {
			contacts.add(getCustomerMobile());
		}
		if (StringUtil.isNotBlank(getCustomerTelephone())) {
			contacts.add(getCustomerMobile());
		}
		if (StringUtil.isNotBlank(getCustomerTelephone2())) {
			contacts.add(getCustomerMobile());
		}
		return StringUtils.join(contacts);
	}

	public void newTarget(int targetType, String operator, String content) {
		Target ta = new Target();
		ta.setName(operator);
		ta.setType(targetType);
		ta.setContent(content);
		ta.setTime(DateToStringUtils.DateToString());
		setProcessDetail(WebPageFunUtils.appendProcessDetail(ta, getProcessDetail()));
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public String getFlagDesc() {
		return flagDesc;
	}

	public void setFlagDesc(String flagDesc) {
		this.flagDesc = flagDesc;
	}

	public Date getFlagAlertDate() {
		return flagAlertDate;
	}

	public void setFlagAlertDate(Date flagAlertDate) {
		this.flagAlertDate = flagAlertDate;
	}

	public String getPleaseReferMall() {
		return pleaseReferMall;
	}

	public void setPleaseReferMall(String pleaseReferMall) {
		this.pleaseReferMall = pleaseReferMall;
	}

	public String getParentSiteId() {
		return parentSiteId;
	}

	public void setParentSiteId(String parentSiteId) {
		this.parentSiteId = parentSiteId;
	}

	public String getParentStatus() {
		return parentStatus;
	}

	public void setParentStatus(String parentStatus) {
		this.parentStatus = parentStatus;
	}

	public String getParentDipatchFlag() {
		return parentDipatchFlag;
	}

	public void setParentDipatchFlag(String parentDipatchFlag) {
		this.parentDipatchFlag = parentDipatchFlag;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public String getFactoryNumber() {
		return factoryNumber;
	}

	public void setFactoryNumber(String factoryNumber) {
		this.factoryNumber = factoryNumber;
	}

	@Transient
	public String getXm() {
		if ("7".equals(getOrderType())) {
			return getOrigin();
		}

		return CrmUtils.getUserXM(getCreateBy());
	}

	public Integer getPrintTimes() {
		return printTimes;
	}

	public void setPrintTimes(Integer printTimes) {
		this.printTimes = printTimes;
	}

	public Date getRecordAccountTime() {
		return recordAccountTime;
	}

	public void setRecordAccountTime(Date recordAccountTime) {
		this.recordAccountTime = recordAccountTime;
	}

	public double getCallbackCost() {
		return callbackCost;
	}

	public void setCallbackCost(double callbackCost) {
		this.callbackCost = callbackCost;
	}

	public String getRepairRecordAccount() {
		return repairRecordAccount;
	}

	public void setRepairRecordAccount(String repairRecordAccount) {
		this.repairRecordAccount = repairRecordAccount;
	}

	public Date getRepairRecordAccountTime() {
		return repairRecordAccountTime;
	}

	public void setRepairRecordAccountTime(Date repairRecordAccountTime) {
		this.repairRecordAccountTime = repairRecordAccountTime;
	}

	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	public String getDisableType() {
		return disableType;
	}

	public void setDisableType(String disableType) {
		this.disableType = disableType;
	}

	public String getDisableResource() {
		return disableResource;
	}

	public void setDisableResource(String disableResource) {
		this.disableResource = disableResource;
	}

	public String getRecordAccountBy() {
		return recordAccountBy;
	}

	public void setRecordAccountBy(String recordAccountBy) {
		this.recordAccountBy = recordAccountBy;
	}

	public Date getDispatchTime() {
		return dispatchTime;
	}

	public void setDispatchTime(Date dispatchTime) {
		this.dispatchTime = dispatchTime;
	}

	public Date getProcessTime() {
		return processTime;
	}

	public void setProcessTime(Date processTime) {
		this.processTime = processTime;
	}

	public Date getDropInTime() {
		return dropInTime;
	}

	public void setDropInTime(Date dropInTime) {
		this.dropInTime = dropInTime;
	}


	public String getReviewRemark() {
		return reviewRemark;
	}

	public void setReviewRemark(String reviewRemark) {
		this.reviewRemark = reviewRemark;
	}
}

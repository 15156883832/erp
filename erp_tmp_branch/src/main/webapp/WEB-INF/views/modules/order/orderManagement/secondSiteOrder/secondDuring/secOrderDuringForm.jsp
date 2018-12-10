<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
	<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/orderConnectionGoods.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>


<script type="text/javascript" src="${ctxPlugin}/lib/lodop/LodopFuncs.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/base64.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/printdesign.js"></script>
    <script type="text/javascript" src="${ctxPlugin}/lib/formatStatus.js"></script>
<style>
	.dropdown-clear-all{
			line-height: 22px
		}
	.dropdown-display{font-size: 12px}
	.dropdown-selected{margin-top: 4px}

 	.webuploader-pick{
		background:none;
		color:#22a0e6;
		width:80px;
		padding:0;
		height:80px;
	}
	.webuploader-pick img{
		width:100px;
		height:100px;
		position:absolute;
		left:0;
		top:0;
	}
	
	/* WebKit browsers */
	input::-webkit-input-placeholder {
		color: #777;
	}
	/* Mozilla Firefox 4 to 18 */
	input:-moz-placeholder {
		color: #777;
		opacity: 1;
	}
	/* Mozilla Firefox 19+ */
	input::-moz-placeholder {
		color: #777;
		opacity: 1;
	}
	/* Internet Explorer 10+ */
	input:-ms-input-placeholder {
		color: #777;
	}
</style>

<script type="text/javascript" src="${ctxPlugin}/lib/jquery.dateformat.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>  
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
</head>

<body>
<!-- 回访结算工单-工单详情 -->
<div class="popupBox odWrap orderdetailVb">
	<h2 class="popupHead">
		工单详情
		<a href="#" class="sficon closePopup" id="cloZongDiv"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pos-r" >
			<div class="pcontent">
				<div id="detialWd">
					<div class="tabBarP" style="overflow: visible;">
						<a href="javascript:;" class="tabswitch current">基本信息</a>
						<a href="javascript:;" class="tabswitch ">过程信息</a>
					</div>
					<form id="updateOrder" method="post" action="${ctx}/order/orderDispatch/update">
					<div class="tabCon">
						<div class="cl mb-10 mt-10">
						<input type="hidden" name="id" value="${order.columns.id}">
							<div class="f-l ">
								<label class="w-100 f-l">工单编号：</label>
								<input type="text" class="input-text w-160 readonly dischange" readonly="readonly" name="number" value="${order.columns.number }"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb w-100 "><em class="mark"></em>服务类型：</label>
								<select id="serviceType" disabled="disabled" name="serviceType" class="select w-120 readonly">
								<c:forEach items="${fns:getServiceTypeDer(order.columns.service_type) }" var="serm">
									 <c:if test="${order.columns.service_type eq serm.columns.name }">  
									 	 <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
									    </c:if> 
									
									  <c:if test="${order.columns.service_type ne  serm.columns.name }">  
									   <option value="${serm.columns.name }" >${serm.columns.name }</option> 
									    </c:if>
								</c:forEach>
								</select>
								<input type="text" class="input-text w-120 readonly hide" disabled="disabled" name="serviceType" value="${order.columns.service_type}"/> 
							</div>
							<div class="f-l pos-r pl-80">
								<label class="lb w-80"><em class="mark"></em>服务方式：</label>
								<select id="serviceMode"  disabled="disabled" name="serviceMode" class="select w-120 readonly">
	 								<c:forEach items="${fns:getNewServiceModeDer(order.columns.service_mode) }" var="serm">
									 <c:if test="${order.columns.service_mode eq serm.columns.name }">  
									 	 <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
									    </c:if> 
									   
									  <c:if test="${order.columns.service_mode ne  serm.columns.name }">  
									   <option value="${serm.columns.name }">${serm.columns.name }</option> 
									    </c:if>
									</c:forEach>
	 							</select>
							</div>
							<div class="f-l pos-r pl-80">
								<label class="lb w-80"><c:if test="${mustfill.columns.origin}"><em class="mark"></em></c:if>信息来源：</label>
								<select id="origin" name="origin"  disabled="disabled" class="select w-120 readonly hide">
								<c:choose>
								<c:when test="${fn:contains(listoriginlist,order.columns.origin)}">
											
								<option value="">请选择</option>
									<c:forEach items="${listorigin}" var="serm">
									 <c:if test="${order.columns.origin eq serm.columns.name }">  
									 	 <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
									    </c:if> 
			
									  <c:if test="${order.columns.origin ne  serm.columns.name }">  
									   <option value="${serm.columns.name }">${serm.columns.name }</option> 
									    </c:if>   
								</c:forEach>
									 
								</c:when>
								
								<c:otherwise>
								<option value="">请选择</option>
								 <option value="${order.columns.origin}" selected="selected">${order.columns.origin }</option>
								<c:forEach items="${listorigin}" var="serm">
									   <option value="${serm.columns.name }">${serm.columns.name }</option>    
								</c:forEach>
								
								</c:otherwise>
								
								</c:choose>
								</select>
							</div>
							<c:if test="${order.columns.record_account=='1' }">
								<a class="f-l c-0383dc lh-26 pl-5" id="btn_More" onclick="showMore(this)">展开</a>
							</c:if>
						</div>
						<div class="cl mb-10 hide" id="moreConWrap">
							<div class="f-l ">
								<label class="w-100 f-l"><em class="mark"></em>厂家工单编号：</label>
								<input type="text" id="factoryNumber" class="input-text w-160 readonly " maxlength="32" readonly="readonly" name="factoryNumber" value="${order.columns.factory_number }"/>
							</div>
						</div>
						<div class="line"></div>
						<div class="cl mt-10">
							<div class="f-l pos-r pl-100">
								<label class="lb w-100"><em class="mark"></em>用户姓名：</label>
								 <input type="text" id="customerName" class="input-text w-160 readonly" readonly="readonly" name="customerName"  value="${order.columns.customer_name }"/>
								<input type="hidden" class="input-text w-160" id="sign"   value=""/> 
								<input type="hidden" class="input-text w-160"  id="siteMsgNums" value=""/> 
						<c:if test="${cusTypecount > 0 }">
								<span class="select-box w-70 ">
			                    <select class="select readonly " <c:if test="${mustfill.columns.customerType}">datatype="*" nullmsg="请选择用户类型"</c:if> id="customerType" name="customerType" disabled="disabled" style="width: 70px;">
				                    <option value="">选择类型</option>
				                    <c:forEach items="${fns:getCustomerType()}" var="to">
				                    <option value="${to.columns.name }" <c:if test="${to.columns.name eq order.columns.customer_type}">selected="selected"</c:if>>${to.columns.name }</option>
				                    </c:forEach>
			                    </select>
								</span>
						</c:if>
							</div>
							<div class="f-l pos-r pl-100">
								<span class="lb w-100" id="mobileType">
									<label class="lb w-90 text-r">联系方式1：</label>
								</span>
								<input type="text" id="customerMobile" class="input-text w-110 readonly" readonly="readonly" name="customerMobile" value="${order.columns.customer_mobile }"/>
							</div>
							<div class="f-l pos-r pl-90">
								<label class="lb w-90">其他联系方式：</label>
								<input type="text" id ="customerTelephone" class="input-text w-110 readonly" readonly="readonly" name="customerTelephone"  value="${order.columns.customer_telephone }"/>
							</div>
							<div class="f-l pos-r " style="padding-left: 15px;">
							<!-- <label class="lb lb2">联系方式3：</label> -->
								<input type="text" id="customerTelephone2" class="input-text w-110 readonly" readonly="readonly" name="customerTelephone2" value="${order.columns.customer_telephone2 }"/>
							</div>
						</div>
						<div class="cl mt-10 mb-10" >
							<div class="pos-r pl-100" id="pcd">
								<label class="lb w-100"><em class="mark"></em>详细地址：</label>
								<span class="select-box w-90 f-l mr-10 " id="showProvince">
                            	<select class="prov select readonly" id="province" name="province" disabled="disabled">
									<c:if test="${not empty order.columns.province}">
										<c:forEach items="${provincelist }" var="pro">
											<option value="${pro.columns.ProvinceName }"
													<c:if test="${pro.columns.ProvinceName==order.columns.province }">selected="selected"</c:if>>${pro.columns.ProvinceName }</option>
										</c:forEach>
									</c:if>
									<c:if test="${empty order.columns.province && not empty site.province}">
										<c:forEach items="${provincelist }" var="pro">
											<option value="${pro.columns.ProvinceName }"
													<c:if test="${pro.columns.ProvinceName==site.province }">selected="selected"</c:if>>${pro.columns.ProvinceName }</option>
										</c:forEach>
									</c:if>
								</select>
                            	</span>
								<span class="select-box w-90 f-l mr-10 " id="showCity">
                            	<select class="city select readonly" id="city" name="city" disabled="disabled">
									<c:if test="${not empty order.columns.city}">
										<c:forEach items="${cities }" var="cs">
											<option value="${cs.columns.CityName }"
													<c:if test="${cs.columns.CityName==order.columns.city }">selected="selected"</c:if>>${cs.columns.CityName }</option>
										</c:forEach>
									</c:if>
									<c:if test="${empty order.columns.city && not empty site.city}">
										<c:forEach items="${cities }" var="cs">
											<option value="${cs.columns.CityName }"
													<c:if test="${cs.columns.CityName==site.city }">selected="selected"</c:if>>${cs.columns.CityName }</option>
										</c:forEach>
									</c:if>

								</select>
                           	 	</span>
								<span class="select-box w-90 f-l mr-10 " id="showArea">
                            	<select class="dist select readonly" id="area" name="area" disabled="disabled">
									<c:if test="${not empty order.columns.area}">
										<c:forEach items="${districts }" var="ds">
											<option value="${ds.columns.DistrictName }"
													<c:if test="${ds.columns.DistrictName==order.columns.area }">selected="selected"</c:if>>${ds.columns.DistrictName }</option>
										</c:forEach>
									</c:if>
									<c:if test="${empty order.columns.area && not empty site.area}">
										<c:forEach items="${districts }" var="ds">
											<option value="${ds.columns.DistrictName }"
													<c:if test="${ds.columns.DistrictName==site.area }">selected="selected"</c:if>>${ds.columns.DistrictName }</option>
										</c:forEach>
									</c:if>
								</select>
                            	</span>
								<input type="text" class="input-text w-280 f-l readonly" readonly="readonly" id="customerAddress1" name="customerAddress1" value="${order.columns.customer_address }" autocomplete="off"/>
								<input type="hidden" id="customerAddress" name="customerAddress" value="${order.columns.customer_address}"/>
								<input type="hidden" id="lnglat" name="customerLnglat" value="${order.columns.customer_lnglat }"/>
							</div>
						</div>
						<div class="line"></div>
						<div class="cl mt-10" id="styleMark">
							<div class="f-l pos-r pl-100">
								<label class="lb w-100"><em class="mark"></em>家电品牌：</label>
							<select  disabled="disabled"  class="select w-160 readonly " name="applianceBrand" id="applianceBrand" datatype="*" nullmsg="请选择品类！">
									 		 
								      <c:choose>
								<c:when test="${fn:contains(brandlist,order.columns.appliance_brand)}">
										 	 <option value="">请选择</option>	
									<c:forEach items="${brand}" var="ba" varStatus="cast">
									  <c:if test="${order.columns.appliance_brand eq ba.value  }">
									 	 <option value="${ba.key }" selected="selected">${ba.value }</option>
									    </c:if> 
									    <c:if test="${order.columns.appliance_brand ne ba.value }"> 
									 	 <option value="${ba.key }">${ba.value }</option>
									    </c:if>
									</c:forEach>
								</c:when>
								
								
								<c:otherwise>
								 <option value="">请选择</option>	
								<option value="${order.columns.appliance_brand}" selected="selected">${order.columns.appliance_brand}</option>
								<c:forEach items="${brand}" var="ba" varStatus="cast">
								 <option value="${ba.key }">${ba.value }</option>
								</c:forEach>
								</c:otherwise>
								</c:choose>
							
									</select>
								<input type="text" id="applanceBrandMirror" class="input-text w-160 readonly hide" readonly="readonly" value="${order.columns.appliance_brand }"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb w-100"><em class="mark"></em>家电品类：</label>
								<select class="select w-120 readonly" name="applianceCategory" id="applianceCategory" datatype="*" nullmsg="请选择品类！"  disabled="disabled">
										 		
								<c:choose>
								<c:when test="${fn:contains(catelist,order.columns.appliance_category)}">
										 	 <option value="">请选择</option>
									 
									 <c:forEach items="${category}" var="cad" varStatus="cast1">
									 	 <c:if test="${order.columns.appliance_category eq cad.columns.name  }">
									 		 <option value="${cad.columns.name }" selected="selected">${cad.columns.name}</option>
									     </c:if> 
									   
									    <c:if test="${order.columns.appliance_category ne cad.columns.name }"> 
									 		 <option value="${cad.columns.name }">${cad.columns.name }</option>
									    </c:if>
									 </c:forEach>
								</c:when>
								
								
								<c:otherwise>
								<option value="">请选择</option>
								 <option value="${order.columns.appliance_category}" selected="selected">${order.columns.appliance_category}</option>
								 <c:forEach items="${category}" var="cad" varStatus="cast1">
								 <option value="${cad.columns.name }">${cad.columns.name }</option>
								 </c:forEach>
								</c:otherwise>
								</c:choose>
							
								</select>
							</div>
							<div class="f-l pos-r pl-80">
								<label class="lb w-80"><c:if test="${mustfill.columns.promiseTime}"><em class="mark"></em></c:if>预约日期：</label>
								<input id="promiseTime" type="text" onfocus="WdatePicker({minDate: '%y-%M-%d' })" class="input-text w-120 readonly" disabled="disabled" name="promiseTime" value="<fmt:formatDate value='${order.columns.promise_time }' pattern='yyyy-MM-dd'/>"/>
							</div>
							<div class="f-l pos-r pl-80">
								<label class="lb w-80"><c:if test="${mustfill.columns.promiseLimit}"><em class="mark"></em></c:if>时间要求：</label>
								<select id="promiseLimit" class="select w-120 readonly" name="promiseLimit"  disabled="disabled">
								<option value="">请选择</option>
									<c:set var="isDoing" value="0"/>
									<c:forEach items="${proLimitList}" var="serm">
										<option value="${serm }" ${order.columns.promise_limit eq serm ?'selected':''} >${serm }</option>
										<c:if test="${order.columns.promise_limit eq serm}">
											<c:set var="isDoing" value="1"/>
										</c:if>
									</c:forEach>
									<c:if test="${isDoing != 1 and not empty order.columns.promise_limit}">
										<option value="${order.columns.promise_limit }" selected="selected" >${order.columns.promise_limit }</option>
									</c:if>
								</select>
							</div>
						</div>
						<div class="cl mt-10">
							<div class="f-l pos-r pl-100 h-50">
								<label class="lb w-100"><c:if test="${mustfill.columns.customerFeedback}"><em class="mark"></em></c:if>服务描述：</label>
								<textarea  class="input-text w-380 h-50 readonly" readonly="readonly" id="customerFeedback" name="customerFeedback">${order.columns.customer_feedback}</textarea>
							</div>
							<div class="f-l pos-r pl-80 h-50">
								<label class="lb w-80"><c:if test="${mustfill.columns.remarks}"><em class="mark"></em></c:if>备注：</label>
								<textarea class="input-text h-50 w-320 readonly" readonly="readonly" id="remarks" name="remarks" >${order.columns.remarks}</textarea>
							</div>
						</div>
						
						
						<div class="cl mt-10">
							<div class="f-l pos-r pl-100">
								<label class="lb w-100"><c:if test="${mustfill.columns.applianceModel}"><em class="mark"></em></c:if>产品型号：</label>
								<input type="text" class="input-text w-160 readonly" readonly="readonly" id="applianceModel" name="applianceModel" value="${order.columns.appliance_model}"/>
								<input type="text" class="input-text w-160 readonly hide" hidden="hidden" id="count1" disabled="disabled" name="count1" value="${count1 }"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb w-100 text-r"><c:if test="${mustfill.columns.applianceNum}"><em class="mark"></em></c:if>产品数量：</label>
								<input type="text" class="input-text w-120 readonly" readonly="readonly" id="applianceNum" name="applianceNum" value="${order.columns.appliance_num }"/>
							</div>
							<div class="f-l pos-r pl-80 wrapss">
								<label class="lb w-80"><c:if test="${mustfill.columns.applianceBarcode}"><em class="mark"></em></c:if>内机条码：</label>
								<input type="text" style="width:180px;" class="input-text  readonly" readonly="readonly" id="applianceBarcode" name="applianceBarcode" value="${order.columns.appliance_barcode}" title="${order.columns.appliance_barcode}"/>
								<span class="weishu1" hidden="hidden">
									( <span id="incodeNum">0</span>位 )
								</span>
								<span class="ml-2 code1" hidden="hidden">
									<a href="javascript:showQRCode('${order.columns.site_id }','1');" class="sficon sficon-scancode"></a>
								</span>
								<span class="va-t underline c-fe0101 codeConnectShow cPointer " preData="${order.columns.appliance_barcode}"  id="codeInshow"></span >
							</div>
							
						</div>
						<div class="cl mt-10">
							<div class="f-l pos-r pl-100">
								<label class="lb w-100"><c:if test="${mustfill.columns.applianceBuyTime}"><em class="mark"></em></c:if>购买日期：</label>
								<input id="buyDate" type="text" onfocus="WdatePicker({maxDate: '%y-%M-%d' })" class="input-text w-160 readonly" disabled="disabled"  name="applianceBuyTime" value="<fmt:formatDate value='${order.columns.appliance_buy_time }' pattern='yyyy-MM-dd'/>"/>
							</div>
							<div class="f-l pos-r pl-100">
                                <c:choose>
                                    <c:when test="${not empty malllist}">
                                        <label class="lb w-100"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
                                        <span class="w-120">
									<select class="select ${mustfill.columns.pleaseReferMall?'mustfill':''} readonly" disabled="diabled"  id="pleaseReferMall"  multiline="false" name="pleaseReferMall" style="width:100%;height:25px" panelMaxHeight="300px" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请选择购机商场"</c:if>>
										<option value="">请选择</option>
										 <c:set var="hadMall" value="0"></c:set>
										<c:forEach items="${malllist }" var="mall">
											<c:if test="${mall.columns.mall_name eq order.columns.please_refer_mall}"><c:set var="hadMall" value="1"></c:set></c:if>
											<option value="${mall.columns.mall_name } " ${order.columns.please_refer_mall eq mall.columns.mall_name ?'selected':''}>${mall.columns.mall_name }</option>
										</c:forEach>
                                        <c:if test="${hadMall eq '0' and not empty order.columns.please_refer_mall}"><option value="${order.columns.please_refer_mall}" selected>${order.columns.please_refer_mall}</option></c:if>
									</select>
								</span>
                                    </c:when>
                                    <c:otherwise>
                                        <label class="lb w-100"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
                                        <input type="text" value="${order.columns.please_refer_mall}" name="pleaseReferMall" class="input-text w-120 ${mustfill.columns.pleaseReferMall?'mustfill':''} readonly" readonly="readonly" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请输入购机商场"</c:if>>
                                    </c:otherwise>
                                </c:choose>
							</div>
							<div class="f-l pos-r pl-80 wrapss">
								<label class="w-80 pos "><c:if test="${mustfill.columns.applianceMachineCode}"><em class="mark"></em></c:if>外机条码：</label>
								<input type="text" style="width:180px;" class="input-text  readonly" readonly="readonly" id="applianceMachineCode" name="applianceMachineCode" value="${order.columns.appliance_machine_code}" title="${order.columns.appliance_machine_code}"/>
								<span class="ml-2 mr-2 weishu2" hidden="hidden">
									( <span id="outcodeNum">0</span>位 )
								</span>
								<span class="ml-2 mr-2 code2"  hidden="hidden">
									<a href="javascript:showQRCode('${order.columns.site_id }','2');" class="sficon sficon-scancode"></a>
								</span>
								<span class="va-t underline c-fe0101 codeConnectShow cPointer" preData="${order.columns.appliance_machine_code}"  id="codeOutshow"></span>
							</div>
							

						</div>
						<div class="mt-10 cl mb-10">
							<div class="f-l ">
								<label class="f-l w-100"><c:if test="${mustfill.columns.warrantyType}"><em class="mark"></em></c:if>保修类型：</label>
									<select class="select  w-160 readonly " name="warrantyType"  disabled="disabled" id="warrantyType">
										<option value="">请选择</option>
										<c:if test="${order.columns.warranty_type eq '1' }">
											<option value="1" selected = "selected">保内</option>
											<option value="2">保外</option>
										</c:if>
										<c:if test="${order.columns.warranty_type eq '2' }">
											<option value="1">保内</option>
											<option value="2" selected = "selected">保外</option>
										</c:if>
										<c:if test="${order.columns.warranty_type ne '1' && order.columns.warranty_type ne '2'}">
											<option value="1">保内</option>
											<option value="2">保外</option>
										</c:if>
									</select>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="w-100 pos"><c:if test="${mustfill.columns.level}"><em class="mark"></em></c:if>重要程度：</label>
									<select class="select w-120 readonly" name="level" id="level"  disabled="disabled">
										<option value="">请选择</option>
										<option value="1" <c:if test="${order.columns.level eq '1' }">selected="selected"</c:if>>紧急</option>
									<option value="2" <c:if test="${order.columns.level eq '2' }">selected="selected"</c:if>>一般</option>
									</select>
							</div>
							<div class="f-l">
								<label class="f-l w-80">报修时间：</label>
								<input type="text" class="input-text w-130 readonly dischange" readonly="readonly" name="repairTime" value="<fmt:formatDate value='${order.columns.repair_time }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
							</div>
							<div class="f-l pos-r pl-80">
								<label class="pos w-80">登记人：</label>
								<input type="text" class="input-text w-110 readonly dischange" readonly="readonly" name="messengerName" value="${order.columns.columns.xm}"/>
							</div>
						</div>
					</div>
					</form>
	
					<div class="tabCon pt-10">
						<div class="processWrap">
							<c:forEach var="pros" items="${fns:getOrderProcess(order.columns.process_detail)}">
								<p class="processItem">
									<span class="time">${pros.time}</span>
									<span>${pros.content}</span>
								</p>
							</c:forEach>
						</div>
					</div>
				</div>
				<div id="serveFb" class="mt-25">
				<div class="tabBarP">
					<a href="javascript:;" class="tabswitch current">服务反馈</a>
					<a href="javascript:showSQMsg();" class="tabswitch ">备件申请</a>
					<a href="javascript:showSYMsg();" class="tabswitch ">备件使用</a>
					<a href="javascript:showOldFitting();" class="tabswitch">旧件信息</a>
					<a href="javascript:showGoodsMsg();" class="tabswitch">商品信息</a>
				</div>
				<div class="tabCon">
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">服务工程师：</label>
							<input type="text" name="fankui" class="input-text w-160 readonly" readonly="readonly"  value="${order.columns.employe_name}" title="手机号：${msg2Mobiles}"/>
						</div>
						<div class="f-l pos-r pl-100">
							<label class="lb text-r w-100">服务状态：</label>
							<input type="text" name="fankui" class="input-text w-120 readonly" readonly="readonly"  value="${dispStatus}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">故障现象：</label>
							<input type="text" name="fankui" class="input-text w-120 readonly" readonly="readonly"  value="${order.columns.malfunction_type}"/>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">收费总额：</label>
							<div class="priceWrap w-140 readonly">
								<input type="text" name="fankui" class="input-text readonly" readonly="readonly"  value="${fns:getOrderTotalFee(order.columns.auxiliary_cost, order.columns.serve_cost, order.columns.warranty_cost)}"/>
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pl-10">
							<label class="f-l">（辅材收费：</label>
							<div class="priceWrap w-80 readonly f-l">
								<input type="text" name="fankui" class="input-text readonly" readonly="readonly" value="${order.columns.auxiliary_cost}" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pl-10">
							<label class="f-l">服务收费：</label>
							<div class="priceWrap w-80 readonly f-l">
								<input type="text" name="fankui" class="input-text readonly" readonly="readonly" value="${order.columns.serve_cost}" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pl-10">
							<label class="f-l">延保收费：</label>
							<div class="priceWrap w-80 readonly f-l">
								<input type="text" name="fankui" class="input-text readonly" readonly="readonly" value="${order.columns.warranty_cost}" />
								<span class="unit">元</span>
							</div>
						</div>
						<span class="pd-5 f-l">）</span>
						<c:if test="${not empty collectionslist}">
							<c:forEach items="${collectionslist}" var="col">
								<c:set value="${sum + col.columns.payment_amount}" var="sum"/>
							</c:forEach>
							<div class="f-l lh-26">
								<div> 无现金收款：${sum}元
									<a class="proofImg c-0383dc" id="imgshows">凭证
										<c:forEach items="${collectionslist}" var="col">
											<c:if test="${not empty col.columns.imgs}">
												<img src="${commonStaticImgPath}${col.columns.imgs}"/>
											</c:if>
										</c:forEach>
									</a>
								</div>
							</div>
						</c:if>

					</div>
					<div class="cl mt-10">
						<div class="pos-r txtwrap1">
							<label class="lb lb1">反馈内容：</label>
							<div class="readonly processWrap2" style="width:807px">
								<c:forEach var="fbItems" items="${feedbackInfo.feedbackResults}">
									<p class="processItem">
										<span class="time">${fbItems.feedbackTime} </span>
										<span>${fbItems.feedbackName }：${fbItems.feedbackResults }</span>
									</p>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="pos-r txtwrap1 h-50" id="Imgprocess2">
							<label class="lb lb1">过程图片：</label>
							<c:forEach var="fbImgItems" items="${feedbackInfo.feedbackImgs}">
								<c:if test="${not empty fbImgItems.fbImgPath }">
									<c:forEach var="fbImgItem" items="${fbImgItems.fbImgPath}">
										<div class="f-l mr-10">
											<div class="imgWrap">
												<img src="${commonStaticImgPath}${fbImgItem}">
												<p class="lh-20">${fbImgItems.fbImgTime}</p>
											</div>
										</div>
									</c:forEach>
								</c:if>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="tabCon">
					<div class="cl text-c">
						<span class="caption_lb">工单关联配件申请</span>
					
					</div>
					<div class="" style="max-height:140px;overflow:auto;">
						<table id="pjsq" class="table table-border table-bordered table-bg table-relatedorder">
							<thead>
							<tr>
								<th class="w-110">备件条码</th>
								<th class="w-250">备件名称</th>
								<th class="w-150">备件型号</th>
								<th class="w-50">数量</th>
								<th class="w-100">备件状态</th>
								<th class="w-140">申请时间</th>
							</tr>
							</thead>
						</table>
					</div>
					<div class="cl mt-10 pos-r txtwrap1 showimg">
					</div>
				</div>
				<div class="tabCon">
					<div class="cl text-c">
						<span class="caption_lb">工单关联配件使用</span>
						<input onclick="useFit()" type="button" class="btn-usebj mr-20 w-70 mt-5 sfbtn sfbtn-opt f-r pos-r"  value="备件使用" />
					</div>
					<div class="" style="max-height:140px;overflow:auto;">
						<table id="pjsy" class="table table-border table-bordered table-bg table-relatedorder">
							<thead>
							<tr>
								<th class="w-180">备件条码</th>
								<th class="w-260">备件名称</th>
								<th class="w-120">备件型号</th>
								<th class="w-90">最新入库价格</th>
								<th class="w-80">工程师价格</th>
								<th class="w-70">零售价格</th>
								<th class="w-50">数量</th>
								<th class="w-70">收费金额</th>
								<th class="w-70">状态</th>
							</tr>
							</thead>
						</table>
					</div>
				</div>
				
				<div class="tabCon">
					<div style="width: 920px;overflow: auto;">
						<table class="table table-border table-bordered table-bg table-relatedorder">
							<caption>工单关联旧件信息</caption>
							<thead>
								<tr>
									<th class="w-160">旧件条码</th>
									<th class="w-150">旧件名称</th>
									<th class="w-160">旧件型号</th>
									<th class="w-70">旧件品牌</th>
									<th class="w-70">是否原配</th>
									<th class="w-70">登记数量</th>
									<th class="w-70">状态</th>
									<th class="w-120">登记时间</th>
								</tr>
							</thead>
							<tbody class="oldtbody">
							</tbody>
						</table>
					</div>
					<div class="cl mt-10 pos-r txtwrap1" id="oldfittingimg">
					</div>
				</div>
				<div class="tabCon">
					<div style="width: 920px;overflow: auto;">
						<table class="table table-border table-bordered table-bg table-relatedorder">
							<caption>工单关联商品销售</caption>
							<thead>
								<tr>
									<th class="w-160">订单编号</th>
									<th class="w-200">商品名称</th>
									<th class="w-70">购买数量</th>
									<th class="w-70">入库价格</th>
									<th class="w-70">成交价</th>
									<th class="w-70">成交总额</th>
									<th class="w-70">实收金额</th>
									<th class="w-70">提成金额</th>
									<th class="w-120">销售人员</th>
									<th class="w-150">登记时间</th>
									<th class="w-120">状态</th>
								</tr>
							</thead>
							<tbody class="oldtbody" id="goodsMsg">
							</tbody>
						</table>
					</div>
				</div>
			</div>
			</div>
			
			
			<div class="btnMenubox pb-80">
				<c:if test="${'7' ne order.columns.order_type}">
				<sfTags:pagePermission authFlag="ORDER_MODORDER_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt" id="xggd" value="修改工单" type="button" />'></sfTags:pagePermission>
				</c:if>
				<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_DISPATCHSECONDORDER_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="返回一级待派工" type="button" onclick="returnSiteOrder()"/>'></sfTags:pagePermission>
				<sfTags:pagePermission authFlag="ORDER_ZHUANPAI_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn"  value="转派" type="button" onclick="directDisZp()"/>'></sfTags:pagePermission>
				<c:if test="${order.columns.status ne '1'  && order.columns.status ne '7' }">
				<sfTags:pagePermission authFlag="ORDER_FEEDBACKCLOSE_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="反馈封单" id="btn-fbOrder" type="button" />'></sfTags:pagePermission>
				</c:if>
			</div>
		</div>
	</div>
</div>

<div class="popupBox fbOrder">
	<h2 class="popupHead">
		反馈封单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<form action="" id="generationOrderFrom">
			<div class="popupMain" ><div class="pcontent  pd-15">
			<div id="fbBaseInfo">
				<div class="tabBarP cl">
					<a href="javascript:;" class="tabswitch current">服务信息</a>
				</div>
				<div class="tabCon">
					<div>
						<input type="hidden"  name="orderId" id="orderId" value="${order.columns.id }" datatype="*">
						<input type="hidden"  name="disOrderId" value="${disOrder.columns.id }" datatype="*"> 
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1" id="stateBox">
                                <input type="hidden" name="feedbackType"/>
							</div>
                        </div>
                        <div class="cl mt-10">
                            <div class="f-l pos-r txtwrap1">
                                <label class="lb lb1"><em class="mark">*</em>保修类型：</label>
                                <span class="select-box w-110 mustfill">
									<select class="select" id="warrantyType1" name="warrantyType" datatype="*" nullmsg="请选择保修类型">
									<c:choose>
                                        <c:when test="${order.columns.warranty_type eq '1'}">
                                            <option value="1" selected="selected">保内</option>
                                            <option value="2">保外</option>
                                            <!-- <option value="3">保内转保外</option> -->
                                        </c:when>
                                        <c:when test="${order.columns.warranty_type eq '2'}">
                                            <option value="1">保内</option>
                                            <option value="2" selected="selected">保外</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="">请选择</option>
                                            <option value="1">保内</option>
                                            <option value="2">保外</option>
                                            <!-- <option value="3">保内转保外</option> -->
                                        </c:otherwise>
                                    </c:choose>
									</select>
								</span>
                            </div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">服务类型：</label>
								<span class="select-box w-110">
									<select class="select" name="serviceType">
										<c:forEach items="${fns:getServiceTypeWithDefault(order.columns.service_type) }" var="stype">
										<c:if test="${stype.columns.name eq order.columns.service_type}">
											<option value="${stype.columns.name }" selected="selected">${stype.columns.name }</option>
										</c:if>
										<c:if test="${stype.columns.name ne order.columns.service_type}">
											<option value="${stype.columns.name }">${stype.columns.name }</option>
										</c:if>
										</c:forEach>
									</select>
								</span>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">服务方式：</label>
								<span class="select-box w-110">
									<select class="select" name="serviceMode">
										<c:forEach items="${fns:getServiceModeWithDefault(order.columns.service_mode) }" var="stype">
										<c:if test="${stype.columns.name eq order.columns.service_mode}">
											<option value="${stype.columns.name }" selected="selected">${stype.columns.name }</option>
										</c:if>
										<c:if test="${stype.columns.name ne order.columns.service_mode}">
											<option value="${stype.columns.name }">${stype.columns.name }</option>
										</c:if>
										</c:forEach>
									</select>
								</span>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">服务工程师：</label>
								<input type="text" class="input-text w-130 readonly" readonly="readonly" value="${order.columns.employe_name }"/>
							</div>
						</div>
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">家电品类：</label>
								<span class="select-box w-110">
									<select class="select" name="applianceCategory">
										<c:set var="dovalue" value="0"/>
										<c:forEach items="${category }" var="ca" varStatus="cast">
											<c:if test="${ca.columns.name eq order.columns.appliance_category}">
									 			<option value="${ca.columns.name }" selected="selected">${ca.columns.name }</option>
												<c:set var="dovalue" value="1"/>
											</c:if>
											<c:if test="${ca.columns.name ne order.columns.appliance_category}">
									 			<option value="${ca.columns.name }">${ca.columns.name }</option>
											</c:if>
										</c:forEach>
										<c:if test="${dovalue eq 0}">
											<option value="${order.columns.appliance_category}" selected>${order.columns.appliance_category}</option>
										</c:if>
									</select>
								</span>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">产品型号：</label>
								<input type="text" class="input-text w-110" value="${order.columns.appliance_model}" name="applianceModel"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2"><em class="mark">*</em>内机条码：</label>
								<input type="text" class="input-text w-110 mustfill" value="${order.columns.appliance_barcode}" name="applianceBarcode" datatype="*" nullmsg="请输入内机条码"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">外机条码：</label>
								<input type="text" class="input-text w-130" value="${order.columns.appliance_machine_mode}" name="applianceMachineCode"/>
							</div>
						</div>
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">故障现象：</label>
								<input type="text" class="input-text" style="width:534px;" value="${order.columns.appliance_model}" id="malfunctionType1" name="malfunctionType"/>
							</div>
						</div>
						<div class="pos-r mt-10 txtwrap1">
							<label class="lb lb1"><em class="mark">*</em>反馈描述：</label>
							<input type="text" class="input-text mustfill" name="feedback" id="feedback" datatype="*" nullmsg="请输入反馈描述" />
						</div>
						<div class="pos-r mt-10 txtwrap1 cl allDuringImgs" id="">
							<label class="lb lb1">过程图片：</label>
							<div id="Imgprocess1">
							 	<c:if test="${not empty duringFeedImgs }">
									<c:forEach items="${duringFeedImgsArr }" var="str" varStatus="da">
										<div class="f-l imgWrap1" id="img${da.index}">
											<div class="imgWrap"> 
												<img src="${commonStaticImgPath}${str}" id="${commonStaticImgPath}${str}"></img>
											</div>
											<a class="sficon btn-delimg" onclick="deleteImg('img${da.index}')"></a>
											<input type="hidden" value="${str}" name="pickerImg" >
										</div>
									</c:forEach>
								</c:if>
							</div>

							<div id="Imgprocess" class="f-l" >	 
							</div>
							<div class="f-l mr-10">
								<div class="imgWrap jiahao" id="jiahao" >
									<div id="filePicker-add">
										<a href="javascript:;" class="btn-upload"></a>
									</div>
								<p class="lh-20">最多可上传8张照片</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class="tabBarP cl mt-10" style="overflow: visible;" id="bjNavBox">
				<a href="javascript:fittingApply('pjmg');" class="tabswitch current">备件使用</a>
				<a href="javascript:fittingApplyrecord();" class="tabswitch ">备件申请</a>
				
			</div> 
			<div class="cl text-c" id="bjNavBox2">
				<span class="caption_lb">工单关联配件使用</span>
				<span class="caption_lb hide">工单关联配件申请</span>
				<input onclick="useFit()" type="button" class="btn-usebj mr-20 w-70 mt-5 sfbtn sfbtn-opt f-r pos-r"  value="备件使用" />
	
			</div>
				<div class="" style="max-height:140px;overflow:auto;">
					<table id="pjmg" class="table table-border table-bordered table-bg table-relatedorder">
						<thead>
						<tr>
							<th class="w-110">备件条码</th>
							<th class="w-250">备件名称</th>
							<th class="w-150">备件型号</th>
							<th class="w-50">数量</th>
							<th class="w-100">备件状态</th>
							<th class="w-140">申请时间</th>
						</tr>
						</thead>
					</table>
				</div>
				<div class="tabBarP cl mt-10">
					<a href="javascript:;" class="tabswitch current">收费信息</a>
					<!-- <input id="btn-usebj" type="button" class="mr-10 sfbtn sfbtn-opt3 f-r" value="收费信息" /> -->
				</div>
				<div class="tabCon" style="display:block">
					<div>
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">服务收费：</label>
								<div class="priceWrap w-110">
									<input type="text" class="input-text" name="serveCost" id="serveCost" value="${order.columns.serve_cost }"  onchange="cost()"/>
									<span class="unit">元</span>
								</div>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">辅材收费：</label>
								<div class="priceWrap w-110 readonly">
									<input type="text" class="input-text readonly" id="auxiliaryCost" readonly="readonly" name="auxiliaryCost" onchange="cost()"/>
									<span class="unit">元</span>
								</div>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">延保收费：</label>
								<div class="priceWrap w-110">
									<input type="text" class="input-text" id="warrantyCost" value="${order.columns.warranty_cost  }" name="warrantyCost" onchange="cost()"/>
									<span class="unit">元</span>
								</div>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">收费总额：</label>
								<div class="priceWrap w-130 readonly">
									<input type="text" class="input-text readonly" readonly="readonly" id="zongCost"/>
									<span class="unit">元</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			<div class="text-c mt-10">
				<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="服务完成" id="Butorder"/>
				<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="过程反馈" onclick="ReplaceEmploye()"/>
				<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" onclick="cancelCloseOrder();">
			</div>
			</div>
		</div>
		</form>
	</div>
</div>

<!-- 备件使用弹出框 -->
<div class="popupBox beijian usebj">
	<h2 class="popupHead">
		备件使用
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain" >
			<div class="cl mb-10" id="beijianshiyong">
				<label class="w-100 f-l"><em class="mark">*</em>备件名称：</label>
				<select class="select f-l w-230 mustfill" id="finame">
				</select>
				<span class="c-666 lh-26 ml-10">请选择工程师备件库存</span>
			</div>
			<div class="cl mb-15">
				<label class="f-l w-100">备件条码：</label>
				<input type="text " name="code" class="input-text w-140 f-l readonly" readonly="readonly"/>
				<label class="f-l w-100">备件型号：</label>
				<input type="text" name="type" class="input-text w-140 f-l readonly" readonly="readonly" />
			</div>
			<div class="cl mb-15">
				<label class="f-l w-100"><em class="mark">*</em>使用数量：</label>
				<input id="finum" name="num" type="text" class="input-text w-140 f-l mustfill" />
				<label class="f-l w-100">是否收费：</label>
				<div class="f-l" id="isPayBox">
					<label class="radiobox f-l mt-3" for="noPay"> <input type="radio" id="noPay" name="isPayRadio" />否 </label>
					<label class="radiobox f-l mt-3 ml-10" for="isPay"> <input type="radio" id="isPay" name="isPayRadio" /> 是</label>
					<div class="priceWrap f-l w-60 ml-10 hide" id="hideMoney">
						<input id="payPrice" type="text" class="input-text mustfill" /><span class="unit">元</span>
						<input type="hidden" name="fittingId" value="">
					</div>
				</div>
			</div>
			<div class="text-c pl-20 mt-30 pt-15">
				<input type="button" id="bj_use" onclick="tj_bjuse()" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button"  name="bjca" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
			</div>
		</div>
	</div>
</div>




<div class="popupBox promptBox1" style="width:400px;">
	<h2 class="popupHead">提示<a href="javascript:;" class="sficon closePopup"></a></h2>
	<div class="popupContainer">
		<div class="popupMain  f-14" >
			<p class="text-c">
				<i class="iconType iconType2"></i>
				工单有未完成的备件申请，确认继续封单？
			</p>
			<div class="text-c mt-25 ">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 mr-10 " onclick="continueConfirm()">继续封单</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70" onclick="cancelFendan()">取消</a>
			</div>
		</div>
	</div>
</div>


<div class="popupBox qrcode" >
    <h2 class="popupHead">
        <a href="javascript:;" class="sficon closePopup"></a>
    </h2>
    <div class="popupContainer">
        <div class="popupMain pd-20" >
            <div class="text-c mt-25 " id="showCode">

            </div>
        </div>
    </div>
</div>

<div class="popupBox w-710 dispatchBox1 activeDispatch1" >
	<h2 class="popupHead">
		转派
		<a href="javascript:;" class="sficon closePopup" onclick="closeDispatch()"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-15" >
			<div class="searchbox mb-10">
				<input type="text" placeholder="请输入二级网点名称、所在地区" id="filterName1" class="input-text" />
				<a href="javascript:searchSite('2');" class="btn-search"><i class="Hui-iconfont Hui-iconfont-search2 f-16"></i></a>
			</div>
			<p class="lh-20"><strong class="c-005aab">当前网点：${siteName }</strong></p> 
			<div class="tableWrap mt-10 " style="max-height: 320px; overflow: auto;">
				<table class="table table-bordered table-border table-bg text-c table1 " >
					<thead>
						<tr>
							<th class="w-170 text-c"><strong class="f-13">所在地区</strong> </th>
							<th class="w-170 text-c"><strong class="f-13">二级网点</strong></th>
							<th class="w-170 text-c"><strong class="f-13">品牌品类</strong></th>
							<th class="w-140 text-c"><strong class="f-13">选择</strong></th>
						</tr>
					</thead>
					<tbody id="zhijiepaidan1">
						
					</tbody>
				</table>
			</div>
			<div class="mt-20 pt-10 pb-5 bk-gray bg-e8f2fa">
				<div class="pos-r pl-70 pr-10 mb-5">
					<label class="w-70 pos"><em class="mark">*</em>转派原因：</label>
					<textarea class="textarea h-40 mustfill" id="zpReson"></textarea>
				</div> 
				<div class="pos-r pl-60 pr-80">
					<label class="pos w-60"><em class="c-fe0101">派工至</em>：</label>
					<p class="lh-30"><span id="disPatchSiteName1"></p>
					<input type="button" class="w-70 sfbtn sfbtn-opt3 pos-a" style="right: 10px;top: 0;" onclick="dispa1()" value="确认派工" />
				</div>
			</div>
				
			
		</div>
	</div>
</div>

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef" ></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/city.union.js"></script>
<script type="text/javascript">
var definedContentCd="";
var definedContentTz="";
var limitCount=0;
var mark="";
var orderMsgId="";
var changeMark = true;
var orderMsgMobile="";
var isCheck="";
var customerPrice="";
var ctx='${ctx}';
var feedImgsCount = '${duringFeedImgsCount}';
var siteId = '${order.columns.site_id}';

$("#cloZongDiv").on("click",function(){
	parent.search();
});

$(function(){
	
	 $('.dropdown-sin-2').dropdown({
	        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
	    });
	
	if('${haveData}'=="1"){
		layer.msg("没有上一条数据了");
	}
	if('${haveData}'=="2"){
		layer.msg("没有下一条数据了");
	}
	if(feedImgsCount==8){
		$("#jiahao").addClass('hide');
	} 

	if($.trim('${order.columns.customer_mobile}')!=null && $.trim('${order.columns.customer_mobile}')!="" ){
		orderMsgMobile=$.trim('${order.columns.customer_mobile}');
	}
	orderMsgId='${order.columns.id}';

	codeNumberCounts();
	
	$('#empSearchName').keyup(function(){
		$('#zhijiepaidan tr').hide()     
			.filter(":contains('" +($(this).val()) + "')").show();
		if(isBlank($(this).val())){
			$('#zhijiepaidan tr').show();
		}
	}).keyup();//DOM加载完时，绑定事件完成之后立即触发
	$("#origin").select2();
	$(".selection").css("width","120px");
	
	$('#applianceBrand').select2();
	$("#applianceBrand").next(".select2").find(".selection").css("width","160px");
	
	$('#applianceCategory').select2();
	$("#applianceCategory").next(".select2").find(".selection").css("width","120px");

    $("#pleaseReferMall").select2({tags:true});
    $("#pleaseReferMall").next(".select2").find(".selection").css("width","120px");

    $('#stateBox .selectLabel').on('click', function () {
        $('#stateBox .selectLabel').removeClass('selectedLabel');
        $(this).addClass('selectedLabel');
    })
    
    $('#bjNavBox .tabswitch').each(function(i){
    	$(this).on('click', function(){
    		 $('#bjNavBox .tabswitch').removeClass('current');
    		 $(this).addClass('current');
    		 $('#bjNavBox2 .caption_lb').hide().eq(i).show();
    		 $('#bjNavBox2 .sfbtn').hide().eq(i).show();
        })
    })
});

function getDefaultAddress(){
	$.ajax({
		type: "POST",
		url: "${ctx}/order/getDefaultAddress",
		datatype:"text",
		success: function (result) {
			$("#pcd").citySelect({
				url:'${ctxPlugin}/lib/city.min.js',
		        address:result
		    });
		},
		error: function () {
			layer.msg("系统繁忙!");
			return;
		},
		complete: function () {
		}
	});
}
//返回一级网点
function returnSiteOrder() {
    var orderId = $('#orderId').val();
    if (isBlank(orderId)) {
        layer.msg("数据有误！");
    } else {
        $('body').popup({
            level: '3',
            type: 2,  // 提示是否进行某种操作
            content: '确定要返回一级网点待派工吗？',
            fnConfirm: function () {
                $.ajax({
                    url: "${ctx}/secondOrder/returnSiteOrder",
                    type: 'post',
                    data: {
                    	orderId: orderId
                    },
                    success: function(data) {
                        if ('500' === data.code) {
                            layer.msg("工单是不可返回的工单，不能操作返回一级网点！")
                        } else if('200' === data.code) {
                            layer.msg("返回成功！");
                        } else if('422' === data.code) {
                            layer.msg("工单已被转派！");
                        } else if('423' === data.code) {
                            layer.msg("自建工单不可退回！");
                        }
                        parent.search();
                        $.closeAllDiv();
                    },
                    error: function() {
                    }
                });
            },
            fnCancel: function () {
            }
        });
    }
}

function closeAll(){
	$.closeAllDiv();
}


	function toggleMirror(isMirror) {
		if(!isMirror) {
			$("#applanceBrandMirror").hide();
			$("#applianceCategoryMirror").hide();
			$("#applianceCategory").show();
			$("#applianceBrand").show();
		} else {
			$("#applanceBrandMirror").show();
			$("#applianceCategoryMirror").show();
			$("#applianceCategory").hide();
			$("#applianceBrand").hide();
		}
	}
	
	//获取工单关联旧件信息
	function showOldFitting(){
		var orderNumber = "${order.columns.number}";
		var str="";
		var imgstr="";
		$.ajax({
			url:"${ctx}/order/showOldFitting",
			data:{orderNumber:orderNumber,siteId:siteId},
			dataType:'json',
			async:false,
			success:function(result){
				$(".oldtbody").empty();
				$("#oldfittingimg").html("<label class='lb lb1'>旧件图片：</label>");
				if(result.list.length>0){
				$.each(result.list,function(index,val){
					str+="<tr>"+
					"<td class='w-180'>"+val.columns.code+"</td>"+
					"<td class='w-260'>"+val.columns.name+"</td>"+
					"<td class='w-120'>"+val.columns.version+"</td>"+
					"<td class='w-100'>"+val.columns.brand+"</td>";
					if(val.columns.yrpz_flag=="1"){
						str+="<td class='w-70'>是</td>";
					}else if(val.columns.yrpz_flag=="2"){
						str+="<td class='w-70'>否</td>";
					}
					str+= "<td class='w-50'>×"+val.columns.num+"</td>";
					if(val.columns.status=="0"){
						str+="<td class='w-70'>已登记</td>";
					}else if(val.columns.status=="1"){
						str+="<td class='w-70'>已入库</td>";
					}else if(val.columns.status=="3"){
						str+="<td class='w-70'>已返厂</td>";
					}else if(val.columns.status=="4"){
						str+="<td class='w-70'>已报废</td>";
					}
					str+= "<td class='w-50'>"+val.columns.cateTime+"</td>";
 					str+="</tr class='w-100'>";


                    var images=val.columns.img.split(",");
                    for(var i=0;i<images.length;i++){
                        imgstr+= "<div class='f-l mr-10'><div class='imgWrap w-120 text-c'><img src='${commonStaticImgPath}"+images[i]+"'></img>";
                        imgstr+= "<p class='lh-20'>"+val.columns.cateTime+" </p></div></div>";
                    }
				});	
 				
				}else{
					$("#oldfittingimg").html("");
				}
				
				$(".oldtbody").append(str);
                jQuery.getScript("${ctxPlugin}/static/h-ui.admin/js/imgShow.js", function(data, status, jqxhr) {
                    $("#oldfittingimg").append(imgstr);
                    $('#oldfittingimg').imgShow();
                });
				return;
			}
			
		});
	}



$(function(){
	$("#xggd").click(function(){
		$("#origin1").hide();
		$("#origin").removeClass("hide");
		var markMobile = '${order.columns.customer_mobile}';
		var firstNumber = "";
		if(markMobile!=null && markMobile!=""){ //如果联系方式的第一位为0，则为固话
			firstNumber = markMobile.substring(0,1);
		}
		var html='<span class="f-r pr-5">:</span>';
		html+='<select class="lb-sel f-r readonly select" style="width:75px" disabled="disabled" id="mobileOrtel">';
		if(firstNumber=="0"){
			html+='<option value="1"  >手机号码</option>';
			html+='<option value="2" selected="selected">固定电话</option>';
		}else{
			html+='<option value="1" selected="selected">手机号码</option>';
			html+='<option value="2" >固定电话</option>';
		}
		html+='</select>';
		html+='<em class="mark f-r">*</em>';
		$("#mobileType").empty().append(html);
		
		if($(this).val()!="保存"){
			/* toggleMirror(false); */
			$(".sbtn").prop("disabled", true);
			$("input[type='text']").removeClass("readonly");
			$("#factoryNumber").removeClass("readonly");
			$("#factoryNumber").removeAttr("readonly");
			$("#factoryNumber").removeAttr("disabled");
			$("#promiseTime").removeClass("readonly");
			$("#buyDate").removeClass("readonly");
			$("select").removeClass("readonly");
			$("textarea").removeClass("readonly");
			$(".priceWrap").removeClass("readonly");
			
			
			$("#promiseTime").prop("disabled",false);
			$("#buyDate").prop("disabled",false);
			//$("input[type='text']").prop("disabled",false);
			$("input[type='text']").prop("readonly",false);
			$("textarea").prop("readonly",false);
			$("#showProvince").css("display","");
			$("#showCity").css("display","");
			$("#showArea").css("display","");
			$("select").prop("disabled",false);
			$(".dischange").addClass("readonly");
			$(".dischange").prop("readonly",true);
			
			$("#serviceType").addClass("mustfill");
			$("#serviceMode").addClass("mustfill");
			$("#customerName").addClass("mustfill");
			$("#customerMobile").addClass("mustfill");
			$("#customerAddress1").addClass("mustfill");
			$("#applianceBrand").addClass("mustfill");
			$("#applianceCategory").addClass("mustfill");
			//$("#customerFeedback").addClass("mustfill");
			$("#styleMark .select2-selection--single").css({'background-color': '#dbf5fd','border':'1px solid #5ebdfb'});

			$(".mark").text("*");
			
			$("input[name='fankui']").addClass("readonly");
			$("input[name='fankui']").prop("readonly",true);
			$(".combo-arrow").addClass("textbox-icon-disabled");
			$("#_easyui_textbox_input1").css("display",true);
			$("#_easyui_textbox_input1").prop("disabled",true);
			/*$("#customerAddress1").css({'width':'480px'});*/
			
			$("#repeatOrder").addClass("sfbtn-disabled");
			$(".btnMenubox").find("input").addClass("sfbtn-disabled");
			$(this).removeClass("sfbtn-disabled");
			$(this).after("<input id='qxgf' class='sfbtn sfbtn-opt' onclick='getoff()'  value='取消' type='button'/>");
			$(this).val("保存");

		}else{
			var mobileOrtel = $("#mobileOrtel").val();
			var serviceType = $("#serviceType").val();
			var serviceMode = $("#serviceMode").val();
			var customerName = $.trim($("#customerName").val());
			var customerMobile = $("#customerMobile").val();
			var customerTelephone = $("#customerTelephone").val();
			var customerTelephone2=$("#customerTelephone2").val();
			var customerAddress = $("#customerAddress1").val();
			var applianceBrand = $("#applianceBrand").val();
			var applianceCategory = $("#applianceCategory").val();
			var customerFeedback = $.trim($("#customerFeedback").val());
			
			
			var moliereg= /^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][34578][0-9]{9}$)$/;
			var mtel=/^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/;
			var tel = /(^1\d{10}$)|(^(\d{3,4}\-)?\d{5,9}$)/;
			if(isBlank(serviceType)){
				layer.msg("服务类型为必填项");
				return;
			}
			if(isBlank(serviceMode)){
				layer.msg("服务方式为必填项");
				return;
			}
			var factoryNumber = $("#factoryNumber").val();
			if('${order.columns.record_account}'=='1'){
				if(isBlank(factoryNumber)){
					layer.msg("请填写厂家工单编号");
		            $("#factoryNumber").focus();
		            return;
				}
				if ($.trim(factoryNumber).length > 32) {
		            layer.msg("厂家工单编号过长");
		            $("#factoryNumber").focus();
		            return;
		        }
			}
			if(isBlank(customerName)){
				layer.msg("用户姓名为必填项");
				return;
			}

				if(!isBlank(customerMobile)){
					//if(!moliereg.test($.trim(customerMobile))){
						if(!tel.test($.trim(customerMobile))){
							layer.msg("请输入正确的联系方式");
							$("#mobileOrtel").prop("disabled",false);
							$("#mobileOrtel").removeClass("readonly");
							if(mobileOrtel == "1"){
								 $("#mobileOrtel").val("手机号码");
							}else{
								 $("#mobileOrtel").val("固定电话");
							}
							return;
						}
					//}
				}else{
					layer.msg("请输入联系方式");
					return;
				}
				if(!isBlank(customerTelephone)){
					if(!mtel.test($.trim(customerTelephone))){
						layer.msg("请输入正确的联系方式2");
						return;
					}
					
				}
				if(!isBlank($.trim(customerTelephone2))){
					if(!mtel.test(customerTelephone2)){
						layer.msg("请输入正确的联系方式3");
						return;
					}
					
				}


			if(isBlank(customerAddress)){
				layer.msg("详细地址为必填项");
				return;
			}
			if(isBlank(applianceBrand)){
				layer.msg("家电品牌为必填项");
				return;
			}
			if(isBlank(applianceCategory)){
				layer.msg("家电品类必填项");
				return;
			}

                $("#customerAddress").val($("#customerAddress1").val());
                $.ajax({
                    url: "${ctx}/order/orderDispatch/update",
                    type: "post",
                    data: $("#updateOrder").serialize(),
                    success: function () {
                        parent.search();
//					$.closeDiv($(".orderdetailVb"));
                        window.location.reload();
                    }
                });
                return;
           
		}
	});
});
</script>

<script type="text/javascript">
function cancelCloseOrder() {
	$.closeDiv($(".fbOrder"), true);
}
function updateDispatchStatus(callback) {
	$.ajax({
		type: "post",
		url: "${ctx}/order/orderDispatch/updateDispatchStatusToYJD?oid=${order.columns.id}",
		success: function() {
			callback.call();
		}
	});
}
function showFeedbackPopup() {
	$('#fbBaseInfo .tabswitch').each(function(index){
		$(this).on('click', function(){
			if(index == 1){
				$('.btn-usebj').show();
			}/* else{
				$('#btn-usebj').hide();
			} */
		})
	});
	$('#bjNavBox .tabswitch').removeClass('current').eq(0).addClass('current');
	$('#bjNavBox .sfbtn').hide().eq(0).show();
	fittingApply("pjmg");
	$('.fbOrder').popup({level:2, closeSelfOnly: true,fixedHeight:false});
}

var ck = /^\d+(\.\d+)?$/;
	$(function(){
		$.Huitab("#detialWd .tabBarP .tabswitch","#detialWd .tabCon","current","click","0");
		$.Huitab("#serveFb .tabBarP .tabswitch","#serveFb .tabCon","current","click","0");
		$.Huitab("#fbBaseInfo .tabBarP .tabswitch","#fbBaseInfo .tabCon","current","click","0");

		$(".codeConnectShow").bind('click', function () {
			var code = $(this).parent(".wrapss").find("input").val();
	        layer.open({
	            type : 2,
	            content:'${ctx}/order/showHistoryPopupDetail?code=' + code+'&id='+'${order.columns.id}',
	            title:false,
	            area: ['100%','100%'],
	            closeBtn:0,
	            shade:0,
	            anim:-1
	        }); 
	    });
		
		$('.orderdetailVb').popup({fixedHeight:false});
		$('#wxImgList').imgShow();
		
		$("input.autoCal").change(function(){
			var sum = 0;
		    $("input.autoCal").each(function(){
		    	if(testCash($(this).val())){
		       		sum = numAdd(sum, $(this).val());
		      	}else if($(this).val() !=''){
		       		$(this).val(""); 
		      	} 
		      	$("#total_cost").val(sum); 
		    }); 
		});

		$('#btn-fbOrder').bind('click', function () {
			$.ajax({
				type: "POST",
				url: "${ctx}/order/orderDispatch/queryDispatchStatus?oid=${order.columns.id}",
				success: function (data) {
					if ('1' == data.status) {
						$('body').popup({
							level: '3',
							type: 2,  // 提示是否进行某种操作
							content: '服务工程师${order.columns.employe_name}未接单，您确认继续反馈封单吗？',
							fnConfirm: function () {
								updateDispatchStatus(function () {
									showFeedbackPopup();
								});
							},
							closeSelfOnly: true
						});
					} else {
						showFeedbackPopup();
					}
				},
				error: function () {
					layer.msg("数据加载失败，请重试！");
				}
			});
		});
		
		$("input.sfbtn.sfbtn-opt3").click(function(){
			$(".lb.lb1").removeClass("readonly");
		});
		
		
		// 选择品类时获取服务商维护对应的品牌
		$("#applianceCategory").change(function(){
			   var brand = $("#applianceBrand").val(); 
		       var cate = $("#applianceCategory").val();
		 			$.ajax({
		 				type:"post",
		 				url:"${ctx}/order/getBrand",
		 				data:{
		 					category:cate,siteId:siteId
		 				},
		 				dataType:"json",
		 				success:function(data){
		 					var obj = eval(data);
		 					$("#applianceBrand").empty();
		 					 if(obj.count == 2){
		 						layer.msg("没有相关品牌，请维护");
		 					 }else{
		 					 var HTML = " <option value=''>请选择</option> ";	
		 					$.each(obj.brand,function(key,values){     
		 						if(brand ==values){
		 							HTML += '<option value="'+values+'" selected = "selected" >'+key+'</option>';
		 						}else{
		 						HTML += '<option value="'+values+'">'+key+'</option>';
		 						}
		 					       
		 					 }); 
		 					$("#applianceBrand").append(HTML); 
		 					 }
		 				}
		 			});
		 		 
			});

		// 选择品牌时获取服务商维护对应的品类
		$("#applianceBrand").change(function () {
			var cate = $("#applianceCategory").val();
			var brand = $("#applianceBrand").val();
			$.ajax({
				type: "post",
				url: "${ctx}/order/getCategory",
				data: {
					brand: brand,siteId:siteId
				},
				dataType: "json",
				success: function (data) {
					var obj = eval(data);
					$("#applianceCategory").empty();
					if (obj.count == 2) {
						layer.msg("没有相关品类，请维护");
					} else {
						var HTML = " <option value=''>请选择</option> ";
						$.each(obj.cate, function (key, values) {
							if (cate == values) {
								HTML += '<option value="' + values + '" selected = "selected" >' + key + '</option>';
							} else {
								HTML += '<option value="' + values + '">' + key + '</option>';
							}

						});
						$("#applianceCategory").append(HTML);
					}
				}
			});
		});
		
		
	});

	$('#btn_showImg').on('click', function(){
		$('#wxImgList img').eq(0).click();
	})


	function ReplaceEmploye(){
            $("input[name='feedbackType']").val("2");
            //alert($("input[name='pickerImg']").val());
			var feedback = $("#feedback").val();
				if(isBlank(feedback)){
					layer.msg("请输入反馈描述");
					return ;
				}
				$.ajax({
					url: "${ctx}/order/orderDispatch/ReplaceEmploye",
					type: "POST",
					data: $('#generationOrderFrom').serialize(),
					async: false,
					success: function(result) {
			        	if(result == "ok"){
							layer.msg('反馈成功');
							setTimeout(function(){
								parent.search();
								parent.numerCheck();
								$.closeDiv($('.fbOrder')); 
								$.closeDiv($('.orderdetailVb')); 
								parent.closeBatchForms();
								$('#Hui-article-box',window.top.document).css({'z-index':'9'});
							},500);
						}else {
							$("#butnAdd").show();
							layer.msg("反馈失败!", {time:2000});
						}
					}
				});  
				
			return false;
		}

	
$('#generationOrderFrom').Validform({
	btnSubmit:"#Butorder",
	postonce:true,
	tiptype:function(msg){
		 if(!isBlank(msg)){
			layer.msg(msg);
			} 
		},
	callback: function(form) {
            $("input[name='feedbackType']").val("1");
			var count = $("#count1").val();
			if(parseInt(count) > 0){
				$('.promptBox1').popup({level:4});
			}else{
				$.ajax({
					url: "${ctx}/order/orderDispatch/ReplaceEmploye",
					type: "POST",
					data: form.serialize(),
					async: false,
					success: function(result) {
			        	if(result == "ok"){
							layer.msg('代反馈成功');
							setTimeout(function(){
								parent.search();
								parent.numerCheck();
								$.closeDiv($('.fbOrder')); 
								$.closeDiv($('.orderdetailVb')); 
								parent.closeBatchForms();
								$('#Hui-article-box',window.top.document).css({'z-index':'9'});
							},500);
						}else {
							$("#butnAdd").show();
							layer.msg("代反馈失败!", {time:2000});
						}
					}
				}); 
			}
			return false;
		}
});

var adpoti = false;
function continueConfirm(){//generationOrderFrom
	if(adpoti) {
	    return;
    }
	adpoti = true;
	$.ajax({
		url: "${ctx}/order/orderDispatch/ReplaceEmploye",
		type: "POST",
		data: $("#generationOrderFrom").serialize(),
		success: function(result) {
        	if(result == "ok"){
				layer.msg('代反馈成功');
				setTimeout(function(){
					window.parent.location.reload(true);
					window.location.href="${ctx}/operate/site/saveTableHeader";
					$('#Hui-article-box',window.top.document).css({'z-index':'9'});
					
				},500);
			}else {
				$("#butnAdd").show();
				layer.msg("代反馈失败!", {time:2000});
			}
		},
        complete: function() {
            adpoti = false;
        }
	}); 
}

function cancelFendan(){
	$.closeDiv($(".promptBox1"));
	$.closeDiv($(".fbOrder"));
	window.location.reload();
	$('#Hui-article-box',window.top.document).css({'z-index':'9'});
}


	var adpot = false;
	function saveCallback(){
		if(adpot) {
		    return;
	    }
		adpot = true;
		var postData = $("#callback_form").serializeJson();
		$.post('${ctx}/order/orderCallback/saveCallback', postData, function(result){
			 adpot = false;
		});
	}
	
	var adpo = false;
	function saveSettlement(){
		if(adpo) {
		    return;
	    }
		adpo = true;
		var postData = $("#seltment_form").serializeJson();
		$.post('${ctx}/order/orderSettlemnt/saveSettlement', postData, function(result){
			 adpo = false;
		});
	}
		function isBlank(val) {
			if(val==null || val=='' || val == undefined) {
				return true;
					}
			return false;
		}
	
		function cost(){
			var wa = $("#warrantyCost").val();
			var au = $("#auxiliaryCost").val();
			var se = $("#serveCost").val();
			if(isBlank(wa)){
				wa = 0.00;
			}
			if(isBlank(au)){
				au = 0.00;
			}
			if(isBlank(se)){
				se = 0.00;
			}
			if(ck.test(se)&&ck.test(au)&&ck.test(wa)){
			var coun = parseFloat(se)+parseFloat(au)+parseFloat(wa);
			$("#zongCost").val(coun);
			}else{
				layer.msg("输入的价格格式错误");
			}
		}
	$(function(){
		createUploader("#filePicker-add","#Imgprocess","file_fake_addimg","file_fake_add","delpickerImg");
		createUploader('#filePicker-mdd','#ImgprocessPJ','','','');
	}); 
	function createUploader(picker,site, el,id,delimg) {
		var thumbnailWidth = 130;   //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档  
		var thumbnailHeight = 130; 
		var upSrc="";
		uploader = WebUploader.create({
		       // 选完文件后，是否自动上传。 
		       auto: true,  
		       swf: '${ctxPlugin}/lib/webuploader/0.1.5/Uploader.swf',  
		       server: '${ctx}/common/uploadFile',
		       
		       duplicate:true,
		       fileSingleSizeLimit:1024*1024*5,
		       pick: picker,  
		       accept: {  
		    	    title: 'Images',
		    	    extensions: 'gif,jpg,jpeg,bmp,png',
		    	    mimeTypes: 'image/gif,image/jpg,image/jpeg,image/bmp,image/png'
		       },
		       method:'POST'
		   }); 
		   uploader.on("error",function (type){
		   if (type=="Q_TYPE_DENIED"){ 
			   layer.msg("请上传JPG、PNG格式文件");
			   }else if(type=="F_EXCEED_SIZE"){
				   layer.msg("文件大小不能超过5M"); }
		   });
		   
		   uploader.on('beforeFileQueued', function(file){
		   });
		   uploader.on( 'uploadSuccess', function( file, response) {
			   $("input[name='markAble']").each(function(index,items){
					if(items.value==file.id){
						$(site).append('<input type="hidden"  name="pickerImg" id="pickerImg'+file.id+'" value="'+response.path+'">');
					}
				}) 
		   });
		   uploader.on( 'uploadError', function( file, reason ) {
				
		   }); 
		   uploader.on( 'uploadFinished', function() {
				if(uploader){
					uploader.reset();
				}
		   }); 
		   
		  
		   uploader.on( 'fileQueued', function( file ) {
			   if(feedImgsCount>=7){
				  $("#jiahao").addClass('hide');
			   }
			   if(parseInt(feedImgsCount) > 7 ){
				   layer.msg("最多可上传8张图片！");
				   return false;
			   }
		   uploader.makeThumb( file, function( error, src ) {
			   if (error) {
				    layer.msg('不能预览');
			   } else {
				   img(id,src,file,site);
			   }
		}, thumbnailWidth, thumbnailHeight );
		});    
		   
	}
	
	function delx(obj,fileId) {
		$("#file"+fileId+"").remove();
		$("#mark"+fileId+"").remove();
		$(obj).parent('.imgWrap1').remove();
		$("#pickerImg"+fileId).remove();
		feedImgsCount = feedImgsCount-1;
		if(feedImgsCount<=7){
			$("#jiahao").removeClass('hide');
		}
    	return ;
	} 
	function img(id,src,file,site){
		if(feedImgsCount > 7){
			$("#jiahao").addClass('hide');
			layer.msg("最多可上传8张图片！");
			return false;
		}
		feedImgsCount=parseInt(feedImgsCount)+1;  
		var html =' <div class="f-l imgWrap1 mb-10" id="file'+file.id+'"><div class="imgWrap"> ';
		html +='<img src="'+src+'" id=""></div><a class="sficon btn-delimg" onclick="delx(this, \''+file.id+'\')"></a></div>'+
				'<input name="markAble" id="mark'+file.id+'" hidden="hidden" value="'+file.id+'" />';
		$(site).append(html);
		if(feedImgsCount>=8){
			$("#jiahao").addClass('hide');
		}
	}
	
	var adp = false;
	function Turntosend(lat,address){
		if(adp) {
		    return;
	    }
		adp = true;
		var orderid = "${order.columns.id}";
		$.ajax({
			url:"${ctx}/order/count2",
			data:{orderId:orderid},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
			dataType:'json',
			success:function(result){
				if(parseInt(result) > 0){
					layer.msg("工单有未审核的备件申请记录，请审核后再转派！");
				}else{
                    $("#arroundUserInfo").empty();
                    $("#arroundCustomerAddress").val('${order.columns.customer_address}');

					$.selectCheck2("serverSelected");
					$('.turnDispatch').popup({level: 2, closeSelfOnly: true});
					initDispatchMap(lat);
					employe(lat,address);
				}
			},
            complete: function() {
                adp = false;
            }
		})
	}


function returnMobile(val1,val2,val3){
    var mobile=$.trim(val1);
    if(isBlank(mobile)){
        mobile= $.trim(val2);
    }
    if(isBlank(mobile)){
        mobile= $.trim(val3);
    }
    if(isBlank(mobile)){
        mobile= "";
    }
    return mobile;
}


function guanbi(){
    $.closeDiv($(".massTextNote"));
}

function closePopup(){
    $.closeDiv($(".massTextNote"));
}


	function initDispatchMap(la) {
		if (!dispatchMap) {
			dispatchMap = new AMap.Map('dispatch_map_container', {
				zoom: 12
			});
	
					dispatchMarker = new AMap.Marker({
						 map:dispatchMap,
				    	 draggable:true
					});
		  
					if(!isBlank(la)){
		 			var lnglats = la.split(",");
		 			var position = new AMap.LngLat(lnglats[0], lnglats[1]);
		 			dispatchMap.setZoomAndCenter(12, position);
		 			dispatchMarker.setPosition(position);
					}
			employeMarker = new AMap.Marker({});
		}
		employeMarker.setMap(null);
	} 

	function employe(lnglat,address) {
	//	var lnglat = $("#lnglat").val();
		var category = $('#applianceCategory').val();
		$.ajax({
			type : "POST",
			url : "${ctx}/operate/employe/dispatchList",
			data : {
				lnglat :lnglat,
				category:category,
				address:address
			},
			success : function(data) {
				var content = $("#zhijiepaidan");
				content.empty();
				var sites = data;
				var appendHtml = '';
				for (var i = 0; i < sites.length; i++) {
					var item = sites[i].columns;
					appendHtml +='<tr>'
					+'<td style="border-left: none;">'+item.name+'</td>'
					+ '<td>' + item.sywwg + '</td>'
					+'<td>'+item.wwg+'</td>'
					 +'<td>'+item.jrywg+'</td>' 
					+'<td><label class="label-cbox3" for="'+item.id+'"><input type="checkbox" name="serverSelected" id="'+item.id+'"></label></td>'
					+'</tr>';
				}
				if(isBlank(appendHtml)){
					 layer.msg("服务工程师没有维护"+category+"服务品类，请先维护");
				}
				content.html(appendHtml);
				
				$("#zhijiepaidan tr").each(function(index) {
					$(this).data("emp", sites[index].columns);
				});
				$("#zhijiepaidan tr").on('click', function(ev) {
					var name = ev.target.tagName.toLowerCase();
					if(name == 'label') return;
					var flag = $(this).hasClass('checked');
					if (flag) {
						$(this).removeClass('checked');
					} else {
						$(this).attr("class","checked");
						$.trim($(this).children('td').eq(0).html())
					} 
					$("#nameWrap").empty();
					var name="";
					var id = "";
					$("#zhijiepaidan tr").each(function(index) {
						var flag = $(this).hasClass('checked');
						if (flag) {
							if(isBlank(name)){
								name = $.trim($(this).children('td').eq(0).html());
							}else{
								name = name+" "+ $.trim($(this).children('td').eq(0).html());
							}
							if(isBlank(id)){
	                 			id= $.trim($(this).children('td').eq(4).children('label').attr('for'));
							}else{
								id= id+","+$(this).children('td').eq(4).children('label').attr('for');
							}
						} 
					});
					$("#nameWrap").append("<span>"+name+"</span>");
					$("#employeId").val(id);
			 
				});
			}
		});
	}
	//确认派工按钮
	var confirmDispa = false;
	function dispa(){
		if(confirmDispa) {
		    return;
	    }
		var empId= $("#employeId").val();
		var orderId = $("#orderId").val();
		var disorderId = $("#disorderId").val();
		var transferReasons = $.trim($("#transferReasons").val());
		if(isBlank(empId)){
			layer.msg("请选择服务工程师");
		}else if(isBlank(transferReasons)){
			layer.msg("请输入转派原因");
			$("#transferReasons").focus();
		}else{
		var name=$.trim($("#nameWrap").children('span').html());
			$('body').popup({
				level: '3',
				type:2,  // 提示是否进行某种操作
                content: '确认派工至' + name + '吗？',
				fnConfirm: function () {
					confirmDispa = true;
					$.ajax({
						type : "POST",
						url : "${ctx}/order/orderDispatch/Redispatch",
						data :{
							orderId :orderId,
							empId :empId,
							disorderId :disorderId,
							transferReasons:transferReasons,
							path: "orderDuringForm"
						},
						success : function(data) {
							if(data){
								layer.msg('已派工!');
								parent.search();
								parent.numerCheck();
								$.closeDiv($('.turnDispatch')); 
								$.closeDiv($('.orderdetailVb'));
								parent.closeBatchForms();
								$('#Hui-article-box',window.top.document).css({'z-index':'9'});
							}else{
								layer.msg('派工失败!');
							}
						},
			            complete: function() {
							confirmDispa = false;
			            }
					}); 
				},
				fnCancel: function () {
				}
			});
		}
		}

	function select(id,val){
		if(!isBlank(val)){
			var select = document.getElementById(id);
			for (var i = 0; i < select.options.length; i++){  
		        if (select.options[i].value == val){  
		        	select.options[i].selected = true;  
		            break;  
		        }  
			} 
		}
	}
	

	function getoff(){
		window.location.reload();
	}
function address() {
    var sz = [];
    var address = $("#customerAddress").val();
    if (address.indexOf("区") > 0 && address.indexOf("县") <= 0 && address.indexOf("市") < 0) {
        sz = address.split("区");
        if (sz.length > 2) {
            var strs = "";
            for (var i = 1; i < sz.length; i++) {
                if (i != sz.length - 1) {
                    strs += sz[i] + "区";
                } else {
                    strs += sz[i];
                }
            }
            $("#customerAddress1").val(strs);
        } else if (1 < sz.length <= 2) {
            $("#customerAddress1").val(sz[1]);
        } else {
            $("#customerAddress1").val(sz[0]);
        }
    }else if (address.indexOf("县") > 0 && address.indexOf("市") < 0) {
        sz = address.split("县");
        if (sz.length > 2) {
            var strs = "";
            for (var i = 1; i < sz.length; i++) {
                if (i != sz.length - 1) {
                    strs += sz[i] + "县";
                } else {
                    strs += sz[i];
                }
            }
            $("#customerAddress1").val(strs);
        } else if (1 < sz.length <= 2) {
            $("#customerAddress1").val(sz[1]);
        } else {
            $("#customerAddress1").val(sz[0]);
        }
    }else if(address.indexOf("县") > 0 && address.indexOf("市") > 0){
        var ciAd=address.indexOf("市");
        var xaAd=address.indexOf("县");
        if(parseInt(ciAd) < parseInt(xaAd)){//市在前
            sz = address.split("市");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "市";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress1").val(strs);
            } else if (sz.length == 2) {
                $("#customerAddress1").val(sz[1]);
            } else {
                $("#customerAddress1").val(sz[0]);
            }
        }else if(parseInt(ciAd) > parseInt(xaAd) ){//县在前
            sz = address.split("县");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "县";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress1").val(strs);
            } else if (1 < sz.length <= 2) {
                $("#customerAddress1").val(sz[1]);
            } else {
                $("#customerAddress1").val(sz[0]);
            }
        }
    }else if(address.indexOf("市") > 0 && address.indexOf("区") < 0){
        sz = address.split("市");
        if (sz.length > 2) {
            var strs = "";
            for (var i = 1; i < sz.length; i++) {
                if (i != sz.length - 1) {
                    strs += sz[i] + "市";
                } else {
                    strs += sz[i];
                }
            }
            $("#customerAddress1").val(strs);
        } else if (sz.length == 2) {
            $("#customerAddress1").val(sz[1]);
        } else {
            $("#customerAddress1").val(sz[0]);
        }
    }else if (address.indexOf("市") > 0 && address.indexOf("区") > 0) {
        var ciAd=address.indexOf("市");
        var quAd=address.indexOf("区");

        if(parseInt(ciAd) < parseInt(quAd)){//市在前
            sz = address.split("市");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "市";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress1").val(strs);
            } else if (sz.length == 2) {
                $("#customerAddress1").val(sz[1]);
            } else {
                $("#customerAddress1").val(sz[0]);
            }
        }else if(parseInt(ciAd) > parseInt(quAd) ){//区在前
            sz = address.split("区");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "区";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress1").val(strs);
            } else if (1 < sz.length <= 2) {
                $("#customerAddress1").val(sz[1]);
            } else {
                $("#customerAddress1").val(sz[0]);
            }
        }
    } else if (address.indexOf("区") <= 0 && address.indexOf("县") <= 0 && address.indexOf("市") <= 0) {
        $("#customerAddress1").val(address);
    }
    var province = $("#province").val();
    var city = $("#city").val();
    var area = $("#area").val();
    if (isBlank(province) || isBlank(city) || isBlank(area)) {
        getDefaultAddress();
    }
}

	
	
	function fittingApply(id){
		var orderNumber = "${order.columns.number}";
		var str="";
		var imgstr="";
		var img = [];
		$.ajax({
			url:"${ctx}/order/showSYMsg",
			data:{orderNumber:orderNumber,remark:'SYMsg',siteId:siteId},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
			dataType:'json',
			async:false,
			success:function(result){
				/*if(id=="pjmg"){*/
					$("#"+id).html(""+
                        "<thead>" +
                        "<tr>" +
                        "<th class='w-180'>备件条码</th>" +
                        "<th class='w-260'>备件名称</th>" +
                        "<th class='w-120'>备件型号</th>" +
                        "<th class='w-90'>最新入库价格</th>" +
                        "<th class='w-80'>工程师价格</th>" +
                        "<th class='w-70'>零售价格</th>" +
                        "<th class='w-50'>数量</th>" +
                        "<th class='w-70'>收费金额</th>" +
                        "<th class='w-100'>使用类型</th>" +
                        "<th class='w-70'>状态</th>" +
                        "<th class='w-70'>操作</th>" +
                        "</tr>" +
                        "</thead>");
              /*  } else {
                    $("#" + id).html(
                        "<thead>" +
                        "<tr>" +
                        "<th class='w-180'>备件条码</th>" +
                        "<th class='w-260'>备件名称</th>" +
                        "<th class='w-120'>备件型号</th>" +
                        "<th class='w-90'>最新入库价格</th>" +
                        "<th class='w-80'>工程师价格</th>" +
                        "<th class='w-70'>零售价格</th>" +
                        "<th class='w-50'>数量</th>" +
                        "<th class='w-70'>收费金额</th>" +
                        "<th class='w-70'>状态</th>" +
                        "</tr>" +
                        "</thead>");
                }*/
				var auxiliaryCostSum=0.0;
				var warrantyCost1 = $("#warrantyCost").val();
				var serveCost1 = $("#serveCost").val();
				if(result.list.length>0){
					$.each(result.list,function(index,val){
                        str += "<tr>" +
                            "<td class='text-c w-140'>" + val.columns.fitting_code + "</td>" +
                            "<td class='text-c w-300'>" + val.columns.fitting_name + "</td>" +
                            "<td class='text-c w-120'>" + val.columns.fitting_version + "</td>" +
                            "<td class='text-c w-90'>" + val.columns.site_price + "</td>" +
                            "<td class='text-c w-80'>" + val.columns.employe_price + "</td>" +
                            "<td class='text-c w-70'>" + val.columns.customer_price + "</td>" +
                            "<td class='text-c w-50'>×" + val.columns.used_num + "</td>" +
                            "<td class='text-c w-70'>" + val.columns.collection_money + "</td>";

                            str+="<td class='text-c  w-100'>"+fmtVerificationTypeForOrder(val)+"</td>";

						if(val.columns.status=="1"){
							str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verifyPass'></i>待核销</td>";
						}else if(val.columns.status=="2"){
							str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>已核销</td>";
						}else if(val.columns.status=="3"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verify2nopass'></i>已拒绝</td>";
						}
						/*if(id=="pjmg"){*/
							if(val.columns.collection_money){
								auxiliaryCostSum+=val.columns.collection_money;
							}
							if(val.columns.status=="2"){//已核销，不显示删除
								str+="<td class='text-c c-fe0101 w-70'>---</td>";
							}else{
								str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteOneFit(\""+val.columns.id+"\",\""+dealSpecialSymbol(val.columns.fitting_name)+"\",\""+val.columns.used_num+"\")'><i class='sficon sficon-del'></i></a></td>";
							}
							
						//}
					});	
						$("#auxiliaryCost").val(auxiliaryCostSum);
						if(warrantyCost1!=null && warrantyCost1!=""){
							auxiliaryCostSum=auxiliaryCostSum + parseFloat(warrantyCost1);
						}
						if(serveCost1!=null && serveCost1!=""){
							auxiliaryCostSum=auxiliaryCostSum + parseFloat(serveCost1);
						}
						$("#zongCost").val(auxiliaryCostSum);
				}else{
						$("#auxiliaryCost").val(0.0);
						if(warrantyCost1){
							auxiliaryCostSum=auxiliaryCostSum + parseFloat(warrantyCost1);
						}
						if(serveCost1){
							auxiliaryCostSum=auxiliaryCostSum + parseFloat(serveCost1);
						}
						$("#zongCost").val(auxiliaryCostSum);
					$(".showimg").html("");
				}
				
				$("#"+id).append(str);
				
				return;
			}
			
		});
	}
	//备件申请记录
	function fittingApplyrecord(){
		var orderNumber = "${order.columns.number}";
		var str="";
		$.ajax({
			url:"${ctx}/order/showSQMsg",
			data:{orderNumber:orderNumber,remark:'SQMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
			dataType:'json',
			async:false,
			success:function(result){
				
					$("#pjmg").html(""+
                        "<thead>" +
                        "<tr>" +
                        "<th class='w-180'>备件条码</th>" +
                        "<th class='w-260'>备件名称</th>" +
                        "<th class='w-120'>备件型号</th>" +
                        "<th class='w-50'>数量</th>" +
                        "<th class='w-150'>审核备注</th>" +
                        "<th class='w-70'>状态</th>" +
                        "<th class='w-70'>操作</th>" +
                        "</tr>" +
                        "</thead>");
				if(result.list.length>0){
					$.each(result.list,function(index,val){
                        str += "<tr>" +
                            "<td class='text-c w-140'>" + val.columns.fitting_code + "</td>" +
                            "<td class='text-c w-300'>" + val.columns.fitting_name + "</td>" +
                            "<td class='text-c w-120'>" + val.columns.fitting_version + "</td>" +
                            "<td class='text-c w-50'>×" + val.columns.fitting_apply_num + "</td>" +
                            "<td class='text-c w-150'>" + val.columns.audit_marks + "</td>" ;
						if(val.columns.status=="0"){
							str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verifyPass'></i>待核销</td>";
							str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteFittingApply(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\")'><i class='sficon sficon-del'></i></a></td>";
						}else if(val.columns.status=="1"){
							str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>缺件中</td>";
							str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteFittingApply(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\")'><i class='sficon sficon-del'></i></a></td>";
						}else if(val.columns.status=="2"){
							str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>待出库</td>";
							str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteFittingApply(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\")'><i class='sficon sficon-del'></i></a></td>";
						}else if(val.columns.status=="3"){
							str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>待领取</td>";
							str+="<td class='text-c c-fe0101 w-70'>---</td>";
						}else if(val.columns.status=="4"){
							str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>可使用</td>";
							str+="<td class='text-c c-fe0101 w-70'>---</td>";
						}else {
							str+="<td class='text-c c-fe0101 w-70'>---</td>";
							str+="<td class='text-c c-fe0101 w-70'>---</td>";
						}
						
					});	
				
				}else{
					
					$(".showimg").html("");
				}
				
				$("#pjmg").append(str);
				
				return;
			}
			
		});
	}
	
	function deleteFittingApply(id,fittingName){
		$.ajax({
			type:"post",
			url:"${ctx}/fitting/fittingApply/checkFittingApplyplan",
			data:{id:id},
			success:function(data){
				if(data.code=="200"){
					layer.msg("该备件进行了备件计划，若要删除申请，请联系配件员拒绝此条申请记录!");
					return;
				}else if(data.code=="402"){
					layer.msg("删除失败，配件信息有误");
					return;
				}else{
		$('body').popup({
			level:'3',
			type:2,
			content:"您确定要删除备件申请"+fittingName+"?",
			closeSelfOnly: true,
			fnConfirm:function(){
				$.ajax({
					type:"post",
					url:"${ctx}/fitting/fittingApply/deleteFittingApply",
					data:{id:id,siteId:siteId},
					success:function(data){
						if(data.code=="200"){
							layer.msg("删除成功");
							fittingApplyrecord();
                            showSQMsg();
							//parent.closeBatchForms();
						}else if(data.code=="400"){
							layer.msg("删除失败，配件信息有误");
							return;
						}else{
							layer.msg("删除失败，请联系管理员");
							return;
						}
					}
				})
			}
		})
				}
			}
		});
	}
	
	function deleteOneFit(id,fittingName,num){
		$('body').popup({
			level:'3',
			type:2,
			content:"您确定要删除备件'"+fittingName+"'*"+num+"?",
			closeSelfOnly: true,
			fnConfirm:function(){
				$.ajax({
					type:"post",
					url:"${ctx}/order/deleteOneFittingRecord",
					data:{id:id,siteId:siteId},
					success:function(data){
						if(data.code=="200"){
							layer.msg("删除成功");
							fittingApply("pjmg");
                            fittingApply("pjsy");
							//parent.closeBatchForms();
						}else if(data.code=="421"){
							layer.msg("删除失败，使用记录有误");
							return;
						}else if(data.code=="422"){
							layer.msg("该配件已核销,不能删除");
							return;
						}else if(data.code=="423"){
							layer.msg("删除失败，配件信息有误");
							return;
						}else if(data.code=="424"){
							layer.msg("工程师不存在，不能删除");
							return;
						}else if(data.code=="425"){
							layer.msg("工程师库存信息有误，不能删除");
							return;
						}else if(data.code=="426"){
							layer.msg("删除失败，当前工程师库存信息有误");
							return;
						}else{
							layer.msg("删除失败，请联系管理员");
							return;
						}
					}
				})
			}
		})
		
	}
	
	//获取工单关联备件使用信息
	function showSYMsg(){
		fittingApply("pjsy");
	}

	
	//获取工单关联备件申请信息
	function showSQMsg(){
		var orderNumber = "${order.columns.number}";
		var str="";
		var imgstr="";
		var img = [];
		$.ajax({
			url:"${ctx}/order/showSQMsg",
			data:{orderNumber:orderNumber,remark:'SQMsg',siteId:siteId},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
			dataType:'json',
			async:false,
			success:function(result){
				mark=result.list.length;
				$("#pjsq").html(
                    "<thead>" +
                    "<tr>" +
                    "<th class='w-180'>备件条码</th>" +
                    "<th class='w-260'>备件名称</th>" +
                    "<th class='w-120'>备件型号</th>" +
                    "<th class='w-50'>数量</th>" +
                    "<th class='w-150'>审核备注</th>" +
                    "<th class='w-70'>状态</th>" +
                    "<th class='w-70'>操作</th>" +
                    "</tr>" +
                    "</thead>");
				$(".showimg").html("<label class='lb lb1'>备件图片：</label>");

                if(result.list.length>0){
                    $.each(result.list,function(index,val){
                        str += "<tr>" +
                            "<td class='text-c w-140'>" + val.columns.fitting_code + "</td>" +
                            "<td class='text-c w-300'>" + val.columns.fitting_name + "</td>" +
                            "<td class='text-c w-120'>" + val.columns.fitting_version + "</td>" +
                            "<td class='text-c w-50'>×" + val.columns.fitting_apply_num + "</td>" +
                            "<td class='text-c w-150'>" + val.columns.audit_marks + "</td>" ;
                        if(val.columns.status=="0"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verifyPass'></i>待审核</td>";
                            str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteFittingApply(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\")'><i class='sficon sficon-del'></i></a></td>";
                        }else if(val.columns.status=="1"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>缺件中</td>";
                            str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteFittingApply(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\")'><i class='sficon sficon-del'></i></a></td>";
                        }else if(val.columns.status=="2"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>待出库</td>";
                            str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteFittingApply(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\")'><i class='sficon sficon-del'></i></a></td>";
                        }else if(val.columns.status=="3"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>待领取</td>";
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                        }else if(val.columns.status=="4"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>已完成</td>";
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                        }else {
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                            str+="<td class='text-c c-fe0101 w-70'>---</td>";
                        }
                        str+="</tr class='w-100'>";
                        img = (val.columns.fitting_img).split(",");
                        for(var i=0;i<img.length;i++){
                            if(img[i]!=""&&img[i]!=null){
                                imgstr+=("<div class='f-l mr-10'><div class='imgWrap'><img src='${commonStaticImgPath}"+img[i]+"'></div></div>");
                            }
                        }
                    });
 					if(imgstr==""){
						imgstr+=("<div class='f-l mr-10'><div class='imgWrap'><img src='${ctxPlugin}/static/h-ui.admin/images/img-default.png'></img></div></div>");
					}
				}else{
					$(".showimg").html("");
				}
				
				$("#pjsq").append(str);
                jQuery.getScript("${ctxPlugin}/static/h-ui.admin/js/imgShow.js", function(data, status, jqxhr) {
                    $(".showimg").append(imgstr);
                    $('.showimg').imgShow();
                });
				return;
			}
			
		});
	}

	//备件使用弹出
	function useFit(){
		$("input[name='code']").val('');
		$("input[name='type']").val('');
		$("input[name='num']").val('');
		$("input[name='num']").prop("placeholder","");
		
		$("#noPay").parent().addClass("radiobox-selected");
        $("#isPay").parent().removeClass("radiobox-selected");
        $("#hideMoney").addClass("hide");
        isCheck="";
		
		$.ajax({
			url:"${ctx}/fitting/employeFitting/getEmployeFittingsSecondSite",
			data:{orderId:"${order.columns.id}",siteId:siteId},
			dataType:'json',
			success:function(result){
				var html='<option value="">请选择</option>';
				for(var i=0;i<result.length;i++){
					if(!isBlank(result[i].columns.fittingName)){
						html+='<option value="'+result[i].columns.fitting_id+','+result[i].columns.employe_id+'">'+result[i].columns.employName+':'+result[i].columns.fittingName+'</option>';
					}
				}
				$("#finame").empty().append(html);
				$("#finame").select2();
                $("#finame").next(".select2").find(".selection").css("width","230px");

				$('.usebj').popup({level:4, closeSelfOnly:true});
				$('#bjuseT input[type="text"]').val('');
				$('#bjuseT input[type="hidden"]').val('');
			},
			error:function(){
				return;
			}
		});
		
	};
	
 	$("#finame").change(function(){
	 	q_bjuser();
	});

	$("input[name='num']").blur(function(){
		if(markBlur=="1"){
			return false;
		}
		var num = $("input[name='num']").val();
		if(num==null||num==""){
			layer.msg("请输使用入数量");
			return;
		}
		if(!checkNum(num)){
			layer.msg("输入数量格式错误");
			return;
		}
		q_bjuser();
	});
	
 	$(function(){
 		$("#noPay").parent().addClass("radiobox-selected");
 		$("#noPay").click(function(){
 			$("#noPay").parent().addClass("radiobox-selected");
            $("#isPay").parent().removeClass("radiobox-selected");
            $("#hideMoney").addClass("hide");
            isCheck="";
        });
        $("#isPay").click(function(){
        	$("#noPay").parent().removeClass("radiobox-selected");
            $("#isPay").parent().addClass("radiobox-selected");
            $("#hideMoney").removeClass("hide");
            isCheck="1";
        });
 	});
 	
 	$("#payPrice").blur(function(){
 		var te =/^(0|[1-9][0-9]{0,9})(\.[0-9]{1,2})?$/;
 		var va=$(this).val();
 		if(isBlank(va)){
 			layer.msg("请输入收费价格");
 			return;
 		}
 		if(!te.test(va)){
 			$(this).val('');
 			layer.msg("收费价格格式不正确！");
 			return;
 		}
 	});
 	
 	function q_bjuser(){
 		var fitIdBindEmpId = $("#finame").val();
 		if(isBlank(fitIdBindEmpId)){
 			layer.msg("请选择工程师备件库存");
 			$("input[name='type']").val("");
			$("input[name='code']").val("");
			$("input[name='num']").val("");
			$("#payPrice").val("");
 			return;
 		}
 		var flag = true;
 		$.ajax({
 			url:"${ctx}/fitting/employeFitting/showFittingTypeSecondSite",
 			data:{fitIdBindEmpId:fitIdBindEmpId,siteId:siteId},
 			async:false,
 			dataType:'json',
 			success:function(result){
 			if(result.jg=='data'){
 				$("input[name='type']").val(result.version);
 				$("input[name='name']").val(result.name);
 				$("input[name='fittingId']").val(result.fittingId);
 				$("input[name='code']").val(result.code);
 				customerPrice=result.customerPrice;
 				if(!isBlank($("input[name='fittingId']").val())){
 					$("input[name='num']").prop("placeholder","最大数量"+result.maxnum);
 				}	
 				if(eval($("input[name='num']").val())>result.maxnum){
 					layer.msg("数量超过最大限制");
 					flag = false;
 				}else{
 					var num = $("input[name='num']").val();
 					$("#payPrice").val(num*customerPrice);
 				}
 			}else{
 				if($("input[name='code']").val()!=null&&$("input[name='code']").val()!=""){
 					$("input[name='type']").val("");
 	 				$("input[name='name']").val("");
 	 				$("input[name='num']").val("");
 					layer.msg("没有该备件");
 					flag = false;
 				}
 			}	
 			},
 			error:function(){
 				flag = false;
 			}
 			
 		});
 		
 		return flag;
 		
 	}
	
 	var btn = document.getElementById("bj_use");
 	btn.onmousedown = function(event) {event.preventDefault()};
 	
	function tj_bjuse(){//bjuseT-table
	//显示型号
	var flag = false;
	var code =  $("input[name='code']").val();
	var num = $("input[name='num']").val();
	var fitIdBindEmpId = $("#finame").val();
	var price="";
	if(isCheck=='1'){
		var te =/^(0|[1-9][0-9]{0,9})(\.[0-9]{1,2})?$/;
		price=$("#payPrice").val();
		if(isBlank(price)){
 			layer.msg("请输入收费价格");
 			return;
 		}
 		if(!te.test(price)){
 			$(this).val('');
 			layer.msg("收费价格格式不正确！");
 			return;
 		}
	}
	if(isBlank(fitIdBindEmpId)){
		layer.msg("请选择工程师备件库存");
		return;
	}else if(isBlank(num)){
		layer.msg("请输入使用数量！");
		return;
	}else if(!checkNum(num)){
		layer.msg("输入数量格式错误");
		return;
	}
	
	flag = q_bjuser(); // 判断有没有符合条件的配件
	
	if(flag&&checkNum(num)&&code!=null&&code!=""){
		$.ajax({
			type:"post",
			url:"${ctx}/fitting/employeFitting/BjEmpFit",
			data:{code:code,fitIdBindEmpId:fitIdBindEmpId,num:num,orderId:"${order.columns.id}",price:price,orderNumber:"${order.columns.number}",customerName:"${order.columns.customer_name}",customerMobile:"${order.columns.customer_mobile}",
			customerAddress:"${order.columns.customer_address}",warrantyType:"${order.columns.warranty_type}",applianceCategory:"${order.columns.appliance_category}",applianceBrand:"${order.columns.appliance_brand}",siteId:siteId},
			dataType:'text',
			async:false,
			success:function(result){
				layer.msg("操作成功!");
				markBlur="1";
				$.closeDiv($('.usebj'),true);
				fittingApply("pjmg");
				fittingApply("pjsy");
				parent.closeBatchForms();
			},
			error:function(){
				return;
			}
		});
		
	}else if(code==""||code==null){
		layer.msg("请输入条码");
		return;
		
	}
	}

	//备件申请
 	$("input[name='acode']").blur(function(){
 		q_bjapply();
		//showFittingType
	}); 
 	$("input[name='anum']").blur(function(){
		//showFittingType
 		var num = $("input[name='anum']").val();
		if(num==null||num==""){
			layer.msg("请输入使用数量");
			return;
		}
		if(!checkNum(num)){
			layer.msg("输入数量格式错误");
			return;
		}
 		q_bjapply();
	}); 
	
	function q_bjapply(){
		//q_bjapply
		var code = $("input[name='acode']").val();
 		var flag = true;
 		$.ajax({
 			url:"${ctx}/fitting/fittingApply/q_bjapply",
 			data:{code:code},
 			async:false,
 			dataType:'json',
 			success:function(result){
 			if(result.jg=='data'){
 				$("input[name='atype']").val(result.version);
 				$("input[name='aname']").val(result.name);
 				$("textarea[name='appremarks']").val(result.remarks);
 				$("input[name='fittingId']").val(result.fittingId);
 				$("input[name='anum']").prop("placeholder","最大数量"+result.maxnum);
 				if(eval($("input[name='anum']").val())>result.maxnum){
 					layer.msg("数量超过最大限制");
 					flag = false;
 				} 
 			}else{
 				if($("input[name='acode']").val()!=null&&$("input[name='acode']").val()!=""){
 					layer.msg("没有该备件");
 					$("input[name='atype']").val("");
 	 				$("input[name='aname']").val("");
 	 				$("textarea[name='appremarks']").val("");
 	 				$("input[name='anum']").prop("");
 	 				$("input[name='fittingId']").val("");
 					flag = false;
 				}
 			}	
 			},
 			error:function(){
 				flag = false;
 			}
 			
 		});
 		
 		return flag;
 	}

	
	
	function checkNum(num){

		var reg=/^([1-9]\d*\.?\d*)|(0\.\d*[1-9])$/;
		return reg.test(num);
	}
	
	function showPjmsg(){
		var header = "<thead>"+
			"<tr>"+
		"<th class='w-110'>备件条码</th>"+
		"<th class='w-250'>备件名称</th>"+
		"<th class='w-150'>备件型号</th>"+
		"<th class='w-50'>数量</th>"+
		"<th class='w-100'>备件状态</th>"+
		"<th class='w-140'>申请时间</th>"+
		"</tr>"+
		"</thead>";
		$.ajax({//table - pjmg
			url:"${ctx}/order/orderDispatch/showPjms",
			async:false,
			dataType:'json',
			data:{orderId:"${order.columns.id}"},
			success:function(result){
				var str="";
			if(result.list.length>0){
				$.each(result.list,function(index,val){
					str+="<tr>";
					str+="<td style='text-align: center;'>"+val.columns.fitting_code+"</td>";
					str+="<td>"+val.columns.fitting_name+"</td>";
					str+="<td>"+val.columns.fitting_version+"</td>";
					str+="<td style='text-align: center;'>×"+val.columns.fitting_apply_num+"</td>";
					if(val.columns.status=="0"){
						str+="<td>待审核</td>";
					}else if(val.columns.status=="1"){
						str+="<td>缺件中</td>";
					}else if(val.columns.status=="2"){
						str+="<td>待出库</td>";
					}else if(val.columns.status=="3"){
						str+="<td>待领取</td>";
					}else if(val.columns.status=="4"){
						str+="<td>已领取</td>";
					}else if(val.columns.status=="5"){
						str+="<td>申请已取消</td>";
					}else if(val.columns.status=="6"){
						str+="<td>申请审核未通过</td>";
					}
					str+="<td>"+new Date(val.columns.create_time).format('yyyy-MM-dd hh:mm')+"</td>";
					str+="</tr>";
				});
				$("#pjmg").html("");
				$("#pjmg").append(header+str);
			}	
			}
		});
	}
	
	$("input[name='bjca']").click(function(){
		$.closeDiv($('.usebj'), true);
		/* $.closeDiv($('.applybj')); */
	});
	Date.prototype.format = function(fmt) { 
	     var o = { 
	        "M+" : this.getMonth()+1,                 //月份 
	        "d+" : this.getDate(),                    //日 
	        "h+" : this.getHours(),                   //小时 
	        "m+" : this.getMinutes(),                 //分 
	        "s+" : this.getSeconds(),                 //秒 
	        "q+" : Math.floor((this.getMonth()+3)/3), //季度 
	        "S"  : this.getMilliseconds()             //毫秒 
	    }; 
	    if(/(y+)/.test(fmt)) {
	            fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
	    }
	     for(var k in o) {
	        if(new RegExp("("+ k +")").test(fmt)){
	             fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
	         }
	     }
	    return fmt; 
	};
	
	function changeStyle(orderNum){
        var bStop = false;
        var bStopIndex = 1;
        var topWindow = $(window.top.document),
            show_navLi = topWindow.find("#min_title_list li");

        show_navLi.each(function() {
            $(this).removeClass('active');
            if($(this).find('span').text() =='短信发送记录'){
                bStopIndex=show_navLi.index($(this));
                bStop=true;
            }
        });
        if(!bStop){
            creatIframe('${ctx }/operate/sendedSms?orderNum='+orderNum,'短信发送记录');
        }else{
            show_navLi.eq(bStopIndex).addClass('active');
            topWindow.find('#iframe_box .show_iframe').hide().eq(bStopIndex).show().find('iframe').attr({'src':'${ctx }/operate/sendedSms?orderNum='+orderNum});
        }
	}
	
	function newOrder(id){ //新建工单
		window.location.href="${ctx}/order/newFormFormDetail?id="+id;
	}

	
	function inputWidth(obj){
		var textValue = obj.value,
			textLength = textValue.length,
			charCode = -1;
		var charLen = textValue.replace(/[^\x00-\xff]/g,"**").length;

		var minWidth = charLen*7 >10?charLen*7 : 10;
		minWidth = minWidth>448?448:minWidth;
		$(obj).css({'width':minWidth + 'px'});
	}
	
	
	$('#Imgprocess2').imgShow();
	$('.showimg').imgShow();
	function dygd(id){
		//使用默认
		window.open("${ctx}/print/order?orderId="+id);
	}


	
	function cancelQueren(){
		$.closeDiv($(".msgTextQuren"),true);
	}

function showMarkOrder(id) {
    layer.open({
        type : 2,
        content:'${ctx}/order/showMarkOrders?ids=' + id,
        title:false,
        area: ['100%','100%'],
        closeBtn:0,
        shade:0,
        anim:-1
    });
}


$(".proofImg").imgShow();

function deleteImg(ff) {
	$("#" + ff).remove();
	feedImgsCount = feedImgsCount - 1;
	if (feedImgsCount >= 7) {
		$("#jiahao").removeClass('hide');
	} 
	if (uploader) {
		uploader = null;
	}
	createUploader("#filePicker-add", "#Imgprocess", "file_fake_addimg","file_fake_add", "delpickerImg");
}

function showGoodsMsg(){
	var orderNumber = "${order.columns.number}";
	$.ajax({
		url:"${ctx}/order/showGoodsMsg",
		data:{orderNumber:orderNumber,siteId:siteId},
		dataType:'json',
		async:false,
		success:function(data){
			var html="";
			if(data.length > 0){
				for(var i=0;i<data.length;i++){
					var dataJson = eval(data[i].columns.detailList);
					html+="<tr>" +
                    "<td title='"+data[i].columns.number+"'>"+data[i].columns.number+"</td>" ;
                    var ht1="";
                    var ht2="";
                    var ht3="";
                    var ht4="";
                    var ht5="";
					for(var j=0;j<dataJson.length;j++){
						var goods = dataJson[j].columns;
						ht1+="<div style='width:195px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;' title='"+goods.good_name+"'>"+goods.good_name+"</div>";
						ht2+="<div title='"+goods.purchase_num+"'>"+goods.purchase_num+"</div>";
						ht3+="<div title='"+goods.site_price+"'>"+goods.site_price+"</div>";
						ht4+="<div title='"+goods.real_amount+"'>"+goods.real_amount+"</div>";
						if(j<dataJson.length-1){
							ht5+="<div style='border-bottom:1px solid #ccc;' title='"+goods.sales_commissions+"'>"+goods.sales_commissions+"</div>";
						}else{
							ht5+="<div title='"+goods.sales_commissions+"'>"+goods.sales_commissions+"</div>";
						}
					}
					html+="<td>"+ht1+"</td>"+
					"<td style='border-left:none;'>"+ht2+"</td>"+
					"<td style='border-left:none;'>"+ht3+"</td>"+
					"<td style='border-left:none;'>"+ht4+"</td>";
                    html+="<td title='"+data[i].columns.real_amount+"'>"+data[i].columns.real_amount+"</td>" +
                    "<td title='"+data[i].columns.confirm_amount+"'>"+data[i].columns.confirm_amount+"</td>";
					html+="<td style='padding-left:0px;padding-right:0px;' class='bb h-30 pd-5'>"+ht5+"</td>";
                    html+= "<td  title='"+data[i].columns.placing_name+"'>"+data[i].columns.placing_name+"</td>" +
	                    "<td >"+formatDate(data[i].columns.placing_order_time)+"</td>" +
	                    "<td style='color:red;'>"+goodsOrderStatus(data[i].columns.status,goods.outstock_type,goods.stocks,goods.purchase_num,goods.outstock_type)+"</td>" +
	                "</tr>";
				}
				$("#goodsMsg").empty();
				$("#goodsMsg").append(html);
			}
		}
	})
}


function showMore(obj){
	if($('#moreConWrap').is(':visible')){
		
		$('#moreConWrap').slideUp();
		$(obj).text('展开');
	}else{
		console.log(2);
		$('#moreConWrap').slideDown();
		$(obj).text('收起');
	}
}

function showQRCode(siteId,type){
	var code = $("#applianceBarcode").val();
	if("2"==type){
		code = $("#applianceMachineCode").val();
	}
	if(isBlank(code)){
		layer.msg("条码为空！");
		return;
	}
   // var str="http://www.sifangerp.com/wxweb/toScan?sid="+siteId+"&xcode="+code;
    $("#showCode").empty().qrcode({width: 200, height: 200, text: code});
    $(".qrcode").popup({level:2,closeSelfOnly:true});

}

function codeNumberCounts(){
	codeCounts();
	$('#applianceBarcode').bind('blur', function() {  
		codeCounts();
		var code = $.trim($(this).val());
		if(!isBlank(code)){
			changeMark = false;
			loadAlreadyCode(1,code);//历史工单显示
			$(".code1").show();
			$(".weishu1").show();
		}else{
			changeMark = true;
			$("#codeInshow").hide();
			$(".code1").hide();
			$(".weishu1").hide();
		}
	});
	$('#applianceMachineCode').bind('input propertychange', function() {  
		codeCounts1();//条码字数统计
	})
	$('#applianceBarcode').bind('input propertychange', function() {  
		codeCounts1();//条码字数统计
	})
	$('#applianceMachineCode').bind('blur', function() {  
		codeCounts();
		var code = $(this).val();
		if(!isBlank(code)){
			changeMark = false;
			loadAlreadyCode(2,code);//历史工单显示
			$(".code2").show();
		    $(".weishu2").show();
		}else{
			changeMark = true;
			$("#codeOutshow").hide();
			$(".code2").hide();
			$(".weishu2").hide();
		}
	});
}

function codeCounts1(){
	var applianceBarcode = $.trim($("#applianceBarcode").val());
	var applianceMachineCode = $.trim($("#applianceMachineCode").val());
	$("#incodeNum").text(applianceBarcode.length);
	$("#outcodeNum").text(applianceMachineCode.length);
	if(!isBlank(applianceBarcode)){
		$(".weishu1").show();
		$(".code1").show();
		changeMark=false;
		//loadAlreadyCode(1,applianceBarcode);
	}else{
		$(".weishu1").hide();
		$(".code1").hide();
	}
	if(!isBlank(applianceMachineCode)){
		$(".weishu2").show();
		$(".code2").show();
		changeMark=false;
		//loadAlreadyCode(2,applianceMachineCode);
	}else{
		$(".weishu2").hide();
		$(".code2").hide();
	}
}

function codeCounts(){
	var applianceBarcode = $.trim($("#applianceBarcode").val());
	var applianceMachineCode = $.trim($("#applianceMachineCode").val());
	$("#incodeNum").text(applianceBarcode.length);
	$("#outcodeNum").text(applianceMachineCode.length);
	if(!isBlank(applianceBarcode)){
		$(".weishu1").show();
		$(".code1").show();
		changeMark=false;
		loadAlreadyCode(1,applianceBarcode);
	}else{
		$(".weishu1").hide();
		$(".code1").hide();
	}
	if(!isBlank(applianceMachineCode)){
		$(".weishu2").show();
		$(".code2").show();
		changeMark=false;
		loadAlreadyCode(2,applianceMachineCode);
	}else{
		$(".weishu2").hide();
		$(".code2").hide();
	}
}

function loadAlreadyCode(type,code){
	if(changeMark){
		return;
	}
	if(isBlank(code)){
		if(type==1){
			 $("#codeInshow").hide();
			 $(".codeIn").hide();
		 }else{
			 $("#codeOutshow").hide();
			 $(".codeOut").hide(); 
		 }
		return;
	}
	$.ajax({
		url: "${ctx}/order/getHistoryOrdersCodeOutCountByTelDetail?code=" + $.trim(code)+"&id="+'${order.columns.id}&f=df',
		type: 'GET',
		success: function(data) {
			if(changeMark){
				return;
			}
			var count = data.cnt;
			if(count == 0){
				 if(type==1){
					 $("#codeInshow").hide();
					 $(".codeIn").hide();
				 }else{
					 $("#codeOutshow").hide();
					 $(".codeOut").hide();
				 }
			 }else{
				 if(count < 1){
					 $(".douhao").text("");
				 }
				 if(count > 0){
					 if(type==1){
						 $("#codeInshow").text(count+'条历史工单');
						 $("#codeInshow").show();
						 $(".codeIn").show();
					 }else{
						 $("#codeOutshow").text(count+'条历史工单');
						 $("#codeOutshow").show();
						 $(".codeOut").show(); 
					 }
				 }else{
					 if(type==1){
						 $(".codeIn").hide();
					 }else{
						 $(".codeOut").hide();
					 }
					 
				 }
				 $('#codeShow').show();
			 }
			changeMark=false;
		}
	});
}

function senMagPopup(id){
	layer.open({
        type : 2,
        content:'${ctx}/order/sendMsgAccountsOne?ids=' + id + "&type=1",
        title:false,
        area: ['100%','100%'],
        closeBtn:0,
        shade:0,
        anim:-1
    });
}

function dealSpecialSymbol(val){
	if(isBlank(val)){
		return "";
	}
	val = val.replace(/'/g,"");
	val = val.replace(/"/g,"");
	return val;
}

function directDisZp() {
	$("#disPatchSiteName1").text();
	var searchName = $("#filterName1").val();
	var selectcategory = $("#applianceCategory").val();
	var selectbrand = $("#applianceBrand").val();
	layer.open({
   		type : 2,
   		content:'${ctx}/secondOrder/toChangeDispatchOrderPage?searchName='+searchName+'&selectcategory='+selectcategory+'&selectbrand='+selectbrand+"&customerMobile="+""+"&orderId="+$("#orderId").val()+"&position=2",
   		title:false,
   		area: ['100%','100%'],
   		closeBtn:0,
   		shade:0,
   		anim:-1 
   	 });
}


</script> 
</body>
</html>
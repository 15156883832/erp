<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/orderConnectionGoods.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>

<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/formatStatus.js"></script>
<style type="text/css">

/* .spimg1{ border:none;} */
.spimg1 .webuploader-pick{
	width:134px;
	height:134px;
}
</style>
</head>

<body>
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
						<input type="hidden" name="id" value="${order.columns.id}" id="orderId">
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
										<option value="${order.columns.promise_limit }" selected="selected" >${order.promise_limit }</option>
									</c:if>
								</select>
							</div>
						</div>
						<div class="cl mt-10">
							<div class="f-l pos-r pl-100 h-50">
								<label class="lb w-100"><c:if test="${mustfill.columns.customerFeedback}"><em class="mark"></em></c:if>服务描述：</label>
								<textarea type="text" class="input-text w-380 h-50 readonly" readonly="readonly" id="customerFeedback" name="customerFeedback">${order.columns.customer_feedback}</textarea>
							</div>
							<div class="f-l pos-r pl-80 h-50">
								<label class="lb w-80"><c:if test="${mustfill.columns.remarks}"><em class="mark"></em></c:if>备注：</label>
								<textarea type="text" class="input-text h-50 w-320 readonly" readonly="readonly" id="remarks" name="remarks" >${order.columns.remarks}</textarea>
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
								<input type="text" class="input-text w-110 readonly dischange" readonly="readonly" name="messengerName" value="${order.columns.xm}"/>
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
					<a href="javascript:showSYMsg();" class="tabswitch ">备件使用</a>
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
						<span class="caption_lb">工单关联配件使用</span>
						<!-- <input onclick="useFit()" type="button" class="btn-usebj mr-20 w-70 mt-5 sfbtn sfbtn-opt f-r pos-r"  value="备件使用" /> -->
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
				
			</div>
			</div>
		<div class="btnMenubox pb-80">
				<c:if test="${'7' ne order.columns.order_type}">
					<sfTags:pagePermission authFlag="ORDER_MODORDER_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt" id="xggd" value="修改工单" type="button" />'></sfTags:pagePermission>
				</c:if>
				<c:if test="${order.columns.parent_status == '2' }">
					<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_DISPATCHZHUANPAISECONDORDER_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="转派" type="button" onclick="directDisZp()"/>'></sfTags:pagePermission>
				</c:if>
				<c:if test="${order.columns.status == '7' }">
					<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_DISPATCHZHUANPAISECONDORDER_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="转派" type="button" onclick="directDisZp()"/>'></sfTags:pagePermission>
				</c:if>
				<c:if test="${order.columns.status == '1' }">
					<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_DISPATCHZHUANPAISECONDORDER_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="转派" type="button" onclick="directDisZp()"/>'></sfTags:pagePermission>
				</c:if>
				<c:if test="${order.columns.parent_status ne '4' && order.columns.parent_status ne '5'}">
					<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_DISPATCHSECONDORDER_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="返回一级待派工" type="button" onclick="returnSiteOrder()"/>'></sfTags:pagePermission>
				</c:if>
				<c:if test="${order.columns.parent_status == '6' }">
					<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_DISPATCHSECONDORDER_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="指派给二级网点" type="button" onclick="directDis()"/>'></sfTags:pagePermission>
				</c:if>
				<c:if test="${order.columns.parent_status == '4' }">
					<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_DISPATCHSECONDORDER_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="回访" type="button" onclick="showCallbackForm()"/>'></sfTags:pagePermission>
				</c:if>
				<c:if test="${order.columns.parent_status == '5' }">
					<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_DISPATCHSECONDORDER_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="重新回访" type="button" onclick="showCallbackForm()"/>'></sfTags:pagePermission>
				</c:if>
			</div>
		</div>
		
	</div>
</div>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/city.union.js"></script>
<script type="text/javascript">
	var formPosted = false;
	var changeMark = true;
    var dispatchMap,dispatchMarker,employeMarker;
    var ctx='${ctx}';
    var siteId = '${order.columns.site_id}';

	$("#closDivPoup").on("click",function(){
		parent.search();
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
	});
    $('#imgshow').imgShow();
    
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
  
   /*合作网点回访*/
    function showCallbackForm() {
    	openedCallbackFormIndex = layer.open({
    		type: 2,
    		content: '${ctx}/order/orderParentCallback/newSecondCallBack?id=${order.columns.id}',
    		title: false,
    		area: ['100%', '100%'],
    		closeBtn: 0,
    		shade: 0,
    		fadeIn: 0,
    		anim: -1
    	});
    }
   

  //获取工单关联备件使用信息
  function showSYMsg(){
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
  			$("#pjsy").html(
  					"<thead>"+
  					"<tr>"+
  						"<th class='w-180'>备件条码</th>"+
  						"<th class='w-260'>备件名称</th>"+
  						"<th class='w-120'>备件型号</th>"+
  						"<th class='w-90'>最新入库价格</th>"+
  						 "<th class='w-80'>工程师价格</th>"+
  						 "<th class='w-70'>零售价格</th>"+
  						"<th class='w-50'>数量</th>"+
  						"<th class='w-70'>收费金额</th>"+
                          "<th class='w-100'>使用类型</th>" +
  						"<th class='w-70'>状态</th>"+
  						"<th class='w-70'>操作</th>"+
  					"</tr>"+
  				"</thead>");
  			/* $(".showimg").html("<label class='lb lb1'>备件图片：</label>"); */
  			if(result.list.length>0){
  			$.each(result.list,function(index,val){
  				str+="<tr>"+
  				"<td class='w-140'>"+val.columns.fitting_code+"</td>"+
  				"<td class='w-300'>"+val.columns.fitting_name+"</td>"+
  				"<td class='w-120'>"+val.columns.fitting_version+"</td>"+
  				"<td class='w-90'>"+val.columns.site_price+"</td>"+
                  "<td class='w-80'>"+val.columns.employe_price+"</td>"+
                  "<td class='w-70'>"+val.columns.customer_price+"</td>"+
  				"<td class='w-50'>×"+val.columns.used_num+"</td>"+
  				"<td class='w-70'>"+val.columns.collection_money+"</td>";
                      str+="<td class='text-c  w-100'>"+fmtVerificationTypeForOrder(val)+"</td>";
  				if(val.columns.status=="1"){
  					str+="<td class='c-fe0101 w-70'><i class='oState state-verifyPass'></i>待核销</td>";
  				}else if(val.columns.status=="2"){
  					str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>已核销</td>";
  				}else if(val.columns.status=="3"){
                      str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verify2nopass'></i>已拒绝</td>";
                  }
                  if(val.columns.status=="2"){//已核销，不显示删除
                      str+="<td class='text-c c-fe0101 w-70'>---</td>";
                  }else{
                      str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteOneFit(\""+val.columns.id+"\",\""+val.columns.fitting_name+"\",\""+val.columns.used_num+"\")'><i class='sficon sficon-del'></i></a></td>";
                  }
  			});
  			}else{
  				$(".showimg").html("");
  			}

  			$("#pjsy").append(str);
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
//						$.closeDiv($(".orderdetailVb"));
	                        window.location.reload();
	                    }
	                });
	                return;
	           
			}
		});
		
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

		$('#wxImgList').imgShow();
		$("#orderNumber").prop("disabled",false);
		$("#orderNumber").prop("readonly",true);

		$('#minusWrap').removeClass('minusWrap');
		$('#minusWrap').find('.prefix').hide();

		$('#emp').select2();
		//2.监听父层按钮的动作
		$('#pngfix-nav-btn', parent.document).click(function(){
			//3.给定一个时间点
			setTimeout(function(){
				//4.再次执行全屏
				layer.restore(full_idx);
			},200);
		});
		
	$(".selection").css("width","160px");


		
		$('#applianceBrand').select2();
		$("#applianceBrand").next(".select2").find(".selection").css("width","160px");

		$('#applianceCategory').select2();
		$("#applianceCategory").next(".select2").find(".selection").css("width","120px");

        $("#pleaseReferMall").select2({tags:true});
        $("#pleaseReferMall").next(".select2").find(".selection").css("width","120px");

		
		$.Huitab("#detialWd .tabBarP .tabswitch","#detialWd .tabCon","current","click","0");
		$.Huitab("#serveFb .tabBarP .tabswitch","#serveFb .tabCon","current","click","0");
		$.Huitab("#fbSettle .tabBarP .tabswitch","#fbSettle .tabCon","current","click","0");
		
		$('.orderdetailVb').popup({fixedHeight:false});
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
	 						document.getElementById("applianceBrand").setAttribute("disabled", "disabled");
	 					 }else{
	 						document.getElementById("applianceBrand").removeAttribute("disabled");
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
					document.getElementById("applianceCategory").setAttribute("disabled", "disabled");
				} else {
					document.getElementById("applianceCategory").removeAttribute("disabled");
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
	});

	function updateCallbackBtn() {
	}
	function closeCallbackForm() {
        layer.close(openedCallbackFormIndex);
		window.location.reload(true);
	}
	
	function newOrder(id){
		window.location.href="${ctx}/order/newFormFormDetail?id="+id;
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
				$("#pjsq").html("<caption>工单关联配件申请</caption>"+
						"<thead>"+
						"<tr>"+
							"<th class='w-180'>备件条码</th>"+
							"<th class='w-260'>备件名称</th>"+
							"<th class='w-120'>备件型号</th>"+
							"<th class='w-150'>审核备注</th>"+
							"<th class='w-50'>数量</th>"+
							"<th class='w-70'>状态</th>"+
						"</tr>"+
					"</thead>");
				$(".showimg").html("<label class='lb lb1'>备件图片：</label>");
				
				if(result.list.length>0){
				$.each(result.list,function(index,val){
					str+="<tr>"+
					"<td class='w-140'>"+val.columns.fitting_code+"</td>"+
					"<td class='w-300'>"+val.columns.fitting_name+"</td>"+
					"<td class='w-120'>"+val.columns.fitting_version+"</td>"+
					  "<td class='text-c w-50'>×" + val.columns.fitting_apply_num + "</td>" +
                      "<td class='text-c w-150'>" + val.columns.audit_marks + "</td>" ;
					if(val.columns.status=="0"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-verifyPass'></i>待审核</td>";
					}else if(val.columns.status=="1"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>缺件中</td>";
					}else if(val.columns.status=="2"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>待出库</td>";
					}else if(val.columns.status=="3"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>待领取</td>";
					}else if(val.columns.status=="4"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>已完成</td>";
					}else if(val.columns.status=="5"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>已取消</td>";
					}else if(val.columns.status=="6"){
						str+="<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>未通过</td>";
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
 					if(imgstr==""){
						imgstr+=("<div class='f-l mr-10'><div class='imgWrap'><img src='${ctxPlugin}/static/h-ui.admin/images/img-default.png'></img></div></div>");
					}
				}else{
					$("#oldfittingimg").html("");
				}
				
				$(".oldtbody").append(str);
                jQuery.getScript("${ctxPlugin}/static/h-ui.admin/js/imgShow.js", function(data, status, jqxhr) {
                    $("#oldfittingimg").append(imgstr);
                    $('#oldfittingimg').imgShow();
                })
				return;
			}
			
		});
	}



	function cancelJs() {
		$.closeDiv($('.addJsBox'));
	}
	 $('#Imgprocess2').imgShow();
		

	function getoff(){
		window.location.reload();
	}
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
                //addressTwo(result);
            },
            error: function () {
                layer.msg("系统繁忙!");
                return;
            },
            complete: function () {

            }

        });
    }
    function addressSplit(str){
        var sz = [];
        if (str.indexOf("区") > 0 && str.indexOf("县") <= 0 && str.indexOf("市") < 0) {
            sz = str.split("区");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "区";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress").val(strs);
            } else if (1 < sz.length <= 2) {
                $("#customerAddress").val(sz[1]);
            } else {
                $("#customerAddress").val(sz[0]);
            }
        }else if (str.indexOf("县") > 0 && str.indexOf("市") < 0) {
            sz = str.split("县");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "县";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress").val(strs);
            } else if (1 < sz.length <= 2) {
                $("#customerAddress").val(sz[1]);
            } else {
                $("#customerAddress").val(sz[0]);
            }
        }else if(str.indexOf("县") > 0 && str.indexOf("市") > 0){
            var ciAd=str.indexOf("市");
            var xaAd=str.indexOf("县");
            if(parseInt(ciAd) < parseInt(xaAd)){//市在前
                sz = str.split("市");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "市";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress").val(strs);
                } else if (sz.length == 2) {
                    $("#customerAddress").val(sz[1]);
                } else {
                    $("#customerAddress").val(sz[0]);
                }
            }else if(parseInt(ciAd) > parseInt(xaAd) ){//县在前
                sz = str.split("县");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "县";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress").val(strs);
                } else if (1 < sz.length <= 2) {
                    $("#customerAddress").val(sz[1]);
                } else {
                    $("#customerAddress").val(sz[0]);
                }
            }
        }else if(str.indexOf("市") > 0 && str.indexOf("区") < 0){
            sz = str.split("市");
            if (sz.length > 2) {
                var strs = "";
                for (var i = 1; i < sz.length; i++) {
                    if (i != sz.length - 1) {
                        strs += sz[i] + "市";
                    } else {
                        strs += sz[i];
                    }
                }
                $("#customerAddress").val(strs);
            } else if (sz.length == 2) {
                $("#customerAddress").val(sz[1]);
            } else {
                $("#customerAddress").val(sz[0]);
            }
        }else if (str.indexOf("市") > 0 && str.indexOf("区") > 0) {
            var ciAd=str.indexOf("市");
            var quAd=str.indexOf("区");

            if(parseInt(ciAd) < parseInt(quAd)){//市在前
                sz = str.split("市");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "市";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress").val(strs);
                } else if (sz.length == 2) {
                    $("#customerAddress").val(sz[1]);
                } else {
                    $("#customerAddress").val(sz[0]);
                }
            }else if(parseInt(ciAd) > parseInt(quAd) ){//区在前
                sz = str.split("区");
                if (sz.length > 2) {
                    var strs = "";
                    for (var i = 1; i < sz.length; i++) {
                        if (i != sz.length - 1) {
                            strs += sz[i] + "区";
                        } else {
                            strs += sz[i];
                        }
                    }
                    $("#customerAddress").val(strs);
                } else if (1 < sz.length <= 2) {
                    $("#customerAddress").val(sz[1]);
                } else {
                    $("#customerAddress").val(sz[0]);
                }
            }
        } else if (str.indexOf("区") <= 0 && str.indexOf("县") <= 0 && str.indexOf("市") <= 0) {
            $("#customerAddress").val(str);
        }
        var province = $("#province").val();
        var city = $("#city").val();
        var area = $("#area").val();
        if (isBlank(province) || isBlank(city) || isBlank(area)) {
            getDefaultAddress();
        }
    }
    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }



    $('#filterName').keyup(function () {
        $('#zhijiepaidan tr').hide().filter(":contains('" + ($(this).val()) + "')").show();
        if(isBlank($(this).val())){
            $('#zhijiepaidan tr').show();
        }

    }).keyup();//DOM加载完时，绑定事件完成之后立即触发
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
        //var str="http://www.sifangerp.com/wxweb/toScan?sid="+siteId+"&xcode="+code;
        $("#showCode").empty().qrcode({width: 200, height: 200, text: code});
        $(".qrcode").popup({level:2,closeSelfOnly:true});

    }
    
    function directDis() {
    	$("#disPatchSiteName").text('');
    	var searchName = $("#filterName").val();
    	var selectcategory = $("#applianceCategory").val();
    	var selectbrand = $("#applianceBrand").val();
    	layer.open({
       		type : 2,
       		content:'${ctx}/secondOrder/toDispatchOrderPage?searchName='+searchName+'&selectcategory='+selectcategory+'&selectbrand='+selectbrand+"&customerMobile="+""+"&orderId="+$("#orderId").val()+"&position=2",
       		title:false,
       		area: ['100%','100%'],
       		closeBtn:0,
       		shade:0,
       		anim:-1 
       	});
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
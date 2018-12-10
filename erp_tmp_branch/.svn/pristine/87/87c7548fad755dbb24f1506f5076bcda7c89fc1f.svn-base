<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base" />

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css" />
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css" />
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/orderConnectionGoods.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.css">
<script src="${ctxPlugin}/lib/moreSelect/jquery.dropdown.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>


<script type="text/javascript" src="${ctxPlugin}/lib/lodop/LodopFuncs.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/base64.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/printdesign.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/formatStatus.js"></script>
<style type="text/css">
.imgWrap .webuploader-pick {
	width: 80px;
	height: 80px;
	padding: 0;
}

.webuploader-pick img {
	width: 100%;
	height: 100%;
	position: absolute;
	left: 0;
	top: 0;
}

.dropdown-clear-all {
	line-height: 22px
}

.dropdown-display {
	font-size: 12px
}

.dropdown-selected {
	margin-top: 4px
}
</style>
</head>


<body>
	<!-- 回访结算工单-工单详情 -->
	<div class="popupBox odWrap orderdetailVb">
		<h2 class="popupHead">
			工单详情
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer pos-r">
			<div class="popupMain pos-r">
				<div class="pcontent">
					<div id="detialWd">
						<div class="tabBarP" style="overflow: visible;">
							<a href="javascript:;" class="tabswitch current">基本信息</a>
							<a href="javascript:;" class="tabswitch ">报修图片</a>
							<a href="javascript:;" class="tabswitch ">过程信息</a>
							<a href="javascript:;" class="tabswitch ">配送信息</a>
							<c:if test="${count != 0 }">
								<a class="tooltipLink f-r" onclick="changeStyle('${order.number}')">
									<i class="sficon sficon-note"></i>
									已发送
									<span class="va-t">${count }</span>
									条短信
								</a>
							</c:if>
							<c:if test="${order.printTimes != 0 }">
								<a class="tooltipLink f-r">
									<i class="sficon sficon-print"></i>
									已打印
									<span class="va-t">${order.printTimes }</span>
									次
								</a>
							</c:if>
						</div>


						<form id="updateOrder" method="post" action="${ctx}/order/orderDispatch/update">
							<input type="hidden" name="employeIds" value="" />
							<div class="tabCon">
								<div class="cl mb-10 mt-10">
									<input type="hidden" name="id" value="${order.id}">
									<div class="f-l pos-r pl-100">
										<label class="lb w-100">工单编号：</label>
										<input type="text" id="orderNumber" class="input-text w-160 readonly dischange" readonly="readonly" name="number" value="${order.number }" />
									</div>
									<div class="f-l pos-r pl-100">
										<label class="lb w-100">
											<em class="mark"></em>
											服务类型：
										</label>
										<select id="serviceType" disabled="disabled" name="serviceType" class="select w-120 readonly">
											<c:forEach items="${fns:getServiceTypeDer(order.serviceType) }" var="serm">
												<c:if test="${order.serviceType eq serm.columns.name }">
													<option value="${serm.columns.name }" selected="selected">${serm.columns.name }</option>
												</c:if>

												<c:if test="${order.serviceType ne  serm.columns.name }">
													<option value="${serm.columns.name }">${serm.columns.name }</option>
												</c:if>
											</c:forEach>

										</select>
										<%-- <input type="text" class="input-text w-110 readonly" disabled="disabled" name="serviceType" value="${order.serviceType}"/> --%>
									</div>
									<div class="f-l pos-r pl-80">
										<label class="lb w-80">
											<em class="mark"></em>
											服务方式：
										</label>
										<%-- 							<input type="text" class="input-text w-110 readonly" disabled="disabled" name="serviceMode" value="${order.serviceMode }" />
 --%>
										<select id="serviceMode" disabled="disabled" name="serviceMode" class="select w-120 readonly">
											<c:forEach items="${fns:getNewServiceModeDer(order.serviceMode) }" var="serm">
												<c:if test="${order.serviceMode eq serm.columns.name }">
													<option value="${serm.columns.name }" selected="selected">${serm.columns.name }</option>
												</c:if>
												<c:if test="${order.serviceMode ne  serm.columns.name }">
													<option value="${serm.columns.name }">${serm.columns.name }</option>
												</c:if>
											</c:forEach>
										</select>
									</div>
									<div class="f-l pos-r pl-80">
										<label class="lb w-80">
											<c:if test="${mustfill.columns.origin}">
												<em class="mark"></em>
											</c:if>
											信息来源：
										</label>
										<select id="origin" name="origin" disabled="disabled" class="select w-120  hide">
											<c:choose>
												<c:when test="${fn:contains(listoriginlist,order.origin)}">

													<option value="">请选择</option>
													<c:forEach items="${listorigin}" var="serm">
														<c:if test="${order.origin eq serm.columns.name }">
															<option value="${serm.columns.name }" selected="selected">${serm.columns.name }</option>
														</c:if>

														<c:if test="${order.origin ne  serm.columns.name }">
															<option value="${serm.columns.name }">${serm.columns.name }</option>
														</c:if>
													</c:forEach>

												</c:when>

												<c:otherwise>
													<option value="">请选择</option>
													<option value="${order.origin}" selected="selected">${order.origin }</option>
													<c:forEach items="${listorigin}" var="serm">
														<option value="${serm.columns.name }">${serm.columns.name }</option>
													</c:forEach>

												</c:otherwise>

											</c:choose>

										</select>
									</div>
								</div>
								<c:if test="${order.recordAccount=='1' }">

									<div class="cl mb-10 " id="moreConWrap">
										<div class="f-l pos-r pl-100">
											<label class="lb w-100">
												<em class="mark"></em>
												厂家工单编号：
											</label>
											<input type="text" id="factoryNumber" class="input-text w-160 readonly " maxlength="32" readonly="readonly" name="factoryNumber" value="${order.factoryNumber }" />
										</div>
									</div>
								</c:if>

								<div class="line"></div>
								<div class="cl mt-10">
									<div class="f-l pos-r pl-100">
										<label class="lb w-100">
											<em class="mark"></em>
											用户姓名：
										</label>
										<input type="text" id="customerName" class="input-text w-160 readonly" readonly="readonly" name="customerName" value="${order.customerName }" />
										<input type="hidden" class="input-text w-140" id="sign" value="" />
										<input type="hidden" class="input-text w-140" id="siteMsgNums" value="" />
										<c:if test="${cusTypecount > 0 }">
											<span class="select-box w-100 ">
												<select class="select readonly " <c:if test="${mustfill.columns.customerType}">datatype="*" nullmsg="请选择用户类型"</c:if> id="customerType" name="customerType"
													disabled="disabled">
													<option value=" "></option>
													<c:forEach items="${fns:getCustomerType()}" var="to">
														<option value="${to.columns.name }" <c:if test="${to.columns.name eq order.customerType}">selected="selected"</c:if>>${to.columns.name }</option>
													</c:forEach>
												</select>
											</span>
										</c:if>
									</div>
									<div class="f-l pos-r pl-100">
										<span class="lb w-100 text-r" id="mobileType">
											<span class="f-r pr-5">
												<em class="mark"></em>
												:
											</span>
											<select class="lb-sel f-r readonly select" style="width: 75px" disabled="disabled" id="mobileOrtel">
												<option value="1" <c:if test="${order.customerMobile.length() eq 11 }">selected="selected"</c:if>>手机号码</option>
												<option value="2" <c:if test="${order.customerMobile.length() ne 11 }">selected="selected"</c:if>>固定电话</option>
											</select>
											<em class="mark f-r">*</em>
										</span>
										<input type="text" id="customerMobile" class="input-text w-120 readonly" readonly="readonly" name="customerMobile" value="${order.customerMobile }" />
									</div>
									<div class="f-l pos-r pl-90">
										<label class="lb w-90">其他联系方式：</label>
										<input type="text" id="customerTelephone" class="input-text w-110 readonly" readonly="readonly" name="customerTelephone" value="${order.customerTelephone }" />
									</div>
									<div class="f-l pos-r " style="padding-left: 15px;">
										<!-- 	<label class="w-80 pos">联系方式3：</label> -->
										<input type="text" id="customerTelephone2" class="input-text w-110 readonly" readonly="readonly" name="customerTelephone2" value="${order.customerTelephone2 }" />
									</div>
								</div>
								<div class="cl mt-10 mb-10">
									<div class="pos-r pl-100" id="pcd">
										<label class="lb w-100">
											<em class="mark"></em>
											详细地址：
										</label>
										<span class="select-box w-90 f-l mr-10 " id="showProvince">
											<select class="prov select readonly" id="province" name="province" disabled="disabled">
												<c:if test="${not empty order.province}">
													<c:forEach items="${provincelist }" var="pro">
														<option value="${pro.columns.ProvinceName }" <c:if test="${pro.columns.ProvinceName==order.province }">selected="selected"</c:if>>${pro.columns.ProvinceName }</option>
													</c:forEach>
												</c:if>
												<c:if test="${empty order.province && not empty site.province}">
													<c:forEach items="${provincelist }" var="pro">
														<option value="${pro.columns.ProvinceName }" <c:if test="${pro.columns.ProvinceName==site.province }">selected="selected"</c:if>>${pro.columns.ProvinceName }</option>
													</c:forEach>
												</c:if>
											</select>
										</span>
										<span class="select-box w-90 f-l mr-10 " id="showCity">
											<select class="city select readonly" id="city" name="city" disabled="disabled">
												<c:if test="${not empty order.city}">
													<c:forEach items="${cities }" var="cs">
														<option value="${cs.columns.CityName }" <c:if test="${cs.columns.CityName==order.city }">selected="selected"</c:if>>${cs.columns.CityName }</option>
													</c:forEach>
												</c:if>
												<c:if test="${empty order.city && not empty site.city}">
													<c:forEach items="${cities }" var="cs">
														<option value="${cs.columns.CityName }" <c:if test="${cs.columns.CityName==site.city }">selected="selected"</c:if>>${cs.columns.CityName }</option>
													</c:forEach>
												</c:if>

											</select>
										</span>
										<span class="select-box w-90 f-l mr-10 " id="showArea">
											<select class="dist select readonly" id="area" name="area" disabled="disabled">
												<c:if test="${not empty order.area}">
													<c:forEach items="${districts }" var="ds">
														<option value="${ds.columns.DistrictName }" ${ds.columns.DistrictName eq order.area ?'selected':'' }>${ds.columns.DistrictName }</option>
													</c:forEach>
												</c:if>
												<c:if test="${empty order.area && not empty site.area}">
													<c:forEach items="${districts }" var="ds">
														<option value="${ds.columns.DistrictName }" ${ds.columns.DistrictName eq site.area ?'selected':''}>${ds.columns.DistrictName }</option>
													</c:forEach>
												</c:if>
											</select>
										</span>
										<input type="text" class="input-text w-280 f-l readonly" readonly="readonly" id="customerAddress1" name="customerAddress1" value="${order.customerAddress }"
											autocomplete="off" />
										<input type="hidden" id="customerAddress" name="customerAddress" value="${order.customerAddress}" />
										<input type="hidden" id="lnglat" name="customerLnglat" value="${order.customerLnglat }" />
									</div>
								</div>
								<div class="line"></div>
								<div class="cl mt-10" id="styleMark">
									<div class="f-l pos-r pl-100" style="height: 26px">
										<label class="lb w-100">
											<em class="mark"></em>
											家电品牌：
										</label>
										<select disabled="disabled" class="select w-160 readonly" style="position: absolute; z-index: 1;" class="choose" onmousedown="if(this.options.length>6){this.size=8}"
											onblur="this.size=0" onchange="this.size=0" name="applianceBrand" id="applianceBrand" datatype="*" nullmsg="请选择品牌！">
											<c:choose>
												<c:when test="${fn:contains(brandlist,order.applianceBrand)}">
													<option value="">请选择</option>
													<c:forEach items="${brand}" var="ba" varStatus="cast">
														<c:if test="${order.applianceBrand eq ba.value  }">
															<option value="${ba.key }" selected="selected">${ba.value }</option>
														</c:if>
														<c:if test="${order.applianceBrand ne ba.value }">
															<option value="${ba.key }">${ba.value }</option>
														</c:if>
													</c:forEach>
												</c:when>


												<c:otherwise>
													<option value="">请选择</option>
													<option value="${order.applianceBrand}" selected="selected">${order.applianceBrand}</option>
													<c:forEach items="${brand}" var="ba" varStatus="cast">
														<option value="${ba.key }">${ba.value }</option>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</select>
										<input type="text" id="applanceBrandMirror" class="input-text w-160 readonly hide" disabled="disabled" value="${order.applianceBrand }" />
									</div>
									<div class="f-l pos-r pl-100" style="height: 26px">
										<label class="lb w-100">
											<em class="mark"></em>
											家电品类：
										</label>
										<select class="select w-120 readonly" style="position: absolute; z-index: 1;" class="choose" onmousedown="if(this.options.length>6){this.size=8}" onblur="this.size=0"
											onchange="this.size=0" name="applianceCategory" id="applianceCategory" datatype="*" nullmsg="请选择品类！" disabled="disabled">
											<c:choose>
												<c:when test="${fn:contains(catelist,order.applianceCategory)}">
													<option value="">请选择</option>

													<c:forEach items="${category}" var="cad" varStatus="cast1">
														<c:if test="${order.applianceCategory eq cad.columns.name  }">
															<option value="${cad.columns.name }" selected="selected">${cad.columns.name}</option>
														</c:if>

														<c:if test="${order.applianceCategory ne cad.columns.name }">
															<option value="${cad.columns.name }">${cad.columns.name }</option>
														</c:if>
													</c:forEach>
												</c:when>


												<c:otherwise>
													<option value="">请选择</option>
													<option value="${order.applianceCategory}" selected="selected">${order.applianceCategory}</option>
													<c:forEach items="${category}" var="cad" varStatus="cast1">
														<option value="${cad.columns.name }">${cad.columns.name }</option>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</select>
										<input type="text" id="applianceCategoryMirror" class="input-text w-120 readonly hide" disabled="disabled" value="${order.applianceCategory }" />
										<%-- <input type="text" class="input-text w-110 readonly" disabled="disabled" name="applianceCategory" value="${order.applianceCategory }"/> --%>
									</div>
									<div class="f-l pos-r pl-80">
										<label class="lb w-80">
											<c:if test="${mustfill.columns.promiseTime}">
												<em class="mark"></em>
											</c:if>
											预约日期：
										</label>
										<input id="promiseTime" type="text" onfocus="WdatePicker({minDate: '%y-%M-%d' })" class="input-text w-120 readonly" disabled="disabled" name="promiseTime"
											value="<fmt:formatDate value='${order.promiseTime }' pattern='yyyy-MM-dd'/>" />
									</div>
									<div class="f-l pos-r pl-80">
										<label class="lb w-80">
											<c:if test="${mustfill.columns.promiseLimit}">
												<em class="mark"></em>
											</c:if>
											时间要求：
										</label>
										<select id="promiseLimit" class="select w-120 f-l readonly" name="promiseLimit" disabled="disabled">
											<option value="">请选择</option>
											<c:set var="isDoing" value="0" />
											<c:forEach items="${proLimitList}" var="serm">
												<option value="${serm }" ${order.promiseLimit eq serm ?'selected':''}>${serm }</option>
												<c:if test="${order.promiseLimit eq serm}">
													<c:set var="isDoing" value="1" />
												</c:if>
											</c:forEach>
											<c:if test="${isDoing != 1 and not empty order.promiseLimit}">
												<option value="${order.promiseLimit }" selected="selected">${order.promiseLimit }</option>
											</c:if>
										</select>
									</div>
								</div>
								<div class="cl mt-10">
									<div class="f-l pos-r pl-100 h-50">
										<label class="lb w-100">
											<c:if test="${mustfill.columns.customerFeedback}">
												<em class="mark"></em>
											</c:if>
											服务描述：
										</label>
										<textarea type="text" class="input-text w-380 h-50 readonly" readonly="readonly" id="customerFeedback" name="customerFeedback">${order.customerFeedback}</textarea>
									</div>
									<div class="f-l pos-r pl-80 h-50">
										<label class="lb w-80">
											<c:if test="${mustfill.columns.remarks}">
												<em class="mark"></em>
											</c:if>
											备注：
										</label>
										<textarea type="text" class="input-text h-50 w-320 readonly" readonly="readonly" id="remarks" name="remarks">${order.remarks}</textarea>
									</div>
								</div>


								<div class="cl mt-10">
									<div class="f-l pos-r pl-100">
										<label class="lb w-100">
											<c:if test="${mustfill.columns.applianceModel}">
												<em class="mark"></em>
											</c:if>
											产品型号：
										</label>
										<input type="text" class="input-text w-160 readonly" readonly="readonly" id="applianceModel" name="applianceModel" value="${order.applianceModel}" />
									</div>
									<div class="f-l pos-r pl-100">
										<label class="lb w-100">
											<c:if test="${mustfill.columns.applianceNum}">
												<em class="mark"></em>
											</c:if>
											产品数量：
										</label>
										<input type="text" class="input-text w-120 readonly" readonly="readonly" id="applianceNum" name="applianceNum" value="${order.applianceNum }" />
									</div>
									<div class="f-l pos-r pl-80 wrapss">
										<label class="lb w-80">
											<c:if test="${mustfill.columns.applianceBarcode}">
												<em class="mark"></em>
											</c:if>
											内机条码：
										</label>
										<input type="text" style="width: 180px;" class="input-text  readonly" readonly="readonly" id="applianceBarcode" name="applianceBarcode" value="${order.applianceBarcode}"
											title="${order.applianceBarcode}" />
										<span class="weishu1" hidden="hidden">
											(
											<span id="incodeNum">0</span>
											位 )
										</span>
										<span class="ml-2 code1" hidden="hidden">
											<a href="javascript:showQRCode('${order.siteId }','1');" class="sficon sficon-scancode"></a>
										</span>
										<span class="va-t underline c-fe0101 codeConnectShow cPointer " preData="${order.applianceBarcode}" id="codeInshow"></span>
									</div>

								</div>
								<div class="cl mt-10">
									<div class="f-l pos-r pl-100">
										<label class="lb w-100">
											<c:if test="${mustfill.columns.applianceBuyTime}">
												<em class="mark"></em>
											</c:if>
											购买日期：
										</label>
										<input type="text" onfocus="WdatePicker({startDate:'1970-01-01'})" class="input-text w-160 readonly ptime" readonly="readonly" id="applianceBuyTime"
											name="applianceBuyTime" value="<fmt:formatDate value='${order.applianceBuyTime }' pattern='yyyy-MM-dd'/>" />
									</div>
									<div class="f-l pos-r pl-100">

										<c:choose>
											<c:when test="${not empty malllist}">
												<label class="lb w-100">
													<c:if test="${mustfill.columns.pleaseReferMall}">
														<em class="mark">*</em>
													</c:if>
													购机商场：
												</label>
												<span class="w-120">
													<select class="select ${mustfill.columns.pleaseReferMall?'mustfill':''} readonly" disabled="diabled" id="pleaseReferMall" multiline="false" name="pleaseReferMall"
														style="width: 100%; height: 25px" panelMaxHeight="300px" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请选择购机商场"</c:if>>
														<option value="">请选择</option>
														<c:set var="hadMall" value="0"></c:set>
														<c:forEach items="${malllist }" var="mall">
															<c:if test="${mall.columns.mall_name eq order.pleaseReferMall}">
																<c:set var="hadMall" value="1"></c:set>
															</c:if>
															<option value="${mall.columns.mall_name } " ${order.pleaseReferMall eq mall.columns.mall_name ?'selected':''}>${mall.columns.mall_name }</option>
														</c:forEach>
														<c:if test="${hadMall eq '0' and not empty order.pleaseReferMall}">
															<option value="${order.pleaseReferMall}" selected>${order.pleaseReferMall}</option>
														</c:if>
													</select>
												</span>
											</c:when>
											<c:otherwise>
												<label class="lb w-100">
													<c:if test="${mustfill.columns.pleaseReferMall}">
														<em class="mark">*</em>
													</c:if>
													购机商场：
												</label>
												<input type="text" value="${order.pleaseReferMall}" name="pleaseReferMall" class="input-text w-120 ${mustfill.columns.pleaseReferMall?'mustfill':''} readonly"
													readonly="readonly" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请输入购机商场"</c:if>>
											</c:otherwise>
										</c:choose>
									</div>
									<div class="f-l pos-r pl-80 wrapss">
										<label class="lb w-80">
											<c:if test="${mustfill.columns.applianceMachineCode}">
												<em class="mark"></em>
											</c:if>
											外机条码：
										</label>
										<input type="text" style="width: 180px;" class="input-text  readonly" readonly="readonly" id="applianceMachineCode" name="applianceMachineCode"
											value="${order.applianceMachineCode}" title="${order.applianceMachineCode}" />
										<span class="ml-2 mr-2 weishu2" hidden="hidden">
											(
											<span id="outcodeNum">0</span>
											位 )
										</span>
										<span class="ml-2 mr-2 code2" hidden="hidden">
											<a href="javascript:showQRCode('${order.siteId }','2');" class="sficon sficon-scancode"></a>
										</span>
										<span class="va-t underline c-fe0101 codeConnectShow cPointer" preData="${order.applianceMachineCode}" id="codeOutshow"></span>
									</div>

								</div>
								<div class="mt-10 cl mb-10">
									<div class="f-l">
										<label class="f-l w-100">
											<c:if test="${mustfill.columns.warrantyType}">
												<em class="mark"></em>
											</c:if>
											保修类型：
										</label>
										<select class="select w-160 readonly " name="warrantyType" disabled="disabled" id="warrantyType">
											<option value="">请选择</option>
											<c:if test="${order.warrantyType eq '1' }">
												<option value="1" selected="selected">保内</option>
												<option value="2">保外</option>
											</c:if>
											<c:if test="${order.warrantyType eq '2' }">
												<option value="1">保内</option>
												<option value="2" selected="selected">保外</option>
											</c:if>
											<c:if test="${order.warrantyType ne '1' && order.warrantyType ne '2'}">
												<option value="1">保内</option>
												<option value="2">保外</option>
											</c:if>
										</select>
									</div>
									<div class="f-l pos-r pl-100">
										<label class="pos w-100">
											<c:if test="${mustfill.columns.level}">
												<em class="mark"></em>
											</c:if>
											重要程度：
										</label>
										<select class="select w-120 readonly" name="level" id="level" disabled="disabled">
											<option value="">请选择</option>
											<option value="1" <c:if test="${order.level eq '1' }">selected="selected"</c:if>>紧急</option>
											<option value="2" <c:if test="${order.level eq '2' }">selected="selected"</c:if>>一般</option>
										</select>
									</div>
									<div class="f-l">
										<label class="f-l w-80">报修时间：</label>
										<input type="text" class="input-text w-130  readonly dischange" readonly="readonly" name="repairTime"
											value="<fmt:formatDate value='${order.repairTime }' pattern='yyyy-MM-dd HH:mm:ss'/>" />
									</div>
									<div class="f-l pos-r pl-80">
										<label class="pos w-80">登记人：</label>
										<input type="text" class="input-text w-110 readonly dischange" readonly="readonly" name="messengerName" value="${order.xm}" />
									</div>
								</div>
							</div>
							<div class="tabCon pt-10">
								<div class="processWrap">
									<div id="repImgprocess">
										<c:forEach items="${repairImgs }" var="str" varStatus="da">
											<div class="f-l imgWrap1" id="img${da.index}">
												<div class="imgWrap">
													<img src="${commonStaticImgPath}${str}" id="${commonStaticImgPath}${str}"></img>
												</div>
												<a class="sficon btn-delimg" onclick="deletereImg('img${da.index}')" style="display: none;"></a>
												<input type="hidden" value="${str}" name="bdImgs">
											</div>
										</c:forEach>
									</div>
									<div class="f-l mr-10">
										<div class="imgWrap jiahao hide" id="jiahaore">
											<div id="repairImgsPicker-add">
												<a href="javascript:;" class="btn-upload"></a>
											</div>
											<p class="lh-20">最多可上传4张照片</p>
										</div>
									</div>
								</div>
							</div>
						</form>

						<div class="tabCon pt-10">
							<div class="processWrap">
								<c:forEach var="pros" items="${fns:getOrderProcess(order.processDetail)}">
									<p class="processItem">
										<span class="time">${pros.time}</span>
										<span>${pros.content}</span>
									</p>
								</c:forEach>
							</div>
						</div>
						<div class="tabCon pt-10">
							<div class="processWrap">
								<c:forEach var="pros" items="${fns:getOrderDistribution(order.id)}">
									<p class="processItem">
										<span class="time">配送单号：${pros.columns.distribution_number}</span>
										<span class='ml-30'>配送日期：${pros.columns.distribution_time}</span>
										<span class='ml-30'>车牌号码：${pros.columns.plate_number}</span>
										<span class='ml-30'>配送人员：${pros.columns.driver_name}</span>
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
							<a href="javascript:;" class="tabswitch">回访</a>
							<a href="javascript:showGoodsMsg();" class="tabswitch">商品信息</a>
						</div>
						<div class="tabCon">
							<div class="cl mt-10">
								<div class="f-l pos-r txtwrap1">
									<label class="lb lb1">服务工程师：</label>
									<span class="w-160 dropdown-sin-2 hide">
										<select class="select w-160 " id="statusFlag" multiple="true" multiline="false" name="employeNames" style="height: 25px" panelMaxHeight="130px">
											<!-- <select class="select "  name="employeNames" class="input-text w-140 readonly"  readonly="readonly"> -->
											<c:forEach items="${fns:getEmloyeList(siteId) }" var="emp">
												<option value="${emp.columns.id }"
													<c:forEach var = "ename" items="${emName }"><c:if test="${emp.columns.name eq ename.columns.name}">selected="selected"</c:if></c:forEach>>${emp.columns.name }</option>
											</c:forEach>
										</select>
									</span>
									<input name="emN" type="text" class="input-text w-160 readonly" readonly="readonly" value="${order.employeName}" title="手机号：${msg2Mobiles}" />
								</div>
								<div class="f-l pos-r pl-100">
									<label class="lb w-100">服务状态：</label>
									<input type="text" name="fankui" class="input-text w-120 readonly" readonly="readonly" value="${dispStatus}" />
								</div>
								<div class="f-l pos-r txtwrap2">
									<label class="lb lb2">故障现象：</label>
									<input type="text" name="fankui" class="input-text w-120 readonly" readonly="readonly" value="${order.malfunctionType}" />
								</div>
								<div class="f-l pos-r txtwrap2">
									<label class="lb lb2">完工时间：</label>
									<input type="text" class="input-text w-130  readonly " readonly="readonly" name="repairTime"
										value="<fmt:formatDate value='${order.endTime }' pattern='yyyy-MM-dd HH:mm:ss'/>" />
								</div>
							</div>
							<div class="cl mt-10">
								<div class="f-l pos-r txtwrap1">
									<label class="lb lb1">收费总额：</label>
									<div class="priceWrap w-140 readonly">
										<input type="text" name="fankui" class="input-text readonly" readonly="readonly" value="${fns:getOrderTotalFee(order.auxiliaryCost, order.serveCost, order.warrantyCost)}" />
										<span class="unit">元</span>
									</div>
								</div>
								<div class="f-l pl-10 ">
									<label class="f-l">（辅材收费：</label>
									<div class="priceWrap w-80 readonly f-l">
										<input type="text" name="fankui" class="input-text readonly" readonly="readonly" value="${order.auxiliaryCost}" />
										<span class="unit">元</span>
									</div>
								</div>
								<div class="f-l pl-10 ">
									<label class="f-l">服务收费：</label>
									<div class="priceWrap w-80 readonly f-l">
										<input type="text" name="fankui" class="input-text readonly" readonly="readonly" value="${order.serveCost}" />
										<span class="unit">元</span>
									</div>
								</div>
								<div class="f-l pl-10 ">
									<label class="f-l">延保收费：</label>
									<div class="priceWrap w-80 readonly f-l">
										<input type="text" name="fankui" class="input-text readonly" readonly="readonly" value="${order.warrantyCost}" />
										<span class="unit">元</span>
									</div>
								</div>
								<span class="pd-5 f-l">）</span>
								<c:if test="${not empty collectionslist}">
									<c:forEach items="${collectionslist}" var="col">
										<c:set value="${sum + col.columns.payment_amount}" var="sum" />
									</c:forEach>
									<div class="f-l lh-26">
										<div>
											无现金收款：${sum}元
											<a class="proofImg c-0383dc" id="imgshow">
												凭证
												<c:forEach items="${collectionslist}" var="col">
													<c:if test="${not empty col.columns.imgs}">
														<img src="${commonStaticImgPath}${col.columns.imgs}" />
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
									<div class="readonly processWrap2" style="width: 807px">
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
								<div class="pos-r txtwrap1 hm-80" id="Imgprocess2">
									<label class="lb lb1">
										过程图片：
										<c:if test="${feedbackInfo.isbackImg }">
											<a style='color: red; cursor: pointer; text-decoration: underline;' href="${ctx}/download/DownloadOrderFeedbackImg?orderId=${order.id}&siteId=${order.siteId }"
												target="_blank">（图片下载）</a>
										</c:if>
									</label>
									<c:forEach var="fbImgItems" items="${feedbackInfo.feedbackImgs}">
										<c:if test="${not empty fbImgItems.fbImgPath }">
											<c:forEach var="fbImgItem" items="${fbImgItems.fbImgPath}">
												<div class="f-l imgWrap1" id="img${da.index}">
													<div class="imgWrap">
														<img src="${commonStaticImgPath}${fbImgItem}"></img>
														<p class="lh-20">${fbImgItems.fbImgTime}</p>
													</div>
													<sfTags:pagePermission authFlag="ORDER_OTHERS_DELPROCESSIMG_BTN"
														html='<a class="sficon btn-delimg" onclick="deleteProcessImg(\'${fbImgItems.feedbackId}\',\'${fbImgItem}\',this)"></a>'></sfTags:pagePermission>
												</div>
											</c:forEach>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>

						<div class="tabCon">
							<table id="pjsq" class="table table-border table-bordered table-bg table-relatedorder">
								<caption>工单关联配件申请</caption>
								<thead>
									<tr>
										<th class="w-180">备件条码</th>
										<th class="w-260">备件名称</th>
										<th class="w-120">备件型号</th>
										<th class="w-50">数量</th>
										<th class="w-70">状态</th>
									</tr>
								</thead>
							</table>
							<div class="cl mt-10 pos-r txtwrap1 showimg"></div>
						</div>
						<div class="tabCon">
							<div class="cl text-c">
								<span class="caption_lb">工单关联配件使用</span>
								<input onclick="useFit()" type="button" class="btn-usebj mr-20 w-70 mt-5 sfbtn sfbtn-opt f-r pos-r" value="备件使用" />
							</div>
							<div class="" style="max-height: 140px; overflow: auto;">
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
							<div style="width: 920px; overflow: auto;">
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
							<div class="cl mt-10 pos-r txtwrap1" id="oldfittingimg"></div>
						</div>

						<div class="tabCon">
							<div class="cl mt-10">
								<div class="f-l pos-r txtwrap1">
									<label class="lb lb1">交回卡单：</label>
									<input type="text" class="input-text w-160 readonly" readonly="readonly" value="${extendedOrder.translatedReturnCard}" />
								</div>
								<div class="f-l pos-r pl-100">
									<label class="lb w-100">服务态度：</label>
									<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${extendedCallback.translatedServiceAttitude}" />
								</div>
								<div class="f-l pos-r txtwrap2">
									<label class="lb lb2">安全评价：</label>
									<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${extendedCallback.translatedSafeEval}" />
								</div>
								<div class="f-l pos-r txtwrap2">
									<label class="lb lb2">多次上门：</label>
									<input type="text" class="input-text w-130 readonly" readonly="readonly" value="${extendedCallback.translatedMultipleDropIn}" />
								</div>
							</div>
							<div class="cl mt-10">
								<div class="f-l pos-r txtwrap1">
									<label class="lb lb1">保修类型：</label>
									<input type="text" class="input-text w-160 readonly" readonly="readonly" value="${extendedOrder.translatedWarrantyType}" />
								</div>
								<div class="f-l pos-r pl-100">
									<label class="lb w-100">是否交款：</label>
									<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${extendedOrder.translatedWhetherCollection}" />
								</div>
								<div class="f-l pos-r txtwrap2">
									<label class="lb lb2">交款总额：</label>
									<div class="priceWrap w-120 readonly">
										<input type="text" class="input-text readonly" readonly="readonly" value="${fns:getOrderTotalFee(order.auxiliaryCost, order.serveCost, order.warrantyCost)}" />
										<span class="unit">元</span>
									</div>
								</div>
								<div class="f-l pos-r txtwrap2">
									<label class="lb lb2">回访总额：</label>
									<div class="priceWrap w-130 readonly">
										<input type="text" class="input-text readonly" readonly="readonly" value="${order.callbackCost}" />
										<span class="unit">元</span>
									</div>
								</div>

							</div>
							<div class="cl mt-10">
								<div class="f-l pos-r txtwrap1">
									<label class="lb lb1">回访结果：</label>
									<input type="text" class="input-text w-160 readonly" readonly="readonly" value="${extendedCallback.translatedResult}" />
								</div>
								<div class="f-l pos-r pl-100">
									<label class="lb w-100">实收总额：</label>
									<div class="priceWrap w-120 readonly">
										<input type="text" class="input-text readonly" readonly="readonly" value="${order.confirmCost}" />
										<span class="unit">元</span>
									</div>
								</div>
								<div class="f-l pos-r pl-20">
									<c:if test="${userType eq '2'}">
										<a class="c-0383dc" href="#" onclick="confirmCollection()">修改</a>
									</c:if>
								</div>
							</div>


							<div class="pos-r mt-10 txtwrap1">
								<label class="lb lb1">回访内容：</label>
								<c:if test="${cbInfo.columns.remarks eq null}">
									<textarea class="textarea h-50 readonly" readonly="readonly" style="width: 807px"></textarea>
								</c:if>
								<c:if test="${cbInfo.columns.remarks ne null}">
									<textarea class="textarea h-50 readonly" readonly="readonly" style="width: 807px"><fmt:formatDate value='${cbInfo.columns.create_time}'
											pattern='yyyy-MM-dd HH:mm:ss' />  ${userLogna} : ${cbInfo.columns.remarks}</textarea>
								</c:if>
							</div>
						</div>
						<div class="tabCon">
							<div style="width: 920px; overflow: auto;">
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
					<c:if test="${'7' ne order.orderType}">
						<sfTags:pagePermission authFlag="ORDER_MODORDER_BTN_OTHERS" html='<input id="xggd" class="sfbtn sfbtn-opt" value="修改工单" type="button" />'></sfTags:pagePermission>
						<sfTags:pagePermission authFlag="ORDER_WXORDER_BTN_OTHERS"
							html='<input class="sfbtn sfbtn-opt sbtn" id="wxgd" onclick="showwxgd(\'${order.orderType}\')" value="无效工单" type="button"/>'></sfTags:pagePermission>
					</c:if>
					<sf:hasPermission perm="ORDERMGM_STAYVISTORDER_PERM_ZJFD_BTN">
						<input class="sfbtn sfbtn-opt zjfd sbtn" onclick="showzjfd()" value="直接封单" type="button" />
					</sf:hasPermission>
					<c:if test="${order.status eq 3 }">
						<input class="sfbtn sfbtn-opt sbtn" value="短信通知" onclick="senMagPopup('${order.id}')" type="button" />
					</c:if>
					<input class="sfbtn sfbtn-opt sbtn" id="repeteWrite" type="button" value="打印工单" target="_blank" onclick="dygd('${order.id}')" />
					<input class="sfbtn sfbtn-opt sbtn" id="repeatOrder_custom" type="button" onclick="dygdcustom('${order.id}')" value="打印工单" style="display: none;" />
					<c:if test="${newOrder!='2'}">
						<sfTags:pagePermission authFlag="ORDER_ADDNEWORDER_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="新建工单" type="button" onclick="newOrder(\'${order.id}\')"/>'></sfTags:pagePermission>
					</c:if>
					<c:if test="${not empty feedBackDetail}">
						<sfTags:pagePermission authFlag="ORDER_REFEEDBACKCLOSE_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="重新反馈封单" type="button" id="btn-fbOrder" />'></sfTags:pagePermission>
					</c:if>
					<c:if test="${empty feedBackDetail}">
						<sfTags:pagePermission authFlag="ORDER_FEEDBACKCLOSE_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="反馈封单" type="button" id="btn-fbOrder" />'></sfTags:pagePermission>
					</c:if>
					<%--<input class="sfbtn sfbtn-opt sbtn" value="${not empty feedBackDetail ? '重新反馈封单' : '反馈封单'}" type="button" id="btn-fbOrder" />--%>
					<input class="sfbtn sfbtn-opt sbtn" value="${order.status eq '4' ? '重新回访' : '回访'}" type="button" onclick="showCallbackForm()" id="callbackBtn" />
					<c:if test="${jsSetRd eq null }">
						<sfTags:pagePermission authFlag="ORDER_SETTLEMENT_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="结算" type="button" onclick="showjiesuanForm()"/>'></sfTags:pagePermission>
					</c:if>
					<c:if test="${jsSetRd ne null }">
						<c:choose>
							<c:when test="${jsSetRd.columns.set_value eq '0' || jsSetRd.columns.set_value eq '2'}">
								<c:if test="${cbInfo.columns.result eq '1'  }">
									<sfTags:pagePermission authFlag="ORDER_SETTLEMENT_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="结算" type="button" onclick="showjiesuanForm()"/>'></sfTags:pagePermission>
								</c:if>
							</c:when>
							<c:otherwise>
								<sfTags:pagePermission authFlag="ORDER_SETTLEMENT_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="结算" type="button" onclick="showjiesuanForm()"/>'></sfTags:pagePermission>
							</c:otherwise>
						</c:choose>
					</c:if>
					<sfTags:pagePermission authFlag="ORDER_MARKORDER_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="标记工单" type="button" onclick="showMarkOrder(\'${order.id}\')"/>'></sfTags:pagePermission>

					<c:if test="${whereMark eq 1 }">
						<div class="btnWrap text-c " style="bottom: 0">
							<a class="sfbtn sfbtn-opt3 sbtn" onclick="previousOrder('${order.id}','${order.number }')">上一单</a>
							<a class="sfbtn sfbtn-opt3 sbtn" onclick="nextOrder('${order.id}','${order.number }')">下一单</a>
						</div>
					</c:if>
				</div>

			</div>

		</div>
	</div>
	<!-- 直接封单提示框 -->
	<div class="popupBox notDispatch showzjfddiv">
		<h2 class="popupHead">
			直接封单
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain ">
				<div class="txtwrap1 pos-r mb-30">
					<label class="lb lb1">
						<em class="mark">*</em>
						直接封单理由：
					</label>
					<textarea id="reasonofzjfd" class="textarea"></textarea>
				</div>
				<div class="text-c pl-30">
					<input onclick="savezjfd('${order.id}')" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
					<input type="button" onclick="cancerBox()" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
				</div>
			</div>
		</div>
	</div>

	<!-- 回访结算工单下的 -->
	<div class="popupBox msgText msgText2" style="height: 232px;">
		<h2 class="popupHead">
			发送短信
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer" style="height: 192px; overflow: auto;">
			<div class="popupMain pd-20" id="msgWrap2">
				<div class="tabBarP ">
					<a href="javascript:;" class="tabswitch current">模板发送</a>
					<a href="javascript:;" class="tabswitch ">编辑发送</a>
				</div>
				<div class="tabCon">
					<div class="pos-r pl-70 pr-80 mt-10">
						<span class="lb w-70 text-c">发送内容：</span>
						<div class="bk-gray pd-10">
							<input type="text" class="msg-input" id="custName" value="${order.customerName }" onkeyup="inputWidth(this)" />
							你好，
							<input type="text" class="msg-input" id="siteNameMobile" value="${siteName }（${jdPhone }）" onkeyup="inputWidth(this)" />
							诚邀您回复数字对本次服务进行评：1.满意；2.一般；3.不满意；4.尚未联系；5.正在处理中，还未处理好。感谢您的支持！ 【
							<input type="text" class="msg-input" value="${serviceName }" id="serviceName1" onkeyup="inputWidth(this)" />
							服务】
						</div>
						<div id="onlyOne"></div>
					</div>
				</div>
				<div class="tabCon">
					<p class="c-f55025 f-12 lh-30">注：自定义文字内容需要人工审核，等待时间较长</p>
					<div class="pr-80 pos-r">
						<div class="bk-gray">
							<textarea class="textarea radius" placeholder="请输入短信内容" id="content" style="border-width: 0; height: 60px;"></textarea>
							<div class="h-26">
								<p class="f-r">
									【
									<input type="text" class="msg-input" value="${serviceName }" id="serviceName2" value="捷成家电" onkeyup="inputWidth(this)" />
									服务】
								</p>
							</div>
						</div>
						<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg " onclick="sendMsg()">发送</a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="popupBox msgText msgTextdefined" style="height: 270px;">
		<h2 class="popupHead">
			发送短信
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer" style="height: 230px; overflow: auto;">
			<div class="popupMain pd-20" id="msgWrapdef">
				<div class="tabBarP ">
					<a href="javascript:;" class="tabswitch current">模板发送</a>
					<a href="javascript:;" class="tabswitch ">编辑发送</a>
				</div>
				<div class="tabCon">
					<div class="pos-r pl-70 pr-80 mt-10">
						<label class="lb w-70 text-r">选择模板：</label>
						<span class="select-box w-160">
							<select class="select radius h-26" id="select-msgmodedef" name="selectModel" onchange="selectMsgMoulddef(this)">
								<c:forEach items="${definedmodel}" var="def">
									<option value="${def.columns.id }">${def.columns.name }(自定义)</option>
								</c:forEach>
							</select>
						</span>
					</div>
					<div class=" defmsgmould">
						<div class="pos-r pl-70 pr-80 mt-10">
							<span class="lb w-70 text-c">发送内容：</span>
							<div class="bk-gray pd-10 defmsgcontent">
								<%--<input type="text" class="msg-input" value="${order.customerName }" onkeyup="inputWidth(this)"/>您好，
							因店内配件无库存，现已紧急调度，配件到位后，具体上门时间，
							<input type="text" class="msg-input" value="${msg1}" onkeyup="inputWidth(this)"/>，
							会与您联系的，监督电话：<input type="text" class="msg-input" value="${jdPhone }" onkeyup="inputWidth(this)"/>。
							【<input type="text" class="msg-input" value="${serviceName }" id="sign5" onkeyup="inputWidth(this)"/>服务】--%>
							</div>
							<div id="defsendModel"></div>
						</div>
					</div>
				</div>
				<div class="tabCon">
					<p class="c-f55025 f-12 lh-30">注：自定义文字内容需要人工审核，等待时间较长</p>
					<div class="pr-80 pos-r">
						<div class="bk-gray">
							<textarea class="textarea radius" placeholder="请输入短信内容" id="contentdef" style="border-width: 0; height: 60px;"></textarea>
							<div class="h-26">
								<p class="f-r">
									【
									<input type="text" class="msg-input" value="${serviceName }" id="signdef" onkeyup="inputWidth(this)" />
									服务】
								</p>
							</div>
						</div>
						<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg  " onclick="defsendMsgConfirm()">发送</a>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="popupBox similarOrder">
		<h2 class="popupHead">
			相似工单提醒
			<a href="#" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer pos-r">
			<div class="popupMain pt-20 pb-20 pl-10 ">
				<div class="cl mb-15">
					<div class="f-l gdxqbox">
						<p class="text-c mb-10">
							<span class="title title1">当前工单</span>
						</p>
						<ul class="gdxqlist" id="gdxqlist1">
							<li>
								<span class="lb">工单编号：</span>
								<p class="txt text-overflow">${order.number }</p>
							</li>
							<li>
								<span class="lb">接入时间：</span>
								<p class="text-overflow txt" id="createTime_ta">
									<fmt:formatDate value='${order.createTime }' pattern='yyyy-MM-dd HH:mm:ss' />
								</p>
							</li>
							<li>
								<span class="lb">服务工程师：</span>
								<p class="text-overflow txt">${order.employeName }</p>
							</li>
							<li>
								<span class="lb">用户姓名：</span>
								<p class="text-overflow txt">${order.customerName }</p>
							</li>
							<li>
								<span class="lb">联系电话：</span>
								<p class="text-overflow txt">${order.customerMobile }</p>
							</li>
							<li>
								<span class="lb">家电信息：</span>
								<p class="text-overflow txt">${order.applianceBrand }${order.applianceCategory }</p>
							</li>
							<li>
								<span class="lb">服务类型：</span>
								<p class="text-overflow txt">${order.serviceType }</p>
							</li>
							<li>
								<span class="lb">用户地址：</span>
								<p class="text-overflow txt">${order.province }${order.city }${order.area }${order.customerAddress }</p>
							</li>
						</ul>
					</div>
					<div class="f-l gdxqbox2">
						<p class="text-c mb-10">
							<span class="title title1">相似工单</span>
							<!--<span class="title title2">未结算</span>-->
							<span class="title title3" id="title3">未完工已结算</span>
						</p>
						<ul class="gdxqlist" id="gdxqlist2">
							<li>
								<span class="lb">工单编号：</span>
								<p class="txt text-overflow" id="xsnumber"></p>
							</li>
							<li>
								<span class="lb">接入时间：</span>
								<p class="text-overflow txt" id="xscreateTime"></p>
							</li>
							<li>
								<span class="lb">服务工程师：</span>
								<p class="text-overflow txt" id="xsemployeName"></p>
							</li>
							<li>
								<span class="lb">用户姓名：</span>
								<p class="text-overflow txt" id="xscustomerName"></p>
							</li>
							<li>
								<span class="lb">联系电话：</span>
								<p class="text-overflow txt" id="xscustomerMobile"></p>
							</li>
							<li>
								<span class="lb">家电信息：</span>
								<p class="text-overflow txt" id="xsapplianceBrand"></p>
							</li>
							<li>
								<span class="lb">服务类型：</span>
								<p class="text-overflow txt" id="xserviceType"></p>
							</li>
							<li>
								<span class="lb">用户地址：</span>
								<p class="text-overflow txt" id="xscustomerAddress"></p>
							</li>
						</ul>
					</div>
				</div>

				<div class="text-c mt-30">
					<a href="javascript:fengdanOrder();" class="sfbtn sfbtn-opt w-120 mr-5">直接封单,不结算</a>
					<a href="javascript:closesimilarOrder();" class="sfbtn sfbtn-opt3 w-70 mr-5">取消</a>
				</div>
			</div>
		</div>
	</div>

	<div class="popupBox fbOrder">
		<h2 class="popupHead">
			重新反馈封单
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<form action="" id="generationOrderFrom">
				<div class="popupMain">
					<div class="pcontent  pd-15">
						<div id="fbBaseInfo">
							<div class="tabBarP cl">
								<a href="javascript:;" class="tabswitch current">服务信息</a>
							</div>
							<div class="tabCon">
								<div>
									<input type="hidden" name="orderId" value="${order.id }" datatype="*">
									<input type="hidden" name="disOrderId" value="${disOrder.columns.id }" datatype="*">
									<div class="cl mt-10">
										<div class="f-l pos-r txtwrap1">
											<label class="lb lb1">反馈类型：</label>
											<input type="text" class="input-text w-110 readonly" readonly="readonly" name="feedbackType1" value="服务完成" />
											<input type="text" class="input-text w-110 readonly" hidden="hidden" name="feedbackType" value="1" />
										</div>
										<div class="f-l pos-r txtwrap2">
											<label class="lb lb2">服务类型：</label>
											<span class="select-box w-110">
												<select class="select" name="serviceType">
													<c:forEach items="${fns:getServiceTypeDer(order.serviceType) }" var="stype">
														<c:if test="${stype.columns.name eq order.serviceType}">
															<option value="${stype.columns.name }" selected="selected">${stype.columns.name }</option>
														</c:if>
														<c:if test="${stype.columns.name ne order.serviceType}">
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
													<c:forEach items="${fns:getNewServiceModeDer(order.serviceMode) }" var="stype">
														<c:if test="${stype.columns.name eq order.serviceMode}">
															<option value="${stype.columns.name }" selected="selected">${stype.columns.name }</option>
														</c:if>
														<c:if test="${stype.columns.name ne order.serviceMode}">
															<option value="${stype.columns.name }">${stype.columns.name }</option>
														</c:if>
													</c:forEach>
												</select>
											</span>
										</div>
										<div class="f-l pos-r txtwrap2">
											<label class="lb lb2">服务工程师：</label>
											<input type="text" class="input-text w-130 readonly" readonly="readonly" value="${order.employeName }" />
										</div>
									</div>
									<div class="cl mt-10">
										<div class="f-l pos-r txtwrap1">
											<label class="lb lb1">家电品类：</label>
											<span class="select-box w-110">
												<select class="select" name="applianceCategory">
													<c:set var="dovalue" value="0" />
													<c:forEach items="${category }" var="ca" varStatus="cast">
														<c:if test="${ca.columns.name eq order.applianceCategory}">
															<option value="${ca.columns.name }" selected="selected">${ca.columns.name }</option>
															<c:set var="dovalue" value="1" />
														</c:if>
														<c:if test="${ca.columns.name ne order.applianceCategory}">
															<option value="${ca.columns.name }">${ca.columns.name }</option>
														</c:if>
													</c:forEach>
													<c:if test="${dovalue eq 0}">
														<option value="${order.applianceCategory}" selected>${order.applianceCategory}</option>
													</c:if>
												</select>
											</span>
										</div>
										<div class="f-l pos-r txtwrap2">
											<label class="lb lb2">产品型号：</label>
											<input type="text" class="input-text w-110" value="${order.applianceModel}" name="applianceModel" />
										</div>
										<div class="f-l pos-r txtwrap2">
											<label class="lb lb2">内机条码：</label>
											<input type="text" class="input-text w-110" value="${order.applianceBarcode}" name="applianceBarcode" />
										</div>
										<div class="f-l pos-r txtwrap2">
											<label class="lb lb2">外机条码：</label>
											<input type="text" class="input-text w-130" value="${order.applianceMachineCode}" name="applianceMachineCode" />
										</div>
									</div>
									<div class="cl mt-10">
										<div class="f-l pos-r txtwrap1">
											<label class="lb lb1">保修类型：</label>
											<span class="select-box w-110">
												<select class="select" id="warrantyType1" name="warrantyType">
													<c:choose>
														<c:when test="${order.warrantyType eq '1'}">
															<option value="1" selected="selected">保内</option>
															<option value="2">保外</option>
														</c:when>
														<c:when test="${order.warrantyType eq '2'}">
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
											<label class="lb lb2">故障现象：</label>
											<input type="text" class="input-text " style="width: 553px;" value="${order.applianceModel}" id="malfunctionType1" name="malfunctionType" />
										</div>
									</div>
									<div class="pos-r mt-10 txtwrap1">
										<label class="lb lb1">反馈描述：</label>
										<c:if test="${not empty feedBackDetail }">
											<input type="text" class="input-text" name="feedback" value="${feedBackDetail.columns.feedback }" />
											<input type="text" class="input-text" hidden="hidden" name="feedbackId" id="feedbackId" value="${feedBackDetail.columns.id }" />
										</c:if>
										<c:if test="${empty feedBackDetail }">
											<input type="text" class="input-text" name="feedback" value="" />
											<input type="text" class="input-text" hidden="hidden" name="feedbackId" id="feedbackId" value="" />
										</c:if>
									</div>
									<div class="pos-r mt-10 txtwrap1 cl ">
										<label class="lb lb1">过程图片：</label>
										<div id="Imgprocess1" class="f-l">
											<c:if test="${not empty feedImgs }">
												<c:forEach items="${feedImgs }" var="str" varStatus="da">
													<div class="f-l imgWrap1" id="img${da.index}">
														<div class="imgWrap">
															<img src="${commonStaticImgPath}${str}" id="${commonStaticImgPath}${str}"></img>
														</div>
														<a class="sficon btn-delimg" onclick="deleteImg('img${da.index}')"></a>
														<input type="hidden" value="${str}" name="pickerImg">
													</div>
												</c:forEach>
											</c:if>
										</div>
										<div id="Imgprocess" class="f-l"></div>
										<div class="f-l mr-10">
											<div class="imgWrap jiahao" id="jiahao">
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
						<div class="tabBarP cl mt-10">
							<a href="javascript:;" class="tabswitch current">备件使用</a>
							<input onclick="useFit()" type="button" class="btn-usebj mr-10 w-70 sfbtn sfbtn-opt f-r" value="备件使用" />
						</div>
						<div class="" style="max-height: 160px; overflow: auto;">

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
						<div class="tabCon" style="display: block">
							<div>
								<div class="cl mt-10">
									<div class="f-l pos-r txtwrap1">
										<label class="lb lb1">服务收费：</label>
										<div class="priceWrap w-110">
											<input type="text" class="input-text" name="serveCost" id="serveCost" onchange="cost()" value="${order.serveCost }" />
											<span class="unit">元</span>
										</div>
									</div>
									<div class="f-l pos-r txtwrap2">
										<label class="lb lb2">辅材收费：</label>
										<div class="priceWrap w-110 readonly">
											<input type="text" class="input-text readonly" id="auxiliaryCost" value="${order.auxiliaryCost }" readonly="readonly" name="auxiliaryCost" onchange="cost()" />
											<span class="unit">元</span>
										</div>
									</div>
									<div class="f-l pos-r txtwrap2">
										<label class="lb lb2">延保收费：</label>
										<div class="priceWrap w-110">
											<input type="text" class="input-text" id="warrantyCost" name="warrantyCost" value="${order.warrantyCost }" onchange="cost()" />
											<span class="unit">元</span>
										</div>
									</div>
									<div class="f-l pos-r txtwrap2">
										<label class="lb lb2">收费总额：</label>
										<div class="priceWrap w-130 readonly">
											<input type="text" class="input-text readonly" readonly="readonly" id="zongCost" />
											<span class="unit">元</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="text-c mt-10">
							<input type="button" class="mr-10 w-80 sfbtn sfbtn-opt" value="重新反馈封单" id="Butorder" />
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
			<div class="popupMain">
				<div class="cl mb-10">
					<label class="w-100 f-l">
						<em class="mark">*</em>
						备件名称：
					</label>
					<select class="select f-l w-230 mustfill" id="finame">
					</select>
					<span class="c-666 lh-26 ml-10">请选择工程师备件库存</span>
				</div>
				<div class="cl mb-15">
					<label class="f-l w-100">备件条码：</label>
					<input type="text " name="code" class="input-text w-140 f-l readonly" readonly="readonly" />
					<label class="f-l w-100">备件型号：</label>
					<input type="text" name="type" class="input-text w-140 f-l readonly" readonly="readonly" />
				</div>
				<div class="cl mb-15">
					<label class="f-l w-100">
						<em class="mark">*</em>
						使用数量：
					</label>
					<input id="finum" name="num" type="text" class="input-text w-140 f-l mustfill" />
					<label class="f-l w-100">是否收费：</label>
					<div class="f-l" id="isPayBox">
						<label class="radiobox f-l mt-3" for="noPay">
							<input type="radio" id="noPay" name="isPayRadio" />
							否
						</label>
						<label class="radiobox f-l mt-3 ml-10" for="isPay">
							<input type="radio" id="isPay" name="isPayRadio" />
							是
						</label>
						<div class="priceWrap f-l w-60 ml-10 hide" id="hideMoney">
							<input id="payPrice" type="text" class="input-text mustfill" />
							<span class="unit">元</span>
							<input type="hidden" name="fittingId" value="">
						</div>
					</div>
				</div>
				<div class="text-c pl-20 mt-30 pt-15">
					<input type="button" id="bj_use" onclick="tj_bjuse()" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
					<input type="button" name="bjca" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" onclick="$.closeDiv($('.usebj'), true);" />
				</div>
			</div>
		</div>
	</div>

	<div class="popupBox msgText msgTextQuren">
		<h2 class="popupHead">
			短信确认
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain pd-20">
				<div class="lh-26">
					<div>
						您确定给
						<span id="peoples" style="color: #999;" class="f-14"></span>
						发送
					</div>
					<div style="min-height: 100px; text-indent: 2em; color: #999;" id="sendContent"></div>
				</div>
				<div class="text-c mt-25 " id="clickSend"></div>
			</div>
		</div>
	</div>

	<div class="popupBox qrcode">
		<h2 class="popupHead">
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain pd-20">
				<div class="text-c mt-25 " id="showCode"></div>
			</div>
		</div>
	</div>

	<!-- 无效工单提示框 -->
	<div class="popupBox notDispatch showwxgddiv">
		<h2 class="popupHead">
			无效工单
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain ">
				<div class="txtwrap1 pos-r mb-30">
					<label class="lb lb1">
						<em class="mark">*</em>
						无效类型：
					</label>
					<select class="select w-140" id="reasonofwxgdType">
						<option value="">请选择</option>
						<option value="1">无效-重复</option>
						<option value="2">无效-机器已好</option>
						<option value="3">无效-费用高不修</option>
						<option value="4">无效-用户没时间</option>
						<option value="5">无效-其他原因</option>
					</select>
				</div>
				<div class="txtwrap1 pos-r mb-30">
					<label class="lb lb1">无效工单理由：</label>
					<textarea id="reasonofwxgd" class="textarea"></textarea>
				</div>
				<div class="text-c pl-30">
					<input onclick="savewxgd('${order.id}')" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
					<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" onclick="closeDivWX()" value="取消" />
				</div>
			</div>
		</div>
	</div>

	<!-- 确认收款弹出框 -->
	<div class="popupBox w-400 qrskShow">
		<h2 class="popupHead">
			确认收款
			<a href="javascript:;" class="sficon closePopup"></a>
		</h2>
		<div class="popupContainer">
			<div class="popupMain pd-20">
				<div class="w-200" style="margin: 0 auto">
					<!-- <p class="mb-15">
					<i class="iconType iconType2" ></i><span style="font-size:14px;">您确定要交款吗？</span>
				</p> -->
					<p class="mb-15 ml-8" style="margin-left: 8px;">
						交款总额：
						<input type="text" class="input-text w-90 mr-5 readonly" readonly="readonly" value="${fns:getOrderTotalFee(order.auxiliaryCost, order.serveCost, order.warrantyCost)}" />
						元
					</p>
					<p class="mb-15 ml-8" style="margin-left: 8px;">
						回访总额：
						<input type="text" class="input-text w-90 mr-5 readonly" readonly="readonly" value="${order.callbackCost}" readonly="readonly" />
						元
					</p>
					<p class="mb-30">
						<em class="mark">*</em>
						实收总额：
						<input type="text" class="input-text w-90 mr-5" value="${order.confirmCost}" id="realConfirmMny" />
						元
						<!-- <input type="hidden" id="hideId" /> -->
					</p>
				</div>
				<div class="text-c ">
					<input onclick="saveConfirmPay('${order.id}')" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
					<input type="button" onclick="canceConfirmPay()" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/city.union.js"></script>
	<script type="text/javascript">
var feedImgsCount = '${feedImgsCount}';
var orderMsgId="";
var orderMsgMobile="";
var definedContentTz="";
var pageMode = "detail"; // 表明当前是编辑(edit)还是详情(detail)
var lastQueriedCodeIn = null;
var lastQueriedCodeOut = null;

function confirmCollection(){//确认交款
    $(".qrskShow").popup();
}
function canceConfirmPay(){
	$.closeDiv($('.qrskShow'));
}
function checkShiShouMy(num){
	var money = /^[0-9]+(.[0-9]{1,2}?|)$/;
	return money.test(num);
}

var saveConfirmPays = false;
function saveConfirmPay(id){
	if(saveConfirmPays){
		return;
	}
	var mnys = $("#realConfirmMny").val();
	if(isBlank(mnys)){
		layer.msg("请填写实收总额！！");
		$("#realConfirmMny").focus();
		return;
   	}
	if(!checkShiShouMy(mnys)){
		layer.msg("实收总额格式有误！");
		$("#realConfirmMny").focus();
		return;
	}
	saveConfirmPays=true;
	    $.ajax({
        type:"post",
        traditional:true,
        data:{id:id,mnys:mnys},
        url:"${ctx}/order/confirmCollection",
        dataType:"JSON",
        success:function(result){
            if(result==true){
                parent.layer.msg("交款成功！");
                canceConfirmPay();
                window.location.reload();
            }else{
                layer.msg("交款失败，请检查！");
            }
            saveConfirmPays=false;
            return;
        }
    }) 
}


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
    $('#imgshow').imgShow();
    $('#btn_showImg').on('click', function(){
        $('#wxImgList img').eq(0).click();
    })
});

var repairImgsCount = '${repairImgsCount}';
$(function(){
	$('#wxImgList').imgShow();
	if(feedImgsCount==8){
		$("#jiahao").addClass('hide');
	} 
	createUploader("#filePicker-add","#Imgprocess","8","file_fake_add","pickerImg");
	createUploader("#repairImgsPicker-add","#repImgprocess","4","","bdImgs");
	
	$.Huitab("#fbBaseInfo .tabBarP .tabswitch","#fbBaseInfo .tabCon","current","click","0");
	$.post("${ctx}/order/pingjia",{id:'7'},function(result){
		$("#onlyOne").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg  " onclick=sendMsg1("7","5","'+result.columns.content+'") >发送</a>');
	});

	if($.trim('${order.customerMobile}')!=null && $.trim('${order.customerMobile}')!="" ){
		orderMsgMobile=$.trim('${order.customerMobile}');
	}
	orderMsgId='${order.id}';

	$.post("${ctx}/order/remainMsgNum",{},function(result){
		$("#sign").val(result.columns.sms_sign);//签名
		$("#siteMsgNums").val(result.columns.sms_available_amount);//服务商剩余可发送短信总数
	});
	$(".codeConnectShow").bind('click', function () {
		var code = $(this).parent(".wrapss").find("input").val();
        layer.open({
            type : 2,
            content:'${ctx}/order/showHistoryPopupDetail?code=' + code+'&id='+'${order.id}',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        }); 
    });
	codeNumberCounts();

    var str='<label class="lb w-100 text-r">联系方式1：</label>';
    $("#mobileType").empty().append(str);

	$(".closePopup").bind('click', function() {

		if (parent.closeOrderdhfForm) {
			parent.closeOrderdhfForm();
		}
	});

	$("input[name='promiseTime']").attr("onfocus","");
	$("input[name='applianceBuyTime']").attr("onfocus","");

	$("#origin").select2();
	$(".selection").css("width","120px");

	$('#applianceBrand').select2();
	$("#applianceBrand").next(".select2").find(".selection").css("width","160px");

	$('#applianceCategory').select2();
	$("#applianceCategory").next(".select2").find(".selection").css("width","120px");

    $("#pleaseReferMall").select2({tags:true});
    $("#pleaseReferMall").next(".select2").find(".selection").css("width","120px");
	
	$('#btn-fbOrder').bind('click', function () {
		$.ajax({
			type: "POST",
			url: "${ctx}/order/orderDispatch/queryDispatchStatus?oid=${order.id}",
			success: function (data) {
				if ('1' == data.status) {
					$('body').popup({
						level: '3',
						type: 2,  // 提示是否进行某种操作
						content: '服务工程师${order.employeName}未接单，您确认继续反馈封单吗？',
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
    $('.dropdown-sin-2').dropdown({
        input: '<input type="text" maxLength="20" placeholder="请输入搜索">',
        choice: function() {
        }
    });
    
    judgedygd();


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

    var btn = document.getElementById("bj_use");
    btn.onmousedown = function(event) {event.preventDefault()};
});
function closeDivWX(){
	$.closeDiv($(".showwxgddiv"), true);
}

function showwxgd(type) {
	if(type=='6'){
		layer.msg("该工单为一级网点所派，不能进行无效工单操作！");
   		 return;
	}
	$('.showwxgddiv').popup({level: 2, closeSelfOnly: true});
}

var adpotin = false;
function savewxgd(id){
	if(adpotin) {
	    return;
    }
	var reasonofwxgdType = $("#reasonofwxgdType").val();
	var latest_process = $.trim($("#reasonofwxgd").val());
	if(isBlank(reasonofwxgdType)){
		layer.msg("请选择无效类型!");
		return;
	}else{
		adpotin = true;
		$.ajax({
			type:"post",
			url:"${ctx}/order/orderDispatch/updateOrderInvalid",
			data:{
			id:id,
			reasonofwxgdType:reasonofwxgdType,
			latest_process:latest_process
			},
			success:function(result){
				parent.layer.msg("无效工单更新完毕!", {time: 2000});
				parent.search();
				parent.numerCheck();
				$.closeDiv($('.showwxgddiv')); 
				$.closeDiv($('.orderdetailVb')); 
				$('#Hui-article-box',window.top.document).css({'z-index':'9'});
			},
			error:function(){
				layer.msg("系统繁忙!");
				return;
			},
			complete:function(){
				adpotin = false;
			}
		});
	}
}

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
 			url:"${ctx}/fitting/employeFitting/showFittingType",
 			data:{fitIdBindEmpId:fitIdBindEmpId},
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

function updateDispatchStatus(callback) {
	$.ajax({
		type: "post",
		url: "${ctx}/order/orderDispatch/updateDispatchStatusToYJD?oid=${order.id}",
		success: function() {
			callback.call();
		}
	});
}

function showFeedbackPopup() {
	//获取反馈工单中数据 fbBaseInfo
	//showPjmsg();
	//$.Huitab("#fbBaseInfo .tabBarP .tabswitch","#fbBaseInfo .tabCon","current","click","0");
	
	$('#fbBaseInfo .tabswitch').each(function(index){
		$(this).on('click', function(){
			if(index == 1){
				$('.btn-usebj').show();
			}
		})
	});
	
	fittingApply("pjmg");
	$('.fbOrder').popup({level:2, closeSelfOnly: true,fixedHeight:false});
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
	
	//$(this).addClass('sfbtn-active');
	$.ajax({
		url:"${ctx}/fitting/employeFitting/getEmployeFittings",
		data:{orderId:"${order.id}"},
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

function fittingApply(id){
	var orderNumber = "${order.number}";
	var str="";
	var imgstr="";
	var img = [];
	$.ajax({
		url:"${ctx}/order/showSYMsg",
		data:{orderNumber:orderNumber,remark:'SYMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
		dataType:'json',
		async:false,
		success:function(result){
				$("#"+id).html(
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
                    "<th class='w-70'>操作</th>" +
                    "</tr>" +
                    "</thead>");
			/* $(".showimg").html("<label class='lb lb1'>备件图片：</label>"); */
			var auxiliaryCostSum=0.0;
			var warrantyCost1 = $("#warrantyCost").val();
			var serveCost1 = $("#serveCost").val();
			if(result.list.length>0){
			$.each(result.list,function(index,val){
				
				str+="<tr>"+
				"<td class='text-c w-140'>"+val.columns.fitting_code+"</td>"+
				"<td class='text-c w-300'>"+val.columns.fitting_name+"</td>"+
				"<td class='text-c w-120'>"+val.columns.fitting_version+"</td>"+
                    "<td class='text-c  w-90'>" + val.columns.site_price + "</td>" +
                    "<td class='text-c  w-80'>" + val.columns.employe_price + "</td>" +
                    "<td class='text-c  w-70'>" + val.columns.customer_price + "</td>" +
				"<td class='text-c w-50'>×"+val.columns.used_num+"</td>"+
				"<td class='text-c w-70'>"+val.columns.collection_money+"</td>";
				if(val.columns.status=="1"){
					str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verifyPass'></i>待核销</td>";
				}else if(val.columns.status=="2"){
					str+="<td class='text-c c-fe0101 w-70'><i class='oState state-waitVerify'></i>已核销</td>";
				}else if(val.columns.status=="3"){
                    str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verify2nopass'></i>已拒绝</td>";
                }
					if(val.columns.collection_money!="" && val.columns.collection_money!=null){
						if(auxiliaryCostSum!=null && auxiliaryCostSum!=""){
							auxiliaryCostSum = auxiliaryCostSum + val.columns.collection_money;
						}else{
							auxiliaryCostSum = val.columns.collection_money;
						}
					}
					if(val.columns.status=="2"){//已核销，不显示删除
						str+="<td class='text-c c-fe0101 w-70'>---</td>";
					}else{
						str+="<td class='text-c c-fe0101 w-70'><a onclick='deleteOneFit(\""+val.columns.id+"\",\""+dealSpecialSymbol(val.columns.fitting_name)+"\",\""+val.columns.used_num+"\")'><i class='sficon sficon-del'></i></a></td>";
					}
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
					/* if(auxiliaryCostSum=="" || auxiliaryCostSum==null ||auxiliaryCostSum==undeefined){
						auxiliaryCostSum=0.0;
					} */
					if(warrantyCost1!=null && warrantyCost1!=""){
						auxiliaryCostSum=auxiliaryCostSum + parseFloat(warrantyCost1);
					}
					if(serveCost1!=null && serveCost1!=""){
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

function deleteOneFit(id,fittingName,num){
	$('body').popup({
		level:'3',
		type:2,
        closeSelfOnly: true,
		content:"您确定要删除备件'"+fittingName+"'*"+num+"?",
		fnConfirm:function(){
			$.ajax({
				type:"post",
				url:"${ctx}/order/deleteOneFittingRecord",
				data:{id:id},
				success:function(data){
					if(data.code=="200"){
						layer.msg("删除成功");
						fittingApply("pjmg");
						fittingApply("pjsy");
						parent.closeBatchForms();
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

function cancerBox(){
	$.closeDiv($('.showzjfddiv'), true);
}
function openJiesuanDetail(){
	if($("#jiesuanDetailBtn").attr("checked")){
		$("#jiesuanDetailBtn").parent("label").addClass("label-cbox2-selected")
		$("#jiesuan_detail_div").show();
	}else{
		$("#jiesuanDetailBtn").parent("label").removeClass("label-cbox2-selected")
		$("#jiesuan_detail_div").hide();
		$("#emp_tc").val("");
		$("input[id^=tc_]").val("");
	}
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

function imilarOrderjie(){
	closesimilarOrder();
	showjiesuanForm();
}

function showjiesuanForm() {
    $.ajax({
        url: "${ctx}/order/settlement/canSettlement",
        type: 'post',
		data: {
            orderId: '${order.id}'
		},
        success: function (data) {
            if ("T" === data) {
                openedJiesuanFormIndex = layer.open({
                    type: 2,
                    content: '${ctx}/order/settlement/new?id=${order.id}',
                    title: false,
                    area: ['100%', '100%'],
                    closeBtn: 0,
                    shade: 0,
                    fadeIn: 0,
                    anim: -1
                });
            } else if("delEmpDT" == data) {
                layer.msg("检测到该工单关联了已删除的工程师，请联系平台管理员！");
                return;
			} else if("F"==data) {
                layer.msg("工单当前工程师信息有误，请修改工单派工工程师信息再操作！");
                return;
            }else if("value0"==data) {
                layer.msg("请回访后再进行结算！");
                return;
            }else if("value1"==data) {
                layer.msg("工单交款金额和实收金额不一致，请确认一致后再进行结算！");
                return;
            }else if("value20"==data) {
                layer.msg("请回访后再进行结算！");
                return;
            }else if("value21"==data) {
                layer.msg("工单交款金额和实收金额不一致，请确认一致后再进行结算！");
                return;
            }
        }
    });
}

function showCallbackForm() {
	openedCallbackFormIndex = layer.open({
		type: 2,
		content: '${ctx}/order/orderCallback/new?id=${order.id}',
		title: false,
		area: ['100%', '100%'],
		closeBtn: 0,
		shade: 0,
		fadeIn: 0,
		anim: -1
	});
}

function closeJiesuanForm() {
	layer.close(openedJiesuanFormIndex);
	parent.search();
}
function closeCallbackForm() {
	layer.close(openedCallbackFormIndex);
}
function updateCallbackBtn() {
	$("#callbackBtn").val("重新回访");
}

//获取工单关联旧件信息
function showOldFitting(){
	var orderNumber = "${order.number}";
	var str="";
	var imgstr="";
	$.ajax({
		url:"${ctx}/order/showOldFitting",
		data:{orderNumber:orderNumber},
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
            })
			return;
		}

	});
}



function getJurisdiction(){
	/*变量名要与元素中的id对应*/
    var promiseTime = '${mustfill.columns.promiseTime}';
    var applianceBuyTime = '${mustfill.columns.applianceBuyTime}';
    var origin = '${mustfill.columns.origin}';
    var promiseLimit = '${mustfill.columns.promiseLimit}';
    var remarks = '${mustfill.columns.remarks}';
    var applianceModel = '${mustfill.columns.applianceModel}';
    var applianceNum = '${mustfill.columns.applianceNum}';
    var applianceBarcode = '${mustfill.columns.applianceBarcode}';
    var applianceMachineCode = '${mustfill.columns.applianceMachineCode}';
    var pleaseReferMall = '${mustfill.columns.pleaseReferMall}';
    var warrantyType = '${mustfill.columns.warrantyType}';
    var level = '${mustfill.columns.level}';
    var customerFeedbackJuris = '${mustfill.columns.customerFeedback}';
    var customerType = '${mustfill.columns.customerType}';
    var jurisdiction=origin+","+promiseTime+","+promiseLimit+","+customerFeedbackJuris+","+remarks+","+applianceModel+","+applianceNum+","+applianceBarcode+","+applianceMachineCode+","+applianceBuyTime+","+pleaseReferMall+","+warrantyType+","+level+","+customerType;
    return jurisdiction;
}
/*获取参数*/
function getJurisdisctionValue(){
    var origin= $("#origin").val();
    var promiseTime= $("#promiseTime").val();
    var promiseLimit= $("#promiseLimit").val();
    var customerFeedback= $("#customerFeedback").val();
    var remarks= $("#remarks").val();
    var applianceModel= $("#applianceModel").val();
    var applianceNum= $("#applianceNum").val();
    var applianceBarcode= $("#applianceBarcode").val();
    var applianceMachineCode= $("#applianceMachineCode").val();
    var applianceBuyTime= $("#applianceBuyTime").val();
    var pleaseReferMall= $("#pleaseReferMall").val();
    var warrantyType= $("#warrantyType").val();
    var level= $("#level").val();
    var customerType= $("#customerType").val();
    //var jurisdictionvalue=origin+"(**..)"+promiseTime+"(**..)"+promiseLimit+"(**..)"+customerFeedback+"(**..)"+remarks+"(**..)"+applianceModel+"(**..)"+applianceNum+"(**..)"+applianceBarcode+"(**..)"+applianceMachineCode+"(**..)"+applianceBuyTime+"(**..)"+pleaseReferMall+"(**..)"+warrantyType+"(**..)"+level;

    var array=new Array();
    array[0]=origin;
    array[1]=promiseTime;
    array[2]=promiseLimit;
    array[3]=customerFeedback;
    array[4]=remarks;
    array[5]=applianceModel;
    array[6]=applianceNum;
    array[7]=applianceBarcode;
    array[8]=applianceMachineCode;
    array[9]=applianceBuyTime;
    array[10]=pleaseReferMall;
    array[11]=warrantyType;
    array[12]=level;
    array[13]=customerType;
	return array;
}

$(function(){

	orderMobile();

	$("#jiesuan_detail_div").on('blur', 'input', function(){
		if(!testCash($("#total_cost").val())){
			layer.msg("请先维护费用!", {time:1000});
			$(this).val("");
			return ;
		}else{
			var sum = 0;
		    $("#jiesuan_detail_div input").each(function(){
		    	if(testCash($(this).val())){
		       		sum = numAdd(sum, $(this).val());
		      	}else if($(this).val() !=''){
		       		$(this).val("");
		      	}
		    });
		    if(sum > $("#total_cost").val()){
		    	layer.msg("提成总额不能大于结算总额!", {time:1000});
		    	$(this).val("");
		    	return;
		    }
		}
	});

	$("#xggd").click(function(){
		$("#origin1").hide();
		var markMobile = '${order.customerMobile}';
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
		html+='<em class="mark">*</em>'
		$("#mobileType").empty().append(html);

		$(".dropdown-sin-2").show();
		$("input[name='emN']").hide();

		if($(this).val()!="保存"){
		    pageMode = 'edit';
            $(".sbtn").prop("disabled", true);
           /*  toggleMirror(false); */
			$("input[type='text']").removeClass("readonly");
			$("textarea").removeClass("readonly");
			$("#factoryNumber").removeClass("readonly");
			$("#factoryNumber").removeAttr("readonly");
			$("#factoryNumber").removeAttr("disabled");
			$("select").removeClass("readonly");
			$(".priceWrap").removeClass("readonly");
			$("input[type='text']").prop("readonly",false);
			$("textarea").prop("readonly",false);
			$('.ptime').removeClass("readonly");
			$('.ptime').prop("disabled",false);

			$("#showProvince").css("display","");
			$("#showCity").css("display","");
			$("#showArea").css("display","");

			$("select").prop("disabled",false);

			$(".dischange").addClass("readonly");
			$(".dischange").prop("disabled",true);
			/*$("#customerAddress1").css({'width':'480px'});*/
			
			$("#serviceType").addClass("mustfill");
			$("#serviceMode").addClass("mustfill");
			$("#customerName").addClass("mustfill");
			$("#customerMobile").addClass("mustfill");
			$("#customerAddress1").addClass("mustfill");
			$("#applianceBrand").addClass("mustfill");
			$("#applianceCategory").addClass("mustfill");
			//$("#customerFeedback").addClass("mustfill");
			$("#styleMark .select2-selection--single").css({'background-color': '#dbf5fd','border':'1px solid #5ebdfb'});


            var str='origin,promiseTime,promiseLimit,customerFeedback,remarks,applianceModel,applianceNum,applianceBarcode,applianceMachineCode,applianceBuyTime,pleaseReferMall,warrantyType,level,customerType';
            addMustFill(getJurisdiction(),str);
			$(".mark").text("*");
			//反馈中的内容部分不可修改

			$(".combo-arrow").removeClass("textbox-icon-disabled");
			$("#_easyui_textbox_input1").css("display","");
			$("#_easyui_textbox_input1").prop("disabled",false);
			$("#_easyui_textbox_input2").prop("disabled",false);
			$(".combo").removeClass("textbox-disabled");

			$(".easyui-combobox").removeClass("readonly");


			$("input[name='fankui']").addClass("readonly");
			$("input[name='fankui']").prop("readonly",true);
			if(repairImgsCount<4){
			$("#jiahaore").removeClass('hide');
				}
			$(".btn-delimg").removeAttr("style");

			$("#repeteWrite").addClass("sfbtn-disabled");
			$(".btnMenubox").find("input").addClass("sfbtn-disabled");
			$(this).removeClass("sfbtn-disabled");
			$(this).val("保存");
			$(this).after("<input id='qxgf' class='sfbtn sfbtn-opt' onclick='getoff()'  value='取消' type='button'/>");

			$("#orderNumber").prop("disabled",false);
			$("#orderNumber").prop("readonly",true);

			$("input[name='messengerName']").prop("disabled",false);
			$("input[name='repairTime']").prop("disabled",false);
			$("input[name='promiseTime']").prop("disabled",false);
			$("input[name='promiseTime']").attr("onfocus","WdatePicker({minDate: '%y-%M-%d' })");
			$("input[name='applianceBuyTime']").prop("disabled",false);
			$("input[name='applianceBuyTime']").attr("onfocus","WdatePicker({})");
		}else{
		    pageMode = "detail";
			var address = $('#customerAddress1').val();
			/*var addr = $("#province").val() + $("#city").val() + $("#area").val() + address;*/
			$("#customerAddress").val(address);
			var mobileOrtel = $("#mobileOrtel").val();
			var serviceType = $("#serviceType").val();
			var serviceMode = $("#serviceMode").val();
			var customerName = $.trim($("#customerName").val());
			var customerMobile = $("#customerMobile").val();
			var customerTelephone = $("#customerTelephone").val();
			var customerTelephone2=$("#customerTelephone2").val();
			var customerAddress = $("#customerAddress").val();
			var applianceBrand = $("#applianceBrand").val();
			var applianceCategory = $("#applianceCategory").val();
			var customerFeedback = $.trim($("#customerFeedback").val());
			var moliereg=/^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][0-9]{10}$)$/;
			var mtel=/^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/;
            var tel = /(^1\d{10}$)|(^(\d{3,4}\-)?\d{5,9}$)/;
			if(serviceType==null||serviceType==""){
				layer.msg("服务类型为必填项");
				return;
			}
			if(serviceMode==null||serviceMode==""){
				layer.msg("服务方式为必填项");
				return;
			}
			var factoryNumber = $("#factoryNumber").val();
			if('${order.recordAccount}'=='1'){
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
			if(customerName==null||customerName==""){
				layer.msg("用户姓名为必填项");
				return;
			}
			if(!isBlank(customerMobile)){
				if(!tel.test($.trim(customerMobile))){
					//if(!tel.test($.trim(customerMobile))){
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
				if(customerTelephone.length>0){
					if(!tel.test($.trim(customerTelephone))){
						layer.msg("请输入正确的联系方式2");
						return;
					}

				}
				if(customerTelephone2.length>0){
					if(!tel.test($.trim(customerTelephone2))){
						layer.msg("请输入正确的联系方式3");
						return;
					}
				}
			if(customerAddress==null||customerAddress==""){
				layer.msg("详细地址为必填项");
				return;
			}
			if(applianceBrand==null||applianceBrand==""){
				layer.msg("家电品牌为必填项");
				return;
			}
			if(applianceCategory==null||applianceCategory==""){
				layer.msg("家电品类必填项");
				return;
			}
			/*if(customerFeedback==null||customerFeedback==""){
				layer.msg("服务描述为必填项");
				return;
			}*/

			var names=$("select[name='employeNames']").val();
			/*$("input[name='employeNames']").each(function(j,item){
				 if(j==0){
					 names=item.value;
				 }else if(j>0){
					 names+=","+item.value;
				 }
			});*/
			$("input[name='employeIds']").val(names);

            var result = checkMustFill(getJurisdiction(), getJurisdisctionValue());
            if (!result) {
                return;
            } else {
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
		}

	});
});

$(function(){

	// 选择品类时获取服务商维护对应的品牌
	$("#applianceCategory").change(function(){
		   var brand = $("#applianceBrand").val();
	       var cate = $("#applianceCategory").val();
	 			$.ajax({
	 				type:"post",
	 				url:"${ctx}/order/getBrand",
	 				data:{
	 					category:cate
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
				brand: brand
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

    $("#cb_whether_collection").change(function() {
        var val = $(this).val();
        if("1" == val) {
            $("#cb_confirm_cost").prop("readonly", false).removeClass("readonly")
        } else if("2" == val) {
            $("#cb_confirm_cost").prop("readonly", true).addClass("readonly");
        }
    });

	$("#serviceMeasures").change(function(){
		var serviceMeasures = $("#serviceMeasures").val();
		var category = $("#selectcategory").val();
		var warranty_type = $("#warranty_type").val();
		var employeName=$("#employeName").val();
		var employeId=$("#employeId").val();
		var serve_cost=$("#serve_cost").val();//服务费
		var auxiliary_cost=$("#auxiliary_cost").val();//辅材费
		var warranty_cost=$("#warranty_cost").val();//延保费
		var empId= employeId.split(',');
		var empName= employeName.split(',');
        var countAmount ="";  //所有费用总和
        var costDetail ="";   //所有明细
		$("#setmeaAmount").empty();
		$("#cost_detail").empty();
		if(isBlank(serviceMeasures)){
			$(".sdefined0").show();
			$(".sdefined1").hide();
		}else{
			$(".sdefined1").show();
			$(".sdefined0").hide();
		$.ajax({
			type:"post",
			url:"${ctx}/order/settlementTemplate/getsetMea",
			data:{
				category :category,
				serviceMeasures :serviceMeasures,
				warranty_type : warranty_type
			},
			dataType:"json",
			success:function(data){
				var obj = eval(data);
				 var length = obj.length;
				 if(length<1){
					 $("#total_cost").val(0);
				 }else{
				 var  HTML = '';
				var abb = empId.length;
					  var costD ="";  //所有费用明细
				for(var i=0; i < length; i++)
				{

					  var coun =0;
					  if(obj[i].columns.basis_type == "0"){
						  coun = obj[i].columns.basis_amount*1*(obj[i].columns.charge_proportion/100)+obj[i].columns.charge_amount*1;
					  }else if(obj[i].columns.basis_type == "1"){//服务费
						  coun = serve_cost*1*(obj[i].columns.charge_proportion/100);
					  }else if(obj[i].columns.basis_type == "2"){//辅材费
						  coun = auxiliary_cost*1*(obj[i].columns.charge_proportion/100);
					  }else if(obj[i].columns.basis_type == "3"){//延保费
						  coun = warranty_cost*1*(obj[i].columns.charge_proportion/100);
					  }

					  HTML += '<div class="f-l mb-10">';
				      HTML += '<label class="w-100 f-l text-r">';
				      HTML += obj[i].columns.charge_name ;
				      HTML += '：</label><div class="priceWrap w-250 f-l">';
				      HTML += '<input type="text" class="input-text"  id="'+obj[i].columns.id+'" name="charge_amount" value="'+coun.toFixed(2)+'" onchange="updatecose();" />';
					  HTML += '<span class="unit">元</span>';
					  HTML += '</div></div>';
				 	  if(costD == ""){
						  costD = obj[i].columns.id+':'+coun.toFixed(2);
					  }else{
						  costD = costD+';'+ obj[i].columns.id+':'+coun.toFixed(2);
					  }

					  countAmount =countAmount*1+coun;
				}


				$("#setmeaAmount").append(HTML);
			    $("#total_cost").val(countAmount.toFixed(2));
			    $("#combination").val(costD);
					 }
				}
		});

				}

	});

    $('select[name="fwjsfa"]').on('change',function(){
        var index = $(this).find("option:selected").val();
        $('.sdefined').hide();
        $('.sdefined'+index).show();
    });
});


function changeUnit(obj){
	var oIndex = $(obj).find('option:selected').val();
	var closeP = $(obj).closest('.pjsbox');
	closeP.find('.jsbox').hide();
	closeP.find('.jsbox'+oIndex).show();
	closeP.find('.jsbox').find('input').val('0');
}

function changeFuwu(obj){
	var cost = "${order.serveCost}";
	$("#serve_costbl").val(cost*$(obj).val()/100);
	$("#serve_costgd").val(cost*$(obj).val()/100);
}
function changeFucai(obj){
	var cost = "${order.auxiliaryCost}";
	$("#auxiliary_costbl").val(cost*$(obj).val()/100);
	$("#auxiliary_costgd").val(cost*$(obj).val()/100);
}
function changeway(obj){
	var cost = "${order.warrantyCost}";
	$("#warranty_costbl").val(cost*$(obj).val()/100);
	$("#warranty_costgd").val(cost*$(obj).val()/100);
}

function isBlank(val) {
	if(val==null || val=='' || val == undefined) {
		return true;
	}
	return false;
}

//修改费用
function updatecose(){
	var countAmount = 0;
	var abb = $("#detailCount").val();
	var costDetail ="";
	var costD = "";
	var employeId=$("#employeId").val();
	var empId= employeId.split(',');
	var abb = empId.length;
	$("#cost_detail").empty();
	$("input[name='charge_amount']").each(function(i, item){
		countAmount += $(this).val() * 1;
 		 var id = $(this).attr("id");
		 if($(this).val() == ""){
			 $(this).val('0')
		 }

		 if(costD == ""){
	 		costD = id+':'+$(this).val();
		  }else{
			costD = costD+';'+ id+':'+$(this).val();
		  }

	});
	$("#combination").val(costD);
    $("#total_cost").val(countAmount.toFixed(2));
    var ht ="（";
    for(var i=0;i<abb;i++){
    	ht += '<span>'+empName[i]+'</span>：<span style="margin-right: 10px;">'+(countAmount/abb).toFixed(2)+'</span>';
    }
    ht =+"）";
    $("#cost_detail").append(ht);

}

	$(function(){
		$.Huitab("#detialWd .tabBarP .tabswitch","#detialWd .tabCon","current","click","0");
		$.Huitab("#serveFb .tabBarP .tabswitch","#serveFb .tabCon","current","click","0");
		$.Huitab("#fbSettle .tabBarP .tabswitch","#fbSettle .tabCon","current","click","0");

		$('.orderdetailVb').popup({fixedHeight:false});

		$(".sdefined0 .input-text").change(function(){
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

        $('#Imgprocess2').imgShow();
        $('#oldfittingimg').imgShow();
        $('#repImgprocess').imgShow();

        $('#generationOrderFrom').Validform({
            btnSubmit:"#Butorder",
            postonce:true,
            tiptype:function(msg){
                if(!isBlank(msg)){
                    layer.msg(msg);
                }
            },
            callback: function(form) {
                $.ajax({
                    url: "${ctx}/order/orderDispatch/ReplaceEmployeRe",
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
                return false;
            }
        });
	});


	function savezjfd(id){
		var latest_process = $.trim($("#reasonofzjfd").val());
		if(isBlank(latest_process)){
			layer.msg("请输入理由!");
			return;
		}else{
			$.ajax({
				type:"POST",
				url:"${ctx}/order/orderDispatch/updateOrderClose",
				data:{
					id:id,
					latest_process:latest_process
					},
				success:function(result){
				layer.msg("封单完成");
				$('#Hui-article-box',window.top.document).css({'z-index':'9'});
				parent.search();
				parent.numerCheck();
				$.closeAllDiv();
				},
				error:function(){
					alert("系统繁忙!");
					return;
				}
			});
		}
	}

	function saveCallback(){
		var postData = $("#callback_form").serializeJson();
		$.post('${ctx}/order/orderCallback/saveCallback', postData, function(result){
            $.closeDiv($('.orderdetailVb'));
            parent.search();
		});
	}

	function closesimilarOrder(){
		$.closeDiv($('.similarOrder'), true);
	}

	function saveSettlement(){
		var tc_str = "";
		var valid = true;
		var sum = 0;
		$("input[id^=tc_]").each(function(){
			if(testCash($(this).val())){
				tc_str += "," + $(this).attr("id").split("_")[1] + "_" +$(this).val();
				sum = numAdd(sum, $(this).val());
			}else{
				valid = false;
			}
		});
		if($("#jiesuanDetailBtn").attr("checked") && !valid){
			layer.msg("请输入正确的提成金额!");
			return ;
		}
		if(sum > $("#total_cost").val()){
			layer.msg("提成总额不能大于结算总额!");
			return ;
		}
		if(sum > 0){
			$("#emp_tc").val(tc_str.substring(1));
			$("#total_tc").val(sum);
		}
		var postData = $("#seltment_form").serializeJson();
		$.post('${ctx}/order/orderSettlemnt/saveSettlement', postData, function(result){
			 if(result == "ok"){
			    	layer.msg("结算成功！");
			    	$.closeDiv($('.orderdetailVb'));
			    	location.href="${ctx}/order/StayVisit";
			    }
		});
	}

	function showzjfd(){
		$('.showzjfddiv').popup({level:2, closeSelfOnly:true});
	}

	function fengdanOrder(){
		closesimilarOrder();
		$('#Hui-article-box',window.top.document).css({'z-index':'1009'});
		setTimeout(function(){showzjfd();},250);
	}

	function newOrder(id){
		window.location.href="${ctx}/order/newFormFormDetail?id="+id;
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
	//获取配件信息
	//获取工单关联备件使用信息
	function showSYMsg(){
		var orderNumber = "${order.number}";
		var str="";
		var imgstr="";
		var img = [];
		$.ajax({
			url:"${ctx}/order/showSYMsg",
			data:{orderNumber:orderNumber,remark:'SYMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
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

	//获取工单关联备件申请信息
	function showSQMsg(){
		var orderNumber = "${order.number}";
		var str="";
		var imgstr="";
		var img = [];
		$.ajax({
			url:"${ctx}/order/showSQMsg",
			data:{orderNumber:orderNumber,remark:'SQMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
			dataType:'json',
			async:false,
			success:function(result){
				$("#pjsq").html("<caption>工单关联配件申请</caption>"+
						"<thead>"+
						"<tr>"+
							"<th class='w-180'>备件条码</th>"+
							"<th class='w-260'>备件名称</th>"+
							"<th class='w-120'>备件型号</th>"+
							"<th class='w-50'>数量</th>"+
							"<th class='w-150'>审核备注</th>"+
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

	function changeStyle(orderNum){
        btnSearch(orderNum);
	}

function btnSearch(orderNum){

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

	 function msgInform(orderId){
			orderMsgId = orderId;
         if(!${empty definedmodel}){
             $.Huitab("#msgWrapdef .tabBarP .tabswitch","#msgWrapdef .tabCon","current","click","0");
             $('.msg-input').each(function(){
                 inputWidth(this);
             });
             selectMsgMoulddef("");
             $('.msgTextdefined').popup({level:4, closeSelfOnly: true});
         }else{
             $('.msgText2').popup({level:4,closeSelfOnly:true});
             $.Huitab("#msgWrap2 .tabBarP .tabswitch","#msgWrap2 .tabCon","current","click","0");
             $('.msg-input').each(function(){
                 inputWidth(this);
             });
         }
		}

	// 下拉框切换模板
	function selectMsgMould(obj){
		var aDiv = $('.msgText2 .msgmould');
		var index = obj.selectedIndex;
		aDiv.hide().eq(index).show();
	}


//下拉框切换自定义模板
function selectMsgMoulddef(obj){
    var id = $('#select-msgmodedef option:selected') .val();
    $.ajax({
        type:"POST",
        url:"${ctx }/order/getsmsbyid",
        data:{id:id},
        success:function(result) {
            if (result != "" || result != null) {
                $(".defmsgcontent").empty();
                var newcontent=result.columns.content;
                while(newcontent.indexOf('@1') >= 0){
                    newcontent = newcontent.replace("@1","<input type='text' class='msg-input' value='${order.customerName }' onkeyup='inputWidth(this)' id='defcustomerName'/>");
                }
                while(newcontent.indexOf('@2') >= 0){
                    newcontent = newcontent.replace("@2","<input type='text' class='msg-input' value='${order.applianceBrand }' onkeyup='inputWidth(this)' id='defapplianceBrand'/>");
                }
                while(newcontent.indexOf('@3') >= 0){
                    newcontent = newcontent.replace("@3","<input type='text' class='msg-input' value='${order.applianceCategory }' onkeyup='inputWidth(this)' id='defapplianceCategory'/>");
                }
                while(newcontent.indexOf('@4') >= 0){
                    newcontent = newcontent.replace("@4","<input type='text' class='msg-input' value='${order.serviceType }' onkeyup='inputWidth(this)' id='defserviceType'/>");
                }
                while(newcontent.indexOf('@5') >= 0){
                    if('${order.serviceMode }'=='1'){
                        newcontent = newcontent.replace("@5","<input type='text' class='msg-input' value='上门' onkeyup='inputWidth(this)' id='defserviceMode'/>");
                    }else if('${order.serviceMode }'=='2'){
                        newcontent = newcontent.replace("@5","<input type='text' class='msg-input' value='拉修' onkeyup='inputWidth(this)' id='defserviceMode'/>");
                    }else{
                        newcontent = newcontent.replace("@5","<input type='text' class='msg-input' value='' onkeyup='inputWidth(this)' id='defserviceMode'/>");
                    }
                }
                while(newcontent.indexOf('@6') >= 0){
                    newcontent = newcontent.replace("@6","<input type='text' class='msg-input' value='${msg2Names}' onkeyup='inputWidth(this)' id='defmsg2Names'/>");
                }
                while(newcontent.indexOf('@7') >= 0){
                    newcontent = newcontent.replace("@7","<input type='text' class='msg-input' value='${msg2Mobiles }' onkeyup='inputWidth(this)' id='defmsg2Mobiles'/>");
                }
                while(newcontent.indexOf('@8') >= 0){
                    newcontent = newcontent.replace("@8","<input type='text' class='msg-input' value='${jdPhone }' onkeyup='inputWidth(this)' id='defjdPhone'/>");
                }
                $(".defmsgcontent").append(newcontent);
                $("#defsendModel").append('<a href="javascript:;" class="sfbtn sfbtn-green w-70 btn-sendmsg" onclick="sendModeldef(\''+result.columns.id+'\',\''+result.columns.tag+'\',\''+result.columns.content+'\')" >发送</a>');
                $.setPos($(".defmsgcontent"))
            }else{

            }
        }
    })
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

	 



    var defafs1
    function defsendMsgConfirm(){
        $("#clickSend").empty();
        if(defafs1) {
            return;
        }

        var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
        var sign = $("#sign").val();
        var customerMobile = $("#customerMobile").val();//用户联系方式
        if($.trim($("#signdef").val())=="" || $("#sign").val()==null){
            layer.msg("短信签名不能为空！");
            $("#signdef").focus();
            return;
        }
        if($.trim($("#signdef").val()).length>6){
            layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
            $("#signdef").focus();
            return;
        }
        sign=$.trim($("#signdef").val());
        var content = $.trim($("#contentdef").val());
        if(content=="" ){
            layer.msg("自定义发送短信内容不能为空");
            $("#content").focus();
            return;
        }
        if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
            //自定义模板
            defafs1 = true;
            $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
                type:"POST",
                url:"${ctx }/order/msgNumbers",
                data:{content:content,
                    sign:sign},
                success:function(result){
                    if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
                        layer.msg("剩余可发送短信条数不足，请先购买后再发送！");
                    }else{
                        $("#peoples").html('${order.customerName}');
                        $("#sendContent").text("“"+$("#contentdef").val()+"”？");
                        definedContentTz=content;
                        $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendMsg(\''+sign+'\',\''+customerMobile+'\',\''+orderMsgId+'\')" >确定</a>&nbsp;&nbsp;'+
                            '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                        $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                    }
                },
                complete: function() {
                    defafs1 = false;
                }
            });
        }else if($.trim(customerMobile)==""){
            layer.msg("请填写用户的手机号码！");
        }else{
            layer.msg("用户的手机号码格式不正确，请重新填写！");
        }
    }

    var send11=false;
    function sendMsg(){
        $("#clickSend").empty();
        if(send11){
            return;
        }
        var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
        var sign = $("#serviceName2").val();
        var customerMobile="";
        customerMobile = $("#customerMobile").val();//用户联系方式
        if($.trim(sign).length>6){
            layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
            $("#serviceName2").focus();
            return;
        }
        if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
            //自定义模板
            var content = $("#content").val();
            if($.trim(content)=="" || content==null){
                layer.msg("自定义发送短信内容不能为空");
                $("#content").focus();
                return;
            }
            send11=true;
            $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
                type:"POST",
                //traditional:true,
                url:"${ctx }/order/msgNumbers",
                data:{content:content,
                    sign:sign},
                success:function(result){
                    if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
                        layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                    }else{
                        $("#peoples").html('${order.customerName}');
                        definedContentTz=content;
                        $("#sendContent").text("“"+$("#content").val()+"”？");
                        $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="confirmSend(\''+sign+'\',\''+customerMobile+'\',\''+orderMsgId+'\')" >确定</a>&nbsp;&nbsp;'+
                            '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                        $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                    }
                },complete:function(){
                    send11=false;
                }

            })
        }else if($.trim(customerMobile)==""){
            layer.msg("请填写用户的手机号码！");
        }else{
            layer.msg("用户的手机号码格式不正确，请重新填写！");
        }
    }
		
		var confirmSend22=false;
		function confirmSend(sign,customerMobile,orderMsgId){
			if(confirmSend22){
				return;
			}
			confirmSend22=true;
			$.ajax({
				type:"POST",
				url:"${ctx }/order/fwzSendmsg",
				data:{content:definedContentTz,
					sign:sign,
					orderMsgMobile:customerMobile,
					orderMsgId:orderMsgId
					},
				success:function(result){
					if(result=="ok"){
						layer.msg("发送成功!");
						$.closeDiv($(".msgText2"));
                        $.closeDiv($(".msgTextdefined"));
						window.location.reload();
						parent.closeBatchForms();
					}else if(result=="noMessage"){
						layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
						return;
					} else{
						layer.msg("发送失败，请稍后重试!");
					}
				},complete:function(){
					confirmSend22=false;
				}
			})
		}



var sendModelMarks=false;
function sendMsg1(id,tag,content){
    $("#clickSend").empty();
    if(sendModelMarks){
        return ;
    }
    var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
    var custName = $("#custName").val();
    var siteNameMobile = $("#siteNameMobile").val();
    var customerMobile = $("#customerMobile").val();//用户联系方式
    var sign = $("#serviceName1").val();
    if($.trim(sign).length>6){
        layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
        $("#serviceName1").focus();
        return;
    }
    var path_1 = content.indexOf("@");// 第一个位置
    var path_2 = path_1 + content.substring(path_1 + 1).indexOf("@") + 1;// 第二个位置
    var path_3 = path_2 + content.substring(path_2 + 1).indexOf("@") + 1;// 第三个位置
    var path_4 = path_3 + content.substring(path_3 + 1).indexOf("@") + 1;// 第四个位置
    var path_5 = path_4 + content.substring(path_4 + 1).indexOf("@") + 1;// 第四个位置
    var path_6 = path_5 + content.substring(path_5 + 1).indexOf("@") + 1;// 第四个位置
    var s_temp = content.substring(0, path_1) + custName
        + content.substring(path_1 + 1, path_2) + siteNameMobile
        + content.substring(path_2 + 1, path_3) + sign
        + content.substring(path_3 + 1);
    if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
        sendModelMarks=true;
        $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
            type:"POST",
            //traditional:true,
            url:"${ctx }/order/msgNumbers",
            data:{content:s_temp,
                sign:sign},
            success:function(result){
                if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
                    layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                }else{
                    $("#peoples").html('${order.customerName}');
                    $("#sendContent").text("“"+s_temp+"”？");
                    $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="confirmSendModel(\''+id+'\',\''+sign+'\',\''+s_temp+'\',\''+tag+'\',\''+orderMsgId+'\',\''+customerMobile+'\')" >确定</a>&nbsp;&nbsp;'+
                        '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                    $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                }
            },complete:function(){
                sendModelMarks=false;
            }
        })
    }else if($.trim(customerMobile)==""){
        layer.msg("请填写用户的手机号码！");
    }else{
        layer.msg("用户的手机号码格式不正确，请重新填写！");
    }
}

	
	function cancelQueren(){
		$.closeDiv($(".msgTextQuren"),true);
	}
	
	var confirmSendModel1=false;
	function confirmSendModel(id,sign,s_temp,tag,orderMsgId,customerMobile){
		if(confirmSendModel1){
			return;
		}
		confirmSendModel1=true;
		$.ajax({
			type:"POST",
			url:"${ctx }/order/fwzSendmsgModel",
			data:{temId:id,
				sign:sign,
				content:s_temp,
				extno:tag,
				orderId:orderMsgId,
				customerMobile:customerMobile
				},
			success:function(result){
				if(result=="ok"){
					layer.msg("发送成功!");
					$.closeDiv($(".msgText2"));
                    $.closeDiv($(".msgTextdefined"));
					window.location.reload();
				}else if(result=="noMessage"){
					layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
					return;
				} else{
					layer.msg("发送失败，请稍后重试!");
				}
			},complete:function(){
				confirmSendModel1=false;
			}
		})
	}

	function orderMobile(){
		var id = "${order.id }";
		var appliance = "${order.applianceBrand }"+"${order.applianceCategory }";
		var customerName = "${order.customerName }";
		var customerAddress = "<c:out value='${order.customerAddress}'/>";
        var customerMobile = "${order.customerMobile }";
		var createTime = $("#createTime_ta").html();
		var employeName="${order.employeName }";
		 var serviceType="${order.serviceType }";
		$.ajax({
			type:"post",
			url:"${ctx}/order/getOrderMobile",
			data:{
				id :id
			},
			dataType:"json",
			success:function(data){
				var obj = eval(data);
				if(obj != "" && obj !=undefined){
				var appliancebrca=obj.columns.appliance_brand+obj.columns.appliance_category;
				$("#xsnumber").html(obj.columns.number);
				$("#xscreateTime").html(obj.columns.time);
				$("#xsemployeName").html(obj.columns.employe_name);
				$("#xscustomerName").html(obj.columns.customer_name);
				$("#xscustomerMobile").html(obj.columns.customer_mobile);
				$("#xsapplianceBrand").html(appliancebrca);
				$("#xscustomerAddress").html(obj.columns.province+obj.columns.city+obj.columns.area+obj.columns.customer_address);
			     $("#xserviceType").html(obj.columns.service_type);
					var status = obj.columns.status;

				if(status =='0'){
				//	$("#title2").html("待接收");
					$("#title3").html("待接收");
				}else if(status =='1'){
				//	$("#title2").html("待派工");
					$("#title3").html("待派工");
				}else if(status =='2'){
				//	$("#title2").html("维修中");
					$("#title3").html("维修中");
				}else if(status =='3'){
				//	$("#title2").html("待回访");
					$("#title3").html("待回访");
				}else if(status =='4'){
				//	$("#title2").html("待结算");
					$("#title3").html("待结算");
				}else if(status =='5'){
				//	$("#title2").html("已完成");
					$("#title3").html("已完成");
				}else if(status =='7'){
				//	$("#title2").html("暂不派工");
					$("#title3").html("暂不派工");
				}

			 	if(appliance==appliancebrca){
				$("#gdxqlist1").children("li").eq(5).addClass("c-0383dc");
				$("#gdxqlist2").children("li").eq(5).addClass("c-0383dc");
				}
				if(customerName==obj.columns.customer_name){
				$("#gdxqlist1").children("li").eq(3).addClass("c-0383dc");
				$("#gdxqlist2").children("li").eq(3).addClass("c-0383dc");
				}
				if(customerAddress==obj.columns.customer_address){
				$("#gdxqlist1").children("li").eq(7).addClass("c-0383dc");
				$("#gdxqlist2").children("li").eq(7).addClass("c-0383dc");
				}
				if(createTime==obj.columns.time){
				$("#gdxqlist1").children("li").eq(1).addClass("c-0383dc");
				$("#gdxqlist2").children("li").eq(1).addClass("c-0383dc");
				}
				if(employeName==obj.columns.employe_name){
				$("#gdxqlist1").children("li").eq(2).addClass("c-0383dc");
				$("#gdxqlist2").children("li").eq(2).addClass("c-0383dc");
				}
				if(customerMobile==obj.columns.customer_mobile){
				$("#gdxqlist1").children("li").eq(4).addClass("c-0383dc");
				$("#gdxqlist2").children("li").eq(4).addClass("c-0383dc");
				}
			    if(serviceType==obj.columns.service_type){
                 $("#gdxqlist1").children("li").eq(6).addClass("c-0383dc");
                 $("#gdxqlist2").children("li").eq(6).addClass("c-0383dc");
                }
				$('.similarOrder').popup({level:2,closeSelfOnly:true});
				}
				}
			});

	}


	function dygd(id){
		//使用默认
		window.open("${ctx}/print/order?orderId="+id);
	}
	
	function dygdcustom(id){
		$.ajax({
			type : 'POST',
			url : "${ctx}/order/printdesign/getOrderKeyName",
			data : {orderId:id},
			datatype:"JSON",
			success : function(data) {
				if(data == null || data.content == null || data.content.length<=0){
					var newTab=window.open('about:blank');
					newTab.location.href="${ctx}/print/order?orderId="+id;
					return
				}
                var number='${order.number}';
                $.ajax({url:"${ctx}/print/writePrintTimes", type:"post", data:{number:number}, success:function(result){}});
				prn_Preview(data);
			}

		});
	}
	//判断是否设置自定义打印模板
	function judgedygd(){
		$.ajax({
			type : 'POST',
			url : "${ctx}/order/printdesign/getOrderPrin",
			data : {},
			datatype:"JSON",
			success : function(data) {
				if(data == "ok"){
					$("#repeteWrite").hide();
					$("#repeatOrder_custom").show();
					return
				}else{
					$("#repeteWrite").show();
					$("#repeatOrder_custom").hide();
				}
			
			}

		});
	}
	
	function cancelCloseOrder() {
		$.closeDiv($(".fbOrder"), true);
	}
	
	function createUploader(picker,site, el,id,name) {
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
						$(site).append('<input type="hidden"  name="'+name+'" id="'+name+file.id+'" value="'+response.path+'">');
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
			   if(el <5){
			   if(parseInt(repairImgsCount) >= 4 ){
				  $("#jiahaore").addClass('hide');
				   layer.msg("最多可上传"+el+"张图片！");
				   return false;
			   }
			   }else{
			   if(feedImgsCount > 7){
				  $("#jiahao").addClass('hide');
			   }
			   if(parseInt(feedImgsCount) >= el ){
				   layer.msg("最多可上传"+el+"张图片！");
				   return false;
			   }
			   }
			   
		   uploader.makeThumb( file, function( error, src ) {
			   if (error) {
				    layer.msg('不能预览');
			   } else {
				   img(id,src,file,site,el);
			   }
		}, thumbnailWidth, thumbnailHeight );
		});    
		   
	}
	
	function delx(obj,fileId,el) {
		$("#file"+fileId+"").remove();
		$("#mark"+fileId+"").remove();
		$(obj).parent('.imgWrap1').remove();
		$("#pickerImg"+fileId).remove();
		if(el <5 ){
			repairImgsCount = repairImgsCount-1;
		if(repairImgsCount<4){
			$("#jiahaore").removeClass('hide');
		}
		}else{
		feedImgsCount = feedImgsCount-1;
		if(feedImgsCount<=el){
			$("#jiahao").removeClass('hide');
		}
		}
    	return ;
	} 
	function img(id,src,file,site,el){
		var html =' <div class="f-l imgWrap1 mb-10" id="file'+file.id+'"><div class="imgWrap"> ';
		html +='<img src="'+src+'" id=""></div><a class="sficon btn-delimg" onclick="delx(this, \''+file.id+'\','+el+')"></a></div>'+
				'<input name="markAble" id="mark'+file.id+'" hidden="hidden" value="'+file.id+'" />';
		if(el =='4'){
		if(repairImgsCount >= el){
			$("#jiahaore").addClass('hide');
			layer.msg("最多可上传"+el+"张图片！");
			return false;
		}
		repairImgsCount=parseInt(repairImgsCount)+1;  
		if(repairImgsCount>=el){
			$("#jiahaore").addClass('hide');
			repairImgsCount = 4;
		}
		if(parseInt(repairImgsCount)<=el){
			$(site).append(html);
		}
		}else{
		if(feedImgsCount >= el){
			$("#jiahao").addClass('hide');
			layer.msg("最多可上传"+el+"张图片！");
			return false;
		}
		feedImgsCount=parseInt(feedImgsCount)+1;  
		if(feedImgsCount>=el){
			$("#jiahao").addClass('hide');
		}
		if(parseInt(feedImgsCount)<=el){
			$(site).append(html);
		}
		}
	
	}
	
	function deleteImg(ff) {
		$("#" + ff).remove();
		feedImgsCount = feedImgsCount - 1;
		if (feedImgsCount == 7) {
			$("#jiahao").removeClass('hide');
		} 
		if (uploader) {
			uploader = null;
		}
		createUploader("#filePicker-add", "#Imgprocess", "8","file_fake_add", "pickerImg");
	}
	function deletereImg(ff) {
		$("#" + ff).remove();
		repairImgsCount = repairImgsCount - 1;
		if (repairImgsCount >= 4) {
			$("#jiahaore").addClass('hide');
		}else{
			$("#jiahaore").removeClass('hide');
		} 
		if (uploader) {
			uploader = null;
		}
		createUploader("#repairImgsPicker-add","#repImgprocess","4","","bdImgs");
	}
	
	var markBlur="0";
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
				data:{code:code,fitIdBindEmpId:fitIdBindEmpId,num:num,orderId:"${order.id}",price:price,orderNumber:"${order.number}",customerName:"${order.customerName}",customerMobile:"${order.customerMobile}",
				customerAddress:"${order.customerAddress}",warrantyType:"${order.warrantyType}",applianceCategory:"${order.applianceCategory}",applianceBrand:"${order.applianceBrand}"},
				dataType:'text',
				async:false,
				success:function(result){
					layer.msg("操作成功!");
					markBlur="1";
					$.closeDiv($('.usebj'),true);
					fittingApply("pjmg");
					fittingApply("pjsy");
                    showSYMsg();
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
	
	function checkNum(num){

		var reg=/^([1-9]\d*\.?\d*)|(0\.\d*[1-9])$/;;
		return reg.test(num);
	}
	var ck = /^\d+(\.\d+)?$/;
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

//下一页
function nextOrder(id,number) {
//	toOrderDetail(id,number,'1');
    if (parent.nextOrder) {
        parent.nextOrder(id);
    }
}

//上一页
function previousOrder(id,number) {
//	toOrderDetail(id,number,'0');
    if (parent.prevOrder) {
        parent.prevOrder(id);
    }
}

function toOrderDetail(id,number,previousOrNext){
	var dtMsg = parent.getConditions();
	var topWin = window.top;
    parent.search();
    $.closeAllDiv();
	var $pFrame = $("#Hui-article-box iframe:visible", topWin.document);
    var frameWin = $pFrame.get(0).contentWindow || $pFrame.get(0);
    frameWin.layer.open({
       type : 2,
       content:'${ctx}/order/orderDispatch/Wholeform?map='+dtMsg+'&id='+id+'&previousOrNext='+previousOrNext+'&whereMark=1'+'&parentNumber='+number,
       title:false,
       area: ['100%','100%'],
       closeBtn:0,
       shade:0,
       anim:-1
   });
}

function showGoodsMsg(){
	var orderNumber = "${order.number}";
	$.ajax({
		url:"${ctx}/order/showGoodsMsg",
		data:{orderNumber:orderNumber},
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

var defafl=false;
function sendModeldef(id,tag,content){
    $("#clickSend").empty();
    if(defafl) {
        return;
    }
    var customerMobile = $("#customerMobile").val();//用户联系方式
    var siteMsgNums = $("#siteMsgNums").val();//服务商已购还有短信数
    var custName = $("#defcustomerName").val();
    var applianceBrand = $("#defapplianceBrand").val();
    var applianceCategory = $("#defapplianceCategory").val();
    var  serviceType =$("#defserviceType").val();
    var  serviceMode =$("#defserviceMode").val();
    var defempName=$("#defmsg2Names").val();
    var defempMobile=$("#defmsg2Mobiles").val();
    var smsmobile=$("#defjdPhone").val();
    var defsign ='${serviceName }';
    while(content.indexOf('@1') >= 0){
        content = content.replace("@1",custName);
    }
    while(content.indexOf('@2') >= 0){
        content = content.replace("@2",applianceBrand);
    }
    while(content.indexOf('@3') >= 0){
        content = content.replace("@3",applianceCategory);
    }
    while(content.indexOf('@4') >= 0){
        content = content.replace("@4",serviceType);
    }
    while(content.indexOf('@5') >= 0){
        content = content.replace("@5",serviceMode);
    }
    while(content.indexOf('@6') >= 0){
        content = content.replace("@6",defempName);
    }
    while(content.indexOf('@7') >= 0){
        content = content.replace("@7",defempMobile);
    }
    while(content.indexOf('@8') >= 0){
        content = content.replace("@8",smsmobile);
    }
    var newdefcontent=content;
    var s_temp;
    if($.trim(defsign)=="" || defsign==null){
        layer.msg("短信签名不能为空！");
        return;
    }
    if($.trim(defsign).length>6){
        layer.msg("短信签名过长，最多为6个汉字！请在系统设置-短信签名中设置！");
        return;
    }
    var sign=defsign;
    s_temp =newdefcontent;

    if($.trim(customerMobile).length==11 && $.trim(customerMobile).substring(0,1)=="1"){
        defafl = true;
        $.ajax({//check短信为几条，并对比看服务商已购买短信够不够发送
            type:"POST",
            //traditional:true,
            url:"${ctx }/order/msgNumbers",
            data:{content:s_temp,
                sign:sign},
            success:function(result){
                if(parseInt(result)>parseInt(siteMsgNums)){//发送短信数大于购买数
                    layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                }else{
                    $("#peoples").html('${order.customerName}');
                    $("#sendContent").text("“"+s_temp+"”？");
                    $("#clickSend").append('<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70  " onclick="sendConfirmMsgModel(\''+id+'\',\''+sign+'\',\''+s_temp+'\',\''+tag+'\',\''+orderMsgId+'\',\''+customerMobile+'\')" >确定</a>&nbsp;&nbsp;'+
                        '<a href="javascript:;" class="sfbtn sfbtn-opt w-70" id="cancelQuren" onclick="cancelQueren()">取消</a>');
                    $(".msgTextQuren").popup({level:5,closeSelfOnly:true});
                }
            },
            complete: function() {
                defafl = false;
            }
        })
    }else if($.trim(customerMobile)==""){
        layer.msg("请填写用户的手机号码！");
    }else{
        layer.msg("用户的手机号码格式不正确，请重新填写！");
    }
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
   // var str="http://www.sifangerp.com/wxweb/toScan?sid="+siteId+"&xcode="+code;
    $("#showCode").empty().qrcode({width: 200, height: 200, text: code});
    $(".qrcode").popup({level:2,closeSelfOnly:true});

}

function codeNumberCounts(){
	codeCounts(true);
	$('#applianceBarcode').bind('blur', function() {  
		codeCounts();
	});
	$('#applianceMachineCode').bind('blur', function() {
		codeCounts();
	});
	$('#applianceMachineCode').bind('input propertychange', function() {  
		codeCounts1();//条码字数统计
	})
	$('#applianceBarcode').bind('input propertychange', function() {  
		codeCounts1();//条码字数统计
	})
}

function codeCounts1(){
	var applianceBarcode = $.trim($("#applianceBarcode").val());
	var applianceMachineCode = $.trim($("#applianceMachineCode").val());
	$("#incodeNum").text(applianceBarcode.length);
	$("#outcodeNum").text(applianceMachineCode.length);
	if(!isBlank(applianceBarcode)){
		$(".weishu1").show();
		$(".code1").show();
		//loadAlreadyCode(1,applianceBarcode);
	}else{
		$(".weishu1").hide();
		$(".code1").hide();
	}
	if(!isBlank(applianceMachineCode)){
		$(".weishu2").show();
		$(".code2").show();
	}else{
		$(".weishu2").hide();
		$(".code2").hide();
	}
}

function codeCounts(force){
	var applianceBarcode = $.trim($("#applianceBarcode").val());
	var applianceMachineCode = $.trim($("#applianceMachineCode").val());
	$("#incodeNum").text(applianceBarcode.length);
	$("#outcodeNum").text(applianceMachineCode.length);
	if(!isBlank(applianceBarcode)){
		$(".weishu1").show();
		$(".code1").show();
		if (pageMode === 'edit' || force) {
            loadAlreadyCode(1, applianceBarcode);
        }
	}else{
		$(".weishu1").hide();
		$(".code1").hide();
	}
	if(!isBlank(applianceMachineCode)){
		$(".weishu2").show();
		$(".code2").show();
		if (pageMode === 'edit' || force) {
            loadAlreadyCode(2, applianceMachineCode);
        }
	}else{
		$(".weishu2").hide();
		$(".code2").hide();
	}
}

function loadAlreadyCode(type,code){
//	if(changeMark){
//		return;
//	}
	if (type === 1 && lastQueriedCodeIn === code) {
	    return;
	}
    if (type === 2 && lastQueriedCodeOut === code) {
        return;
    }

	if(isBlank(code)){
		if(type===1){
			 $("#codeInshow").hide();
			 $(".codeIn").hide();
		 }else{
			 $("#codeOutshow").hide();
			 $(".codeOut").hide(); 
		 }
		return;
	}
	if (type === 1) {
	    lastQueriedCodeIn = code;
	} else {
	    lastQueriedCodeOut = code;
	}
	$.ajax({
		url: "${ctx}/order/getHistoryOrdersCodeOutCountByTelDetail?code=" + $.trim(code)+"&id="+'${order.id}&f=dhf',
		type: 'GET',
		success: function(data) {
//			if(changeMark){
//				return;
//			}
			var count = data.cnt;
			if(count === 0){
				 if(type===1){
					 $("#codeInshow").hide();
					 $(".codeIn").hide();
				 }else{
					 $("#codeOutshow").hide();
					 $(".codeOut").hide();
				 }
			 }else{
				 if(count > 0){
					 if(type===1){
						 $("#codeInshow").text(count+'条历史工单');
						 $("#codeInshow").show();
						 $(".codeIn").show();
					 }else{
						 $("#codeOutshow").text(count+'条历史工单');
						 $("#codeOutshow").show();
						 $(".codeOut").show(); 
					 }
				 }else{
					 if(type===1){
						 $(".codeIn").hide();
					 }else{
						 $(".codeOut").hide();
					 }
					 
				 }
				 $('#codeShow').show();
			 }
		}
	});
}

function senMagPopup(id){
	layer.open({
        type : 2,
        content:'${ctx}/order/sendMsgAccountsOne?ids=' + id + "&type=3"+"&target=5",
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

var del1Mark = false;
function deleteProcessImg(id,path,obj){
	var content = "图片删除后不可恢复，您确认要删除吗？";
	$('body').popup({
		level:3,
		title:"过程图片删除",
		content:content,
		fnConfirm :function(){
			 if(del1Mark){
				 return;
			 }
			 del1Mark=true;
			 $.ajax({
				type : "POST",
				url : "${ctx}/order/orderDispatch/deleteProcessImage",
				data : {
					id : id,
					path:path
				},
				success : function(data) {
					if (data == "200") {
						layer.msg('删除成功!');
						$(obj).parent("div").remove();
					} else if(data == "420"){
						layer.msg('工单反馈信息有误，请刷新后重试');
					}else if(data == "421"){
						layer.msg('该图片已被删除，请刷新后重试！');
					}else {
						layer.msg('删除失败，请检查！');
					}
					del1Mark=false;
					return;
				},
				error:function(){
					layer.msg('删除失败，请检查!');
					del1Mark=false;
					return;
				}
			 }); 
		 },
		 fnCancel:function (){
				
		 }
	}); 
}
</script>
</body>
</html>
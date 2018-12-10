<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/tips_style.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>  
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script>  
	<style type="text/css">
		.errorwran{
			display: none;
		}
		.Validform_wrong{
			display: block;
		}
		.Validform_right{
			display: none;
		}
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
</head>

<body>

<!-- 新建工单 -->
<div class="popupBox odWrap addNewOrder">
	<h2 class="popupHead">
		新建工单
		<a href="javascript:;" class="sficon closePopup" id="closeNewBuild"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pos-r" >
			<form id="neworderForm"  action="" method="post" >
				<h3 class="modelHead">工单信息</h3>
				<div class="mt-10 cl h-40">	
					<c:if test="${orderNumSet != '200' }">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><em class="mark">*</em>工单编号：</label>
							<input type="text" class="input-text w-160 mustfill"  maxlength="20"  id="number" name="number" value="${number }" datatype="num" nullmsg = "请输入工单编号！" errormsg="工单编号格式错误！" ajaxurl="${ctx}/main/redirect/checkOrderNo"/>
							<p class="errorwran"></i>请输入有效的工单编号</p>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><em class="mark">*</em>服务类型：</label>
							
								<select class="select w-110 mustfill" name="serviceType" id="serviceType" datatype="*" errormsg="请选择服务类型" nullmsg="请选择服务类型">
									<option value="">请选择</option>
									<c:forEach items="${fns:getNewServiceType() }" var="stype">
										<option value="${stype.columns.name }" ${stype.columns.name eq order.serviceType ? 'selected': ''}>${stype.columns.name }</option>
									</c:forEach>
								</select>
							<p class="errorwran">请选择服务类型</p>
						</div>
					</c:if>
					<c:if test="${orderNumSet == '200' }">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><em class="mark">*</em>服务类型：</label>
							
								<select class="select w-110 mustfill" name="serviceType" id="serviceType" datatype="*" errormsg="请选择服务类型" nullmsg="请选择服务类型">
									<option value="">请选择</option>
									<c:forEach items="${fns:getNewServiceType() }" var="stype">
										<option value="${stype.columns.name }" ${stype.columns.name eq order.serviceType ? 'selected': ''}>${stype.columns.name }</option>
									</c:forEach>
								</select>
							<p class="errorwran">请选择服务类型</p>
						</div>
					</c:if>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2"><em class="mark">*</em>服务方式：</label>
							<select class="select w-100 mustfill" name="serviceMode" id="serviceMode" datatype="*" errormsg="请选择服务方式" nullmsg="请选择服务方式">
								<option value="">请选择</option>
								<c:forEach items="${fns:getNewServiceMode() }" var="stype">
									<option value="${stype.columns.name }" ${stype.columns.name eq order.serviceMode ? 'selected': ''}>${stype.columns.name }</option>
								</c:forEach>
							</select>
						<p class="errorwran">请选择服务方式</p>
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2"><c:if test="${mustfill.columns.origin}"><em class="mark">*</em></c:if>信息来源：</label>
							<select class="select w-100 ${mustfill.columns.origin?'mustfill':''}" <c:if test="${mustfill.columns.origin}">datatype="*" nullmsg="请选择信息来源"</c:if> size="1" name="origin" id="origin">
							<option value="">请选择</option>
								<c:forEach items="${listorigin }" var="otype">
								<option value="${otype.columns.name }" <c:if test="${otype.columns.name == order.origin }">selected="selected"</c:if>>${otype.columns.name }</option>
								</c:forEach>
						</select>
					</div>
				</div>
				<div class="cl mb-10  mt-10">
					<div class="f-l pos-r pl-100">
						<label class="lb w-100">厂家工单编号：</label>
						<input type="text" id="factoryNumber" class="input-text w-160 " maxlength="32" name="factoryNumber" value=""/>
					</div>
				</div>
				<h3 class="modelHead">用户信息</h3>
				<div class="pt-10 mb-15">
					<div class="cl">
						<div class="f-l pos-r txtwrap1 mb-10">
							<label class="lb lb1"><em class="mark">*</em>用户姓名：</label>
							<input type="text" class="input-text w-140 mustfill" name="customerName" id="customerName" datatype="*" errormsg="用户姓名格式不正确" nullmsg="请输入用户姓名" value="${order.customerName }"/>
							<p class="errorwran">请输入用户姓名</p>
							<c:if test="${cusTypecount > 0 }">
							<span class="select-box w-100 ">
		                    <select  style="border: none" class="select ${mustfill.columns.customerType?'mustfill':''}" <c:if test="${mustfill.columns.customerType}">datatype="*" nullmsg="请选择用户类型"</c:if>  id="customerType" name="customerType">
			                    <option value="">选择类型</option>
			                    <c:forEach items="${fns:getCustomerType()}" var="to">
			                    <option value="${to.columns.name }" ${to.columns.name==order.customerType ?'selected':''}>${to.columns.name }</option>
			                    </c:forEach>
		                    </select>
							</span>
							</c:if>
						</div>
						<div class="f-l pos-r txtwrap2">
							<span class="lb lb2">
								<span class="f-r pr-5">:</span>
								<select class="lb-sel f-r" id="mobileOrtel">
									<option value="1">手机号码</option>
									<option value="2">固定电话</option>
								</select>
							</span>
							<input type="text" class="input-text w-110 mustfill" name="customerMobile" id="customerMobile" datatype="tel" errormsg="手机号码格式不正确" nullmsg="请输入手机号码" value="${order.customerMobile }"/>
							<p class="errorwran">请输入联系电话</p>
							</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">其他联系方式：</label>
							<input type="text" class="input-text w-110" id="customerTelephone" name="customerTelephone" ignore="ignore" datatype="dh" errormsg="联系方式2格式错误" value="${order.customerTelephone }"/>
							<p class="errorwran"></p>
						</div>
						<div class="f-l pos-r " style="padding-left: 15px;">
							<!-- <label class="lb lb2">联系方式3：</label> -->
							<input type="text" class="input-text w-110" id="customerTelephone2" name="customerTelephone2" ignore="ignore" datatype="dh" errormsg="联系方式3格式错误" value="${order.customerTelephone2 }"/>
							<p class="errorwran"></p>
						</div>
					</div>
					<div class="pos-r txtwrap1" >
						<label class="lb lb1"><em class="mark">*</em>详细地址：</label>
						<span class="select-box w-90 ">
						<select class="prov select" id="province" name="province">
							<c:if test="${not empty order.province}">
								<c:forEach items="${provincelist }" var="pro">
									<option value="${pro.columns.ProvinceName }" ${pro.columns.ProvinceName==order.province ?'selected':'' }>${pro.columns.ProvinceName }</option>
								</c:forEach>
							</c:if>
							<c:if test="${empty order.province && not empty site.province}">
								<c:forEach items="${provincelist }" var="pro">
									<option value="${pro.columns.ProvinceName }" ${pro.columns.ProvinceName==site.province ?'selected':''}>${pro.columns.ProvinceName }</option>
								</c:forEach>
							</c:if>
						</select>
						</span>
						<span class="select-box w-90 ">
	                    <select class="city select" id="city" name="city">
							<c:if test="${not empty order.city}">
								<c:forEach items="${cities }" var="cs">
									<option value="${cs.columns.CityName }" ${cs.columns.CityName==order.city ?'selected':''}>${cs.columns.CityName }</option>
								</c:forEach>
							</c:if>
							<c:if test="${empty order.city && not empty site.city}">
								<c:forEach items="${cities }" var="cs">
									<option value="${cs.columns.CityName }" ${cs.columns.CityName==site.city ?'selected':''}>${cs.columns.CityName }</option>
								</c:forEach>
							</c:if>
						</select>
						</span>
						<span class="select-box w-90 ">
	                    <select class="dist select" id="area" name="area">
							<c:if test="${not empty order.area}">
								<c:forEach items="${districts }" var="ds">
									<option value="${ds.columns.DistrictName }" ${ds.columns.DistrictName==order.area ?'selected':''}>${ds.columns.DistrictName }</option>
								</c:forEach>
							</c:if>
							<c:if test="${empty order.area && not empty site.area}">
								<c:forEach items="${districts }" var="ds">
									<option value="${ds.columns.DistrictName }" ${ds.columns.DistrictName==site.area ?'selected':''}>${ds.columns.DistrictName }</option>
								</c:forEach>
							</c:if>
						</select>
						</span>
						<c:if test="${wnsize > 0 }">
						<span class="select-box w-90 ">
	                    <select class="select" id="township" name="township">
	                    <option value="">乡/镇选择</option>
	                    <c:forEach items="${township }" var="to">
	                    <option value="${to.columns.name }">${to.columns.name }</option>
	                    </c:forEach>
	                    </select>
						</span>
						</c:if>
						<input type="text" class="input-text w-260 mustfill" id="customerAddress1" placeholder="详细地址" datatype="*" errormsg="详细地址格式错误" nullmsg="请输入详细地址" value="${order.customerAddress}"/>
						<a class="btn-dw" onclick="curmaskAddr()" id="btn-showaddr"></a>
						<span class="ml-5 c-fe0101 hide" id="distancealert">距离xxx公里</span>
						<%-- display: inline-block --%>
						<input type="hidden" class="input-text w-260 mustfill" value="${order.customerAddress}" name="customerAddress" id="customerAddress" placeholder="详细地址" datatype="*" errormsg="详细地址格式错误" ignore="ignore"/>
						<p class="errorwran">请输入详细地址</p>
						<input type="hidden"  name="customerLnglat" readonly="true" id="lnglat" />
					</div>
				</div>
				<h3 class="modelHead">服务信息</h3>
				<div class="pt-10">
					<div class="cl mb-10" id="styleMark">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><em class="mark">*</em>家电品牌：</label>
								<select class="select w-140 mustfill" name="applianceBrand" id="applianceBrand" datatype="*" nullmsg="请选择家电品牌！" >
									<option value="">请选择</option>				
									<c:forEach items="${brand }" var="ba" varStatus="sta">
									 <option value="${ba.key }" ${ba.key eq order.applianceBrand ? 'selected': ''}>${ba.value }</option>
								</c:forEach>
								</select>
							<p class="errorwran">请选择家电品牌</p>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><em class="mark">*</em>家电品类：</label>
								<select class="select w-110 mustfill" name="applianceCategory" id="applianceCategory" datatype="*" nullmsg="请选择家电品类！">
										<option value="">请选择</option>				
								<c:forEach items="${category }" var="ca" varStatus="cast">
									 <option value="${ca.columns.name }" ${ca.columns.name eq order.applianceCategory ? 'selected': ''}>${ca.columns.name }</option>
								</c:forEach>
								</select>
							<p class="errorwran">请选择家电品类</p>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.promiseTime}"><em class="mark">*</em></c:if>预约日期：</label>
							<input type="text" onfocus="WdatePicker({minDate: '%y-%M-%d' })" id="promiseTime" name="promiseTime" class="input-text Wdate w-110 ${mustfill.columns.promiseTime?'mustfill':''}">
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.promiseLimit}"><em class="mark">*</em></c:if>时间要求：</label>
								<select class="select w-110 ${mustfill.columns.promiseLimit?'mustfill':''}" name="promiseLimit" id="promiseLimit" <c:if test="${mustfill.columns.promiseLimit}">datatype="*" nullmsg="请选择时间要求"</c:if>>
									<option value="">请选择</option>
								</select>
						</div>
					</div>
					<div class="cl mb-10">
						<div class="f-l pos-r txtwrap1 h-50">
							<label class="lb lb1"><c:if test="${mustfill.columns.customerFeedback}"><em class="mark">*</em></c:if>服务描述：</label>
							<textarea type="text" class="input-text w-340 h-50 ${mustfill.columns.customerFeedback?'mustfill':''}" <c:if test="${mustfill.columns.customerFeedback}">datatype="*" nullmsg="请输入服务描述"</c:if> name="customerFeedback" id="customerFeedback" >${order.customerFeedback}</textarea>
						<p class="errorwran"></p>
						</div>
						<div class="f-l pos-r txtwrap2 h-50">
							<label class="lb lb2"><c:if test="${mustfill.columns.remarks}"><em class="mark">*</em></c:if>备注：</label>
							<textarea type="text" class="input-text h-50 w-310 ${mustfill.columns.remarks?'mustfill':''}" <c:if test="${mustfill.columns.remarks}">datatype="*" nullmsg="请输入备注"</c:if> id="remarks" name="remarks">${order.remarks}</textarea>
						</div>
					</div>
					
					<div class="cl mb-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><c:if test="${mustfill.columns.applianceModel}"><em class="mark">*</em></c:if>产品型号：</label>
							<input type="text" class="input-text w-140 ${mustfill.columns.applianceModel?'mustfill':''}" <c:if test="${mustfill.columns.applianceModel}">datatype="*" nullmsg="请输入产品型号"</c:if> id="applianceModel" name="applianceModel" value="${order.applianceModel}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.applianceNum}"><em class="mark">*</em></c:if>产品数量：</label>
							<input type="text"  class="input-text w-110 ${mustfill.columns.applianceNum?'mustfill':''}" <c:if test="${mustfill.columns.applianceNum}">datatype="anum" errormsg="产品数量格式不正确"  nullmsg="请输入产品数量"</c:if> name="applianceNum" id="applianceNum" value="${order.applianceNum}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.applianceBarcode}"><em class="mark">*</em></c:if>内机条码：</label>
							<input type="text" style="width:180px;" class="input-text  ${mustfill.columns.applianceBarcode?'mustfill':''}" <c:if test="${mustfill.columns.applianceBarcode}">datatype="*" nullmsg="请输入内机条码"</c:if> name="applianceBarcode" id="applianceBarcode" value="${order.applianceBarcode}"/>
							<span class="weishu1" hidden="hidden">
								( <span id="incodeNum">0</span>位 )
							</span>
							<span class="ml-2 code1" hidden="hidden">
								<a href="javascript:showQRCode('${site.id }','1');" class="sficon sficon-scancode  " ></a>
							</span>
							<span class="va-t underline c-fe0101 codeConnectShow cPointer " preData="${order.applianceBarcode}"  id="codeInshow"></span >
						</div>
						
					</div>
					<div class="mb-10 cl">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><c:if test="${mustfill.columns.applianceBuyTime}"><em class="mark">*</em></c:if>购买日期：</label>
							<input type="text" onfocus="WdatePicker({maxDate: '%y-%M-%d' })"  id="applianceBuyTime" name="applianceBuyTime" class="input-text Wdate w-140 ${mustfill.columns.applianceBuyTime?'mustfill':''}" value="<fmt:formatDate value='${order.applianceBuyTime }' pattern='yyyy-MM-dd'/>" readonly>
						</div>
						<div class="f-l pos-r txtwrap2">

							<c:choose>
								<c:when test="${not empty malllist}">
									<label class="lb lb2"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
									<span class="w-110">
									<select class="select ${mustfill.columns.pleaseReferMall?'mustfill':''}"  id="pleaseReferMall"  multiline="false" name="pleaseReferMall" style="width:100%;height:25px" panelMaxHeight="300px" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请选择购机商场"</c:if>>
										<option value="">请选择</option>
										 <c:set var="hadMall" value="0"></c:set>
										<c:forEach items="${malllist }" var="mall">
											<c:if test="${mall.columns.mall_name eq order.pleaseReferMall}"><c:set var="hadMall" value="1"></c:set></c:if>
											<option value="${mall.columns.mall_name } " ${order.pleaseReferMall eq mall.columns.mall_name ?'selected':''}>${mall.columns.mall_name }</option>
										</c:forEach>
                                        <c:if test="${hadMall eq '0' and not empty order.pleaseReferMall}"><option value="${order.pleaseReferMall}" selected>${order.pleaseReferMall}</option></c:if>
									</select>
								</span>
								</c:when>
								<c:otherwise>
									<label class="lb lb2"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
									<input type="text" value="${order.pleaseReferMall}" name="pleaseReferMall" class="input-text w-110 ${mustfill.columns.pleaseReferMall?'mustfill':''}" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请输入购机商场"</c:if> value="${order.pleaseReferMall}">
								</c:otherwise>
							</c:choose>

							<%--<label class="lb lb2"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
							<input type="text" name="pleaseReferMall" class="input-text w-110 ${mustfill.columns.pleaseReferMall?'mustfill':''}" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请输入购机商场"</c:if> value="${order.pleaseReferMall}">--%>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.applianceMachineCode}"><em class="mark">*</em></c:if>外机条码：</label>
							<input type="text" style="width:180px;" class="input-text  ${mustfill.columns.applianceMachineCode?'mustfill':''}" <c:if test="${mustfill.columns.applianceMachineCode}">datatype="*" nullmsg="请输入外机条码"</c:if> name="applianceMachineCode" id="applianceMachineCode" value="${order.applianceMachineCode}"/>
							<span class="ml-2 mr-2 weishu2" hidden="hidden">
								( <span id="outcodeNum">0</span>位 )
							</span>
							<span class="ml-2 mr-2 code2"  hidden="hidden">
								<a href="javascript:showQRCode('${site.id }','2');" class="sficon sficon-scancode  "></a>
							</span>
							<span class="va-t underline c-fe0101 codeConnectShow cPointer" preData="${order.applianceMachineCode}"  id="codeOutshow"></span>
						</div>
						

					</div>
					<div class="mb-10 cl">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><c:if test="${mustfill.columns.warrantyType}"><em class="mark">*</em></c:if>保修类型：</label>
								<select class="select w-140 ${mustfill.columns.warrantyType?'mustfill':''}" <c:if test="${mustfill.columns.warrantyType}">datatype="*" nullmsg="请选择保修类型"</c:if> id="warrantyType" name="warrantyType">
									<option value="">请选择</option>
									<option value="1" ${order.warrantyType eq '1' ? 'selected' : ''}>保内</option>
									<option value="2" ${order.warrantyType eq '2' ? 'selected' : ''}>保外</option>
								</select>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.level}"><em class="mark">*</em></c:if>重要程度：</label>
								<select class="select  w-110 ${mustfill.columns.level?'mustfill':''}" <c:if test="${mustfill.columns.level}">datatype="*" nullmsg="请选择重要程度"</c:if> id="level" name="level">
									<option value="">请选择</option>
									<option value="1" ${order.level eq '1' ? 'selected' : ''}>重要</option>
									<option value="2" ${order.level eq '2' ? 'selected' : ''}>一般</option>
								</select>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><em class="mark">*</em>报修时间：</label>
							<input type="text" id="repairTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="repairTime" value ="<fmt:formatDate value="${curDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" class="input-text  w-130 ">
						</div>
						<div class="f-l pos-r pl-80">
							<label class="pos w-80">登记人：</label>
							<input type="text" class="input-text w-100 readonly" name="messengerName" value="${fns:getUserXm() }" readonly="readonly" />
						</div>
					</div>
					<div class="pos-r mt-10 txtwrap1 cl allDuringImgs" id="">
					<label class="lb lb1">报修图片：</label>
						<div id="Imgprocess">
								<c:forEach items="${repairImgs }" var="str" varStatus="da">
									<div class="f-l imgWrap1" id="img${da.index}">
										<div class="imgWrap"> 
											<img src="${commonStaticImgPath}${str}" id="${commonStaticImgPath}${str}"></img>
										</div>
										<a class="sficon btn-delimg" onclick="deleteImg('img${da.index}')" ></a>
										<input type="hidden" value="${str}" name="bdImgs" >
									</div>
								</c:forEach>
							
						</div>
						<div class="f-l mr-10">
								<div class="imgWrap jiahao hide" id="jiahao" >
									<div id="filePicker-add">
										<a href="javascript:;" class="btn-upload"></a>
									</div>
								<p class="lh-20">最多可上传4张照片</p>
								</div>
							</div>
					</div>
				</div>
				<div class="mb-10 cl">
						
						<div class="f-l pos-r txtwrap1 ">
							<label class="lb lb2"><em class="mark">*</em>配送单号：</label>
							<input type="text"  class="input-text  w-130 " id="distributionNumber"  name="distributionNumber"  >
						</div>
						<div class="f-l pos-r txtwrap2 ">
							<label class="lb lb2"><em class="mark">*</em>配送日期：</label>
							<input type="text"  class="input-text  w-130 " id="distributionTime"   onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="distributionTime" value ="<fmt:formatDate value="${order.repairTime}" pattern="yyyy-MM-dd"/>" >
						</div>
						<div class="f-l pos-r pl-80">
							<label class="pos w-80">车牌号码：</label>
							<input type="text" class="input-text w-130 readonly" readonly="readonly" name="plateNumber" id="plateNumber" />
							<input type="hidden"  name="siteplateId" id="siteplateId" />
						</div>
						<div class="f-l pos-r pl-80">
							<label class="pos w-80">配送人员：</label>
							<input type="text" class="input-text w-130 readonly" readonly="readonly" name="driverName" id="driverName" />
							<input type="hidden" name="sitedriverId" id="sitedriverId" />
						</div>
						<a href="javascript:;" class="sficon sficon-add2 f-l mt-3 ml-5 " onclick="addDriver()"></a>
					</div>
				<input type="hidden" name= "employeId" id="employeId">
			<div class="btnMenubox">
				<input class="sfbtn sfbtn-opt3" value="保存" type="submit"/>
				<input class="sfbtn sfbtn-opt" value="重置" type="button" onclick="resetDetailForm();"/>
				<input class="sfbtn sfbtn-opt" value="直接派单" type="button" onclick="directDis()"/>
				<input class="sfbtn sfbtn-opt" value="保存并打印" type="button" onclick="printView()"/>
			</div>
			</form>
		</div>
	</div>
</div>

<!-- 选车车辆和司机人员
 -->
<div class="popupBox  addDriver" style="z-index: 199;'">
	<h2 class="popupHead">
		新增
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r" style='height: 125px;'>
		<div class="popupMain">
			<div class="pcontent" id="originbox" >
				<div class="cl mb-10 mt-10">
					<label class="f-l w-70"><em class="mark">*</em>车牌号码：</label>
					<span class="w-140">
						<select class="select"  id="siteplateNumber" >
						<option value="">请选择</option>
							<c:forEach items="${fns:getSiteVehicle() }" var="stype">
								<option value="${stype.columns.id }"  >${stype.columns.plate_number }</option>
							</c:forEach>
						</select>
					</span>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-70"><em class="mark">*</em>配送人员：</label>
					<span class="w-140">
						<select class="select easyui-combobox"  id="siteDriver" multiple="true" multiline="false" name="statuss" style="width:100%;height:25px" panelMaxHeight="300px">
							<c:forEach items="${fns:getsiteDriver() }" var="stype">
								<option value="${stype.columns.id }"  >${stype.columns.driver_name }</option>
							</c:forEach>
						</select>
					</span>
				</div>
				
			</div>	
		</div>
		<div class="text-c btnWrap" style='top:80px'>
			<a class="sfbtn sfbtn-opt3 w-70 mr-5" onclick="addDrive()">保存</a>
			<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5"  onclick="closed()">取消</a>
		</div>
	</div>
</div>


<!-- 我要派工 -->
<div class="popupBox dispatch activeDispatch " >
	<h2 class="popupHead">
		我要派工
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain cl" >
			<div class="f-l serversWrap">
				<div class="searchbox">
					<input type="text" placeholder="请输入工程师姓名" class="input-text" id="filterName"/>
					<a href="javascript:;" class="btn-search"><i class="Hui-iconfont Hui-iconfont-search2 f-16"></i></a>
				</div>
				<div class="mt-10 serverlistWrap">
					<div class="tableWrap">
						<table class="table table-border table-bg table-serverlist">
							<thead>
								<th class="w-90" style="border-left: none;">工程师姓名</th>
								<th class="w-100">未完成工单</th>
								<!-- <th class="w-100">今日已完成</th> -->
								<th class="w-100">今日未完工
								 <i class="Hui-iconfont f-20 c-fe0101 mr-5 left_tip_">
											&#xe6cd;
											<span class="tip__" style="width:380px;"><em class="left_tip"></em>统计今日派工且未预约以及预约时间为今日的工程师未完工工单数量</span>
										</i>
								</th>
								<th class="w-100">今日已完工</th> 
								<th class="w-90">距离</th>
								<th class="w-80">选择</th>
							</thead>
							
						<tbody id="zhijiepaidan">
						
							</tbody>
						</table>
					</div>
					<div class="serversName">
						<div class="txtwrap1 pos-r">
							<label class="lb lb1"><em class="c-fe0101">派工至</em>：</label>
							<p class="lh-30" id="nameWrap"></p>
							<input type="button" class="w-70 sfbtn sfbtn-opt3" value="确认派工" onclick="dispa()"/>
						</div>
					</div>
				</div>
			</div>
			<div class="f-r w-460">
				<div class="cl mb-10">
					<div class="f-l w-220 bk-gray" id="dispatch_map_container" style="height: 120px;">
						<!-- 地图 -->
					</div>
					<div class="f-l w-230 ml-10 f-13 pt-10" style="height: 120px;">
						<p class=""><strong class="custNam"></strong></p>
						<p class=""><strong class="custMob"></strong></p>
						<p class="custAddr"></p>
					</div>
				</div>
				<div class="cl mb-10">
					<input type="text"  class="input-text w-330 f-l" id="arroundCustomerAddress" />
					<a class="sfbtn sfbtn-opt f-r" href="javascript:searchArroundCust();"><i class="sficon sficon-search"></i>查看周边用户 </a>
				</div>
				<div class="serverlistWrap">
					<div class="tableWrap" style="height: 195px;">
						<table class="table table-border table-bg table-serverlist" style="table-layout: auto;">
							<thead>
							<th class="w-90" style="border-left: none;">姓名</th>
							<th class="w-100">联系方式</th>
							<th class="w-100">报修家电</th>
							<th class="w-90">报修时间</th>
							<th class="w-80">选择</th>
							</thead>
							<tbody id="arroundUserInfo">
							<tr>
								<%--<td style="border-left: none;">小灰灰</td>
								<td>15656565656</td>
								<td>格力空调</td>
								<td>2018-02-23</td>
								<td>
									<label class="label-cbox3" ><input type="checkbox" name="serverSelected" ></label>
								</td>--%>
							</tr>
							</tbody>
						</table>
					</div>
					<div class="serversName">
						<div class="pos-r pl-15 pr-80">
							<p class="pt-5 pb-5 lh-20" style="min-height: 30px"><%--郑经文、小灰灰、张晓明郑经文、小灰灰、张晓明--%></p>
							<input type="button" class="w-70 sfbtn sfbtn-opt3 " value="发送短信" onclick="senMsg()" />
							<input type="hidden" name="sendMsgOrderId" value="" />
							<input type="hidden" name="customerMobileNow" value="" />
							<input type="hidden" name="sign" id="sign" value="" />
							<input type="hidden" name="siteMsgNums" id="siteMsgNums" value="" />
							<input type="hidden" name="jdTelephone" id="jdTelephone" value="" />
						</div>
					</div>
				</div>
			</div>
			<%--<div class="f-r mapWrap" id="dispatch_map_container">

			</div>--%>
		</div>
	</div>
</div>
	<div id="map-container" style="display: none;">
				
	</div>


<!-- 短信群发 -->
<div class="popupBox massTextNote massTextNoteQf">
	<h2 class="popupHead">
		短信群发
		<a href="javascript:;" class="sficon closePopup" onclick="guanbi()"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain " >
			<div class="f-14">
				您已发送<strong class="c-005aab" id="sucMsg">0</strong>条，未发送<strong class="c-fd7e2a" id="wroMsg">0</strong>条！
			</div>
			<a id="exportLink" onclick="closePopup()" href="${ctx}/order/exportWrongNumber?formPath=/a/order/History" target="_blank" class="c-0383dc mt-10" style="text-decoration: underline;">查看发送失败的工单</a>
			<div class="text-c mt-20">
				<a  class="sfbtn sfbtn-opt w-70" onclick="guanbi()">关闭</a>
			</div>
		</div>
	</div>
</div>
	
	<div class="popupBox popupMap plocation">
	<h2 class="popupHead">
		地址定位
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain ">
			<div class="bk-gray mapBox pos-r">
				<div class="addrTxtBg"></div>
				<div class="addrTxt ">
					<p class="c-f55025 lh-26">注：在地图上拖动用户位置或输入详细地址（XX市XX县/区XX街道XX小区）点击“定位”获取用户位置信息</p>
					<input type="text" class="input-text w-300 mr-5" id="dingweidizhi" value="合肥市蜀山区">
					<a href="javascript:dingwei1();" id="dingwei" class="sfbtn sfbtn-opt3 text-c f-13 w-70">定位</a>
					<a href="javascript:gather();" class="sfbtn sfbtn-opt3 text-c f-13 w-70 ml-10">确定</a>
				</div>
				<div class="addrMap" id="map-container1">
					<!-- 地图部分 -->
				</div>
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

<input id="signPoint" name="signPoint" value="" type="hidden">
<input type="hidden" name="longitude" readonly="true" id="longitude" value="" />
<input type="hidden" name="latitude" readonly="true" id="latitude" value="" />

<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/city.union.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/addressChange.union.js"></script>
<script type="text/javascript">
$("#closeNewBuild").on("click",function(){
	window.location.href="${ctx}/operate/site/saveTableHeader";
});
var changeMark = true;
var ctx='${ctx}';
AMap.service('AMap.Geocoder', function () {//回调函数
    //实例化Geocoder
    geocoder = new AMap.Geocoder();
});
var dispatchMap,dispatchMarker,employeMarker;
	var marker;
	var mark;
	var a = true;
	var num = /^[A-Za-z0-9]{1,20}$/ ;

$(function(){
	$("#number").focus();
	$('.addNewOrder').popup();
	$("#number").blur();
	$('#applianceBrand').select2();
	$(".selection").css("width","140px");
	$("#origin").select2();
	$(".selection").css("width","140px");
	$('#applianceCategory').select2();
	$("#applianceCategory").next(".select2").find(".selection").css("width","110px");
	$("#origin").next(".select2").find(".selection").css("width","110px");
	$("#styleMark .select2-selection--single").css({'background-color': '#dbf5fd','border':'1px solid #5ebdfb'});
	$("#applianceMachineCode").focus(function(){
		var nei = $("#applianceBarcode").val();
		if(isBlank(nei)){
			layer.msg("请先填写内机条码！");
		}
	});

    $("#pleaseReferMall").select2({tags: true});
    $("#pleaseReferMall").next(".select2").find(".selection").css("width","110px");

	$('#filterName').keyup(function(){
		$('#zhijiepaidan tr').hide()     
		.filter(":contains('" +($(this).val()) + "')").show();  
		}).keyup();//DOM加载完时，绑定事件完成之后立即触发  
	// 当预约时间没选择时给出提示
	var limit ="";
	 $.post("${ctx}/order/getproLimitList",function(result){
		    $.each(result, function(){
		    	var value= this;
		    	limit = limit + '<option value="'+value+'">'+value+'</option>';
		    });
		});
	$("#promiseLimit").focus(function(){
		$("#promiseLimit").empty();
		var html ="";
		if(isBlank($("#promiseTime").val())){
			layer.msg("请选择预约时间");
			html ='<option value="">请选择</option>';
		}else{
			html ='<option value="">请选择</option>';
			html = html+limit;
		}
			$("#promiseLimit").append(html);	
	});
	// 选择品类时获取服务商维护对应的品牌
	$("#applianceCategory").change(function () {
		var brand = $("#applianceBrand").val();
		var cate = $("#applianceCategory").val();
		$.ajax({
			type: "post",
			url: "${ctx}/order/getBrand",
			data: {
				category: cate
			},
			dataType: "json",
			success: function (data) {
				var obj = eval(data);
				$("#applianceBrand").empty();
				if (obj.count == 2) {
					layer.msg("没有相关品牌，请维护");
				} else {
					var HTML = " <option value=''>请选择</option> ";
					$.each(obj.brand, function (key, values) {
						if (brand == values) {
							HTML += '<option value="' + values + '" selected = "selected" >' + key + '</option>';
						} else {
							HTML += '<option value="' + values + '">' + key + '</option>';
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
				if (obj.count == 2) {
					layer.msg("没有相关品类，请维护");
				} else {
					$("#applianceCategory").empty();
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
	//获取用户地址经纬度
 	$("#customerAddress1").change(function() {
 		initAddrmap();
		dingwei();
	});

    $.post("${ctx}/order/remainMsgNum",{},function(result){
        $("#sign").val(result.columns.sms_sign);
        $("#siteMsgNums").val(result.columns.sms_available_amount);
        $("#jdTelephone").val(result.columns.sms_phone);
    });
});


$("#mobileOrtel").change(function () {
    var tel = $("#mobileOrtel").val();
    if (tel == "1") {
        $("#customerMobile").attr("datatype", "tel");
        $("#customerMobile").attr("nullmsg", "请输入手机号码");
        $("#customerMobile").attr("errormsg", "请输入手机号码");
    } else if (tel == "2") {
        $("#customerMobile").attr("datatype", "tel");
        $("#customerMobile").attr("nullmsg", "请输入固定电话");
        $("#customerMobile").attr("errormsg", "请输入固定电话");
    }
});


function addDriver(){
	$('.addDriver').popup({level: 2,closeSelfOnly:true});
}

function initComboboxYclx(datas,valu) {////////////datas是后台传来的数据
	$('#siteDriver').combobox('loadData', {});//清空option选项  
	var datas_edit = [];
	for (var i = 0; i < datas.length; i++) {
		datas_edit.push(datas[i].value); // 将移除’全部’的数据放到 data_new
	}
	for(var j = 0; j < valu.length; j++){
		var index=$.inArray(valu[j],datas_edit);
		datas.splice(index,1);
	$("#siteDriver option[value='"+valu[j]+"']").remove(); 
	}
	$('#siteDriver').combobox('clear');//清空选中项
	$('#siteDriver').combobox('loadData', datas);
}


function addDrive(){
	var number = $("#plateNumber").val();//已添加过得车牌号
	var renyuan = $("#driverName").val();//已添加过得人员
	var siteplateNumber = $("#siteplateNumber").find("option:selected").text();
	var plateNumberId = $("#siteplateNumber").val();
	var driveId = $('#siteDriver').combobox('getValues');
	var drive = $('#siteDriver').combobox('getText');
	if(isBlank(plateNumberId)){
		layer.msg("请选择车牌号！");
		return 
	}
	if(isBlank(driveId)){
		layer.msg("请选择配送人员！");
		return 
	}
	
	if(isBlank(number)){
		number = siteplateNumber;
	}else if(number.indexOf(siteplateNumber) != -1){
		layer.msg("选择的车牌号重复");
		return 
	}else{
		number = number+","+ siteplateNumber;
	}
	var plateId = $('#siteplateId').val();
	if(isBlank(plateId)){
		plateId = plateNumberId;
	}else{
		plateId=plateId+","+plateNumberId;
	}
	var driverName = $("#driverName").val();
	if(isBlank(driverName)){
		driverName = drive;
	}else{
		driverName=driverName+";"+drive;
	}
	
	var sitedriverId = $("#sitedriverId").val();
	if(isBlank(sitedriverId)){
		sitedriverId = driveId;
	}else{
		sitedriverId=sitedriverId+";"+driveId;
	}
	var a = $("#siteDriver").combobox('getData'); 
	initComboboxYclx(a,driveId);
	$('#siteplateId').val(plateId);
	$("#sitedriverId").val(sitedriverId);
	$("#plateNumber").val(number);
	$("#driverName").val(driverName);
    $('#siteplateNumber').val('');//清空选中项
    $('#siteDriver').combobox('clear');//清空选中项
    $.closeDiv($('.addDriver'));
}

function deleteImg(ff) {
	$("#" + ff).remove();
	repairImgsCount = repairImgsCount - 1;
	if (repairImgsCount >= 4) {
		$("#jiahao").addClass('hide');
	}else{
		$("#jiahao").removeClass('hide');
	}  
	if (uploader) {
		uploader = null;
	}
	createUploader("#filePicker-add", "#Imgprocess", "file_fake_addimg","file_fake_add", "delpickerImg");
}


var repairImgsCount = '${repairImgsCount}';
$(function(){
	createUploader("#filePicker-add","#Imgprocess","file_fake_addimg","file_fake_add","delpickerImg");
	if("${repairImgsCount}"<4){
		$("#jiahao").removeClass('hide');
	}
	$('.imgWrap').imgShow();
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
		   if(parseInt(repairImgsCount)<5){
		   $("input[name='markAble']").each(function(index,items){
				if(items.value==file.id){
					$(site).append('<input type="hidden"  name="bdImgs" id="bdImgs'+file.id+'" value="'+response.path+'">');
				}
			}) 
		   }
	   });
	   uploader.on( 'uploadError', function( file, reason ) {
			
	   }); 
	   uploader.on( 'uploadFinished', function() {
			if(uploader){
				uploader.reset();
			}
	   }); 
	   
	  
	   uploader.on( 'fileQueued', function( file ) {
		   if(repairImgsCount>=4){
			  $("#jiahao").addClass('hide');
		   }
		   if(parseInt(repairImgsCount) >4 ){
			   layer.msg("最多可上传4张图片！");
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
	$("#bdImgs"+fileId).remove();
	repairImgsCount = repairImgsCount-1;
	if(repairImgsCount<4){
		$("#jiahao").removeClass('hide');
	}
	return ;
} 
function img(id,src,file,site){
	if(repairImgsCount >= 4){
		$("#jiahao").addClass('hide');
		}
	if(repairImgsCount > 4){
		$("#jiahao").addClass('hide');
		layer.msg("最多可上传4张图片！");
		return false;
	}
	repairImgsCount=parseInt(repairImgsCount)+1;  
	var html =' <div class="f-l imgWrap1 mb-10" id="file'+file.id+'"><div class="imgWrap"> ';
	html +='<img src="'+src+'" id=""></div><a class="sficon btn-delimg" onclick="delx(this, \''+file.id+'\')"></a></div>'+
			'<input name="markAble" id="mark'+file.id+'" hidden="hidden" value="'+file.id+'" />';
	if(parseInt(repairImgsCount)<5){
		$(site).append(html);
	}
	if(repairImgsCount>=4){
		$("#jiahao").addClass('hide');
		repairImgsCount = 4;
	}
}

function resetDetailForm() {
	$("#applianceBrand").select2('val', '请选择');
	$("#serviceType").val("");
	$("#serviceMode").val("");
	$("#origin").val("");
	$("#customerName").val("");
	$("#customerMobile").val("");
	$("#customerTelephone").val("");
	$("#customerTelephone2").val("");
	$("#customerAddress").val("");
	$("#lnglat").val("");
	$("#applianceBrand").val("");
	$("#applianceCategory").val("");
	$("#promiseTime").val("");
	$("#promiseLimit").val("");
	$("#customerFeedback").val("");
	$("#remarks").val("");
	$("#applianceModel").val("");
	$("#applianceBarcode").val("");
	$("#applianceBuyTime").val("");
	$("#applianceMachineCode").val("");
	$("#warrantyType").val("");
	$("#level").val("");
	codeCounts();
}

function directDis(){
	var number=$.trim($("#number").val());
	var serviceType =$("#serviceType").val();
	var serviceMode = $("#serviceMode").val();
	var name =$("#customerName").val();
	var customerMobile =$("#customerMobile").val();
	var add =$("#customerAddress1").val();

	var selectcategory =$("#applianceCategory").val();
	var selectbrand =$("#applianceBrand").val();
	var customerFeedback =$("#customerFeedback").val();
	var codeSet = '${orderNumSet}';
	   var distributionNumber = $("#distributionNumber").val();    
       var plateNumber = $("#plateNumber").val(); 
	if(codeSet!='200'){
		if(isBlank(number)){
			layer.msg("请输入工单编号");
			$("#number").focus();
			return;
		}
		if(!num.test(number)){
			layer.msg("请输入正确的工单编号");
			$("#number").focus();
			return;
		}
	}
	if(isBlank(serviceType)){
		layer.msg("请选择服务类型");
	}else if(isBlank(serviceMode)){
		layer.msg("请选择服务方式");
	}else if(isBlank(name)){
		layer.msg("请输入用户姓名");
		$("#customerName").focus();
	}else if(isBlank(customerMobile)){
			layer.msg("请输入联系方式");
			$("#customerMobile").focus();
	}else if(isPhoneNo(customerMobile) == false){
		layer.msg("手机号码格式不正确");
		$("#customerMobile").focus();
	}else if(isBlank(add)){
		layer.msg("请输入详细地址");
		$("#customerAddress1").focus();
	}else if(isBlank(selectcategory)){
		layer.msg("请选择家电品类！");
	}else if(isBlank(selectbrand)){
		layer.msg("请选择家电品牌！");
	}else{
		if(isBlank(distributionNumber)){
	    	if(!isBlank(plateNumber)){
	    		layer.msg("请输入配送单号！");
	    		return
	    	}
	    }else if(isBlank(plateNumber)){
	    	layer.msg("请选择车牌信息！");
	    	return
	    }
        var result=checkMustFill(getJurisdiction(),getJurisdisctionValue());
        if(!result){
            return;
		}else{
            var repairTime=$("#repairTime").val();
            if(isBlank(repairTime)){
                layer.msg("请选择报修时间！");
                return;
            }

            $.ajax({
                type:"post",
                url:"${ctx}/order/checkonumber",
                data:{orderNumber:number},
                success:function(data){
                    if(data=="existNumber"){
                        layer.msg("工单编号已存在！");
                        return false;
                    }
                    $("#arroundUserInfo").empty();
                    $(".custNam").text($("#customerName").val());
                    $(".custMob").text($("#customerMobile").val());
                    $(".custAddr").text($("#customerAddress").val());
                    $("#arroundCustomerAddress").val($("#customerAddress1").val());

                    $('.activeDispatch').popup({level:2, closeSelfOnly:true}); //显示我要派工弹出框和判断高度
                    $.selectCheck2("serverSelected");
                    initDispatchMap();
                    employe();
                }
            })
		}
	}
}


function searchArroundCust(){
    var address = $("#arroundCustomerAddress").val();
    var orderId = $("input[name='sendMsgOrderId']").val();
    var mobile = $("input[name='customerMobileNow']").val();
    if(isBlank(address)){
        layer.msg("请输入地址信息");
    }else if(address.length>=2){
        $.ajax({
            type : "POST",
            url : "${ctx}/order/geteArroundCustInfo",
            data : {
                address :address,
                orderId:orderId,
                mobile:mobile
            },
            success : function(data) {
                var html='';
                if(data.length>0){
                    for(var i=0;i<data.length;i++){
                        html+='<tr><td style="border-left: none;">'+data[i].columns.customer_name+'</td>';
                        html+='<td class="customerMobile">'+data[i].columns.customer_mobile+'</td>';
                        html+='<td>'+data[i].columns.applBranCate+'</td>';
                        html+='<td>'+data[i].columns.repair_time+'</td>';
                        html+='<td><label class="label-cbox3" ><input type="hidden" name="customerTelephone" value="'+data[i].columns.customer_telephone+'"/><input type="hidden" name="customerTelephone2" value="'+data[i].columns.customer_telephone2+'"/><input type="hidden" name="number" value="'+data[i].columns.number+'"/><input type="checkbox" name="serverSelected" ></label></td></tr>';
                    }
                    $("#arroundUserInfo").empty().append(html);

                    $("#arroundUserInfo tr").on('click', function(ev) {
                        var name = ev.target.tagName.toLowerCase();
                        if(name == 'label') return;

                        var flag = $(this).hasClass('checked');
                        if (flag) {
                            $(this).removeClass('checked');
                        } else {
                            $(this).attr("class","checked");
                            $.trim($(this).children('td').eq(0).html())
                        }
                    });
                }else{
                    layer.msg("该地址暂无周边用户信息！");
                }
            },
        });
    }else{
        layer.msg("输入的地址信息需要超过两个字符！");
    }

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

var noRepeateSend=false;
function senMsg(){ //批量发送短信
    var ids=$("#arroundUserInfo").find(".checked");
    var mobile="";
    var number="";
    var wrongNumber="";

    var sign = $("#sign").val();
    var jsPhone = $("#jdTelephone").val();
    var toAnUrl='${oneHref}';
    var content ="";
    if(ids.length<1){
        layer.msg("您还未选中任何数据！");
        return false;
    }
    for(var i=0;i<ids.length;i++){
        var customer_mobile = $(ids[i]).find(".customerMobile").text();
        var customer_telephone = $(ids[i]).find("input[name='customerTelephone']").val();
        var customer_telephone2 = $(ids[i]).find("input[name='customerTelephone2']").val();
        var numb=$(ids[i]).find("input[name='number']").val();
        var applBranCate=$(ids[i]).find(".applBranCate").text();/*品牌品类*/

        var ph1=returnMobile(customer_mobile,customer_telephone,customer_telephone2);//去空格的mobile
        if($.trim(ph1)=="" || $.trim(ph1)==null){
            layer.msg("选择发送的工单中存在用户手机号为空的工单，请先维护或者重新选择工单！");
            return ;
        }
        if($.trim(ph1).length!=11 || $.trim(ph1).substring(0,1)!="1" ){
            if(wrongNumber==""){
                wrongNumber=numb;
            }else{
                wrongNumber=wrongNumber+','+numb;
            }
        }
        if(i==0){
            mobile=$.trim(ph1);
            number=$.trim(numb);
        }else{
            mobile=mobile+','+$.trim(ph1);
            number=number+','+$.trim(numb);
        }

		/*短信模板*/
        content+="尊敬的用户，您好。我们是曾为您服务过的"+sign+"维修部。" +
            "您的"+applBranCate+"产品在上次服务后使用效果是否满意，提醒您定期检查。如果需要服务，" +
            "可以联系我们公司："+jsPhone+"。同时，家用电器用电安全也需要进行关注，" +
            "可以放心点击观看以下用电安全内容（"+toAnUrl+"）。#";

    }
    $("#wrongNumber").val(wrongNumber);//未发送的工单编号
    if(wrongNumber==""){
        var a = document.getElementById("exportLink");
        a.removeAttribute("href");
        a.setAttribute("onclick","tishi()");
    }else{
        $("#exportLink").prop("href", $("#exportLink").prop("href")+"&no="+wrongNumber);
    }

    if($.trim(sign)=="" || sign==null ){
        layer.msg("短信签名不能为空！");
        $("#sign").focus();
        return false;
    }
    if($.trim(sign).length>6 ){
        layer.msg("短信签名过长，最多为6个汉字！");
        $("#sign").focus();
        return false;
    }
    var siteMsgNums = $("#siteMsgNums").val();
    var msgNumbers = mobile.split(",");
    var msgNums = msgNumbers.length;//需要发送短信的工单数
    var message="尊敬的用户，您好。我们是曾为您服务过的"+sign+"维修部。" +
        "您的XXXX产品在上次服务后使用效果是否满意，提醒您定期检查。如果需要服务，" +
        "可以联系我们公司："+jsPhone+"。同时，家用电器用电安全也需要进行关注，" +
        "可以放心点击观看以下用电安全内容（XXXXXX）。";

    $('body').popup({
        level:3,
        title:"短信确认",
        content:message,
        fnConfirm :function(){
            if(noRepeateSend){
                return;
            }
            noRepeateSend=true;
            layer.msg("短信发送中，请耐心等待...",{time:5000000});
            $.ajax({
                type:"POST",
                traditional:true,
                url:"${ctx }/order/msgNumbers",
                data:{content:content,
                    sign:sign},
                success:function(result){
                    if(parseInt(result)*parseInt(msgNums) > parseInt(siteMsgNums)){
                        layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                    }else{
                        $.ajax({
                            type:"POST",
                            traditional:true,
                            url:"${ctx }/order/sendInDispOrTurnDisp",
                            data:{content:content,
                                sign:sign,
                                mobile:mobile,
                                number:number
                            },
                            success:function(result){
                                if(result=="noMessage"){
                                    layer.msg("剩余可发送短信条数不足，请先购买后在发送！");
                                }else{
                                    var n = 0;
                                    for(var j=0;j<msgNumbers.length;j++){
                                        if(msgNumbers[j].length==11 && msgNumbers[j].substring(0,1)=="1" ){
                                            n++;
                                        }
                                    }
                                    $("#sucMsg").text(n);
                                    $("#wroMsg").text(parseInt(msgNumbers.length)-parseInt(n));
                                    layer.msg("发送成功");
                                    $('.massTextNoteQf').popup({level:2});
                                }
                            }
                        })
                    }
                },complete:function(){
                    noRepeateSend=false;
                }
            })
        },
        fnCancel:function (){

        }
    });
}

function guanbi(){
    $.closeDiv($(".massTextNote"));
}

function closePopup(){
    $.closeDiv($(".massTextNote"));
}

// 验证手机号
function isPhoneNo(phone) {
	var tel = /(^1\d{10}$)|(^(\d{3,4}\-)?\d{5,9}$)/;
	return tel.test($.trim(phone));
}

function initDispatchMap() {
	if (!dispatchMap) {
		dispatchMap = new AMap.Map('dispatch_map_container', {
			zoom: 12
		});
		dispatchMarker = new AMap.Marker({
			map: dispatchMap,
			draggable: true
		});
		employeMarker = new AMap.Marker({});
		dispatchMarker.setMap(dispatchMap);
	}
	var lnglat = $("#lnglat").val();
	if (!isBlank(lnglat)) {
		var lnglats = lnglat.split(",");
		var position = new AMap.LngLat(lnglats[0], lnglats[1]);
		dispatchMap.setZoomAndCenter(12, position);
		dispatchMarker.setPosition(position);
	}
	employeMarker.setMap(null);
}

function initAddrmap() {
	map = new AMap.Map('map-container', {
		zoom: 10
	});
}

function dingwei() {
	var slnglat;
	var address = $('#customerAddress1').val();
	var town = "";
	if(!isBlank($("#township").val())){
		town = $("#township").val();
	}
	if (isBlank(address)) {
	} else {
		var addr = $("#province").val() + $("#city").val() + $("#area").val() +town + address;
		$("#customerAddress").val(address);
		geocoder.getLocation(addr, function (status, result) {
			if (status === 'complete' && result.info === 'OK') {
				if (result.resultNum && result.resultNum > 0) {
					var location = result.geocodes[0].location;
					slnglat = location.lng + "," + location.lat;
					$("#lnglat").val(slnglat);
				}
			}
		});
	}
}



function employe() {
	var lnglat = $("#lnglat").val();
	var category = $('#applianceCategory').val();
	$.ajax({
		type : "POST",
		url : "${ctx}/operate/employe/dispatchList",
		data : {
			lnglat :lnglat,
			category:category
		},
		//dataType: 'json',
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
				+'<td>'+item.distance_formatted+'</td>'
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
                 			id= $.trim($(this).children('td').eq(5).children('label').attr('for'));
						}else{
							id= id+","+$(this).children('td').eq(5).children('label').attr('for');
						}
					} 
				});
				$("#nameWrap").append("<span>"+name+"</span>");
				$("#employeId").val(id);
			});
		}
	});
}
//直接派工中点击派工按钮
var confirmpai=false;
function dispa() {
	var empId = $("#employeId").val();
	if (isBlank(empId)) {
		layer.msg("请选择服务工程师");
	} else {

        var town  = "";
        if(!isBlank($("#township").val())){
            town = $("#township").val();
        }
        var customerAddress1 = $("#customerAddress1").val();
        var address =  town +customerAddress1;
        $("input[name='customerAddress']").val(address);

		var name = $.trim($("#nameWrap").children('span').html());
		$('body').popup({
			level: '3',
			//	 type:1,  // 提示操作成功
			type: 2,  // 提示是否进行某种操作
			content: '确认派工至' + name + '吗？',
			fnConfirm: function () {
				confirmpai = false;
				if (confirmpai) {
					return;
				}
				confirmpai = true;
				var pro = $("#province").val();
				var city = $("#city").val();
				var area = $("#area").val();
				var town = "";
				if(!isBlank($("#township").val())){
					town = $("#township").val();
				}
				var customerAddress1 = $("#customerAddress1").val();
				var address = pro + city + area + town + customerAddress1;
				$("input[name='customerAddress']").val(address);
				$("#neworderForm").submit();
			},
			fnCancel: function () {
			}
		});
	}
}


$('#neworderForm').Validform({
	tiptype: function (msg, o, cssctl) {
		if (msg && (o.type == "3")) {
			layer.msg(msg);
		}
	},
	postonce: true,
	tipSweep: true,
	showAllError: false,
	datatype: {
		"dh": /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/,
		"z46": /^[^\%\'\"\?]{1,20}$/,
		"zimu": /^[A-Za-z0-9]{1,18}$/,
        "anum":/^[0-9]{0,4}$/,
		"num": /^[A-Za-z0-9]{1,20}$/,
		/*"tel": /^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][34578][0-9]{9}$)|(^(0[0-9]{2,3}?[2-9][0-9]{6,7})?$)$/*/
        "tel": /(^1\d{10}$)|(^(\d{3,4}\-)?\d{5,9}$)/,

	},
    beforeCheck:function(curform){
        var  applianceNum='${mustfill.columns.applianceNum}';
        var applianceNumV=$("#applianceNum").val();
        if(applianceNum!='true'){
            if(!isBlank(applianceNumV)){
                var te=/^[0-9]{0,4}$/;
                if(!te.test(applianceNumV)){
                    layer.msg("产品数量格式不正确");
                    return false;
                }
            }
        }
        var distributionNumber = $("#distributionNumber").val();    
        var plateNumber = $("#plateNumber").val(); 
         if(isBlank(distributionNumber)){
         	if(!isBlank(plateNumber)){
         		layer.msg("请输入配送单号！");
         		return false;
         	}
         }else if(isBlank(plateNumber)){
         	layer.msg("请选择车牌信息！");
         	return false;
         }
    },
    beforeSubmit:function(curform){
		var addressspace="";
		if($("#province").val()!=null){
			addressspace+=$("#province").val();
		}else{
			layer.msg("省市区为必填项");
			return false;
		}
		if($("#city").val()!=null){
			addressspace+=$("#city").val();
		}else{
			layer.msg("省市区为必填项");
			return false;
		}
		if($("#area").val()!=null){
			addressspace+=$("#area").val();
		}else{
			layer.msg("省市区为必填项");
			return false;
		}
		var town = "";
		if(!isBlank($("#township").val())){
			addressspace+=$("#township").val();
			town = $("#township").val();
		}
		addressspace+=$("#customerAddress1").val();
		$("#customerAddress").val(addressspace);
		if($("#province").val()==$("#city").val()){
			$("#customerAddress").val($("#province").val()+$("#area").val()+ town +$("#customerAddress1").val());
		}

        var promiseTime = '${mustfill.columns.promiseTime}';
        var applianceBuyTime = '${mustfill.columns.applianceBuyTime}';
        var jurisdiction=false+","+promiseTime+","+false+","+false+","+false+","+false+","+false+","+false+","+false+","+applianceBuyTime+","+false+","+false+","+false+","+false;
        var promiseTimev= $("#promiseTime").val();
        var applianceBuyTimev= $("#applianceBuyTime").val();

        //var jurisdictionvalue=null+"(**..)"+promiseTimev+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+applianceBuyTimev+"(**..)"+null+"(**..)"+null+"(**..)"+null;

        var array=new Array();
        array[0]=null;
        array[1]=promiseTimev;
        array[2]=null;
        array[3]=null;
        array[4]=null;
        array[5]=null;
        array[6]=null;
        array[7]=null;
        array[8]=null;
        array[9]=applianceBuyTimev;
        array[10]=null;
        array[11]=null;
        array[12]=null;
        array[13]=null;


        var result= checkMustFill(jurisdiction,array);
        if(result){
            var repairTime=$("#repairTime").val();
            if(isBlank(repairTime)){
                layer.msg("请选择报修时间！");
                return false;
            }
            return true;
        }else{
            return false;
        }
	},
	callback: function (form) {
		var town  = "";
		if(!isBlank($("#township").val())){
			town = $("#township").val();
		}
		var customerAddress1 = $("#customerAddress1").val();
		var address =  town +customerAddress1;
		$("input[name='customerAddress']").val(address);

		$.ajax({
			url: "${ctx}/order/save",
			type: "POST",
			data: form.serialize(),
			success: function (data) {
				if(data=='420'){
					layer.msg("工单编号已被使用！");
					return;
				}
				layer.msg('保存成功');
				parent.search();
				parent.numerCheck();
				$.closeAllDiv();
			}
		});
		return false;
	}
});
function isBlank(val) {
	if (val == null || val == '' || val == undefined) {
		return true;
	}
	return false;
}

var markOrder = false;
function printView() {
	if(markOrder){
		return;
	}
	var number=$.trim($("#number").val());
	var serviceType =$("#serviceType").val();
	var serviceMode = $("#serviceMode").val();
	var name =$("#customerName").val();
	var customerMobile =$("#customerMobile").val();
	var add =$("#customerAddress1").val();

	var selectcategory =$("#applianceCategory").val();
	var selectbrand =$("#applianceBrand").val();
	var customerFeedback =$("#customerFeedback").val();
	var codeSet = '${orderNumSet}';
	var distributionNumber = $("#distributionNumber").val();    
    var plateNumber = $("#plateNumber").val(); 
	if(codeSet!='200'){
		if(isBlank(number)){
			layer.msg("请输入工单编号");
			$("#number").focus();
		}else if(!num.test(number)){
			layer.msg("请输入正确的工单编号");
			$("#number").focus();
		}
	}
	if(isBlank(serviceType)){
		layer.msg("请选择服务类型");
	}else if(isBlank(serviceMode)){
		layer.msg("请选择服务方式");
	}else if(isBlank(name)){
		layer.msg("请输入用户姓名");
		$("#customerName").focus();
	}else if(isBlank(customerMobile)){
			layer.msg("请输入联系方式");
			$("#customerMobile").focus();
	}else if(isPhoneNo(customerMobile) == false){
		layer.msg("手机号码格式不正确");
		$("#customerMobile").focus();
	}else if(isBlank(add)){
		layer.msg("请输入详细地址");
		$("#customerAddress1").focus();
	}else if(isBlank(selectcategory)){
		layer.msg("请选择家电品类！");
	}else if(isBlank(selectbrand)){
		layer.msg("请选择家电品牌！");
	}else{
		 if(isBlank(distributionNumber)){
	     	if(!isBlank(plateNumber)){
	     		layer.msg("请输入配送单号！");
	     		return
	     	}
	     }else if(isBlank(plateNumber)){
	     	layer.msg("请选择车牌信息！");
	     	return
	     }
        var town  = "";
        if(!isBlank($("#township").val())){
            town = $("#township").val();
        }
        var customerAddress1 = $("#customerAddress1").val();
        var address =  town +customerAddress1;
        $("input[name='customerAddress']").val(address);

        var result=checkMustFill(getJurisdiction(),getJurisdisctionValue());
        if(!result){
            return;
        } else {
            var repairTime=$("#repairTime").val();
            if(isBlank(repairTime)){
                layer.msg("请选择报修时间！");
                return;
            }

            markOrder = true;
            $.ajax({
                url: "${ctx}/order/save",
                type: "POST",
                data: $("#neworderForm").serialize(),
                success: function (data) {
                    markOrder = false;
                    if (data == '420') {
                        layer.msg("工单编号已被使用！");
                        return;
                    }
                    $("#printForm").find("input").each(function () {
                        var attrName = $(this).attr("name");
                        $("#pt-" + attrName).val($("#neworderForm input[name='" + attrName + "']").val());
                    });
                    $("#pt-applianceCategory").val($("#applianceCategory").select2('val'));//$("#select2").select2("val")
                    $("#pt-applianceBrand").val($("#applianceBrand").select2('val'));
                    $("#pt-serviceMode").val($("#serviceMode").val());
                    $("#pt-serviceType").val($("#serviceType").val());
                    $("#pt-origin").val($("#origin").val());
                    $("#pt-level").val($("#level").val());
                    $("#pt-promiseLimit").val($("#promiseLimit").val());
                    $("#pt-customerFeedback").val($("#customerFeedback").val());
                    $("#pt-remarks").val($("#remarks").val());
                    $("#pt-warrantyType").val($("#warrantyType").val());

                    $("#printForm").submit();
                    parent.search();
                    setTimeout(function () {
                        $.closeAllDiv();
                    }, 500)
                }
            })
        }
	}
}

/*获取必填项设置参数*/
function getJurisdiction(){
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
    var originv= $("#origin").val();
    var promiseTimev= $("#promiseTime").val();
    var promiseLimitv= $("#promiseLimit").val();
    var customerFeedbackv= $("#customerFeedback").val();
    var remarksv= $("#remarks").val();
    var applianceModelv= $("#applianceModel").val();
    var applianceNumv= $("#applianceNum").val();
    var applianceBarcodev= $("#applianceBarcode").val();
    var applianceMachineCodev= $("#applianceMachineCode").val();
    var applianceBuyTimev= $("#applianceBuyTime").val();
    var pleaseReferMallv= $("#pleaseReferMall").val();
    var warrantyTypev= $("#warrantyType").val();
    var levelv= $("#level").val();
    var customerType= $("#customerType").val();
    //var jurisdictionvalue=originv+"(**..)"+promiseTimev+"(**..)"+promiseLimitv+"(**..)"+customerFeedbackv+"(**..)"+remarksv+"(**..)"+applianceModelv+"(**..)"+applianceNumv+"(**..)"+applianceBarcodev+"(**..)"+applianceMachineCodev+"(**..)"+applianceBuyTimev+"(**..)"+pleaseReferMallv+"(**..)"+warrantyTypev+"(**..)"+levelv;
    var array=new Array();
    array[0]=originv;
    array[1]=promiseTimev;
    array[2]=promiseLimitv;
    array[3]=customerFeedbackv;
    array[4]=remarksv;
    array[5]=applianceModelv;
    array[6]=applianceNumv;
    array[7]=applianceBarcodev;
    array[8]=applianceMachineCodev;
    array[9]=applianceBuyTimev;
    array[10]=pleaseReferMallv;
    array[11]=warrantyTypev;
    array[12]=levelv;
    array[13]=customerType;
	return array;
}


//点击显示“地址定位”弹出框
var a = true;
function curmaskAddr(){
	var openBtn = $('#btn-showaddr');
	var obj = $('.plocation');
	var province ="";
	var city="";
	var area ="";
	var address="";
	var address1="";
	if(!isBlank($("#city").val())){
		city= $("#city").val();
	}
	if(!isBlank($("#province").val())){
		province= $("#province").val();
	}
	if(!isBlank($("#area").val())){
		area= $("#area").val();
	}
	if(!isBlank($("#customerAddress1").val())){
		address1= $("#customerAddress1").val();
	}
	var address = province+city+area+address1;
	if(province==city){
		address = province+area+address1;
	}
	$("#dingweidizhi").val(address);
	//address ="山东济南历下区朱家峪景区";
    geocoder.getLocation(address, function(status, result) {
        if (status === 'complete' && result.info === 'OK') {
            initAddrmap1(result.geocodes[0].location.lng,result.geocodes[0].location.lat);
			if(a) {
			 map.plugin(["AMap.ToolBar"],function(){
			        var tool = new AMap.ToolBar();
			        tool.setOffset(new AMap.Pixel(10,52));
			        map.addControl(tool);  
			    });
			 a = false;
			}
			$('.plocation').popup({level:4,closeSelfOnly:true});
        }else{
        	initAddrmap2();
			if(a) {
			 map.plugin(["AMap.ToolBar"],function(){
			        var tool = new AMap.ToolBar();
			        tool.setOffset(new AMap.Pixel(10,52));
			        map.addControl(tool);  
			    });
			 a = false;
			}
			$('.plocation').popup({level:4,closeSelfOnly:true});
        }
    });
} 

function initAddrmap2(lat,lng){
	var addrMap = $('#addrMap');
	var hAddr = addrMap.height();
	var hWin = $(window).height()/2 ;
	addrMap.height( hWin < 394 ? 394:hWin );
	
	map = new AMap.Map('map-container1', {
        zoom: 10
    });
	 mark = new AMap.Marker({ 
    	 map:map,
    	 draggable:true
	 })
    mark.setMap(map);
     mark.on('dragend',function(e){
	    geocoder.getAddress(mark.getPosition(),function(status,result){
	      if(status=='complete'){
	    	  $('#dingweidizhi').val(result.regeocode.formattedAddress);
	          $("#lnglat").val(mark.getPosition());
	          $("#latitude ").val(mark.getPosition().lat);
	          $("#longitude").val(mark.getPosition().lng);
	      }else{
	    	  layer.msg('无法获取地址');
	      }
	    })
	})
}

function initAddrmap1(lat,lng){
	var addrMap = $('#addrMap');
	var hAddr = addrMap.height();
	var hWin = $(window).height()/2 ;
	addrMap.height( hWin < 394 ? 394:hWin );
	var lg11=[lat,lng];
	if($.trim(lg11)=="" || lg11==null || lg11==undefined ){
		map = new AMap.Map('map-container1', {
	        zoom: 10
	    });
		 mark = new AMap.Marker({ 
	    	 map:map,
	    	 draggable:true
	    });
	}else{
		map = new AMap.Map('map-container1', {
	        zoom: 10,
	        center:lg11
	    });
		mark = new AMap.Marker({ 
	    	 map:map,
	    	 position:lg11,
	    	 draggable:true
	    });
	}
    mark.setMap(map);
     mark.on('dragend',function(e){
	    geocoder.getAddress(mark.getPosition(),function(status,result){
	      if(status=='complete'){
	    	  $('#dingweidizhi').val(result.regeocode.formattedAddress);
	          $("#lnglat").val(mark.getPosition());
	          $("#latitude ").val(mark.getPosition().lat);
	          $("#longitude").val(mark.getPosition().lng);
	      }else{
	    	  layer.msg('无法获取地址');
	      }
	    })
	})
}

function dingwei1(){//定位
	var slnglat;
	 var address = $('#dingweidizhi').val();
	 if($('#dingweidizhi').val() == ""){
			layer.msg("请输入地址定位");
		}else{
			mark.setMap(null);
         geocoder.getLocation(address, function (status, result) {
        	 if(marker!=null){
        	       	marker.setMap(null);
        	       	marker = null;
        	       	}
            if (status === 'complete' && result.info === 'OK') {
                if (result.resultNum && result.resultNum > 0) {
                    var location = result.geocodes[0].location;
                    slnglat = location.lng+","+location.lat
                    $("#lnglat").val(slnglat); 
                    map.panTo(new AMap.LngLat(location.lng, location.lat));
                    map.setZoom(13);
                    $("#latitude ").val(location.lat);
         	        $("#longitude").val(location.lng);
                    if (marker == null) {
                        marker = new AMap.Marker({
                            position: [location.lng, location.lat],
                            map: map,
                            draggable:true
                        });
                        marker.setMap(map);
                        marker.on('dragend',function(e){
                    	    geocoder.getAddress(marker.getPosition(),function(status,result){
                    	      if(status=='complete'){
                    	    	  $('#dingweidizhi').val(result.regeocode.formattedAddress);
                    	    	  $("#latitude ").val(marker.getPosition()[0]);
                    	          $("#longitude").val(marker.getPosition()[1]);
                    	          $("#lnglat").val(marker.getPosition()); 
                    	      }else{
                    	    	  layer.msg('无法获取地址');
                    	      }
                    	    })
                    	});
                    } else {
                        marker.setPosition(location.lng, location.lat);
                    }
                }
                var province=result.geocodes[0].addressComponent.province;
                var city=result.geocodes[0].addressComponent.city;
                var area=result.geocodes[0].addressComponent.district;
                addressChange(province,city,area);
            } else {
            }
        }); 
	}
}

function gather(){
    var dizhi=$('#dingweidizhi').val();
	if(isBlank(dizhi)){
		layer.msg("请输入地址定位");
	}else if(isBlank($("#lnglat").val())) {		
			layer.msg('请定位'); 
	}else{
	   $("#signPoint").val($('#dingweidizhi').val());
        var proCityArea=$("#province").val()+$("#city").val()+$("#area").val();
        if($("#province").val()==$("#city").val()){
            proCityArea=$("#city").val()+$("#area").val();
        }
        var address=dizhi.split(proCityArea);
        $("#customerAddress1").val(address[1])
        $("#customerAddress").val(address[1]);


        $.closeDiv($('.plocation'),true);
	  $('#dingweidizhi').val("");
	  $("#customerAddress").val($("#province").val()+$("#city").val()+$("#area").val()+$("#customerAddress1").val());
	 
    }
    var customProvince = $("#province").val();
    var customCity = $("#city").val();
    var customArea = $("#area").val();
    var customAdress = $("#customerAddress1").val();
    $.ajax({
        type: "post",
        url: "${ctx}/order/getDistance",
        data: {
            customProvince: customProvince,
            customCity: customCity,
            customArea: customArea,
            customAdress: customAdress
        },
        success: function (data) {
            if (data != null && data != "") {
                if (data == "未知") {
                    $("#distancealert").hide();
                } else {
                    $("#distancealert").html("距离用户约"+data+"公里");
                    $("#distancealert").css("display","inline-block");
                }
            } else {
                $("#distancealert").hide();
            }
        },
        error: function () {
            $("#distancealert").hide();
            return;
        },
    });

}

$("#customerAddress1").blur(function () {
    var customProvince = $("#province").val();
    var customCity = $("#city").val();
    var customArea = $("#area").val();
    var customAdress = $("#customerAddress1").val();
    $.ajax({
        type: "post",
        url: "${ctx}/order/getDistance",
        data: {
            customProvince: customProvince,
            customCity: customCity,
            customArea: customArea,
            customAdress: customAdress
        },
        success: function (data) {
            if (data != null && data != "") {
                if (data == "未知") {
                    $("#distancealert").hide();
                } else {
                    $("#distancealert").html("距离用户约"+data+"公里");
                    $("#distancealert").css("display","inline-block");
                }
            } else {
                $("#distancealert").hide();
            }
        },
        error: function () {
            $("#distancealert").hide();
            return;
        },
    });
})

function codeNumberCounts(){
	codeCounts();//条码字数统计
	//getCodeShowPopups();
	
	$('#applianceBarcode').bind('blur', function() {  
		codeCounts();//条码字数统计
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
	$('#applianceMachineCode').bind('blur', function() {  
		codeCounts();//条码字数统计
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
	$('#applianceMachineCode').bind('input propertychange', function() {  
		codeCounts1();//条码字数统计
	})
	$('#applianceBarcode').bind('input propertychange', function() {  
		codeCounts1();//条码字数统计
	})
	$(".codeConnectShow").bind('click', function () {
        var code = $(this).parent(".txtwrap2").find("input").val();
        layer.open({
            type : 2,
            content:'${ctx}/order/showHistoryPopup?code=' + code+'&id=',
            title:false,
            area: ['100%','100%'],
            closeBtn:0,
            shade:0,
            anim:-1
        });  
    }); 
}

function codeCounts1(type){
	var applianceBarcode = $.trim($("#applianceBarcode").val());
	var applianceMachineCode = $.trim($("#applianceMachineCode").val());
	$("#incodeNum").text(applianceBarcode.length);
	$("#outcodeNum").text(applianceMachineCode.length);
	if(!isBlank(applianceBarcode)){
		$(".weishu1").show();
		$(".code1").show();
		changeMark=false;
	}else{
		$(".weishu1").hide();
		$(".code1").hide();
	}
	if(!isBlank(applianceMachineCode)){
		$(".weishu2").show();
		$(".code2").show();
		changeMark=false;
	}else{
		$(".weishu2").hide();
		$(".code2").hide();
	}
}

function codeCounts(type){
	var applianceBarcode = $.trim($("#applianceBarcode").val());
	var applianceMachineCode = $.trim($("#applianceMachineCode").val());
	$("#incodeNum").text(applianceBarcode.length);
	$("#outcodeNum").text(applianceMachineCode.length);
	if(!isBlank(applianceBarcode)){
		$(".weishu1").show();
		$(".code1").show();
		$("#codeInshow").show();
		$(".codeIn").show();
		changeMark=false;
		loadAlreadyCode(1,applianceBarcode);
	}else{
		$(".weishu1").hide();
		$(".code1").hide();
		$("#codeInshow").hide();
		$(".codeIn").hide();
	}
	if(!isBlank(applianceMachineCode)){
		$(".weishu2").show();
		$(".code2").show();
		$("#codeOutshow").show();
		$(".codeOut").show();
		changeMark=false;
		loadAlreadyCode(2,applianceMachineCode);
	}else{
		$(".weishu2").hide();
		$(".code2").hide();
		$("#codeOutshow").hide();
		$(".codeOut").hide();
	}
}



$(function() {
	codeNumberCounts();
});

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
	if(type==1){
		code = $("#applianceBarcode").val();
	 }else{
		 code = $("#applianceMachineCode").val();
	 }
	$.ajax({
		url: "${ctx}/order/getHistoryOrdersCodeOutCountByTel?code=" + $.trim(code),
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
</script>
<form id="printForm" action="${ctx}/print/order" style="display: none;" target="_blank" method="post">
	<input type="hidden" name="number" id="pt-number">
	<input type="hidden" name="serviceType" id="pt-serviceType">
	<input type="hidden" name="serviceMode" id="pt-serviceMode">
	<input type="hidden" name="origin" id="pt-origin">
	<input type="hidden" name="customerName" id="pt-customerName">
	<input type="hidden" name="customerMobile" id="pt-customerMobile">
	<input type="hidden" name="customerTelephone" id="pt-customerTelephone">
	<input type="hidden" name="customerTelephone2" id="pt-customerTelephone2">
	<input type="hidden" name="customerAddress" id="pt-customerAddress">
	<input type="hidden" name="applianceBrand" id="pt-applianceBrand">
	<input type="hidden" name="applianceCategory" id="pt-applianceCategory">
	<input type="hidden" name="promiseTime" id="pt-promiseTime">
	<input type="hidden" name="promiseLimit" id="pt-promiseLimit">
	<input type="hidden" name="customerFeedback" id="pt-customerFeedback">
	<input type="hidden" name="remarks" id="pt-remarks">
	<input type="hidden" name="applianceModel" id="pt-applianceModel">
	<input type="hidden" name="applianceBarcode" id="pt-applianceBarcode">
	<input type="hidden" name="applianceMachineCode" id="pt-applianceMachineCode">
	<input type="hidden" name="applianceBuyTime" id="pt-applianceBuyTime">
	<input type="hidden" name="warrantyType" id="pt-warrantyType">
	<input type="hidden" name="level" id="pt-level">
	<input type="hidden" name="repairTime" id="pt-repairTime">
	<input type="hidden" name="messengerName" id="pt-messengerName">
	
	
	<input type="hidden" name="siteName" id="pt-siteName">
</form>
</body>
</html>
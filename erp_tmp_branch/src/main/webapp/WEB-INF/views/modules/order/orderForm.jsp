<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/tips_style.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/formatStatus.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/dateUtils.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/easyui.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/jquery.easyui.min.js"></script>
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
/* 	@media screen and (max-width: 1366px) {
    .popupContainer1{
    	height: 430px;

overflow-y: auto;
    }
} */
</style>
</head>

<body>

<!-- 新建工单 -->
<div class="popupBox odWrap  addNewOrder">
	<h2 class="popupHead">
		新建工单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer popupContainer1">
		<div class="popupMain pos-r mr" >
		<form id="neworderForm" action="" method="post" >
				<input id="dyOrSave" value="" hidden="hidden" />
				<h3 class="modelHead">工单信息</h3>
				<div class="mt-10 cl h-40">	
					<c:if test="${orderNumSet != '200' }">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><em class="mark">*</em>工单编号：</label>
							<input type="text" class="input-text w-160 mustfill " maxlength="20"  id="number" name="number" value="${order.number }" datatype="num" nullmsg = "请输入工单编号！" errormsg="格式错误！" ajaxurl="${ctx}/main/redirect/checkOrderNo"/>
							<p class="errorwran"></i>请输入有效的工单编号</p>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><em class="mark">*</em>服务类型：</label>
							
								<select class="select w-110 mustfill" name="serviceType" id="serviceType" datatype="*" errormsg="请选择服务类型" nullmsg="请选择服务类型">
									<option value="">请选择</option>
									<c:forEach items="${fns:getNewServiceType() }" var="stype">
										<option value="${stype.columns.name }"  ${stype.columns.is_default eq '1' ? 'selected=\'selected\'' : ''}>${stype.columns.name }</option>
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
												<option value="${stype.columns.name }"  ${stype.columns.is_default eq '1' ? 'selected=\'selected\'' : ''}>${stype.columns.name }</option>
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
									<option value="${stype.columns.name }" ${stype.columns.is_default eq '1' ? 'selected=\'selected\'' : ''}>${stype.columns.name }</option>
								</c:forEach>
							</select>
						<p class="errorwran">请选择服务方式</p>
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2"><c:if test="${mustfill.columns.origin}"><em class="mark">*</em></c:if>信息来源：</label>
							<select class="select w-100 ${mustfill.columns.origin?'mustfill':''}" <c:if test="${mustfill.columns.origin}">datatype="*" nullmsg="请选择信息来源"</c:if> size="1" name="origin" id="origin">
							<option value="">请选择</option>
								<c:forEach items="${listorigin }" var="otype">
								<option value="${otype.columns.name }">${otype.columns.name }</option>
								</c:forEach>
						</select>
					</div>
				</div>
				
				<div class="cl mb-10 mt-10">
					<div class="f-l pos-r pl-100">
						<label class="lb w-100">厂家工单编号：</label>
						<input type="text" id="factoryNumber" class="input-text w-160 " maxlength="32" name="factoryNumber" />
					</div>
				</div>
				<h3 class="modelHead">用户信息</h3>
				<div class="pt-10 mb-15">
					<div class="cl">
						<div class="f-l pos-r txtwrap1 mb-10">
							<label class="lb lb1"><em class="mark">*</em>用户姓名：</label>
							<input type="text" class="input-text w-140 mustfill" name="customerName" id="customerName" datatype="*" errormsg="格式错误" nullmsg="请输入用户姓名！"/>
							<p class="errorwran">请输入用户姓名</p>
							<c:if test="${cusTypecount > 0 }">
							<span class="select-box w-100 ">
		                    <select class="select ${mustfill.columns.customerType?'mustfill':''}" <c:if test="${mustfill.columns.customerType}">datatype="*" nullmsg="请选择用户类型"</c:if> id="customerType" name="customerType" >
			                    <option value="">选择类型</option>
			                    <c:forEach items="${fns:getCustomerType()}" var="to">
			                    <option value="${to.columns.name }">${to.columns.name }</option>
			                    </c:forEach>
		                    </select>
							</span>
							</c:if>
						</div>
						<div class="f-l pos-r txtwrap2">
							<span class="lb lb2" style="width:94px;">
								<span class="f-r pr-5 mr-2">:&nbsp;</span>
								<select class="lb-sel f-r" id="mobileOrtel">
									<option value="1">手机号码</option>
									<option value="2">固定电话</option>
								</select>
								<em class="mark">*</em>
							</span>
							<input type="text" class="input-text w-110 mustfill" name="customerMobile" id="customerMobile" datatype="tel" errormsg="手机号码格式不正确" nullmsg="请输入手机号码" maxlength="20"/>
							<div class="ttipWrap hide">
								<div class="ttipbox radius">
									<i class="sficon sficon-note"></i>
									有<span class="va-t">3</span>条历史工单
								</div>
								<span class="bgArrow"></span>
							</div>
							<p class="errorwran">请输入联系电话</p>
							</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">其他联系方式：</label>
							<input type="text" class="input-text w-110" name="customerTelephone" ignore="ignore" id="customerTelephone" datatype="mtel" errormsg="格式错误" maxlength="20"/>
							<div class="ttipWrap hide">
								<div class="ttipbox radius">
									<i class="sficon sficon-note"></i>
									有<span class="va-t">3</span>条历史工单
								</div>
								<span class="bgArrow"></span>
							</div>
							<p class="errorwran"></p>
						</div>
						<div class="f-l pos-r" style="padding-left: 15px;">
							<!-- <label class="lb lb2">联系方式3：</label> -->
							<input type="text" class="input-text w-110" name="customerTelephone2" ignore="ignore" id="customerTelephone2" datatype="mtel" errormsg="格式错误" maxlength="20"/>
							<div class="ttipWrap hide">
								<div class="ttipbox radius">
									<i class="sficon sficon-note"></i>
									有<span class="va-t">3</span>条历史工单
								</div>
								<span class="bgArrow"></span>
							</div>
							<p class="errorwran"></p>
						</div>
					</div>
					<div class="pos-r txtwrap1" id="pcd">
						<label class="lb lb1"><em class="mark">*</em>详细地址：</label>
						<span class="select-box w-90 ">
						<select class="prov select" id="province" name="province">
							<c:forEach items="${provincelist }" var="pro">
								<option value="${pro.columns.ProvinceName }" <c:if test="${pro.columns.ProvinceName==site.province }">selected="selected"</c:if>>${pro.columns.ProvinceName }</option>
							</c:forEach>
						</select>
						</span>
						<span class="select-box w-90 ">
	                    <select class="city select" id="city"  name="city">
							<c:forEach items="${cities }" var="cs">
								<option value="${cs.columns.CityName }" <c:if test="${cs.columns.CityName==site.city }">selected="selected"</c:if>>${cs.columns.CityName }</option>
							</c:forEach>
						</select>
						</span>
						<span class="select-box w-90 ">
	                    <select class="dist select" id="area" name="area">
							<c:forEach items="${districts }" var="ds">
								<option value="${ds.columns.DistrictName }" <c:if test="${ds.columns.DistrictName==site.area }">selected="selected"</c:if>>${ds.columns.DistrictName }</option>
							</c:forEach>
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
						<input type="text" class="input-text w-260 mustfill" id="customerAddress1" placeholder="详细地址" datatype="*" errormsg="格式错误" nullmsg="请输入详细地址"/>
						<a class="btn-dw" onclick="curmaskAddr()" id="btn-showaddr"></a>
						<span class="ml-5 c-fe0101 hide" id="distancealert">距离xxx公里</span>
						<%-- display: inline-block --%>
						<input type="hidden" class="input-text w-260 mustfill" name="customerAddress" id="customerAddress" placeholder="详细地址" datatype="*" errormsg="格式错误" nullmsg="请输入详细地址"/>
						<p class="errorwran">请输入详细地址</p>
						<input type="hidden"  name="customerLnglat" readonly="true" id="lnglat" />
					</div>
				</div>
				<h3 class="modelHead">服务信息</h3>
				<div class="pt-10">
					<div class="cl mb-10" id="styleMArk">
						<div class="f-l pos-r txtwrap1" style="width:214px;height:26px" >
							<label class="lb lb1"><em class="mark">*</em>家电品牌：</label>
								<select class="select w-140 " style="position: absolute;z-index: 1;"  class="choose" onmousedown="if(this.options.length>6){this.size=8}" onblur="this.size=0" onchange="this.size=0"  name="applianceBrand" id="applianceBrand" datatype="*" nullmsg="请选择家电品牌！" >
									<option value="">请选择</option>				
									<c:forEach items="${brand }" var="ba" varStatus="sta">
									 <option value="${ba.key }">${ba.value }</option>
								</c:forEach>
								</select>
							<p class="errorwran">请选择家电品牌</p>
						</div>
						<div class="f-l pos-r txtwrap2 " >
							<label class="lb lb2"><em class="mark">*</em>家电品类：</label>
								<select class="select w-110  "  style="position: absolute;z-index: 1;" class="choose" onmousedown="if(this.options.length>6){this.size=8}" onblur="this.size=0" onchange="this.size=0"  name="applianceCategory" id="applianceCategory" datatype="*" nullmsg="请选择家电品类！">
										<option value="">请选择</option>				
								<c:forEach items="${category }" var="ca" varStatus="cast">
									 <option value="${ca.columns.name }">${ca.columns.name }</option>
								</c:forEach>
								</select>
							<p class="errorwran">请选择家电品类</p>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.promiseTime}"><em class="mark">*</em></c:if>预约日期：</label>
							<input type="text" onfocus="WdatePicker({minDate: '%y-%M-%d' })" id="promiseTime" name="promiseTime" class="input-text Wdate w-110 ${mustfill.columns.promiseTime?'mustfill':''}" autocomplete="off">
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.promiseLimit}"><em class="mark">*</em></c:if>时间要求：</label>
								<select class="select w-110 ${mustfill.columns.promiseLimit?'mustfill':''}" <c:if test="${mustfill.columns.promiseLimit}">datatype="*" nullmsg="请选择时间要求"</c:if> name="promiseLimit" id="promiseLimit">
									<option value="">请选择</option>
								</select>
						</div>
					</div>
					<div class="cl mb-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><c:if test="${mustfill.columns.customerFeedback}"><em class="mark">*</em></c:if>服务描述：</label>
							<textarea class="input-text w-340 h-50 ${mustfill.columns.customerFeedback?'mustfill':''} " <c:if test="${mustfill.columns.customerFeedback}">datatype="*" nullmsg="请输入服务描述"</c:if> name="customerFeedback" id="customerFeedback" ></textarea>
						<p class="errorwran"></p>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.remarks}"><em class="mark">*</em></c:if>备注：</label>
							<textarea class="input-text h-50 w-310 ${mustfill.columns.remarks?'mustfill':''}" <c:if test="${mustfill.columns.remarks}">datatype="*" nullmsg="请输入备注"</c:if> id="remarks" name="remarks"></textarea>
						</div>
					</div>
					
					<div class="cl mb-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><c:if test="${mustfill.columns.applianceModel}"><em class="mark">*</em></c:if>产品型号：</label>
							<input type="text" class="input-text w-140 ${mustfill.columns.applianceModel?'mustfill':''}" id="applianceModel" name="applianceModel" <c:if test="${mustfill.columns.applianceModel}">datatype="*" nullmsg="请输入产品型号"</c:if>/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.applianceNum}"><em class="mark">*</em></c:if>产品数量：</label>
							<input type="text" value="1" class="input-text w-110 ${mustfill.columns.applianceNum?'mustfill':''}" name="applianceNum" id="applianceNum" <c:if test="${mustfill.columns.applianceNum}">datatype="anum" errormsg="产品数量格式不正确" nullmsg="请输入产品数量"</c:if>/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.applianceBarcode}"><em class="mark">*</em></c:if>内机条码：</label>
							<input type="text" class="input-text  ${mustfill.columns.applianceBarcode?'mustfill':''}" style="width:180px;" name="applianceBarcode" id="applianceBarcode" <c:if test="${mustfill.columns.applianceBarcode}">datatype="*" nullmsg="请输入内机条码"</c:if>/>
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
							<input type="text" onfocus="WdatePicker({maxDate: '%y-%M-%d' })"  id="applianceBuyTime" name="applianceBuyTime" class="input-text Wdate w-140 ${mustfill.columns.applianceBuyTime?'mustfill':''}" readonly>
						</div>
						<div class="f-l pos-r txtwrap2">
							<c:choose>
								<c:when test="${not empty malllist}">
									<label class="lb lb2"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
									<span class="w-110">
									<select class="select ${mustfill.columns.pleaseReferMall?'mustfill':''}"  id="pleaseReferMall"  multiline="false" name="pleaseReferMall" style="width:100%;height:25px" panelMaxHeight="300px" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请选择购机商场"</c:if>>
										<option value="">请选择</option>
										<c:forEach items="${malllist }" var="mall">
											<option value="${mall.columns.mall_name } ">${mall.columns.mall_name }</option>
										</c:forEach>
									</select>
								</span>
								</c:when>
								<c:otherwise>
									<label class="lb lb2"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
									<input type="text" value="${order.pleaseReferMall}" name="pleaseReferMall" class="input-text w-110 ${mustfill.columns.pleaseReferMall?'mustfill':''} readonly" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请输入购机商场"</c:if>>
								</c:otherwise>
							</c:choose>

							<%--<c:choose>
								<c:when test="${not empty malllist}">
									<label class="lb lb2"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
									<span class="w-110">
									<select class="select easyui-combobox ${mustfill.columns.pleaseReferMall?'mustfill':''}"  id="pleaseReferMall"  multiline="false" name="pleaseReferMall" style="width:100%;height:25px" panelMaxHeight="300px" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请选择购机商场"</c:if>>
										<option value="">请选择</option>
										<c:forEach items="${malllist }" var="mall">
											<option value="${mall.columns.mall_name }">${mall.columns.mall_name }</option>
										</c:forEach>
									</select>
								</span>
								</c:when>
								<c:otherwise>
									<label class="lb lb2"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
									<input type="text" name="pleaseReferMall" class="input-text w-110 ${mustfill.columns.pleaseReferMall?'mustfill':''}" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请输入购机商场"</c:if>>
								</c:otherwise>
							</c:choose>--%>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.applianceMachineCode}"><em class="mark">*</em></c:if>外机条码：</label>
							<input type="text" style="width:180px;" class="input-text  ${mustfill.columns.applianceMachineCode?'mustfill':''}" name="applianceMachineCode" id="applianceMachineCode" <c:if test="${mustfill.columns.applianceMachineCode}">datatype="*" nullmsg="请输入外机条码"</c:if>/>
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
								<select class="select w-140 ${mustfill.columns.warrantyType?'mustfill':''}" id="warrantyType" name="warrantyType" <c:if test="${mustfill.columns.warrantyType}">datatype="*" nullmsg="请选择保修类型"</c:if>>
									<option value="">请选择</option>
									<option value="1">保内</option>
									<option value="2">保外</option>
								</select>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.level}"><em class="mark">*</em></c:if>重要程度：</label>
								<select class="select  w-110 ${mustfill.columns.level?'mustfill':''}" id="level" name="level" <c:if test="${mustfill.columns.level}">datatype="*" nullmsg="请选择重要程度"</c:if>>
									<option value="">请选择</option>
									<option value="1">紧急</option>
									<option value="2" selected="selected">一般</option>
								</select>
						</div>
						<div class="f-l pos-r txtwrap2 ">
							<label class="lb lb2"><em class="mark">*</em>报修时间：</label>
							<input type="text"  class="input-text  w-130 mustfill" id="repairTime"  nullmsg="请选择报修时间！" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="repairTime" value ="<fmt:formatDate value="${order.repairTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" >
						</div>
						<div class="f-l pos-r pl-80">
							<label class="pos w-80">登记人：</label>
							<input type="text" class="input-text w-100 readonly" name="messengerName" value="${fns:getUserXm() }" readonly="readonly" />
						</div>
					</div>
					<div class="pos-r mt-10 txtwrap1 cl allDuringImgs" id="">
							<label class="lb lb1">报修图片：</label>
							<div id="Imgprocess1">
							 	<c:if test="${not empty duringFeedImgs }">
									<c:forEach items="${duringFeedImgsArr }" var="str" varStatus="da">
										<div class="f-l imgWrap1" id="img${da.index}">
											<div class="imgWrap"> 
												<img src="${commonStaticImgPath}${str}" id="${commonStaticImgPath}${str}"></img>
											</div>
											<a class="sficon btn-delimg" onclick="deleteImg('img${da.index}')"></a>
											<input type="hidden" value="${str}" name="bdImgs" >
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
								<p class="lh-20">最多可上传4张照片</p>
								</div>
							</div>
						</div>
				</div>
				<div class="mb-10 cl">
						
						<div class="f-l pos-r txtwrap1 ">
							<label class="lb lb2">配送单号：</label>
							<input type="text"  class="input-text  w-130 " id="distributionNumber"  name="distributionNumber"  >
						</div>
						<div class="f-l pos-r txtwrap2 ">
							<label class="lb lb2">配送日期：</label>
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
				<input class="sfbtn sfbtn-opt" value="保存" type="submit" id="baocunorder"/>
				<input class="sfbtn sfbtn-opt " value="重置" type="button" id="resetOrderForm" onclick="resetOrderFormBut()"/>
				<input class="sfbtn sfbtn-opt" value="直接派单" type="button" id="directOrder" onclick="directDis()"/>
				<input class="sfbtn sfbtn-opt" value="新建工单" type="button" id="xinorder" style="display: none;" onclick="addNew()"/>
				<!-- <input class="sfbtn sfbtn-opt" value="短信通知" type="button" id="msgInorderform" onclick="msgInform()" style="display: none;"/> -->
				<input class="sfbtn sfbtn-opt" value="保存并打印" type="button" onclick="printView()"/>
			</div>
			</form>
		
		</div>
	</div>
</div>

<!-- 选车车辆和配送人员
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
		我要派工	<a href="javascript:;" class="sficon closePopup"></a>
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


<div id="map-container" style="display: none;">
</div>
<div class="popupBox historyOrder">
	<h2 class="popupHead">
		历史工单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pb-60 pos-r">
		<div class="popupMain ">
			<div class="tableWrap text-c">
				<table class="table table-bg table-border table-bordered table-sdrk">
					<thead>
					<tr>
						<th class="w-70"></th>
						<th class="w-150">工单编号</th>
						<th class="w-100">工单状态</th>
						<th class="w-100">用户姓名</th>
						<th class="w-100">联系电话</th>
						<th class="w-200">详细地址</th>
						<th class="w-100">家电品牌</th>
						<th class="w-100">家电品类</th>
						<th class="w-100">家电型号</th>
						<th class="w-100">内机条码</th>
						<th class="w-100">外机条码</th>
						<th class="w-130">购机时间</th>
						<th class="w-100">保修类型</th>
						<th class="w-130">报修时间</th>
						<th class="w-100">服务工程师</th>
						<th class="w-130">完工时间</th>
					</tr>
					</thead>
					<tbody>
					<!--
					<tr>
						<td>
							<span class="radiobox" ><input type="radio" name="" id="rd1" /> </span>
						</td>
						<td>报修时间报修时间报修时间报修时间报修时间报修时间</td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td>2017-07-06</td>
					</tr>
					-->
					</tbody>
				</table>
			</div>
		</div>
		<div class="text-c btnWrap">
			<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="dupOrder">工单复制</a>
			<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" id="closPop">关闭</a>
		</div>
	</div>
</div>

<div class="popupBox historyOrderIn" style="width:1000px;">
	<h2 class="popupHead">
		历史工单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pb-60 pos-r pl-15 pr-15">
		<div class="popupMain pt-15 tableWrap " style="">
			<div class="text-c">
				<table class="table table-bg table-border table-bordered table-sdrk inCode">
					<thead>
					<tr>
						<th class="w-70"></th>
						<th class="w-150">工单编号</th>
						<th class="w-100">工单状态</th>
						<th class="w-100">用户姓名</th>
						<th class="w-100">联系电话</th>
						<th class="w-200">详细地址</th>
						<th class="w-100">家电品牌</th>
						<th class="w-100">家电品类</th>
						<th class="w-100">家电型号</th>
						<th class="w-100">内机条码</th>
						<th class="w-100">外机条码</th>
						<th class="w-130">购机时间</th>
						<th class="w-100">保修类型</th>
						<th class="w-130">报修时间</th>
						<th class="w-100">服务工程师</th>
						<th class="w-130">完工时间</th>
					</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<div class="text-c btnWrap">
			<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="dupOrderIn">工单复制</a>
			<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" id="closPopIn" >关闭</a>
		</div>
	</div>
</div>

<div class="popupBox historyOrderOut" style="width:1000px;">
	<h2 class="popupHead">
		历史工单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pb-60 pos-r pl-15 pr-15">
		<div class="popupMain pt-15 tableWrap " style="">
			<div class="text-c">
				<table class="table table-bg table-border table-bordered table-sdrk outCode">
					<thead>
					<tr>
						<th class="w-70"></th>
						<th class="w-150">工单编号</th>
						<th class="w-100">工单状态</th>
						<th class="w-100">用户姓名</th>
						<th class="w-100">联系电话</th>
						<th class="w-200">详细地址</th>
						<th class="w-100">家电品牌</th>
						<th class="w-100">家电品类</th>
						<th class="w-100">家电型号</th>
						<th class="w-100">内机条码</th>
						<th class="w-100">外机条码</th>
						<th class="w-130">购机时间</th>
						<th class="w-100">保修类型</th>
						<th class="w-130">报修时间</th>
						<th class="w-100">服务工程师</th>
						<th class="w-130">完工时间</th>
					</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<div class="text-c btnWrap">
			<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="dupOrderOut">工单复制</a>
			<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" id="closPopOut" >关闭</a>
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
					<input type="text" class="input-text w-300 mr-5" id="dingweidizhi" value="">
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

<%--<input type="hidden" name="customerLnglat" readonly="true" id="lnglat" value="" />--%>
<input id="signPoint" name="signPoint" value="" type="hidden">
<input type="hidden" name="longitude" readonly="true" id="longitude" value="" />
<input type="hidden" name="latitude" readonly="true" id="latitude" value="" />
<input type="hidden" name="orderId"  id="orderMsgId" />
<input type="hidden" name="orderMsgMobile"  id="orderMsgMobile" />
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/city.union.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/addressChange.union.js"></script>
<script type="text/javascript">
var currentHistoryList = [];
var currentHistoryListIn = [];
var currentHistoryListOut = [];
var orderMsgId="";
var orderMsgMobile="";
var ctx='${ctx}';
var feedImgsCount = 0;

var bodyHeight = $(window).height();
var maxHeight = bodyHeight;
var $formContain = $('.popupContainer1');
	if($formContain){
		$formContain.css({
			'max-height': maxHeight-120,
			'overflow-y':'auto',
	/* 	 	'padding-right':(paddingR-17)>0?(paddingR-17): 0  */
		});
	}

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
	
	$("#origin").select2();

	$('#applianceBrand').select2();
	$(".selection").css("width","140px");
	
	$('#applianceCategory').select2();
	$("#applianceCategory").next(".select2").find(".selection").css("width","110px");
	
	$("#origin").next(".select2").find(".selection").css("width","110px");

    $("#pleaseReferMall").select2({tags:true});
    $("#pleaseReferMall").next(".select2").find(".selection").css("width","110px");

    //$("#pleaseReferMall").select2();
    //$("#pleaseReferMall").next(".select2").find(".selection").css("width","110px");

	$("#number").focus();
	$('.addNewOrder').popup();
	$("#number").blur();
	
	$("#applianceMachineCode").focus(function(){
		var nei = $("#applianceBarcode").val();
		if(isBlank(nei)){
			layer.msg("请先填写内机条码！");
		}
	});
	$("#styleMArk .select2-selection--single").css({'background-color': '#dbf5fd','border':'1px solid #5ebdfb'});
	$('#filterName').keyup(function () {
		$('#zhijiepaidan tr').hide().filter(":contains('" + ($(this).val()) + "')").show();
		if(isBlank($(this).val())){
			$('#zhijiepaidan tr').show();
		}
		
	}).keyup();//DOM加载完时，绑定事件完成之后立即触发
	// 当预约时间没选择时给出提示
	var limit ="";
	 $.post("${ctx}/order/getproLimitList",function(result){
		    $.each(result, function(){
		    	var value= this;
		    	limit = limit + '<option value="'+value+'">'+value+'</option>';
		    });
		});
	$("#promiseLimit").focus(function () {
		$("#promiseLimit").empty();
		var html = "";
		if (isBlank($("#promiseTime").val())) {
			layer.msg("请选择预约时间");
			html = '<option value="">请选择</option>';
		} else {
			html = '<option value="">请选择</option>';
			html = html+limit;
		}
		$("#promiseLimit").append(html);
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
	// 选择品类时获取服务商维护对应的品牌
	$("#applianceCategory").change(function () {
		var brand = $("#applianceBrand").val();
		var cate = $("#applianceCategory").val();
		//if(!isBlank(cate)){
		$.ajax({
			type: "post",
			url: "${ctx}/order/getBrand",
			data: {
				category: cate
			},
			dataType: "json",
			success: function (data) {
				var obj = eval(data);
				if (obj.count == 2) {
					layer.msg("没有相关品牌，请维护");
					$("#applianceBrand").empty();
					document.getElementById("applianceBrand").setAttribute("disabled", "disabled");
				} else {
					$("#applianceBrand").empty();
					document.getElementById("applianceBrand").removeAttribute("disabled");
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
		// if(isBlank(cate)){
		var brand = $("#applianceBrand").val();
		//if(!isBlank(brand)){
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
					//$("#applianceCategory").Attr("disabled","disabled");
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
	//获取用户地址经纬度
 	$("#customerAddress1").change(function() {
 		initAddrmap();
		dingwei();
	});
	
 	$("#applianceBarcode").bind('blur', function () {
		contactBlurHandlerCodeIn($(this));
	});
 	
 	$("#applianceMachineCode").bind('blur', function () {
		contactBlurHandlerCodeOut($(this));
	});

	$("#customerMobile").bind('blur', function () {
		contactBlurHandler($(this));
	});
	$("#customerTelephone").bind('blur', function() {
		contactBlurHandler($(this));
	});
	$("#customerTelephone2").bind('blur', function() {
		contactBlurHandler($(this));
	});
	$(".ttipWrap").bind('click', function () {
		var tel = $(this).prev("input").val();
		loadHistoryOrders(tel, function (data) {
			if (data && data.length > 0) {
				currentHistoryList = data;
				var tbody = $(".table-sdrk tbody");
				tbody.empty();
				var html = "";
				for (var i = 0; i < data.length; i++) {
					html += createHistoryOrderItem(data[i].columns, i);
				}
				tbody.html(html);
				$('.historyOrder').popup({level: 2, closeSelfOnly:true});
			}
		});
	});
	
	$(".codeIn").bind('click', function () {
		var code = $(this).prev("input").val();
		loadHistoryOrdersIn(code, function (data) {
			if (data && data.length > 0) {
				currentHistoryListIn = data;
				var tbody = $(".inCode tbody");
				tbody.empty();
				var html = "";
				for (var i = 0; i < data.length; i++) {
					html += createHistoryOrderItemCode(data[i].columns, i);
				}
				tbody.html(html);
				$('.historyOrderIn').popup({level: 2,closeSelfOnly:true});
			}
		});
	});
	
	$(".codeOut").bind('click', function () {
		var code = $(this).prev("input").val();
		loadHistoryOrdersOut(code, function (data) {
			if (data && data.length > 0) {
				currentHistoryListOut = data;
				var tbody = $(".outCode tbody");
				tbody.empty();
				var html = "";
				for (var i = 0; i < data.length; i++) {
					html += createHistoryOrderItemCode(data[i].columns, i);
				}
				tbody.html(html);
				$('.historyOrderOut').popup({level: 2,closeSelfOnly:true});
			}
		});
	});
	
	$('.historyOrder .table').on('click', 'tr', function (ev) {
		if ($(this).hasClass('trselect')) {
			$(this).removeClass('trselect');
			$(this).find('input[type="radio"]').removeAttr('checked');
		} else {
			$('.historyOrder .table tr').removeClass('trselect');
			$('.historyOrder .table tr').find('input[type="radio"]').removeAttr('checked');
			$(this).addClass('trselect');
			$(this).find('input[type="radio"]').attr({'checked': 'checked'});
		}
	});
	$('#closPop').on('click',function(){
//		$(this).parents('.historyOrder').find('.closePopup').click();
		$.closeDiv($(".historyOrder"), true);
	});
	$('#closPopIn').on('click',function(){
//		$(this).parents('.historyOrderIn').find('.closePopup').click();
        $.closeDiv($(".historyOrderIn"), true);
	});
	$('#closPopOut').on('click',function(){
//		$(this).parents('.historyOrderOut').find('.closePopup').click();
        $.closeDiv($(".historyOrderOut"), true);
	});
	$("#dupOrder").bind('click', function () {
		var selected = $(".trselect", $('.historyOrder .table'));
		if (selected.size() <= 0) {
			layer.msg("请选择一条工单");
		} else {
			var id = selected.prop("id");
			var rowNo = id.split("_")[1];
			var order = currentHistoryList[rowNo].columns;
			autoFillFromHistory(order);
			$('#closPop').trigger('click');
		}
	});
	
	$('.historyOrderIn .table').on('click', 'tr', function (ev) {
		if ($(this).hasClass('trselect')) {
			$(this).removeClass('trselect');
			$(this).find('input[type="radio"]').removeAttr('checked');
		} else {
			$('.historyOrderIn .table tr').removeClass('trselect');
			$('.historyOrderIn .table tr').find('input[type="radio"]').removeAttr('checked');
			$(this).addClass('trselect');
			$(this).find('input[type="radio"]').attr({'checked': 'checked'});
		}
	});
	
	$('.historyOrderOut .table').on('click', 'tr', function (ev) {
		if ($(this).hasClass('trselect')) {
			$(this).removeClass('trselect');
			$(this).find('input[type="radio"]').removeAttr('checked');
		} else {
			$('.historyOrderOut .table tr').removeClass('trselect');
			$('.historyOrderOut .table tr').find('input[type="radio"]').removeAttr('checked');
			$(this).addClass('trselect');
			$(this).find('input[type="radio"]').attr({'checked': 'checked'});
		}
	});
	
	$("#dupOrderIn").bind('click', function () {
		var selected = $(".trselect", $('.historyOrderIn .table'));
		if (selected.size() <= 0) {
			layer.msg("请选择一条工单");
		} else {
			var id = selected.prop("id");
			var rowNo = id.split("_")[1];
			var order = currentHistoryListIn[rowNo].columns;
			autoFillFromHistory(order);
			$('#closPopIn').trigger('click');
		}
	});
	$("#dupOrderOut").bind('click', function () {
		var selected = $(".trselect", $('.historyOrderOut .table'));
		if (selected.size() <= 0) {
			layer.msg("请选择一条工单");
		} else {
			var id = selected.prop("id");
			var rowNo = id.split("_")[1];
			var order = currentHistoryListOut[rowNo].columns;
			autoFillFromHistory(order);
			$('#closPopOut').trigger('click');
		}
	});

    $.post("${ctx}/order/remainMsgNum",{},function(result){
        $("#sign").val(result.columns.sms_sign);
        $("#siteMsgNums").val(result.columns.sms_available_amount);
        $("#jdTelephone").val(result.columns.sms_phone);
    });

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
    $.closeDiv($('.addDriver'));
}

function closed(){
	 $.closeDiv($('.addDriver'));
}

$(function(){
	createUploader("#filePicker-add","#Imgprocess","file_fake_addimg","file_fake_add","delpickerImg");
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
		   if(parseInt(feedImgsCount)<5){
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
		   if(feedImgsCount>=4){
			  $("#jiahao").addClass('hide');
		   }
		   if(parseInt(feedImgsCount) >4 ){
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
	feedImgsCount = feedImgsCount-1;
	console.log(feedImgsCount)
	if(feedImgsCount<4){
		$("#jiahao").removeClass('hide');
	}
	return ;
} 
function img(id,src,file,site){
	if(feedImgsCount >= 4){
		$("#jiahao").addClass('hide');
		}
	if(feedImgsCount > 4){
		$("#jiahao").addClass('hide');
		layer.msg("最多可上传4张图片！");
		return false;
	}
	feedImgsCount=parseInt(feedImgsCount)+1;  
	var html =' <div class="f-l imgWrap1 mb-10" id="file'+file.id+'"><div class="imgWrap"> ';
	html +='<img src="'+src+'" id=""></div><a class="sficon btn-delimg" onclick="delx(this, \''+file.id+'\')"></a></div>'+
			'<input name="markAble" id="mark'+file.id+'" hidden="hidden" value="'+file.id+'" />';
	if(parseInt(feedImgsCount)<5){
		$(site).append(html);
	}
	if(feedImgsCount>=4){
		$("#jiahao").addClass('hide');
		feedImgsCount = 4;
	}
}

function resetOrderFormBut() {
    window.location.reload();
}

function contactBlurHandlerCodeIn(target) {
	var code = target.val();
	var tip = target.siblings(".ttipWrap");
	if (code!=null && $.trim(code)!="") {
		loadHistoryOrdersCodeInCount(code, function (data) {
			if (data && data.cnt > 0) {
				$(".va-t", tip).text(data.cnt);
				tip.show();
			} else {
				tip.hide();
			}
		});
	} else {
		tip.hide();
	}
}

function contactBlurHandlerCodeOut(target) {
	var code = target.val();
	var tip = target.siblings(".ttipWrap");
	if (code!=null && $.trim(code)!="") {
		loadHistoryOrdersCodeOutCount(code, function (data) {
			if (data && data.cnt > 0) {
				$(".va-t", tip).text(data.cnt);
				tip.show();
			} else {
				tip.hide();
			}
		});
	} else {
		tip.hide();
	}
}

function loadHistoryOrdersCodeOutCount(code, callback) {
	$.ajax({
		url: "${ctx}/order/getHistoryOrdersCodeOutCountByTel?code=" + $.trim(code),
		type: 'GET',
		success: function(data) {
			if(callback) {
				callback.call(data, data);
			}
		}
	});
}

function loadHistoryOrdersCodeInCount(code, callback) {
	$.ajax({
		url: "${ctx}/order/getHistoryOrdersCodeInCountByTel?code=" + $.trim(code),
		type: 'GET',
		success: function(data) {
			if(callback) {
				callback.call(data, data);
			}
		}
	});
}

function contactBlurHandler(target) {
	var mobile = target.val();
	var tip = target.siblings(".ttipWrap");
	if (mobile && mobile.length >= 3) {
		loadHistoryOrdersCount(mobile, function (data) {
			if (data && data.cnt > 0) {
				$(".va-t", tip).text(data.cnt);
				tip.show();
			} else {
				tip.hide();
			}
		});
	} else {
		tip.hide();
	}
}

function createHistoryOrderItemCode(order, idx) {
	return(
	'<tr id="row_'+idx+'">'+
	'<td>'+
	'<span class="radiobox" ><input type="radio" name="" /> </span>'+
	'	</td>'+
	'	<td>'+order.number+'</td>'+
	'	<td>'+fmtOrderStatusTxt({status: order.status})+'</td>'+
	'	<td>'+order.customer_name+'</td>'+
	'	<td>'+order.customer_mobile+'</td>'+
	'	<td>'+order.province+order.city+order.area+order.customer_address+'</td>'+
	'	<td>'+order.appliance_brand+'</td>'+
	'	<td>'+order.appliance_category+'</td>'+
	'	<td>'+order.appliance_model+'</td>'+
	'	<td>'+order.appliance_barcode+'</td>'+
	'	<td>'+order.appliance_machine_code+'</td>'+
	'	<td>'+order.appliance_buy_time+'</td>'+
	'	<td>'+fmtOrderWarrantyType({warranty_type: order.warranty_type})+'</td>'+
	'	<td>'+fmtDate(order.repair_time)+'</td>'+
	'	<td>'+order.employe_name+'</td>'+
	'	<td>'+fmtDate(order.end_time)+'</td>'+
	'</tr>');
}

function createHistoryOrderItem(order, idx) {
	return(
	'<tr id="row_'+idx+'">'+
	'<td>'+
	'<span class="radiobox" ><input type="radio" name="" /> </span>'+
	'	</td>'+
	'	<td>'+order.number+'</td>'+
	'	<td>'+fmtOrderStatusTxt({status: order.status})+'</td>'+
	'	<td>'+order.customer_name+'</td>'+
	'	<td>'+order.customer_mobile+'</td>'+
	'	<td>'+order.province+order.city+order.area+order.customer_address+'</td>'+
	'	<td>'+order.appliance_brand+'</td>'+
	'	<td>'+order.appliance_category+'</td>'+
	'	<td>'+order.appliance_model+'</td>'+
	'	<td>'+order.appliance_barcode+'</td>'+
	'	<td>'+order.appliance_machine_code+'</td>'+
	'	<td>'+order.appliance_buy_time+'</td>'+
	'	<td>'+fmtOrderWarrantyType({warranty_type: order.warranty_type})+'</td>'+
	'	<td>'+fmtDate(order.repair_time)+'</td>'+
	'	<td>'+order.employe_name+'</td>'+
	'	<td>'+fmtDate(order.end_time)+'</td>'+
	'</tr>');
}

function fmtDate(t) {
	if (t && typeof t === 'number') {
		return $.dateUtils.formatDate(t);
	}
	return "";
}

function directDis(){
	var number = $.trim($("#number").val());
	var serviceType = $("#serviceType").val();
	var serviceMode = $("#serviceMode").val();
	var name = $("#customerName").val();
	var customerMobile = $("#customerMobile").val();
	var add = $("#customerAddress1").val();

	var selectcategory = $("#applianceCategory").val();
	var selectbrand = $("#applianceBrand").val();
	var customerFeedback = $("#customerFeedback").val();
	var codeSet = '${orderNumSet}';
	   var distributionNumber = $("#distributionNumber").val();    
       var plateNumber = $("#plateNumber").val(); 
	if(codeSet!='200'){
		if (isBlank(number)) {
			layer.msg("请输入工单编号");
			return
		} else if (!num.test(number)) {
			layer.msg("请输入正确的工单编号");
			return
		} 
	}
	if (isBlank(serviceType)) {
		layer.msg("请选择服务类型");
	} else if (isBlank(serviceMode)) {
		layer.msg("请选择服务方式");
	} else if (isBlank(name)) {
		layer.msg("请输入用户姓名！");
	} else if (isBlank(customerMobile)) {
		layer.msg("请输入联系方式");
	} else if (!isPhoneNo($.trim(customerMobile)) ) {
		layer.msg("手机号码格式不正确");
	} else if (isBlank(add)) {
		layer.msg("请输入详细地址");
	}else if (isBlank(selectbrand)) {
		layer.msg("请选择家电品牌！");
	} else if (isBlank(selectcategory)) {
		layer.msg("请选择家电品类！");
	}  /*else if (isBlank(customerFeedback.replace(/(^\s*)|(\s*$)/g, ""))) {
		layer.msg("请输入服务描述");
	}*/
       
	else{
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
                    if(data==="existNumber"){
                        layer.msg("工单编号已存在！");
                        return false;
                    }

                    $("#arroundUserInfo").empty();
                    $(".custNam").text($("#customerName").val());
                    $(".custMob").text($("#customerMobile").val());
                    var township=$("#township").val() || '';
                    $(".custAddr").text($("#province").val()+$("#city").val()+$("#area").val()+township+$("#customerAddress").val());
                    $("#arroundCustomerAddress").val($("#customerAddress1").val());

                    $('.activeDispatch').popup({level:2,closeSelfOnly:true}); //显示我要派工弹出框和判断高度
                    $.selectCheck2("serverSelected");
                    initDispatchMap();
                    employe();
                }
            });
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
	/* var moliereg=/^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][34578][0-9]{9}$)$/;
	var tel= /^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][34578][0-9]{9}$)|(^(0[0-9]{2,3})?([2-9][0-9]{6,7})+([0-9]{1,4})?$)$/;
	var pattern = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/; */
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
		var addr =$("#province").val()+$("#city").val()+$("#area").val()+ town + address;
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
		type: "POST",
		url: "${ctx}/operate/employe/dispatchList",
		data: {
			lnglat: lnglat,
			category: category
		},
		//dataType: 'json',
		success: function (data) {
			var content = $("#zhijiepaidan");
			content.empty();
			var sites = data;
			var appendHtml = '';
			for (var i = 0; i < sites.length; i++) {
				var item = sites[i].columns;
				appendHtml += '<tr>'
						+ '<td style="border-left: none;">' + item.name + '</td>'
						+ '<td>' + item.sywwg + '</td>'
						+ '<td>' + item.wwg + '</td>'
					 	+ '<td>' + item.jrywg + '</td>' 
						+ '<td>' + item.distance_formatted + '</td>'
						+ '<td><label class="label-cbox3" for="' + item.id + '"><input type="checkbox" name="serverSelected" id="' + item.id + '"></label></td>'
						+ '</tr>';
			}
			if (isBlank(appendHtml)) {
				layer.msg("服务工程师没有维护"+category+"服务品类，请先维护");
			}
			content.html(appendHtml);

			$("#zhijiepaidan tr").each(function (index) {
				$(this).data("emp", sites[index].columns);
			});
			$("#zhijiepaidan tr").on('click', function (ev) {
				
				var name = ev.target.tagName.toLowerCase();
				if(name == 'label') return;
			
				var flag = $(this).hasClass('checked');
				if (flag) {
					$(this).removeClass('checked');
				} else {
					$(this).attr("class", "checked");
					$.trim($(this).children('td').eq(0).html())
				}
				$("#nameWrap").empty();
				var name = "";
				var id = "";
				$("#zhijiepaidan tr").each(function (index) {
					var flag = $(this).hasClass('checked');
					if (flag) {
						if (isBlank(name)) {
							name = $.trim($(this).children('td').eq(0).html());
						} else {
							name = name + " " + $.trim($(this).children('td').eq(0).html());
						}
						if (isBlank(id)) {
							id = $.trim($(this).children('td').eq(5).children('label').attr('for'));
						} else {
							id = id + "," + $(this).children('td').eq(5).children('label').attr('for');
						}
					}
				});
				$("#nameWrap").append("<span>" + name + "</span>");
				$("#employeId").val(id);
			});
		}
	});
}

//直接派工中点击派工按钮
var confirmpai=false;
function dispa() {
    if(confirmpai){
        return;
    }
	var empId = $("#employeId").val();
	if (isBlank(empId)) {
		layer.msg("请选择服务工程师");
	} else {
		var name = $.trim($("#nameWrap").children('span').html());
		$('body').popup({
			level: '3',
			type: 2,  // 提示是否进行某种操作
			content: '确认要给工程师' + name + '派工吗？',
			closeSelfOnly: true,
			fnConfirm: function () {
                var addressspace="";
                addressspace += ($("#township").val() || '');
                addressspace += $("#customerAddress1").val();
                $("#customerAddress").val(addressspace);

                confirmpai=true;
				$.ajax({
					url: "${ctx}/order/save",
					type: "POST",
					data: $("#neworderForm").serialize(),
					success: function (data) {
						if(data=='420'){
							layer.msg("工单编号已被使用！");
							return;
						}
						parent.layer.msg('保存成功');
						$("#dyOrSave").val("ok");
						$("#orderMsgMobile").val(data.mobile);
						$("#orderMsgId").val(data.id);
						saveorder(data);
					},
					complete: function() {
                        confirmpai = false;
                    }
				});
			}
		});
	}
}

function closeParent(){
	$.closeDiv($(".activeDispatch"));
}


	$('#neworderForm').Validform({
		tiptype: function (msg, o, cssctl) {
			if (o.type == "3") {
                layer.msg(msg);
            }
		},
		tipSweep: true,
		postonce: true,
		showAllError: false,
		datatype: {
			"dh": /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/,
			"z46": /^[^\%\'\"\?]{1,20}$/,
			"zimu": /^[A-Za-z0-9]{1,18}$/,
			"anum":/^[0-9]{0,4}$/,
			"num": /^[A-Za-z0-9]{1,20}$/,
			"tel": /(^1\d{10}$)|(^(\d{3,4}\-)?\d{5,9}$)/,
			"mtel": /^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/
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
			if(isBlank($("#province").val())){
                layer.msg("省市区为必填项");
                return;
            }
            if(isBlank($("#city").val())){
                layer.msg("省市区为必填项");
                return;
            }
            if(isBlank($("#area").val())){
                layer.msg("省市区为必填项");
                return;
            }
            var addressspace="";
            if(!isBlank($("#township").val())){
                addressspace+=$("#township").val();
            }
            addressspace+=$("#customerAddress1").val();
            $("#customerAddress").val(addressspace);

            var promiseTime = '${mustfill.columns.promiseTime}';
            var applianceBuyTime = '${mustfill.columns.applianceBuyTime}';
            var jurisdiction=false+","+promiseTime+","+false+","+false+","+false+","+false+","+false+","+false+","+false+","+applianceBuyTime+","+false+","+false+","+false+","+false;
            var promiseTimev= $("#promiseTime").val();
            var applianceBuyTimev= $("#applianceBuyTime").val();
           // var jurisdictionvalue=null+"(**..)"+promiseTimev+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+null+"(**..)"+applianceBuyTimev+"(**..)"+null+"(**..)"+null+"(**..)"+null;

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
                    $.closeAllDiv();
				}
			});
			return false;
		}
	
	});

	function saveorder(order) {
		$.ajax({
			url: "${ctx}/order/commonsetting/shifoukaitong",
			type: "POST",
			data: {},
			success: function (data) {
				if (!isBlank(data)) {
					if(data.columns.set_value =="1"){
                        var topWin = window.top;
                        parent.search();
                        $.closeAllDiv();
                        msgInform(topWin, order.id);
					}else{
						parent.search();
						$.closeAllDiv();
					}
				} else {
					parent.search();
					$.closeAllDiv();
				}
			}
		});

	}
	
	function addNew(){
		location.href='${ctx}/order/form';
	}
	
	function msgInform(topWin, id){
        var $pFrame = $("#Hui-article-box iframe:visible", topWin.document);
        var frameWin = $pFrame.get(0).contentWindow || $pFrame.get(0);

		if(isBlank(id)){
            frameWin.layer.msg("数据有误！");
			return
		}
        frameWin.layer.open({
			type : 2,
			content:'${ctx}/order/sendMsgAccountsOne?ids=' + id + "&type=1",
			title:false,
			area: ['100%','100%'],
			closeBtn:0,
			shade:0,
			anim:-1 
		}); 
	}
	
		function isBlank(val) {
			if(val==null || $.trim(val)=='' || val == undefined) {
				return true;
			}
			return false;
		}
		
		
		var markOrder = false;
		function printView(){
			if(markOrder){
				return;
			}
			var number = $.trim($("#number").val());
			var serviceType = $("#serviceType").val();
			var serviceMode = $("#serviceMode").val();
			var name = $("#customerName").val();
			var customerMobile = $("#customerMobile").val();
			var add = $("#customerAddress1").val();

			var selectcategory = $("#applianceCategory").val();
			var selectbrand = $("#applianceBrand").val();
			var customerFeedback = $("#customerFeedback").val();
			var codeSet = '${orderNumSet}';
			var distributionNumber = $("#distributionNumber").val();    
            var plateNumber = $("#plateNumber").val(); 
			if(codeSet!='200'){
				if (isBlank(number)) {
					layer.msg("请输入工单编号");
					return;
				} else if (!num.test(number)) {
					layer.msg("请输入正确的工单编号");
					return;
				}
			}
			if (isBlank(serviceType)) {
				layer.msg("请选择服务类型");
			} else if (isBlank(serviceMode)) {
				layer.msg("请选择服务方式");
			} else if (isBlank(name)) {
				layer.msg("请输入用户姓名！");
			} else if (isBlank(customerMobile)) {
				layer.msg("请输入联系方式");
			} else if (!isPhoneNo($.trim(customerMobile)) ) {
				layer.msg("手机号码格式不正确");
			} else if (isBlank(add)) {
				layer.msg("请输入详细地址");
			}else if (isBlank(selectbrand)) {
				layer.msg("请选择家电品牌！");
			} else if (isBlank(selectcategory)) {
				layer.msg("请选择家电品类！");
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

                    markOrder = true;
                    $.ajax({
                        url: "${ctx}/order/save",
                        type: "POST",
                        data: $("#neworderForm").serialize(),
                        success: function (data) {
                            markOrder = false;
                            if(data=='420'){
                                layer.msg("工单编号已被使用！");
                                return;
                            }
                            $("#printForm").find("input").each(function(){
                                var attrName = $(this).attr("name");
                                $("#pt-"+attrName).val($("#neworderForm input[name='"+attrName+"']").val());
                            });
                            $("#pt-applianceCategory").val($("#applianceCategory").select2('val'));
                            $("#pt-applianceBrand").val($("#applianceBrand").select2('val'));
                            $("#pt-serviceMode").val($("#serviceMode").val());
                            $("#pt-serviceType").val($("#serviceType").val());
                            $("#pt-origin").val($("#origin").val());
                            $("#pt-level").val($("#level").val());
                            $("#pt-promiseLimit").val($("#promiseLimit").val());
                            $("#pt-customerFeedback").val($("#customerFeedback").val());
                            $("#pt-remarks").val($("#remarks").val());
                            $("#pt-warrantyType").val($("#warrantyType").val());
                            $("#pt-customerAddress").val($("#province").val()+$("#city").val()+$("#area").val()+($("#township").val()||'')+$("#customerAddress").val());
                            $("#printForm").submit();
                            parent.search();
                            setTimeout(function(){
                                $.closeAllDiv();
                            },500)
                        },
                        complete: function() {
                            markOrder = false;
                        }
                    });
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


	function loadHistoryOrders(tel, callback) {
			$.ajax({
				url: "${ctx}/order/getHistoryOrdersByTel?tel=" + tel,
				type: 'GET',
				success: function(data) {
					if(callback) {
						callback.call(data, data);
					}
				}
			});
		}
		
		function loadHistoryOrdersIn(code, callback) {
			$.ajax({
				url: "${ctx}/order/getHistoryOrdersBycodeIn?code=" + $.trim(code),
				type: 'GET',
				success: function(data) {
					if(callback) {
						callback.call(data, data);
					}
				}
			});
		}
		
		function loadHistoryOrdersOut(code, callback) {
			$.ajax({
				url: "${ctx}/order/getHistoryOrdersBycodeOut?code=" + $.trim(code),
				type: 'GET',
				success: function(data) {
					if(callback) {
						callback.call(data, data);
					}
				}
			});
		}

		function loadHistoryOrdersCount(tel, callback) {
			$.ajax({
				url: "${ctx}/order/getHistoryOrdersCountByTel?tel=" + tel,
				type: 'GET',
				success: function(data) {
					if(callback) {
						callback.call(data, data);
					}
				}
			});
		}
		
		function autoFillFromHistory(order) {
			$("#serviceType").val(order.service_type);
			$("#serviceMode").val(order.service_mode);
			$("#origin").val(order.origin);
			$("#customerName").val(order.customer_name);
			$("#customerMobile").val(order.customer_mobile);
			$("#customerTelephone").val(order.customer_telephone);
			$("#customerTelephone2").val(order.customer_telephone2);
			$("#customerAddress").val(order.customer_address);
			
			$("#customerAddress1").val(order.customer_address);
			$("#province").val(order.province);
			$("#city").val(order.city);
			$("#area").val(order.area);
			$("#customerLnglat").val(order.customer_lnglat);
			$("#applianceBrand").val(order.appliance_brand);
			$("#applianceCategory").val(order.appliance_category);
			$("#customerFeedback").val(order.customer_feedback);
			$("#applianceModel").val(order.appliance_model);
			$("#applianceBarcode").val(order.appliance_barcode);
			$("#applianceMachineCode").val(order.appliance_machine_code);
			$("#applianceBuyTime").val(order.appliance_buy_time);
			$("#warrantyType").val(order.warranty_type);
			$("#promiseTime").val(order.promise_time);
			$("#promiseLimit").val(order.promise_limit);
			$("#remarks").val(order.remarks);
			$("#applianceModel").val(order.appliance_model);
			$("#applianceBuyTime").val(order.appliance_buy_time);
			$("#warrantyType").val(order.warranty_type);
			$("#level").val(order.level);
			$("#origin").val([order.origin]).trigger("change");
			$("#applianceBrand").val([order.appliance_brand]).trigger("change");
			$("#applianceCategory").val([order.appliance_category]).trigger("change");
			/* $(".ttipWrap").addClass("hide");
			$(".ttipbox").addClass("hide"); */
			$(".ttipWrap").hide();
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
			var town="";
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
			if(!isBlank($("#township").val())){
				town= $("#township").val();
			}
			var address = province+city+area+town+address1;
			if(province==city){
				address = province+area+town+address1;
			}
			
			$("#dingweidizhi").val(address);
			//address ="山东济南历下区朱家峪景区";
			//dingwei11(address);
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
			});
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
	    	    });
			})
		}
		var markers=[];
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
                     if (marker != null) {
                         marker.setMap(null);
                         marker = null;
                     }
                     if (status === 'complete' && result.info === 'OK') {
                         if (result.resultNum && result.resultNum > 0) {
                             var location = result.geocodes[0].location;
                             slnglat = location.lng + "," + location.lat
                             $("#lnglat").val(slnglat);
                             map.panTo(new AMap.LngLat(location.lng, location.lat));
                             map.setZoom(13);
                             $("#latitude ").val(location.lat);
                             $("#longitude").val(location.lng);
                             if (marker == null) {
                                 marker = new AMap.Marker({
                                     position: [location.lng, location.lat],
                                     map: map,
                                     draggable: true
                                 });
                                 marker.setMap(map);
                                 marker.on('dragend', function (e) {
                                     geocoder.getAddress(marker.getPosition(), function (status, result) {
                                         if (status == 'complete') {
                                             $('#dingweidizhi').val(result.regeocode.formattedAddress);
                                             $("#latitude ").val(marker.getPosition()[0]);
                                             $("#longitude").val(marker.getPosition()[1]);
                                             $("#lnglat").val(marker.getPosition());
                                         } else {
                                             layer.msg('无法获取地址');
                                         }
                                     })
                                 });
                             } else {
                                 marker.setPosition(location.lng, location.lat);
                             }
                         }
                         $('#dingweidizhi').val(result.geocodes[0].formattedAddress);
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
			   $("#signPoint").focus();
                var proCityArea=$("#province").val()+$("#city").val()+$("#area").val();
                if($("#province").val()==$("#city").val()){
                    proCityArea=$("#city").val()+$("#area").val();
				}
                var address=dizhi.split(proCityArea);
                $("#customerAddress1").val(address[1])
                $("#customerAddress").val(address[1]);

			 
			  $.closeDiv($('.plocation'),true);
			  $('#dingweidizhi').val("");
			  var town = "";
			  if(!isBlank($("#township").val())){
				  town = $("#township").val();
			  }
			  $("#customerAddress").val(town+$("#customerAddress1").val());
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

function getCodeShowPopups(){
	$.post("${ctx}/order/orderDispatch/getCodeShowPopupNew",{id:''},function(result){
		var cdIn = result.codeIn;
		 var cdOut = result.codeOut;
		 if(cdIn == 0 && cdOut == 0){
			 $('#codeShow').hide();
		 }else{
			 if(cdIn < 1 || cdOut < 1){
				 $(".douhao").text("");
			 }
			 if(cdIn > 0){
				 $("#codeInshow").text('有'+cdIn+'条历史');
				 $(".codeIn").show();
			 }else{
				 $(".codeIn").hide();
			 }
			 if(cdOut > 0){
				 
				 $("#codeOutshow").text('有'+cdOut+'条历史');
				 $(".codeOut").show();
			 }else{
				 $(".codeOut").hide();
			 }
			 $('#codeShow').show();
		 }
	})
}

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
		codeCounts();//条码字数统计
	})
	$('#applianceBarcode').bind('input propertychange', function() {  
		codeCounts();//条码字数统计
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

function codeCounts(){
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
		//loadAlreadyCode(1,applianceBarcode);
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
		//loadAlreadyCode(2,applianceMachineCode);
	}else{
		$(".weishu2").hide();
		$(".code2").hide();
		$("#codeOutshow").hide();
		$(".codeOut").hide();
	}
}


var changeMark = true;
$(function() {
	codeNumberCounts();
	$("#printForm").bind('ajax:complete', function() {
    });
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
	$.ajax({
		url: "${ctx}/order/getHistoryOrdersCodeOutCountByTel?code=" + $.trim(code),
		type: 'GET',
		success: function(data) {
			var codeNow = type==1 ? $.trim($("#applianceBarcode").val()) : $.trim($("#applianceMachineCode").val());
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
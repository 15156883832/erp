<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/static/h-ui.admin/css/tips_style.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.css"/>
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/orderConnectionGoods.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/webuploader/0.1.5/webuploader.min.js"></script> 
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/LodopFuncs.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/base64.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/printdesign.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.qrcode.min.js"></script>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/formatStatus.js"></script>
<style type="text/css">
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
/* .spimg1{ border:none;} */
.spimg1 .webuploader-pick{
	width:134px;
	height:134px;
}
</style>
</head>

<body>
<!-- 回访结算工单-工单详情 -->
<div class="popupBox odWrap orderdetailVb">
	<h2 class="popupHead">
		工单详情
		<a href="javascript:;" class="sficon closePopup" id="closDivPoup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain pos-r" >
			<div class="pcontent">
			<div id="detialWd">
				<div class="tabBarP" style="overflow: visible;">
					<a href="javascript:;" class="tabswitch current">基本信息</a>
					<a href="javascript:;" class="tabswitch ">报修图片</a>
					<a href="javascript:;" class="tabswitch ">过程信息</a>
					<a href="javascript:;" class="tabswitch ">配送信息</a>
					<c:if test="${count != 0 }">
						<a  class="tooltipLink f-r" onclick="changeStyle('${order.number}')"  >
							<i class="sficon sficon-note"></i>已发送<span class="va-t">${count }</span>条短信
						</a>
					</c:if>
					<c:if test="${order.printTimes != 0 }">
						<a  class="tooltipLink f-r" >
							<i class="sficon sficon-print"></i>已打印<span class="va-t">${order.printTimes }</span>次
						</a>
					</c:if>
				</div>
				<form id="updateOrder" method="post" >
				<input type="hidden" name= "employeId" id="employeId">
				<div class="tabCon">
					<div class="cl mb-15 mt-10">
						<div class="f-l pos-r pl-100">
							<label class="lb w-100">工单编号：</label>
							<input type="text" id="orderNumber" class="input-text w-160 readonly" readonly="readonly" value="${order.number }"/>
						</div>
						<div class="f-l pos-r pl-100">
							<label class="lb w-100 text-r">服务类型：</label>
							<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${order.serviceType}"/>
						</div>
						<div class="f-l pos-r pl-80">
							<label class="lb w-80"><em class="mark"></em>服务方式：</label>
								<select id="serviceMode"  disabled="disabled" name="serviceMode" class="select w-120 readonly">
	 								<c:forEach items="${fns:getNewServiceModeDer(order.serviceMode) }" var="serm">
									 <c:if test="${order.serviceMode eq serm.columns.name }">  
									 	 <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
									    </c:if> 
									   
									  <c:if test="${order.serviceMode ne  serm.columns.name }">  
									   <option value="${serm.columns.name }">${serm.columns.name }</option> 
									    </c:if>
									</c:forEach>
	 							</select>
						</div>
						<div class="f-l pos-r pl-80">
							<label class="lb w-80">信息来源：</label>
							<input type="text" class="input-text w-130 readonly" readonly="readonly" value="${order.origin }"/>
						</div>
					</div>
						<c:if test="${order.recordAccount=='1' }">
						<!-- 	<a class="f-r c-0383dc lh-26" id="btn_More" onclick="showMore(this)">展开</a> -->
					<div class="cl mb-10 " id="moreConWrap">
						<div class="f-l pos-r pl-100">
							<label class="lb w-100"><em class="mark hide"></em>厂家工单编号：</label>
							<input type="text" id="factoryNumber" class="input-text w-160 readonly " maxlength="32" readonly="readonly" name="factoryNumber" value="${order.factoryNumber }"/>
						</div>
					</div>
						</c:if>
					<div class="line"></div>
					
					<div class="cl mt-10">
						<div class="f-l pos-r pl-100">
							<label class="lb w-100"><em class="mark hide ">*</em>用户姓名：</label>
							<input id="customerName" type="text" class="input-text w-160 readonly remarkUpdate " name="customerName" readonly="readonly"  value="${order.customerName }"/>
							<input type="hidden" name="id" value="${order.id }"/>
							 <c:if test="${cusTypecount > 0 }">
							<span class="select-box w-100 ">
		                    <select class="select readonly " id="customerType" name="customerType" disabled="disabled" >
			                    <option value=" "></option>
			                    <c:forEach items="${fns:getCustomerType()}" var="to">
			                   
			                    <option value="${to.columns.name }" <c:if test="${to.columns.name eq order.customerType}">selected="selected"</c:if>>${to.columns.name }</option>
			                    </c:forEach>
		                    </select>
							</span>
							</c:if>
						</div>
						<div class="f-l pos-r pl-100">
							<span id="telTypeChoose" class="lb w-100 text-r" style="display:none;">
									<span class="f-r ">：</span>
									<select id="telType" class="select f-r" style="width:75px">
										<option value="0" <c:if test="${fn:substring(order.customerMobile,0,1) ne '0'}">selected="selected"</c:if>>手机号码</option>
										<option value="1" <c:if test="${fn:substring(order.customerMobile,0,1) eq '0'}">selected="selected"</c:if>>固定电话</option>
									</select>
									<em class="mark f-r pr-5 hide">*</em>
								</span>
								<label class="lb w-100 reLX1" >联系方式1：</label>
							
							<input id="customerMobile" type="text" class="input-text w-120 readonly remarkUpdate " readonly="readonly" name="customerMobile" value="${order.customerMobile }"/>
						</div>
						<div class="f-l pos-r pl-90">
							<label class="lb w-90">其他联系方式：</label>
							<input id="customerTelephone" name="customerTelephone"  type="text" class="input-text w-110 readonly remarkUpdate" readonly="readonly"  value="${order.customerTelephone }"/>
						</div>
						<div class="f-l pos-r " style="padding-left: 15px;">
							<!-- 	<label class="w-80 pos">联系方式3：</label> -->
							<input id="customerTelephone2" name="customerTelephone2" type="text" class="input-text w-110 readonly remarkUpdate" readonly="readonly" value="${order.customerTelephone2 }"/>

						</div>
					</div>
					<div class="cl mt-10 mb-15">
						<div class="pos-r pl-100" id="pcd">
							<label class="lb w-100"><em class="mark hide">*</em>详细地址：</label>
							<span class="select-box w-90 f-l mr-10 " id="showProvince">
                            	<select class="prov select readonly" id="province" name="province" disabled="disabled">
									<c:if test="${not empty order.province}">
										<c:forEach items="${provincelist }" var="pro">
											<option value="${pro.columns.ProvinceName }"
													<c:if test="${pro.columns.ProvinceName==order.province }">selected="selected"</c:if>>${pro.columns.ProvinceName }</option>
										</c:forEach>
									</c:if>
									<c:if test="${empty order.province && not empty site.province}">
										<c:forEach items="${provincelist }" var="pro">
											<option value="${pro.columns.ProvinceName }"
													<c:if test="${pro.columns.ProvinceName==site.province }">selected="selected"</c:if>>${pro.columns.ProvinceName }</option>
										</c:forEach>
									</c:if>
								</select>
                            	</span>
							<span class="select-box w-90 f-l mr-10 " id="showCity">
                            	<select class="city select readonly" id="city" name="city" disabled="disabled">
									<c:if test="${not empty order.city}">
										<c:forEach items="${cities }" var="cs">
											<option value="${cs.columns.CityName }"
													<c:if test="${cs.columns.CityName==order.city }">selected="selected"</c:if>>${cs.columns.CityName }</option>
										</c:forEach>
									</c:if>
									<c:if test="${empty order.city && not empty site.city}">
										<c:forEach items="${cities }" var="cs">
											<option value="${cs.columns.CityName }"
													<c:if test="${cs.columns.CityName==site.city }">selected="selected"</c:if>>${cs.columns.CityName }</option>
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
							<input id="customerAddress" name="customerAddress" type="text" class="input-text w-280 readonly remarkUpdate " readonly="readonly" value="${order.customerAddress }"/>
							<input id="customerAddressRecord" type="hidden" class="input-text w-340 readonly remarkUpdate mustfill" readonly="readonly" value="${order.customerAddress }"/>
							<input type="hidden" id="lnglat" name="customerLnglat" value="${order.customerLnglat }"/>
						</div>
					</div>
					<div class="line"></div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><em class="mark"></em>家电品牌：</label>
							<select disabled="disabled"  class="select w-160 readonly" style="position: absolute;z-index: 1;" class="choose" onmousedown="if(this.options.length>6){this.size=8}" onblur="this.size=0" onchange="this.size=0" name="applianceBrand" id="applianceBrand" datatype="*" nullmsg="请选择品牌！">
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
							<input type="text" id="applanceBrandMirror" class="input-text w-160 readonly hide" disabled="disabled" value="${order.applianceBrand }"/>
					</div>
						<div class="f-l pos-r pl-100">
							<label class="lb text-r w-100"><em class="mark"></em>家电品类：</label>
							<select class="select w-120 readonly" style="position: absolute;z-index: 1;" class="choose" onmousedown="if(this.options.length>6){this.size=8}" onblur="this.size=0" onchange="this.size=0" name="applianceCategory" id="applianceCategory" datatype="*" nullmsg="请选择品类！"  disabled="disabled">
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
							<input type="text" id="applianceCategoryMirror" class="input-text w-120 readonly hide" disabled="disabled" value="${order.applianceCategory }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><c:if test="${mustfill.columns.promiseTime}"><em class="mark"></em></c:if>预约日期：</label>
							<input type="text" class="input-text w-130 readonly remarkUpdate" onfocus="WdatePicker({minDate: '%y-%M-%d' })"  readonly="readonly" name="promiseTime" value="<fmt:formatDate value='${order.promiseTime }' pattern='yyyy-MM-dd'/>"/>
						</div>

						<div class="f-l pos-r pl-80">
							<label class="lb w-80"><c:if test="${mustfill.columns.promiseLimit}"><em class="mark"></em></c:if>时间要求：</label>
							<select id="promiseLimit" class="select w-130 readonly" name="promiseLimit"  disabled="disabled">
							<option value="">请选择</option>
								<c:set var="isDoing" value="0"/>
								<c:forEach items="${proLimitList}" var="serm">
									<option value="${serm }" ${order.promiseLimit eq serm ?'selected':''} >${serm }</option>
									<c:if test="${order.promiseLimit eq serm}">
										<c:set var="isDoing" value="1"/>
									</c:if>
								</c:forEach>
								<c:if test="${isDoing != 1 and not empty order.promiseLimit}">
									<option value="${order.promiseLimit }" selected="selected" >${order.promiseLimit }</option>
								</c:if>
							</select>
						</div>
					</div>
					<div class="cl mt-10">

						<div class="f-l pos-r txtwrap1 h-50">
							<label class="lb lb1"><c:if test="${mustfill.columns.customerFeedback}"><em class="mark"></em></c:if>服务描述：</label>
							<textarea type="text" class="input-text w-380 h-50 readonly remarkUpdate" readonly="readonly" name="customerFeedback">${order.customerFeedback}</textarea>

						</div>

						<div class="f-l pos-r txtwrap2 h-50">
							<label class="lb lb2"><c:if test="${mustfill.columns.remarks}"><em class="mark"></em></c:if>备注：</label>
							<textarea type="text" class="input-text h-50 w-340 readonly remarkUpdate" readonly="readonly" name="remarks">${order.remarks}</textarea>

						</div>
					</div>
					
					
					<div class="cl mt-10">

						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><c:if test="${mustfill.columns.applianceModel}"><em class="mark"></em></c:if>产品型号：</label>
							<input type="text" class="input-text w-160 readonly remarkUpdate" readonly="readonly" name="applianceModel" value="${order.applianceModel}"/>
						</div>
						<div class="f-l pos-r pl-100">
							<label class="lb text-r w-100"><c:if test="${mustfill.columns.applianceNum}"><em class="mark"></em></c:if>产品数量：</label>
							<input type="text" class="input-text w-120 readonly remarkUpdate" readonly="readonly" name="applianceNum" id="applianceNum" value="${order.applianceNum }"/>
						</div>
						<div class="f-l pos-r txtwrap2 wrapss">
							<label class="lb lb2"><c:if test="${mustfill.columns.applianceBarcode}"><em class="mark"></em></c:if>内机条码：</label>
							<input type="text" style="width:180px;" class="input-text readonly remarkUpdate" readonly="readonly" id="applianceBarcode" name="applianceBarcode" value="${order.applianceBarcode}" title="${order.applianceBarcode}"/>
							<span class="weishu1" hidden="hidden">
								( <span id="incodeNum">0</span>位 )
							</span>
							<span class="ml-2 code1" hidden="hidden">
								<a href="javascript:showQRCode('${order.siteId }','1');" class="sficon sficon-scancode"></a>
							</span>
							<span class="va-t underline c-fe0101 codeConnectShow cPointer " preData="${order.applianceBarcode}"  id="codeInshow"></span >
						</div>
						
						
					</div>
					<div class="cl mt-10">

						<div class="f-l pos-r txtwrap1">
							<label class="lb" style="width:85px"><c:if test="${mustfill.columns.applianceBuyTime}"><em class="mark"></em></c:if>购买日期：</label>
							<input type="text" onfocus="WdatePicker()" class="input-text w-160 readonly remarkUpdate" readonly="readonly" id="applianceBuyTime" name="applianceBuyTime" value="<fmt:formatDate value='${order.applianceBuyTime }' pattern='yyyy-MM-dd'/>"/>
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
											<c:if test="${mall.columns.mall_name eq order.pleaseReferMall}"><c:set var="hadMall" value="1"></c:set></c:if>
											<option value="${mall.columns.mall_name } " ${order.pleaseReferMall eq mall.columns.mall_name ?'selected':''}>${mall.columns.mall_name }</option>
										</c:forEach>
                                        <c:if test="${hadMall eq '0' and not empty order.pleaseReferMall}"><option value="${order.pleaseReferMall}" selected>${order.pleaseReferMall}</option></c:if>
									</select>
								</span>
								</c:when>
								<c:otherwise>
									<label class="lb w-100"><c:if test="${mustfill.columns.pleaseReferMall}"><em class="mark">*</em></c:if>购机商场：</label>
									<input type="text" value="${order.pleaseReferMall}" name="pleaseReferMall" class="input-text w-120 ${mustfill.columns.pleaseReferMall?'mustfill':''} readonly" readonly="readonly" <c:if test="${mustfill.columns.pleaseReferMall}">datatype="*" nullmsg="请输入购机商场"</c:if>>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="f-l pos-r txtwrap2 wrapss">
							<label class="lb lb2"><c:if test="${mustfill.columns.applianceMachineCode}"><em class="mark"></em></c:if>外机条码：</label>
							<input type="text" style="width:180px;" class="input-text readonly remarkUpdate" readonly="readonly" id="applianceMachineCode" name="applianceMachineCode" value="${order.applianceMachineCode}" title="${order.applianceMachineCode}"/>
							<span class="ml-2 mr-2 weishu2" hidden="hidden">
								( <span id="outcodeNum">0</span>位 )
							</span>
							<span class="ml-2 mr-2 code2"  hidden="hidden">
								<a href="javascript:showQRCode('${order.siteId }','2');" class="sficon sficon-scancode"></a>
							</span>
							<span class="va-t underline c-fe0101 codeConnectShow cPointer" preData="${order.applianceMachineCode}"  id="codeOutshow"></span>
						</div>
						
					</div>
					
					<div class="cl mt-10 mb-10">
						<div class="f-l">
							<label class="w-85 f-l" style="width:85px;"><c:if test="${mustfill.columns.warrantyType}"><em class="mark"></em></c:if>保修类型：</label>
							<select class="select w-160 readonly remarkUpdate" name="warrantyType"  disabled="disabled" id="warrantyType">
								<option value="">请选择</option>
								<c:if test="${order.warrantyType eq 1 }">
									<option value="1" selected = "selected">保内</option>
									<option value="2">保外</option>
								</c:if>
								<c:if test="${order.warrantyType eq 2 }">
									<option value="1">保内</option>
									<option value="2" selected = "selected">保外</option>
								</c:if>
								<c:if test="${order.warrantyType eq 3 }">
									<option value="1">保内</option>
									<option value="2">保外</option>
								</c:if>
								<c:if test="${order.warrantyType ne 1 && order.warrantyType ne 2 && order.warrantyType ne 3}">
									<option value="1">保内</option>
									<option value="2">保外</option>
								</c:if>
							</select>
						</div>

						<div class="f-l pos-r pl-100">
							<label class="w-100 pos"><c:if test="${mustfill.columns.level}"><em class="mark"></em></c:if>重要程度：</label>
							<select class="select w-120 readonly remarkUpdate" name="level" id="level"  disabled="disabled">
								<option value="">请选择</option>
								<c:if test="${order.level eq 1}">
									<option value="1" selected ="selected">紧急</option>
									<option value="2">一般</option>
								</c:if>
								<c:if test="${order.level eq 2}">
									<option value="1">紧急</option>
									<option value="2" selected ="selected">一般</option>
								</c:if>
								<c:if test="${order.level ne 1 && order.level ne 2}">
									<option value="1">紧急</option>
									<option value="2">一般</option>
								</c:if>
							</select>
						</div>
						<div class="f-l">
							<label class="f-l " style="width:88px;">报修时间：</label>
							<input type="text" class="input-text w-130 readonly" readonly="readonly" value="<fmt:formatDate value='${order.repairTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
						</div>
						<div class="f-l pos-r pl-80">
							<label class="pos w-80">登记人：</label>
							<input type="text" class="input-text w-130 readonly" readonly="readonly" value="${order.xm}"/>
						</div>
					</div>
				</div>
				<div class="tabCon pt-10">
					<div class="processWrap">
						<div id="Imgprocess1">
								<c:forEach items="${repairImgs }" var="str" varStatus="da">
									<div class="f-l imgWrap1" id="img${da.index}">
										<div class="imgWrap"> 
											<img src="${commonStaticImgPath}${str}" id="${commonStaticImgPath}${str}"></img>
										</div>
										<a class="sficon btn-delimg" onclick="deletereImg('img${da.index}')" style="display: none;"></a>
										<input type="hidden" value="${str}" name="bdImgs" >
									</div>
								</c:forEach>
						</div>
						<div class="f-l mr-10">
								<div class="imgWrap jiahao hide" id="jiahao" >
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
					<a href="javascript:showSQMsg();" class="tabswitch">备件申请</a>
					<a href="javascript:showSYMsg();" class="tabswitch">备件使用</a>
					<a href="javascript:showOldFitting();" class="tabswitch">旧件信息</a>
					<a href="javascript:;" class="tabswitch">回访</a>
					<a href="javascript:;" class="tabswitch">结算</a>
					<a href="javascript:showGoodsMsg();" class="tabswitch">商品信息</a>
				</div>
				<div class="tabCon">
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">服务工程师：</label>
							<input type="text" class="input-text w-160 readonly" readonly="readonly"  value="${order.employeName}" title="手机号：${msg2Mobiles}" />
						</div>
						<div class="f-l pos-r pl-100">
							<label class="lb text-r w-100">服务状态：</label>
							<input type="text" class="input-text w-120 readonly" readonly="readonly"  value="${dispStatus}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">故障现象：</label>
							<input type="text" class="input-text w-120 readonly" readonly="readonly"  value="${order.malfunctionType}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">完工时间：</label>
							<input type="text" class="input-text w-130  readonly "   readonly="readonly" name="repairTime" value="<fmt:formatDate value='${order.endTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">收费总额：</label>
							<div class="priceWrap w-140 readonly">
								<input type="text" class="input-text readonly" readonly="readonly"  value="${fns:getOrderTotalFee(order.auxiliaryCost, order.serveCost, order.warrantyCost)}"/>
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pl-10">
							<label class="f-l">（辅材收费：</label>
							<div class="priceWrap w-80 readonly f-l">
								<input type="text" class="input-text readonly" readonly="readonly" value="${order.auxiliaryCost}" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pl-10">
							<label class="f-l">服务收费：</label>
							<div class="priceWrap w-80 readonly f-l">
								<input type="text" class="input-text readonly" readonly="readonly" value="${order.serveCost}" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pl-10">
							<label class="f-l">延保收费：</label>
							<div class="priceWrap w-80 readonly f-l">
								<input type="text" class="input-text readonly" readonly="readonly" value="${order.warrantyCost}" />
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
									<a class="proofImg c-0383dc" id="imgshow">凭证
										<c:forEach items="${collectionslist}" var="col">
											<c:if test="${not empty col.columns.imgs}">
												<img src="${commonStaticImgPath}${col.columns.imgs}"/>
											</c:if>
										</c:forEach>
									</a>
								</div>
									<%--<span><a class="c-0383dc" href="javascript:showPz();">凭证</a></span>--%>
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
						<div class="pos-r txtwrap1 h-50 " id="Imgprocess2">
							<label class="lb lb1">过程图片：
							<c:if test="${feedbackInfo.isbackImg }">
							<a style='color: red;cursor: pointer;text-decoration: underline;' href="${ctx}/download/DownloadOrderFeedbackImg?orderId=${order.id}&siteId=${order.siteId }" target="_blank">（图片下载）</a>
							</c:if>
							</label>
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
						
						<!-- <tr>                                        
							<td>201704082214</td>
							<td>(201375600082)室外主板组件(7分钟不检低压保护)(中央)</td>
							<td>×1</td>
							<td>KFR-120W/S-590 </td>
							<td class="c-fe0101"><i class="sficon state-waitVerify"></i>待审核</td>
							<td>2017-04-26  10:01</td>
						</tr> -->
					</table>
					<div class="cl mt-10 pos-r txtwrap1 showimg">
					</div>
				</div>
				<div class="tabCon">
					<div style="width: 920px;overflow: auto;">
					<table id="pjsy" class="table table-border table-bordered table-bg table-relatedorder">
						<caption>工单关联配件使用</caption>
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
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">交回卡单：</label>
							<input type="text" class="input-text w-160 readonly" readonly="readonly" value="${extendedOrder.translatedReturnCard}"/>
						</div>
						<div class="f-l pos-r pl-100">
							<label class="lb w-100">服务态度：</label>
							<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${extendedCallback.translatedServiceAttitude}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">安全评价：</label>
							<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${extendedCallback.translatedSafeEval}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">多次上门：</label>
							<input type="text" class="input-text w-130 readonly" readonly="readonly" value="${extendedCallback.translatedMultipleDropIn}"/>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">保修类型：</label>
							<input type="text" class="input-text w-160 readonly" readonly="readonly" value="${extendedOrder.translatedWarrantyType}"/>
						</div>
						<div class="f-l pos-r pl-100">
							<label class="lb w-100">是否交款：</label>
							<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${extendedOrder.translatedWhetherCollection}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">交款总额：</label>
							<div class="priceWrap w-120 readonly">
								<input type="text" class="input-text readonly" readonly="readonly" value="${fns:getOrderTotalFee(order.auxiliaryCost, order.serveCost, order.warrantyCost)}"/>
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">回访总额：</label>
							<div class="priceWrap w-130 readonly">
								<input type="text" class="input-text readonly" readonly="readonly" value="${order.callbackCost}"/>
								<span class="unit">元</span>
							</div>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">实收总额：</label>
							<div class="priceWrap w-160 readonly">
								<input type="text" class="input-text readonly" readonly="readonly" value="${order.confirmCost}"/>
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pos-r pl-100">
							<label class="lb w-100">回访结果：</label>
							<input type="text" class="input-text w-120 readonly" readonly="readonly" value="${extendedCallback.translatedResult}"/>
						</div>
					</div>
					<div class="pos-r mt-10 txtwrap1">
						<label class="lb lb1">回访内容：</label>
						<c:if test="${cbInfo.columns.remarks eq null}">
							<textarea class="textarea h-50 readonly" readonly="readonly" style="width:807px"></textarea>
						</c:if>
						<c:if test="${cbInfo.columns.remarks ne null}">
							<textarea class="textarea h-50 readonly" readonly="readonly" style="width:807px"><fmt:formatDate value='${cbInfo.columns.create_time}' pattern='yyyy-MM-dd HH:mm:ss'/>  ${userLogna} : ${cbInfo.columns.remarks}</textarea>
						</c:if>
					</div>
				</div>
				<div class="tabCon " id="settlementDetail">
					
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
				<c:if test="${'7' ne order.orderType}">
				<sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_FINISHORDER_ALLEDIT_BTN" html='<input class="sfbtn sfbtn-opt sbtn caozuo" type="button" value="修改工单" onclick="updateHistory(\'${order.id}\')" />'></sfTags:pagePermission>
				</c:if>
				<input class="sfbtn sfbtn-opt sbtn goback hide" type="button" value="取消" onclick="goback()" />
				<!-- <input class="sfbtn sfbtn-opt sbtn other" value="打印工单" onclick="dygd('${order.id}')" target="_blank"  /> -->
				<input class="sfbtn sfbtn-opt sbtn other" id="repeatOrder"  type="button"  value="打印工单" onclick="dygd('${order.id}')" />
				<input class="sfbtn sfbtn-opt sbtn" id="repeatOrder_custom" type="button" onclick="dygdcustom('${order.id}')" value="打印工单" style="display: none;"/>
				<c:if test="${newOrder!='2'}">
					<sfTags:pagePermission authFlag="ORDER_ADDNEWORDER_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt sbtn" value="新建工单" type="button" onclick="newOrder(\'${order.id}\')"/>'></sfTags:pagePermission>
				</c:if>
				<c:if test="${order.canSettlement}">
					<c:if test="${not hasSettlement}">
						<%-- <c:if test="${jsSetRd eq null }"> --%>
						<sfTags:pagePermission authFlag="ORDER_RESETTLEMENT_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt other" value="结算" type="button" id="btn-addJs" mark="0"/>'></sfTags:pagePermission>
						<%-- </c:if>
						<c:if test="${jsSetRd ne null }">
							<c:choose>
								<c:when test="${jsSetRd.columns.set_value eq '0' || jsSetRd.columns.set_value eq '2'}"> 
									<c:if test="${cbInfo.columns.result eq '1'  }">
										<sfTags:pagePermission authFlag="ORDER_RESETTLEMENT_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt other" value="结算" type="button" id="btn-addJs"/>'></sfTags:pagePermission>
									</c:if>
								</c:when>
								<c:otherwise>
									<sfTags:pagePermission authFlag="ORDER_RESETTLEMENT_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt other" value="结算" type="button" id="btn-addJs"/>'></sfTags:pagePermission>
								</c:otherwise>
							</c:choose>
						</c:if> --%>
					</c:if>
					<c:if test="${hasSettlement}">
						<%-- <c:if test="${jsSetRd eq null }"> --%>
						<sfTags:pagePermission authFlag="ORDER_RESETTLEMENT_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt other" value="重新结算" type="button" mark="1" id="btn-addJs"/>'></sfTags:pagePermission>
						<%-- </c:if>
						<c:if test="${jsSetRd ne null }">
							<c:choose>
								<c:when test="${jsSetRd.columns.set_value eq '0' || jsSetRd.columns.set_value eq '2'}"> 
									<c:if test="${cbInfo.columns.result eq '1'  }">
										<sfTags:pagePermission authFlag="ORDER_RESETTLEMENT_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt other" value="重新结算" type="button" id="btn-addJs"/>'></sfTags:pagePermission>
									</c:if>
								</c:when>
								<c:otherwise>
									<sfTags:pagePermission authFlag="ORDER_RESETTLEMENT_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt other" value="重新结算" type="button" id="btn-addJs"/>'></sfTags:pagePermission>
								</c:otherwise>
							</c:choose>
						</c:if> --%>
					</c:if>
				</c:if>
				<c:if test="${extendedOrder.translatedReturnCard eq 'null' || extendedOrder.translatedReturnCard eq ''}">
					<c:if test="${order.canVisit}">
						<input class="sfbtn sfbtn-opt sbtn other" value="回访" type="button" onclick="showCallbackForm()" id="callbackBtn"/>
					</c:if>
				</c:if>
				<c:if test="${wxgd}">
					<%-- <sfTags:pagePermission authFlag="ORDERMGM_HISTORYORDER_WXORDER_REDISPATCH_BTN" html='<input class="sfbtn sfbtn-opt" value="重新派工" type="button" onclick="directDis();"/>'></sfTags:pagePermission> --%>
					<sfTags:pagePermission authFlag="ORDER_REDISPORDER_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt other" value="重新派工" type="button" onclick="directDis();"/>'></sfTags:pagePermission>
				</c:if>
				<sfTags:pagePermission authFlag="ORDER_MARKORDER_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt other" value="标记工单" type="button" onclick="showMarkOrder(\'${order.id}\')"/>'></sfTags:pagePermission>
				<c:if test="${whereMark eq 1 }">
					<div class="btnWrap text-c" style="bottom:0">
						<a class="sfbtn sfbtn-opt3 sbtn " onclick="previousOrder('${order.id}','${order.number }')">上一单</a>
						<a class="sfbtn sfbtn-opt3 sbtn" onclick="nextOrder('${order.id}','${order.number }')" >下一单</a>
					</div>
				</c:if>
			</div>
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
			<div class="f-r mapWrap" id="dispatch_map_container">

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



<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/city.union.js"></script>
<script type="text/javascript">
	var formPosted = false;
    var pageMode = "detail"; // 表明当前是编辑(edit)还是详情(detail)
    var lastQueriedCodeIn = null;
    var lastQueriedCodeOut = null;
    var dispatchMap,dispatchMarker,employeMarker;
    var ctx='${ctx}';

	$("#closDivPoup").on("click",function(){
		parent.search();
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
	});
    $('#imgshow').imgShow();
	$(function(){
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
	codeNumberCounts();
		
		
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

		$('#reason').on('change',function(){
			var index = $(this).val();
			if(index == '扣款'){
				$('#minusWrap').addClass('minusWrap');
				$('#minusWrap').find('.prefix').show();
			}else{
				$('#minusWrap').removeClass('minusWrap');
				$('#minusWrap').find('.prefix').hide();
			}
		});

		$("#samount").blur(function () {
			var samount = $.trim($("#samount").val());
			if (samount < 0) {
				layer.msg("请输入正确格式的结算金额");
				return false;
			}
			if (!(/^[1-9]\d*(\.\d{1,2})?$/).test(samount) || !(/^[1-9]\d*(\.\d{1,2})?$/).test(samount)) {
				layer.msg("结算金额要求大于零且最多包含两位小数");
				return false;
			}
		});
		
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
		
		   judgedygd();
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
	});
	
	
	var repairImgsCount = '${repairImgsCount}';
	$(function(){
		createUploader("#repairImgsPicker-add","#Imgprocess1","file_fake_addimg","file_fake_add","delpickerImg");
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
			   if(parseInt(repairImgsCount) <=4 ){
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
		if(repairImgsCount<=4){
			$("#jiahao").removeClass('hide');
		}
		return ;
	} 
	function img(id,src,file,site){
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


	function deletereImg(ff) {
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
		createUploader("#repairImgsPicker-add", "#Imgprocess1", "file_fake_addimg","file_fake_add", "delpickerImg");
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
	
	//显示重新结算
	function saveSettlementup(){
		$(".feyon").show();
		$(".jiesuan").hide();
		$("#seltment_form").show();
		$("#seltment_form_up").hide();
		 
	}
	
	$('#btn_showImg').on('click', function(){
		$('#wxImgList img').eq(0).click();
	});

	function updateCallbackBtn() {
	}
	function closeCallbackForm() {
        layer.close(openedCallbackFormIndex);
		window.location.reload(true);
	}
	
	function showCallbackForm() {
		openedCallbackFormIndex = layer.open({
			type: 2,
			content: '${ctx}/order/orderCallback/new?id=${order.id}&espesially='+"fromHistory",
			title: false,
			area: ['100%', '100%'],
			closeBtn: 0,
			shade: 0,
			fadeIn: 0,
			anim: -1
		});
	}
	
	function saveCallback(){
		var postData = $("#callback_form").serializeJson();
		$.post('${ctx}/order/orderCallback/saveCallback', postData, function(result){
		});
	}
	
	function newOrder(id){
		window.location.href="${ctx}/order/newFormFormDetail?id="+id;
	
		/* */
	}
	
  	//显示结算
	function showjiesuan(){
 		$(".feyon").hide();
		$(".jiesuan").show();
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
				$("#pjsy").html("<caption>工单关联配件使用</caption>"+
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
                    "</tr>" +
                    "</thead>");
				/* $(".showimg").html("<label class='lb lb1'>备件图片：</label>"); */
				
				if(result.list.length>0){
                    $.each(result.list, function (index, val) {
                        str += "<tr>" +
                            "<td class='w-140'>" + val.columns.fitting_code + "</td>" +
                            "<td class='w-300'>" + val.columns.fitting_name + "</td>" +
                            "<td class='w-120'>" + val.columns.fitting_version + "</td>" +
                            "<td class='w-90'>" + val.columns.site_price + "</td>" +
                            "<td class='w-80'>" + val.columns.employe_price + "</td>" +
                            "<td class='w-70'>" + val.columns.customer_price + "</td>" +
                            "<td class='w-50'>×" + val.columns.used_num + "</td>" +
                            "<td class='w-70'>" + val.columns.collection_money + "</td>";
                            str+="<td class='text-c  w-100'>"+fmtVerificationTypeForOrder(val)+"</td>";
                        if (val.columns.status == "1") {
                            str += "<td class='c-fe0101 w-70'><i class='oState state-verifyPass'></i>待核销</td>";
                        } else if (val.columns.status == "2") {
                            str += "<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>已核销</td>";
                        }else if(val.columns.status=="3"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verify2nopass'></i>已拒绝</td>";
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
			    	location.href="${ctx}/order/History";
			    }
		});
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

	function addNewSettlementItem(orderId) {
	}

	function cancelJs() {
		$.closeDiv($('.addJsBox'));
	}

	$('#btn-addJs').on('click', function(){
//		$('.addJsBox').popup({level:4});
//		$("#addJsForm").get(0).reset();
        var modes = $(this).attr("mark");//结算和重新结算的区分
		showjiesuanForm(modes);
	});

    function showjiesuanForm(modes) {
        $.ajax({
            url: "${ctx}/order/settlement/canSettlement",
            type: 'post',
            data: {
                orderId: '${order.id}',
                markIf:"redirect"
            },
            success: function (data) {
                if ("T" === data) {
                    openedJiesuanFormIndex = layer.open({
                        type: 2,
                        content: '${ctx}/order/settlement/edit?id=${order.id}'+'&mode='+modes+'&markIf=redirect',
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
                } else if ("F" === data) {
                    layer.msg("工单当前工程师信息有误，无法完成结算！");
                } else if ("value0" === data) {
                    layer.msg("请回访后再进行结算！");
                    return;
                } else if ("value1" === data) {
                    layer.msg("工单交款金额和实收金额不一致，请确认一致后再进行结算！");
                    return;
                } else if ("value20" === data) {
                    layer.msg("请回访后再进行结算！");
                    return;
                } else if ("value21" === data) {
                    layer.msg("工单交款金额和实收金额不一致，请确认一致后再进行结算！");
                    return;
                }
            }
        });
    }

	function closeJiesuanForm() {
		layer.close(openedJiesuanFormIndex);
		$("#settlementDetail").load("${ctx}/order/settlement/showHtml?id=${order.id}&v=" + new Date().getTime());
		parent.search();
	}

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

	$(function () {
		var validForm = $('#addJsForm').Validform({
			btnSubmit: "#subBtn",
			tiptype: function (msg, o, cssctl) {
				if (msg) {
					layer.msg(msg);
				}
			},
//			postonce: true,
//			tipSweep: true,
			datatype: {
				"price": /^\d+(\.\d{1,2})?$/
			},
			callback: function (form) {
				if (formPosted) {
					return false;
				}

				var settlementDate = $("#bxdatemax_guishu").val();
				if (!settlementDate) {
					layer.msg("请选择结算归属日期");
					return false;
				}

				var empName = $("#emp").children("option").filter(":selected").text();
				$("#empName").val(empName);
				var reasonVal = $('#reason option:selected') .val();
				if(reasonVal == '扣款') {
					$("#realAmount").val(-1 * $("#samount").val());
				} else {
					$("#realAmount").val($("#samount").val());
				}
				formPosted = true;
				$.ajax({
					url: "${ctx}/order/settlement/addNewSettlementItem",
					data: $(form).serialize(),
					type: 'post',
					success: function () {
						validForm.resetForm();
						$.closeDiv($('.addJsBox'));
						$("#settlementDetail").load("${ctx}/order/settlement/showHtml?id=${order.id}&v=" + new Date().getTime());
					},
					complete: function () {
						formPosted = false;
					}
				});
				return false;
			}
		});
	});

	$("#settlementDetail").load("${ctx}/order/settlement/showHtml?id=${order.id}");
	 $('#Imgprocess2').imgShow();
	 $('#Imgprocess1').imgShow();


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
						$("#repeatOrder").hide();
						$("#repeatOrder_custom").show();
						return
					}else{
						$("#repeatOrder").show();
						$("#repeatOrder_custom").hide();
					}
				
				}

			});
		}
		
	var chongfu = true;
	//历史工单的修改
	var addressReco = "";
	function updateHistory(id){
        var caozuo = $(".caozuo").val();
        if(caozuo == '修改工单'){
            pageMode = 'edit';
            $(".other").addClass("sfbtn-disabled");
            $(".other").prop("disabled","disabled");
            $(".mark").removeClass("hide");
            if(repairImgsCount<4){
				$("#jiahao").removeClass('hide');
				}
				$(".btn-delimg").css('display','block ');

            $("#pro").css({display:"block"});
            $("#cit").css({display:"block"});
            $("#factoryNumber").removeClass("readonly");
			$("#factoryNumber").removeAttr("readonly");
			$("#factoryNumber").removeAttr("disabled");
			$(".mark").text("*");
            $("#are").css({display:"block"});
            $("#telTypeChoose").css({display:"block"});
            $(".reLX1").addClass("hide");
            $(".remarkUpdate").prop("readonly",false);
            $(".remarkUpdate").removeClass("readonly");
            $("select").removeClass("readonly");
        	$("select").prop("disabled",false);
            var str='promiseTime,promiseLimit,customerFeedback,remarks,applianceModel,applianceNum,applianceBarcode,applianceMachineCode,applianceBuyTime,pleaseReferMall,warrantyType,level';
            addMustFill(getJurisdiction(),str);
            $(".mark").text("*");
            
            $(".goback").removeClass("hide");
            $(".caozuo").val("保存");
            $("#customerMobile").addClass("mustfill");
            $("#customerName").addClass("mustfill");
            $("#customerAddress").addClass("mustfill");

            $("#applianceBrand").addClass("mustfill");
			$("#applianceCategory").addClass("mustfill");

            /*$("#customerAddress").css({'width':'480px'});*/

		}else if(caozuo == '保存'){
            pageMode = 'detail';
            if(chongfu){
                chongfu = false;
                var moliereg=/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/;
                var mtel=/^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/;
                //保存操作
                
				var telType = $("#telType").val();
                var customerName = $("#customerName").val();
                var customerMobile = $("#customerMobile").val();
                var customerTelephone = $("#customerTelephone").val();
                var customerTelephone2 = $("#customerTelephone2").val();
                var customerAddress = $("#customerAddress").val();

                var pro = $("#province").val();
                var city = $("#city").val();
                var area = $("#area").val();
               // customerAddress = pro+city+area+customerAddress;
                $("#customerAddress").val(customerAddress);
                addressReco = customerAddress;
                $("#customerAddressRecord").val(addressReco);
                var applianceNum=$("#applianceNum").val();
                
                
                //yz
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
                if(customerName == ''){
                    layer.msg("请输入用户姓名");
                    chongfu = true;
                    return;
                }
                if(customerAddress == ''){
                    layer.msg("请输入用户地址");
                    chongfu = true;
                    return;
                }
				if(customerMobile == ''){
				    layer.msg("请输入联系方式1");
                    chongfu = true;
				    return;
				}
                if(telType == '0' && !moliereg.test(customerMobile)){
                    layer.msg("请输入正确联系方式1");
                    chongfu = true;
                    return;
                }else if(telType == '1' && !mtel.test(customerMobile)){
                    layer.msg("请输入正确联系方式1");
                    chongfu = true;
                    return;
				}
                if(customerTelephone != '' && !mtel.test(customerTelephone)){
                    layer.msg("请输入正确联系方式2");
                    chongfu = true;
                    return;
                }
                if(customerTelephone2 != '' && !mtel.test(customerTelephone2)){
                    layer.msg("请输入正确联系方式3");
                    chongfu = true;
                    return;
                }
                if(pro == '' || city == ''){
                    layer.msg("省市为必填项");
                    chongfu = true;
                    return;
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
                var musNum = "${mustfill.columns.applianceNum }";
                if(musNum !='true'){
                    if(!isBlank(applianceNum)){
                        var te=/^[0-9]{1,4}$/;
                        if(!te.test(applianceNum)){
                            layer.msg("产品数量格式不正确！");
                            return;
                        }
                    }
                }

                $.ajax({
                    url:"${ctx}/order/orderDispatch/updateHistoryUser",
                    data:$("#updateOrder").serialize(),

                    dataType:'text',
					type:"post",
                    success:function(){
                        //chongfu = true;
                        parent.search();
                        window.location.reload();
                        //$(".goback").addClass("hide");
                        //return;
                    }
                });

                $("#pro").css({display:"none"});
                $("#cit").css({display:"none"});
                $("#are").css({display:"none"});
                $("#telTypeChoose").css({display:"none"});
                $(".reLX1").removeClass("hide");
                $(".remarkUpdate").prop("readonly",true);
                $(".remarkUpdate").addClass("readonly").removeClass('mustfill');
                $(".other").removeClass("sfbtn-disabled");
                $(".other").removeAttr("disabled");
                $(".mark").addClass("hide");
                $("#factoryNumber").addClass("readonly");
    			$("#factoryNumber").attr("readonly","readonly");
    			$("#factoryNumber").attr("disabled",true);

                $(".caozuo").val("修改工单");
			}else{
				layer.msg("一项操作正在执行");
                return;
			}
		}
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
	    var jurisdiction=promiseTime+","+promiseLimit+","+customerFeedbackJuris+","+remarks+","+applianceModel+","+applianceNum+","+applianceBarcode+","+applianceMachineCode+","+applianceBuyTime+","+pleaseReferMall+","+warrantyType+","+level;
	    return jurisdiction;
	}
	/*获取参数*/
	function getJurisdisctionValue(){

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

	    var array=new Array();
	    array[0]=promiseTime;
	    array[1]=promiseLimit;
	    array[2]=customerFeedback;
	    array[3]=remarks;
	    array[4]=applianceModel;
	    array[5]=applianceNum;
	    array[6]=applianceBarcode;
	    array[7]=applianceMachineCode;
	    array[8]=applianceBuyTime;
	    array[9]=pleaseReferMall;
	    array[10]=warrantyType;
	    array[11]=level;
		return array;
	}
	
	function goback() {
	    $(".goback").addClass("hide");
        $(".remarkUpdate").prop("readonly",true);
        $(".remarkUpdate").addClass("readonly");
        $("#pro").css({display:"none"});
        $("#cit").css({display:"none"});
        $("#are").css({display:"none"});
        $("#telTypeChoose").css({display:"none"});
        $(".reLX1").removeClass("hide");
        $(".mark").addClass("hide");
        $(".other").removeClass("sfbtn-disabled");
        $(".other").removeAttr("disabled");
        $("#customerAddress").val($("#customerAddressRecord").val());
        $("#customerAddress").removeClass("mustfill");
        $("#customerAddress").removeClass("mustfill");
        $("#customerName").removeClass("mustfill");
        $("#customerMobile").removeClass("mustfill");
        $("#factoryNumber").addClass("readonly");
		$("#factoryNumber").attr("readonly","readonly");
		$("#factoryNumber").attr("disabled",true);
        $(".caozuo").val("修改工单");
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

    function directDis() {
        var number = $.trim($("#number").val());
        $.ajax({
            type:"post",
            url:"${ctx}/order/checkonumber",
            data:{orderNumber:number},
            success:function(data){
//                if(data=="existNumber"){
//                    layer.msg("工单编号已存在！");
//                    return false;
//                }
                $('.activeDispatch').popup({level:2,closeSelfOnly:true}); //显示我要派工弹出框和判断高度
                $.selectCheck2("serverSelected");
                initDispatchMap();
                employe();
            }
        });
    }

    var confirmpai=false;

    function dispa() {
        if (confirmpai) {
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
                    confirmpai = true;
                    $.ajax({
                        url: "${ctx}/order/orderDispatch/wxdRedispatch",
                        type: "POST",
                        data: {
                            id: "${order.id}",
							empId: empId
						},
                        success: function (data) {
                            if(data && "422" === data.code) {
                                window.top.layer.msg("工单编号已存在，无法重新派工。");
							} else {
                                window.top.layer.msg('派单成功');
                            }
                            parent.search();
                            $.closeAllDiv();
                        },
                        complete: function () {
                            confirmpai = false;
                        }
                    });
                },
                fnCancel: function () {
                }
            });
        }
    }

    $('#filterName').keyup(function () {
        $('#zhijiepaidan tr').hide().filter(":contains('" + ($(this).val()) + "')").show();
        if(isBlank($(this).val())){
            $('#zhijiepaidan tr').show();
        }

    }).keyup();//DOM加载完时，绑定事件完成之后立即触发

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
    	});
    	$('#applianceBarcode').bind('input propertychange', function() {  
    		codeCounts1();//条码字数统计
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
    			loadAlreadyCode(1,applianceBarcode);
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
        if (type === 1 && lastQueriedCodeIn === code) {
            return;
        }
        if (type === 2 && lastQueriedCodeOut === code) {
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
        if (type === 1) {
            lastQueriedCodeIn = code;
        } else {
            lastQueriedCodeOut = code;
        }
    	$.ajax({
    		url: "${ctx}/order/getHistoryOrdersCodeOutCountByTelDetail?code=" + $.trim(code)+"&id="+'${order.id}&f=hf',
    		type: 'GET',
    		success: function(data) {
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
//    				 if(count < 1){
//    					 $(".douhao").text("");
//    				 }
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
    		}
    	});
    }
</script>
</body>
</html>
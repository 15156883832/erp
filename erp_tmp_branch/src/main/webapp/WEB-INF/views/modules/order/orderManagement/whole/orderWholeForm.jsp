<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>

<script type="text/javascript" src="${ctxPlugin}/lib/lodop/LodopFuncs.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/base64.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/lodop/printdesign.js"></script>
</head>

<body>
<!-- 回访结算工单-工单详情 -->
<div class="popupBox odWrap orderdetailVb">
	<h2 class="popupHead">
		工单详情
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pos-r" >
			<div class="pcontent">
			<div id="detialWd">
				<div class="tabBarP" style="overflow: visible;">
					<a href="javascript:;" class="tabswitch current">基本信息</a>
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
				
				
				<form id="updateOrder" method="post" action="${ctx}/order/orderDispatch/update">
				<div class="tabCon">
					<div class="cl mb-25 mt-10">
					<input type="hidden" name="id" value="${order.id}">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">工单编号：</label>
							<input type="text" class="input-text w-140 readonly dischange" disabled="disabled" name="number" value="${order.number }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><em class="mark"></em>服务类型：</label>
							<select id="serviceType"  disabled="disabled" name="serviceType" class="select w-110 mustfill">
							<c:forEach items="${fns:getServiceTypeDer(order.serviceType) }" var="serm">
								 <c:if test="${order.serviceType eq serm.columns.name }">  
								 	 <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
								    </c:if> 
								   
								  <c:if test="${order.serviceType ne  serm.columns.name }">  
								   <option value="${serm.columns.name }">${serm.columns.name }</option> 
								    </c:if>
							</c:forEach>
							
							</select>
							<%-- <input type="text" class="input-text w-110 readonly" disabled="disabled" name="serviceType" value="${order.serviceType}"/> --%>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><em class="mark"></em>服务方式：</label>
<%-- 							<input type="text" class="input-text w-110 readonly" disabled="disabled" name="serviceMode" value="${order.serviceMode }" />
 --%>							<select id="serviceMode"  disabled="disabled" name="serviceMode" class="select w-110 mustfill">
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
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">信息来源：</label>
							<select id="origin" name="origin"  disabled="disabled" class="select w-110 mustfill hide">
<c:choose>
							<c:when test="${fn:contains(listoriginlist,order.origin)}">
										
							<option value="">请选择</option>
								<c:forEach items="${listorigin}" var="serm">
								 <c:if test="${order.origin eq serm.columns.name }">  
								 	 <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
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
							<input type="text" id="origin1" class="input-text w-110 readonly" disabled="disabled" value="${order.origin}"/>
						</div>
					</div>
					<div class="line"></div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><em class="mark"></em>用户姓名：</label>
							 <input type="text" id="customerName" class="input-text w-140 readonly" disabled="disabled" name="customerName"  value="${order.customerName }"/>
							<%-- <input type="text" class="input-text w-140"   value="${order.customerName }"/> --%>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">联系方式1：</label>
							<input type="text" id="customerMobile" class="input-text w-110 readonly" disabled="disabled" name="customerMobile" value="${order.customerMobile }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">联系方式2：</label>
							<input type="text" id ="customerTelephone" class="input-text w-110 readonly" disabled="disabled" name="customerTelephone"  value="${order.customerTelephone }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">联系方式3：</label>
							<input type="text" id="customerTelephone2" class="input-text w-110 readonly" disabled="disabled" name="customerTelephone2" value="${order.customerTelephone2 }"/>
						</div>
					</div>
					<div class="cl mt-10 mb-25">
						<div class="pos-r txtwrap1">
							<label class="lb lb1"><em class="mark"></em>详细地址：</label>
							<span class="select-box w-90 " id="showProvince" style="display:none">
							<select class="select" id="province" disabled="disabled">
								<c:forEach items="${fns:getProvinceList() }" var="pro">
								<%-- <c:if test="${pro.columns.ProvinceName eq site.province }">
								<option value="${pro.columns.ProvinceName }" selected="selected">${pro.columns.ProvinceName }</option>
								</c:if>
								<c:if test="${pro.columns.ProvinceName ne site.province }"> --%>
								<option value="${pro.columns.ProvinceName }">${pro.columns.ProvinceName }</option>
								<%-- </c:if> --%>
								</c:forEach>
							</select>
						</span>
						<span class="select-box w-90 " id="showCity"  style="display:none">
							<select class="select" id="city"  disabled="disabled">
								<c:forEach items="${fns:getCityList(site.province) }" var="city">
								<%-- <c:if test="${city.columns.CityName eq site.city }">
								<option value="${city.columns.CityName }" selected="selected">${city.columns.CityName }</option>
								</c:if>
								<c:if test="${city.columns.CityName ne site.city }"> --%>
								<option value="${city.columns.CityName }">${city.columns.CityName }</option>
								<%-- </c:if> --%>
								</c:forEach>
							</select>
						</span>
						<span class="select-box w-90 " id="showArea" style="display:none">
							<select class="select" id="area"  disabled="disabled">
								<c:forEach items="${fns:getDistrictList(site.city) }" var="area">
								<%-- <c:if test="${area.columns.DistrictName eq site.area }">
								<option value="${area.columns.DistrictName }" selected="selected">${area.columns.DistrictName }</option>
								</c:if>
								<c:if test="${area.columns.DistrictName ne site.area }"> --%>
								<option value="${area.columns.DistrictName }">${area.columns.DistrictName }</option>
								<%-- </c:if> --%>
								</c:forEach>
							</select>
						</span>
							<input type="text" class="input-text w-340 readonly" disabled="disabled" id="customerAddress1" name="customerAddress1" value="${order.customerAddress }"/>
							<input type="hidden" id="customerAddress" name="customerAddress" value="${order.customerAddress}"/>
							<input type="hidden" id="lnglat" name="customerLnglat" value="${order.customerLnglat }"/>
						</div>
					</div>
					<div class="line"></div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1" style="width:214px;height:26px">
							<label class="lb lb1"><em class="mark"></em>家电品牌：</label>
					 <select   disabled="disabled"  class="select w-140 mustfill" style="position: absolute;z-index: 1;" class="choose" onmousedown="if(this.options.length>6){this.size=8}" onblur="this.size=0" onchange="this.size=0" name="applianceBrand"  id="applianceBrand" datatype="*" nullmsg="请选择家电品牌！">
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
						</div>
						<div class="f-l pos-r txtwrap2" style="width:199px;height:26px">
							<label class="lb lb2"><em class="mark"></em>家电品类：</label>
							<select class="select w-110 mustfill" style="position: absolute;z-index: 1;" class="choose" onmousedown="if(this.options.length>6){this.size=8}" onblur="this.size=0" onchange="this.size=0" name="applianceCategory" id="applianceCategory" datatype="*" nullmsg="请选择家电品类！"  disabled="disabled">
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
							<%-- <input type="text" class="input-text w-110 readonly" disabled="disabled" name="applianceCategory" value="${order.applianceCategory }"/> --%>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">预约日期：</label>
							<input type="text" onfocus="WdatePicker({minDate: '%y-%M-%d' })" class="input-text w-110 readonly" disabled="disabled" name="promiseTime" value="<fmt:formatDate value='${order.promiseTime }' pattern='yyyy-MM-dd'/>"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">时间要求：</label>
							<select id="promiseLimit" class="select w-110 mustfill" name="promiseLimit"  disabled="disabled">
							<option value="">请选择</option>
								<c:forEach items="${proLimitList}" var="serm">
								 <c:if test="${order.promiseLimit eq serm }">  
								 	 <option value="${serm }" selected="selected" >${serm }</option>
								    </c:if> 
								   
								  <c:if test="${order.promiseLimit ne  serm }">  
								   <option value="${serm }">${serm }</option> 
								    </c:if>
								
								</c:forEach>
							</select>
<%-- 							<input type="text" class="input-text w-110 readonly" disabled="disabled" name="promiseLimit"  value="${order.promiseLimit }"/>
 --%>						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1 h-50">
							<label class="lb lb1"><em class="mark"></em>服务描述：</label>
							<textarea type="text" class="input-text w-340 h-50 readonly" disabled="disabled" id="customerFeedback" name="customerFeedback">${order.customerFeedback}</textarea>
						</div>
						<div class="f-l pos-r txtwrap3 h-50">
							<label class="lb lb3">备注：</label>
							<textarea type="text" class="input-text h-50 w-310 readonly" disabled="disabled" name="remarks" >${order.remarks}</textarea>
						</div>
					</div>
					
					
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">产品型号：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" name="applianceModel" value="${order.applianceModel}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">内机条码：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" name="applianceBarcode" value="${order.applianceBarcode}" title="${order.applianceBarcode}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">外机条码：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" name="applianceMachineCode" value="${order.applianceMachineCode}" title="${order.applianceMachineCode}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">购买日期：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" name="applianceBuyTime" value="<fmt:formatDate value='${order.applianceBuyTime }' pattern='yyyy-MM-dd'/>"/>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">保修类型：</label>
							<%-- <input type="text" class="input-text w-140 readonly" disabled="disabled" name="warrantyType" value="${order.warrantyType}"/> --%>
							<span class="select-box w-140">
								<select class="select  mustfill" name="warrantyType"  disabled="disabled" id="warrantyType">
									<option value="">请选择</option>
									<c:if test="${order.warrantyType eq 1 }">
										<option value="1" selected = "selected">保内</option>
										<option value="2">保外</option>
										<!-- <option value="3">保内转保外</option> -->
									</c:if>
									<c:if test="${order.warrantyType eq 2 }">
										<option value="1">保内</option>
										<option value="2" selected = "selected">保外</option>
										<!-- <option value="3">保内转保外</option> -->
									</c:if>
									<c:if test="${order.warrantyType eq 3 }">
										<option value="1">保内</option>
										<option value="2">保外</option>
										<!-- <option value="3" selected = "selected">保内转保外</option> -->
									</c:if>
									<c:if test="${order.warrantyType ne 1 && order.warrantyType ne 2 && order.warrantyType ne 3}">
										<option value="1">保内</option>
										<option value="2">保外</option>
										<!-- <option value="3">保内转保外</option> -->
									</c:if>
								</select>
							</span>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">重要程度：</label>
							<%-- <input type="text" class="input-text w-110 readonly" disabled="disabled" name="level" value="${order.level}"/> --%>
							<span class="select-box w-110 ">
								<select class="select mustfill" name="level"  disabled="disabled">
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
							</span>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">报修时间：</label>
							<input type="text" class="input-text w-110 readonly dischange" disabled="disabled" name="repairTime" value="<fmt:formatDate value='${order.repairTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">登记人：</label>
							<input type="text" class="input-text w-110 readonly dischange" disabled="disabled" name="messengerName" value="${order.xm}"/>
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
					<a href="javascript:;" class="tabswitch ">配件信息</a>
				</div>
				<div class="tabCon">
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">服务工程师：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled"  value="${order.employeName}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务状态：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${dispStatus}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">故障现象：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${order.malfunctionType}"/>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">收费总额：</label>
							<div class="priceWrap w-140 readonly">
								<input type="text" class="input-text readonly" disabled="disabled"  value="${fns:getOrderTotalFee(order.auxiliaryCost, order.serveCost, order.warrantyCost)}"/>
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pl-10">
							<label class="f-l">（辅材收费：</label>
							<div class="priceWrap w-80 readonly f-l">
								<input type="text" class="input-text readonly" disabled="disabled" value="${order.auxiliaryCost}" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pl-10">
							<label class="f-l">服务收费：</label>
							<div class="priceWrap w-80 readonly f-l">
								<input type="text" class="input-text readonly" disabled="disabled" value="${order.serveCost}" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pl-10">
							<label class="f-l">延保收费：</label>
							<div class="priceWrap w-80 readonly f-l">
								<input type="text" class="input-text readonly" disabled="disabled" value="${order.warrantyCost}" />
								<span class="unit">元</span>
							</div>
						</div>

						<span class="pd-5 f-l">）</span>
						<c:if test="${not empty collectionslist}">
							<c:forEach items="${collectionslist}" var="col">
								<c:set value="${sum + col.columns.payment_amount}" var="sum"/>
								<%--<c:if test="${col.columns.payment_type=='0'}">
									<c:set value="${sum1 + col.columns.payment_amount}" var="sum1"/>
								</c:if>
								<c:if test="${col.columns.payment_type=='1'}">
									<c:set value="${sum2 + col.columns.payment_amount}" var="sum2"/>
								</c:if>--%>
							</c:forEach>
							<div class="f-l lh-26">
								<div> 无现金收款：${sum}元<%--（
									<span>支付宝：${sum1}元</span>
									<span>微信：${sum2}元</span>）--%>
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
							<div class="readonly processWrap2">
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
					<table class="table table-border table-bordered table-bg table-relatedorder">
						<caption>关联工单</caption>
						<thead>
							<tr>
								<th class="w-100">配件条码</th>
								<th class="w-340">配件名称</th>
								<th class="w-50">数量</th>
								<th class="w-120">配件型号</th>
								<th class="w-70">状态</th>
								<th class="w-130">申请时间</th>
							</tr>
						</thead>
						
						<tr>                                        
							<td>201704082214</td>
							<td>(201375600082)室外主板组件(7分钟不检低压保护)(中央)</td>
							<td>×1</td>
							<td>KFR-120W/S-590 </td>
							<td class="c-fe0101"><i class="sficon state-waitVerify"></i> 待审核</td>
							<td>2017-04-26  10:01</td>
						</tr>
					</table>
					<div class="cl mt-10 pos-r txtwrap1">
						<label class="lb lb1">配件图片：</label>
						<div class="f-l mr-10">
							<div class="imgWrap">
								<img src="static/h-ui.admin/images/img1.png"></img>
								<p class="lh-20">04-26 10:12 </p>
							</div>
						</div>
						<div class="f-l mr-10">
							<div class="imgWrap">
								<img src="static/h-ui.admin/images/img1.png"></img>
								<p class="lh-20">04-26 10:12 </p>
							</div>
						</div>
						<div class="f-l mr-10">
							<div class="imgWrap">
								<img src="static/h-ui.admin/images/img1.png"></img>
								<p class="lh-20">04-26 10:12 </p>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div id="fbSettle" class="mt-25">
				<div class="tabBarP">
					<a href="javascript:;" class="tabswitch current">回访</a>
					<a href="javascript:;" class="tabswitch ">结算</a>
				</div>
				
				<div class="tabCon">
					<!-- 待回访表单 -->
					<form id="callback_form">
						<input type="hidden" id="cb_id" name="id" value="${cbInfo.columns.id}">
						<input type="hidden" id="cb_orderId" name="orderId" value="${order.id}">
						<input type="hidden" id="cb_dispatchId" name="dispatchId" value="${dispRd.columns.id}">
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1"><em class="mark">*</em>交回卡单：</label>
								<select class="select w-140 mustfill" name="return_card" id=cb_return_card">
									<option value="1" ${order.returnCard == '1' ? 'selected=\'selected\'' : ''}>是</option>
									<option value="2" ${order.returnCard eq '2' ? 'selected=\'selected\'' : ''}>否</option>
								</select>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2"><em class="mark">*</em>服务态度：</label>
								<select class="select w-110 mustfill" name="serviceAttitude" id="cb_serviceAttitude">
									<option value="1" ${cbInfo.columns.service_attitude eq '1' ? 'selected=\'selected\'' : ''}>十分不满意</option>
									<option value="2" ${cbInfo.columns.service_attitude eq '2' ? 'selected=\'selected\'' : ''}>不满意</option>
									<option value="3" ${cbInfo.columns.service_attitude eq '3' ? 'selected=\'selected\'' : ''}>一般</option>
									<option value="4" ${cbInfo.columns.service_attitude eq '4' ? 'selected=\'selected\'' : ''}>满意</option>
									<option value="5" ${cbInfo.columns.service_attitude eq '5' ? 'selected=\'selected\'' : ''}>十分满意</option>
								</select>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2"><em class="mark">*</em>安全评价：</label>
								<select class="select w-110 mustfill" name="safetyEvaluation" id="cb_safetyEvaluation">
									<option value="1" ${cbInfo.columns.safety_evaluation eq '1' ? 'selected=\'selected\'' : ''}>按安全规范操作</option>
									<option value="2" ${cbInfo.columns.safety_evaluation eq '2' ? 'selected=\'selected\'' : ''}>未出示上岗证</option>
									<option value="3" ${cbInfo.columns.safety_evaluation eq '3' ? 'selected=\'selected\'' : ''}>未穿工作服鞋套</option>
									<option value="4" ${cbInfo.columns.safety_evaluation eq '4' ? 'selected=\'selected\'' : ''}>未清理现场</option>
								</select>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2"><em class="mark">*</em>多次上门：</label>
								<select class="select w-110 mustfill" name="multipleDropin" id="cb_multipleDropin">
									<option value="1" ${cbInfo.columns.multiple_dropin eq '1' ? 'selected=\'selected\'' : ''}>是</option>
									<option value="0" ${cbInfo.columns.multiple_dropin eq '0' ? 'selected=\'selected\'' : ''}>否</option>
								</select>
							</div>
						</div>
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">保修类型：</label>
								<select class="select w-140 mustfill" name="warranty_type" id="cb_warranty_type">
									<option value="1" ${order.warrantyType eq '1' ? 'selected=\'selected\'' : ''}>保内</option>
									<option value="2" ${order.warrantyType eq '2' ? 'selected=\'selected\'' : ''}>保外</option>
									<option value="3" ${order.warrantyType eq '3' ? 'selected=\'selected\'' : ''}>保内转保外</option>
								</select>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2"><em class="mark">*</em>是否交款：</label>
								<select class="select w-110 mustfill" name="whether_collection" id="cb_whether_collection">
									<option value="1" ${order.whetherCollection eq '1' ? 'selected=\'selected\'' : ''}>是</option>
									<option value="2" ${order.whetherCollection eq '2' ? 'selected=\'selected\'' : ''}>否</option>
								</select>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">交款总额：</label>
								<div class="priceWrap w-110">
									<%-- <input type="text" class="input-text" value="${order.confirmCost}" /> --%>
									${fns:getOrderTotalFee(order.auxiliaryCost, order.serveCost, order.warrantyCost)}
									<span class="unit">元</span>
								</div>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">实收总额：</label>
								<div class="priceWrap w-110">
									<input type="text" class="input-text" value="${order.confirmCost}" name="confirm_cost" id="cb_confirm_cost"/>
									<span class="unit">元</span>
								</div>
							</div>
						</div>
						<div class="pos-r mt-10 txtwrap1">
							<label class="lb lb1"><em class="mark">*</em>回访结果：</label>
							<select class="select w-140 mustfill" name="result" id="cb_result">
								<option value="1" ${cbInfo.columns.result eq '1' ? 'selected=\'selected\'' : ''}>已完工</option>
								<option value="2" ${cbInfo.columns.result eq '2' ? 'selected=\'selected\'' : ''}>仍需上门</option>
							</select>
						</div>
						<div class="pos-r mt-10 txtwrap1">
							<label class="lb lb1">回访内容：</label>
							<textarea class="textarea h-50" name="remarks" id="cb_remarks">${cbInfo.columns.remarks }</textarea>
						</div>
						<div class="pos-r txtwrap1 mt-10">
							<input type="button" class="w-70 sfbtn sfbtn-opt3" value="保存" onclick="saveCallback();"/>
						</div>
					</form>
				</div>
				<div class="tabCon">
					<!-- 结算表单 -->
					<form id="seltment_form">
						<input type="hidden" id="st_orderId" name="orderId" value="${order.id}">
						<input type="hidden" id="st_dispatchId" name="dispatchId" value="${dispRd.columns.id}">
						<div class="pos-r txtwrap1 mt-10">
							<label class="lb lb1">服务结算方案：</label>
							<span class="select-box w-140">
								<select class="select" name="serviceMeasures" >
									<option value="1" ${stlment.columns.service_measures eq '1' ? 'selected=\'selected\'' : ''}>方案1</option>
								</select>
							</span>
							<span class="c-0383dc"><i class="sficon sficon-whjsfa"></i>维护结算方案</span>
						</div>
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">服务费结算：</label>
								<div class="priceWrap w-140">
									<input type="text" class="input-text autoCal"  name="serve_cost"/>
									<span class="unit">元</span>
								</div>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">辅材费结算：</label>
								<div class="priceWrap w-110">
									<input type="text" class="input-text autoCal"  name="auxiliary_cost"/>
									<span class="unit">元</span>
								</div>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">延保费结算：</label>
								<div class="priceWrap w-110">
									<input type="text" class="input-text autoCal" name="warranty_cost" />
									<span class="unit">元</span>
								</div>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">其他结算：</label>
								<div class="priceWrap w-110">
									<input type="text" class="input-text autoCal" name="other_cost" />
									<span class="unit">元</span>
								</div>
							</div>
						</div>
						<div class="pos-r txtwrap1 mt-10">
							<label class="lb lb1">结算总额：</label>
							<div class="priceWrap w-140">
								<input type="text" class="input-text"  id="total_cost"/>
								<span class="unit">元</span>
							</div>
						</div>
						<div class="pos-r txtwrap1 mt-10">
							<label class="lb lb1">备注：</label>
							<textarea class="textarea h-50" name="remarks"></textarea>
						</div>
						<div class="pos-r txtwrap1 mt-10">
							<input type="button" class="w-70 sfbtn sfbtn-opt3" value="保存" onclick="saveSettlement();"/>
						</div>
					</form>
				</div>
			</div>
			</div>
			<div class="btnMenubox">
				<c:if test="${'7' ne order.orderType}">
					<sfTags:pagePermission authFlag="ORDER_MODORDER_BTN_OTHERS" html='<input id="xggd" class="sfbtn sfbtn-opt3" value="修改工单" type="button" />'></sfTags:pagePermission>
				</c:if>
				<sf:hasPermission perm="ORDERMGM_STAYVISTORDER_PERM_ZJFD_BTN"><input class="sfbtn sfbtn-opt zjfd" onclick="showzjfd()" value="直接封单" type="button"/></sf:hasPermission>
				<input class="sfbtn sfbtn-opt" value="短信通知" type="button" />
				<a class="sfbtn sfbtn-opt sbtn"  onclick="dygd('${order.id}')">打印工单</a>
				<input class="sfbtn sfbtn-opt" value="新建工单" type="button" onclick="newOrder('${order.id}')"/>
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
		<div class="popupMain " >
			<div class="txtwrap1 pos-r mb-30">
				<label class="lb lb1">直接封单理由：</label>
				<textarea id="reasonofzjfd" class="textarea"></textarea>
			</div>
			<div class="text-c pl-30">
				<input onclick="savezjfd('${order.id}')" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
    $('#imgshow').imgShow();
function dygd(id){
	 
	$.ajax({
		type : 'POST',
		url : "${ctx}/order/printdesign/getOrderKeyName",
		data : {orderId:id},
		datatype:"JSON",
		success : function(data) {
			if(data == null || data.content == null || data.content.length<=0){
				var newTab=window.open('about:blank');
				newTab.location.href="${ctx}/print/order?orderId="+id;
				//使用默认
				//window.open("${ctx}/print/order?orderId="+id);
				return
			}
			prn_Preview(data);
			//console.log(data);
		}

	});
}


$(function(){
	$("#xggd").click(function(){
		$("#origin1").hide();
		$("#origin").removeClass("hide");
		if($(this).val()!="保存"){
			$("input[type='text']").removeClass("readonly");
			$("textarea").removeClass("readonly");
			$("input[type='text']").prop("disabled",false);
			$("textarea").prop("disabled",false);
			
			
			$("#serviceType").addClass("mustfill");
			$("#serviceMode").addClass("mustfill");
			$("#customerName").addClass("mustfill");
			$("#customerMobile").addClass("mustfill");
			$("#customerAddress1").addClass("mustfill");
			$("#applianceBrand").addClass("mustfill");
			$("#applianceCategory").addClass("mustfill");
			$("#customerFeedback").addClass("mustfill");
			
			$(".mark").text("*");
			
			$("#showProvince").css("display","");
			$("#showCity").css("display","");
			$("#showArea").css("display","");
			
			$("select").prop("disabled",false);
		
			$(".dischange").addClass("readonly");
			$(".dischange").prop("disabled",true);
		
			$(this).val("保存");
			$(this).after("<input id='qxgf' class='sfbtn sfbtn-opt' onclick='getoff()'  value='取消' type='button'/>");
			address();
		}else{
			
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
			var moliereg=/^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/;
			var mtel=/^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/;
			if(serviceType==null||serviceType==""){
				layer.msg("服务类型为必填项");
				return;
			}
			if(serviceMode==null||serviceMode==""){
				layer.msg("服务方式为必填项");
				return;
			}
			if(customerName==null||customerName==""){
				layer.msg("用户姓名为必填项");
				return;
			}
		/* 	if((customerMobile==null||customerMobile=="")&&(customerTelephone==null||customerTelephone=="")&&(customerTelephone2==null||customerTelephone2=="")){
				layer.msg("至少输入一个联系方式");
				return;
			} */
			
				if(customerMobile.length>0){
					if(!moliereg.test(customerMobile)){
						layer.msg("请输入正确的联系方式");
						return;
					}
				}else{
					layer.msg("请输入联系方式");
					return;
				}
				if(customerTelephone.length>0){
					if(!mtel.test(customerTelephone)){
						layer.msg("请输入正确的联系方式2");
						return;
					}
					
				}
				if(customerTelephone2.length>0){
					if(!mtel.test(customerTelephone2)){
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
			if(customerFeedback==null||customerFeedback==""){
				layer.msg("服务描述为必填项");
				return;
			}
//			$("#updateOrder").submit();
			$.ajax({
				url: "${ctx}/order/orderDispatch/update",
				type: "post",
				data: $("#updateOrder").serialize(),
				success: function() {
					parent.search();
					$.closeDiv($(".orderdetailVb"));
				}
			});
			return;
		}
		
	});
});

$(function(){
	
	var name="${order.applianceBrand}";
	var strls = "";
	$.ajax({
		url:"${ctx}/order/orderDispatch/changeBrand",
		dataType:'json',
		data:{"name":name},
		async:false,
		success:function(result){
			$.each(result.changecstr,function(index,val){
				if("${order.applianceCategory}"==val){
					strls+="<option value="+val+" selected='selected'>"+val+"</option>";
				}else{
					strls+="<option value="+val+">"+val+"</option>";
				}
			});
			$("#applianceCategory").html();
			$("#applianceCategory").html(strls);
		},
		error:function(){
			return;
		}
		
	});
	
	
});	





	
	$(function(){
		$.Huitab("#detialWd .tabBarP .tabswitch","#detialWd .tabCon","current","click","0");
		$.Huitab("#serveFb .tabBarP .tabswitch","#serveFb .tabCon","current","click","0");
		$.Huitab("#fbSettle .tabBarP .tabswitch","#fbSettle .tabCon","current","click","0");
		
		$('.orderdetailVb').popup({fixedHeight:false});
		
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
		/* 			parent.search();
					parent.numerCheck();
					$.closeDiv($('.showzjfddiv')); 
					$.closeDiv($('.orderdetailVb')); 
					parent.closeBatchForm();	 */
				},
						error:function(){
							alert("系统繁忙!");
							return;
						},
						complete:function(){
							layer.msg("直接封单更新完毕!",{time:2000});
					
							//setTimeout(function(){location.href="${ctx}/order/orderDispatch/form?id="+id;},2000);
							setTimeout(function(){location.href="${ctx}/order/StayVisit";},2000);
							return;
						}
				
			});
		}
		}
	
	function saveCallback(){
		var postData = $("#callback_form").serializeJson();
		$.post('${ctx}/order/orderCallback/saveCallback', postData, function(result){
		});
	}
	function closejisuanform() {
		
	}
	function saveSettlement(){
		var postData = $("#seltment_form").serializeJson();
		$.post('${ctx}/order/orderSettlemnt/saveSettlement', postData, function(result){
		});
	}
	function showzjfd(){
		$('.showzjfddiv').popup({level:2});
	}
	
	function newOrder(id){
		window.location.href="${ctx}/order/newFormFormDetail?id="+id;
	}

	function getoff(){
		$("#origin").addClass("hide");
		$("#origin1").show();
		$("#xggd").val("修改工单");
		$("input[type='text']").prop("disabled",true);
		$("input[type='text']").addClass("readonly");
		$("textarea").prop("disabled",true);
		$("textarea").addClass("readonly");
		$("#qxgf").remove();
		$("#showProvince").css("display","none");
		$("#showCity").css("display","none");
		$("#showArea").css("display","none");
		$("select").prop("disabled",true);
		
        $(".mark").text("");
		
		$("#serviceType").removeClass("mustfill");
		$("#serviceMode").removeClass("mustfill");
		$("#customerName").removeClass("mustfill");
		$("#customerMobile").removeClass("mustfill");
		$("#customerAddress1").removeClass("mustfill");
		$("#applianceBrand").removeClass("mustfill");
		$("#applianceCategory").removeClass("mustfill");
		$("#customerFeedback").removeClass("mustfill");
		
		var addressrecord="";
		var addressspace="";
/* 
				if($("#province").val()!=null){
					addressrecord+=$("#province").val();
					addressspace+=$("#province").val();
				}
				if($("#city").val()!=null){
					addressrecord+=$("#city").val();
					addressspace+=$("#city").val();
				}
				if($("#area").val()!=null){
					addressrecord+=$("#area").val();
					addressspace+=$("#area").val();
				} */
				addressspace+=$("input[name='customerAddress1']").val();
				addressrecord+=$("input[name='customerAddress1']").val();
				$("#customerAddress1").val("${order.customerAddress}");
				$("#customerAddress").val("${order.customerAddress}");
				//$("#customerAddress").val(addressspace);
		return;
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
	 $('#Imgprocess2').imgShow();
</script> 
</body>
</html>
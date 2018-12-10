<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
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
		<a href="javascript:;" class="sficon closePopup" ></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pos-r" >
			<input name="secondSiteId" id="secondSiteId" hidden="hidden" />
			<input type="hidden" name= "orderId" id="orderId" value="${order.id}">
			<div class="pcontent">
			<div id="detialWd">
				<div class="tabBarP" style="overflow: visible;">
					<a href="javascript:;" class="tabswitch current">基本信息</a>
					<a href="javascript:;" class="tabswitch ">过程信息</a>
					<span class="f-r">处理情况：<strong class="c-fe0101">
						${dispStatus}
					</strong></span>
				</div>
				<form id="updateOrder" action="${ctx}/order/orderDispatch/update" method="post">
				<div class="tabCon">
					<div class="cl mb-10 mt-10">
					<input type="hidden" name="id" value="${order.id}">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">工单编号：</label>
							<input type="text" id="orderNumber" class="input-text w-160 readonly dischange" readonly="readonly" name="number" value="${order.number }"/>
						</div>
						<div class="f-l pos-r pl-100">
							<label class="lb w-100"><em class="mark"></em>服务类型：</label>
							<select id="serviceType"  disabled="disabled" name="serviceType" class="select w-120 readonly">
							<c:forEach items="${fns:getServiceTypeWithDefault(order.serviceType) }" var="serm">
								 <c:if test="${order.serviceType eq serm.columns.name }">  
								 	 <option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
								    </c:if> 
								   
								  <c:if test="${order.serviceType ne  serm.columns.name }">  
								   <option value="${serm.columns.name }">${serm.columns.name }</option> 
								    </c:if>
							</c:forEach>
							
							</select>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><em class="mark"></em>服务方式：</label>
							<select id="serviceMode"  disabled="disabled" name="serviceMode" class="select w-120 readonly ">
 								<c:forEach items="${fns:getServiceModeWithDefault(order.serviceMode) }" var="serm">
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
							<select id="origin" name="origin"  disabled="disabled" class="select w-130 readonly hide">
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
						</div>
					</div>
					<div class="line"></div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><em class="mark"></em>用户姓名：</label>
							 <input type="text" id="customerName" class="input-text w-160 readonly" readonly="readonly" name="customerName"  value="${order.customerName }"/>
						     <input type="hidden" class="input-text w-140" id="sign"   value=""/> 
							 <input type="hidden" class="input-text w-140"  id="siteMsgNums" value=""/>
						</div>
						<div class="f-l pos-r pl-100">
							<span class="lb w-100" id="mobileType">
								<label class="lb w-100 text-r">联系方式1：</label>
							</span>
							<input type="text" id="customerMobile" class="input-text w-120 readonly" readonly="readonly" name="customerMobile" value="${order.customerMobile }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">联系方式2：</label>
							<input type="text" id ="customerTelephone" class="input-text w-120 readonly" readonly="readonly" name="customerTelephone"  value="${order.customerTelephone }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">联系方式3：</label>
							<input type="text" id="customerTelephone2" class="input-text w-130 readonly" readonly="readonly" name="customerTelephone2" value="${order.customerTelephone2 }"/>
						</div>
					</div>
					<div class="cl mt-10 mb-10">
						<div class="pos-r txtwrap1" <%--id="pcd"--%>>
							<label class="lb lb1"><em class="mark"></em>详细地址：</label>
						<span class="select-box w-90 " id="showProvince" >
						<select class="prov select" disabled="disabled" id="province" name="province">
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
						<span class="select-box w-90 " id="showCity" >
	                    <select class="city select" id="city" disabled="disabled" name="city">
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
						<span class="select-box w-90 " id="showArea" >
	                    <select class="dist select" id="area" disabled="disabled" name="area">
							<c:if test="${not empty order.area}">
								<c:forEach items="${districts }" var="ds">
											<option value="${ds.columns.DistrictName }"
													<c:if test="${ds.columns.DistrictName==order.area }">selected="selected"</c:if>>${ds.columns.DistrictName }</option>
								</c:forEach>
							</c:if>
									<c:if test="${empty order.area && not empty site.area}">
										<c:forEach items="${districts }" var="ds">
											<option value="${ds.columns.DistrictName }"
													<c:if test="${ds.columns.DistrictName==site.area }">selected="selected"</c:if>>${ds.columns.DistrictName }</option>
										</c:forEach>
									</c:if>
						</select>
						</span>
							<input type="text"  class="input-text w-280 readonly" readonly="readonly" id="customerAddress1" name="customerAddress1" value="<c:out value='${order.customerAddress}'/>"/>
							<input type="hidden" id="customerAddress" name="customerAddress" value="<c:out value='${order.customerAddress}'/>"/>
							<input type="hidden" id="lnglat" name="customerLnglat" value="${order.customerLnglat }"/>
						</div>
					</div>
					<div class="line"></div>
					<div class="cl mt-10" id="styleMArk">
						<div class="f-l pos-r txtwrap1" style="height:26px">
							<label class="lb lb1"><em class="mark"></em>家电品牌：</label>
					 		<select  disabled="disabled"  class="select w-160 readonly " name="applianceBrand" id="applianceBrand" datatype="*" nullmsg="请选择品类！">
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
						<div class="f-l pos-r pl-100" style="height:26px">
							<label class="lb text-r w-100"><em class="mark"></em>家电品类：</label>
							<select class="select w-120 readonly" name="applianceCategory" id="applianceCategory" datatype="*" nullmsg="请选择品类！"  disabled="disabled">
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
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">预约日期：</label>
							<input type="text" onfocus="WdatePicker({minDate: '%y-%M-%d' })" class="input-text Wdate w-120 readonly ptime" disabled="disabled" name="promiseTime" id="promiseTime" value="<fmt:formatDate value='${order.promiseTime }' pattern='yyyy-MM-dd'/>"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">时间要求：</label>
							<select id="promiseLimit" class="select w-130 readonly " name="promiseLimit"  disabled="disabled">
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
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1 h-50">
							<label class="lb lb1"><em class="mark"></em>服务描述：</label>
							<textarea type="text" class="input-text w-380 h-50 readonly" readonly="readonly" id="customerFeedback" name="customerFeedback">${order.customerFeedback}</textarea>
						</div>
						<div class="f-l pos-r txtwrap2 h-50">
							<label class="lb lb2">备注：</label>
							<textarea type="text" class="input-text h-50 w-340 readonly" readonly="readonly" id="remark" name="remarks" >${order.remarks}</textarea>
						</div>
					</div>
					
					
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">产品型号：</label>
							<input type="text" class="input-text w-160 readonly" readonly="readonly" name="applianceModel" value="${order.applianceModel}"/>
						</div>
						<div class="f-l pos-r pl-100">
							<label class="lb w-100 text-r">产品数量：</label>
							<input type="text" class="input-text w-120 readonly" readonly="readonly" name="applianceNum" value="${order.applianceNum }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">内机条码：</label>
							<input type="text" class="input-text w-120 readonly" maxlength="100" readonly="readonly" name="applianceBarcode" value="${order.applianceBarcode}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">外机条码：</label>
							<input type="text" class="input-text w-130 readonly" readonly="readonly" name="applianceMachineCode" value="${order.applianceMachineCode}"/>
						</div>
						
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">购买日期：</label>
							<input type="text" onfocus="WdatePicker({maxDate: '%y-%M-%d' })" class="input-text w-160 readonly ptime" disabled="disabled" name="applianceBuyTime" value="<fmt:formatDate value='${order.applianceBuyTime }' pattern='yyyy-MM-dd'/>"/>
						</div>
						<div class="f-l pos-r pl-100">
							<label class="lb w-100 text-r">购机商场：</label>
							<input type="text" name="pleaseReferMall" class="input-text w-120 readonly" readonly="readonly" value="${order.pleaseReferMall}">
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">保修类型：</label>
							<span class="select-box w-120">
								<select class="select readonly" name="warrantyType"  disabled="disabled" id="warrantyType">
									<option value="">请选择</option>
									<c:if test="${order.warrantyType eq '1' }">
										<option value="1" selected = "selected">保内</option>
										<option value="2">保外</option>
									</c:if>
									<c:if test="${order.warrantyType eq '2' }">
										<option value="1">保内</option>
										<option value="2" selected = "selected">保外</option>
									</c:if>
									<c:if test="${order.warrantyType ne '1' && order.warrantyType ne '2'}">
										<option value="1">保内</option>
										<option value="2">保外</option>
									</c:if>
								</select>
							</span>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">重要程度：</label>
							<span>
							<select class="select w-130 readonly" name="level"  disabled="disabled">
								<option value="">请选择</option>
								<c:choose>
									<c:when test="${order.level eq '1'}">
										<option value="1" selected ="selected">紧急</option>
										<option value="2">一般</option>
									</c:when>
									<c:when test="${order.level eq '2'}">
										<option value="1">紧急</option>
										<option value="2" selected ="selected">一般</option>
									</c:when>
									<c:otherwise>
										<option value="1">紧急</option>
										<option value="2">一般</option>
									</c:otherwise>
								</c:choose>
							</select>
							</span>
						</div>

					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">报修时间：</label>
							<input type="text" class="input-text w-160 readonly dischange" readonly="readonly" name="repairTime" value="<fmt:formatDate value='${order.repairTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
						</div>
						<div class="f-l pos-r pl-100">
							<label class="lb w-100 text-r">登记人：</label>
							<input type="text" class="input-text w-120 readonly dischange" readonly="readonly" name="messengerName" value="${order.messengerName}"/>
						</div>
					</div>
				</div>
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
			</form>
			</div>
			<div class="btnMenubox pb-80">
				<c:if test="${'7' ne order.orderType}">
					<sfTags:pagePermission authFlag="ORDER_MODORDER_BTN_OTHERS" html='<input id="xggd" class="sfbtn sfbtn-opt" value="修改工单" type="button" />'></sfTags:pagePermission>
				</c:if>
			
				<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_DISPATCHZHUANPAISECONDORDER_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="反馈封单" type="button" onclick="directDisZp()"/>'></sfTags:pagePermission>

				<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_ZHIJIEFENGDANSECONDORDER_BTN" html='<input class="sfbtn sfbtn-opt sbtn" value="取消工单" type="button" onclick="zjfd(\'${order.id}\')"/>'></sfTags:pagePermission>
			</div>
		</div>
		
	</div>
	
</div>
</div>

<div class="popupBox notDispatch showzjfddiv">
	<h2 class="popupHead">
		取消工单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain " >
			<div class="txtwrap1 pos-r mb-30">
				<label class="lb lb1"><em class="mark">*</em>取消工单理由：</label>
				<textarea id="reasonofzjfd" class="textarea"></textarea>
			</div>
			<div class="text-c pl-30">
				<input onclick="savezjfd()" type="button" class="mr-10 w-70 sfbtn sfbtn-opt3" value="确认" />
				<input type="button" onclick="cancerBox()" class="mr-10 w-70 sfbtn sfbtn-opt" value="取消" />
			</div>
		</div>
	</div>
</div>




<div id="map-container" style="display: none;">
			
</div>		
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=727b25e7366ab5015225754e8ee00fef"></script>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/city.union.js"></script>

<script type="text/javascript">

var ctx='${ctx}';
var definedContentTz="";
var addressRecord="";
var orderMsgId="";
var orderMsgMobile="";
var marker;
var mark;

$(function(){
	$('#wxImgList').imgShow();
	orderMsgId='${order.id}';
	
	var addr="<c:out value='${order.customerAddress}'/>";
	if(isBlank(addr)){
		getDefaultAddress();
	}else if(addr.indexOf("区") <= 0 && addr.indexOf("县") <=0 && addr.indexOf("市")<=0){
		getDefaultAddress();
	}else{
		$("#pcd").citySelect({
			url:'${ctxPlugin}/lib/city.min.js',
  	  	    address:"<c:out value='${order.customerAddress}'/>"
  		});
	}
	
	$('#filterName').keyup(function(){
		$('#zhijiepaidan tr').hide()     
		.filter(":contains('" +($(this).val()) + "')").show();  
		if(isBlank($(this).val())){
			$('#zhijiepaidan tr').show();
		}
		}).keyup();//DOM加载完时，绑定事件完成之后立即触发
	$('#filterName1').keyup(function(){
		$('#zhijiepaidan1 tr').hide()     
		.filter(":contains('" +($(this).val()) + "')").show();  
		if(isBlank($(this).val())){
			$('#zhijiepaidan1 tr').show();
		}
		}).keyup();//DOM加载完时，绑定事件完成之后立即触发
	$("#origin").select2();
	$(".selection").css("width","130px");
	
	$('#applianceBrand').select2();
	$("#applianceBrand").next(".select2").find(".selection").css("width","160px");
	
	$('#applianceCategory').select2();
	$("#applianceCategory").next(".select2").find(".selection").css("width","120px");
	
    //judgedygd();
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

function addressTwo(str){
	var sz=[];
	var regshi = "市";
	var regqu="区";
	var address = str;

	if(address.indexOf(regqu) >0 && address.indexOf("县")<=0){
		sz=address.split(regqu);
		if(sz.length>2){
			$("#customerAddress1").val(sz[1]+"区"+sz[2]);
		}else if(1<sz.length<=2){
			$("#customerAddress1").val(sz[1]);
		}else{
			$("#customerAddress1").val(sz[0]);
		}
	}else if(address.indexOf("县") >0 ){
		sz=address.split("县");
		if(sz.length>2){
			$("#customerAddress1").val(sz[1]+"县"+sz[2]);
		}else if(1<sz.length<=2){
			$("#customerAddress1").val(sz[1]);
		}else{
			$("#customerAddress1").val(sz[0]);
		}
	}else if(address.indexOf(regqu) <=0 && address.indexOf("县")<=0){
		sz=address.split(regshi);
		$("#customerAddress1").val(sz[1]);
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
		$("#xggd").click(function(){
//			$("#origin1").hide();
			$("#origin").removeClass("hide");
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
			html+='<em class="mark f-r">*</em>'
			$("#mobileType").empty().append(html);

			if($(this).val()!="保存"){
                toggleMirror(false);
				$(".sbtn").prop("disabled", true);
				$("input[type='text']").removeClass("readonly");
				$("textarea").removeClass("readonly");
				$("input[type='text']").prop("readonly",false);
				$("textarea").prop("disabled",false);
				$("#customerFeedback").prop("readonly", false);
				$("#remark").prop("readonly", false);
				$("select").removeClass("readonly");
				$('.ptime').removeClass("readonly");
				$('.ptime').prop("disabled",false);
				
				$("#showProvince").css("display","");
				$("#showCity").css("display","");
				$("#showArea").css("display","");
				
				$("select").prop("disabled",false);
				
				$("#serviceType").addClass("mustfill");
				$("#serviceMode").addClass("mustfill");
				$("#customerName").addClass("mustfill");
				$("#customerMobile").addClass("mustfill");
				$("#customerAddress1").addClass("mustfill");
				$("#applianceBrand").addClass("mustfill");
				$("#applianceCategory").addClass("mustfill");
				$("#styleMArk .select2-selection--single").css({'background-color': '#dbf5fd','border':'1px solid #5ebdfb'});
				$("#customerFeedback").addClass("mustfill");
				
				$(".mark").text("*");
			
				$(".dischange").addClass("readonly");
				$(".dischange").prop("disabled",true);
				$("#customerAddress1").css({'width':'523px'});
				$("#repeteWrite").addClass("sfbtn-disabled");
				$(".btnMenubox").find("input").addClass("sfbtn-disabled");
				$(this).removeClass("sfbtn-disabled");
				$(this).after("<input id='qxgf' class='sfbtn sfbtn-opt' onclick='getoff()'  value='取消' type='button'/>");
				$(this).val("保存");
				
				$("#orderNumber").prop("disabled",false);
				$("#orderNumber").prop("readonly",true);
				
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
				var moliereg=/^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][34578][0-9]{9}$)$/;
				var mtel=/^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/;
				//var tel=/^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][34578][0-9]{9}$)$/;
				//var tel = /^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][345789][0-9]{9}$)|(^(0[0-9]{2,3}?[2-9][0-9]{6,7})?$)$/;
				var tel = /(^1\d{10}$)|(^(\d{3,4}\-)?\d{5,9}$)/;
				//var fdfd = /^(^(0[0-9]{2,3}?[2-9][0-9]{6,7})?$)$/;
				
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
					if(customerTelephone.length>0){
						if(!mtel.test($.trim(customerTelephone))){
							layer.msg("请输入正确的联系方式2");
							return;
						}
						
					}
					if(customerTelephone2.length>0){
						if(!mtel.test($.trim(customerTelephone2))){
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
				
				
				var addressspace="";
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
				addressspace+=$("input[name='customerAddress1']").val();

				$("#customerAddress").val(addressspace);
				$.ajax({
					url: "${ctx}/order/orderDispatch/update",
					type: "post",
					data: $("#updateOrder").serialize(),
					success: function() {
						parent.search();
                        window.location.reload();
					}
				});
				return;
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
	 						//$("#applianceBrand").empty();
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
	 		//}
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

	function saveCallback(){
		var postData = $("#callback_form").serializeJson();
		$.post('${ctx}/order/orderCallback/saveCallback', postData, function(result){
		});
	}
	
	function saveSettlement(){
		var postData = $("#seltment_form").serializeJson();
		$.post('${ctx}/order/orderSettlemnt/saveSettlement', postData, function(result){
		});
	}
	
	function newOrder(id){
		window.location.href="${ctx}/secondOrder/newOrder?oId="+id;
	}

	function isBlank(val) {
		if(val==null || $.trim(val)=='' || val == undefined) {
			return true;
		}
		return false;
	}

function msgInforms(topWin, id){
    var $pFrame = $("#Hui-article-box iframe:visible", topWin.document);
    var frameWin = $pFrame.get(0).contentWindow || $pFrame.get(0);

    if(isBlank(id)){
        frameWin.layer.msg("数据有误！");
        return
    }
    frameWin.layer.open({
        type : 2,
        content:'${ctx}/order/orderDispatch/SMSnotification?id='+id,
        title:false,
        area: ['100%','100%'],
        closeBtn:0,
        shade:0,
        anim:-1
    });
}

function cancelBox(a) {
	$.closeDiv($(".showzbpgdiv"), true);
}

function msgInform(orderId){
	orderMsgId = orderId;
	$.Huitab("#msgWrap .tabBarP .tabswitch","#msgWrap .tabCon","current","click","0");
	$('.msg-input').each(function(){
		inputWidth(this);
	});
	$('.msgText1').popup({level:4, closeSelfOnly: true});
}




function isValid(num){
	if($.trim(num)=='' || num==null || num==undefined || num=='undefined'){
		return '';
	}
	return num;
}


function closeDispatch(){
	$("#secondSiteId").val('');
}



function zjfd(id){
   $('.showzjfddiv').popup({level:2,closeSelfOnly:true});
}

function cancerBox(){
    $.closeDiv($('.showzjfddiv'));
}

var zjfdMark = false;
function savezjfd(){
	if(zjfdMark){
		return;
	}
	var latest_process = $.trim($("#reasonofzjfd").val());
    if(isBlank(latest_process)){
        layer.msg("请输入理由!");
        return;
    }
   	zjfdMark = true;
       $.ajax({
           type:"POST",
           url:"${ctx}/secondOrder/waitDealOrderPlfd",
           data:{
               id:$("#orderId").val(),
               latestProcess:latest_process
           },
           success:function(result){
           	if(result=="200"){
                parent.search();
                parent.numerCheck();
                $.closeAllDiv();
                parent.layer.msg("取消工单成功！");
           	}else{
           		layer.msg("取消工单失败，请检查！");
           	}
           	zjfdMark = false;
           	return;
           },
           error:function(){
               alert("系统繁忙!");
               return;
           }
       });
}
</script> 
</body>
</html>
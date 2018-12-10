<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>

<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/formatStatus.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/dateUtils.js"></script>
<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script> 

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
	</style>
</head>

<body>

<!-- 新建工单 -->
<div class="popupBox addNewOrder">
	<h2 class="popupHead">
		新建工单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pos-r" >
			<form id="neworderForm"  action="" method="post" >
				<input name="secondSiteId" id="secondSiteId" hidden="hidden" />
				<h3 class="modelHead">工单信息</h3>
				<div class="mt-10 cl h-50">	
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
									<option value="${stype.columns.name }" <c:if test="${stype.columns.name==orderCopy.serviceType }" >selected="selected"</c:if> >${stype.columns.name }</option>
								</c:forEach>
							</select>
						
						<p class="errorwran">请选择服务类型</p>
						
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2"><em class="mark">*</em>服务方式：</label>
							<select class="select w-100 mustfill" name="serviceMode" id="serviceMode" datatype="*" errormsg="请选择服务方式" nullmsg="请选择服务方式">
								<option value="">请选择</option>
								<c:forEach items="${fns:getNewServiceMode() }" var="stype">
									<option value="${stype.columns.name }"  <c:if test="${stype.columns.name==orderCopy.serviceMode }" >selected="selected"</c:if>  >${stype.columns.name }</option>
								</c:forEach>
							</select>
						<p class="errorwran">请选择服务方式</p>
					</div>
					<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">信息来源：</label>
							<select class="select w-100" size="1" name="origin" id="origin">
							<option value="">请选择</option>
								<c:forEach items="${listorigin }" var="otype">
								<option value="${otype.columns.name }" <c:if test="${otype.columns.name==orderCopy.origin }" >selected="selected"</c:if> >${otype.columns.name }</option>
								</c:forEach>
						</select>
					</div>
				</div>
				<h3 class="modelHead">用户信息</h3>
				<div class="pt-10 mb-15">
					<div class="cl">
						<div class="f-l pos-r txtwrap1 mb-10">
							<label class="lb lb1"><em class="mark">*</em>用户姓名：</label>
							<input type="text" class="input-text w-140 mustfill" value="${orderCopy.customerName }" name="customerName" id="customerName" datatype="*" errormsg="格式错误" nullmsg="请输入用户姓名！"/>
							<p class="errorwran">请输入用户姓名</p>
							<c:if test="${cusTypecount > 0 }">
							<span class="select-box w-90 ">
		                    <select class="select" id="customerType" name="customerType">
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
								<span class="f-r pr-5">:</span>
								<select class="lb-sel f-r" id="mobileOrtel">
									<option value="1">手机号码</option>
									<option value="2">固定电话</option>
								</select>
								<em class="mark">*</em>
							</span>
							<input type="text" class="input-text w-100 mustfill" name="customerMobile" value="${orderCopy.customerMobile }" id="customerMobile" datatype="tel" errormsg="手机号码格式不正确" nullmsg="请输入手机号码" maxlength="20"/>
							<!-- <div class="ttipWrap hide">
								<div class="ttipbox radius">
									<i class="sficon sficon-note"></i>
									有<span class="va-t">3</span>条历史工单
								</div>
								<span class="bgArrow"></span>
							</div> -->
							<p class="errorwran">请输入联系电话</p>
							</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">其他联系方式：</label>
							<input type="text" class="input-text w-100" name="customerTelephone" value="${orderCopy.customerTelephone }" ignore="ignore" id="customerTelephone" datatype="mtel" errormsg="格式错误" maxlength="20"/>
				
							<p class="errorwran"></p>
						</div>
						<div class="f-l pos-r" style="padding-left: 15px;">
							<!-- <label class="lb lb2">联系方式3：</label> -->
							<input type="text" class="input-text w-100" value="${orderCopy.customerTelephone2 }"  name="customerTelephone2" ignore="ignore" id="customerTelephone2" datatype="mtel" errormsg="格式错误" maxlength="20"/>
							<!-- <div class="ttipWrap hide">
								<div class="ttipbox radius">
									<i class="sficon sficon-note"></i>
									有<span class="va-t">3</span>条历史工单
								</div>
								<span class="bgArrow"></span>
							</div> -->
							<p class="errorwran"></p>
						</div>
					</div>
					<div class="pos-r txtwrap1" <%--id="pcd"--%>>
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
	                    <select class="dist select" id="area"  name="area">
							<c:forEach items="${districts }" var="ds">
								<option value="${ds.columns.DistrictName }" <c:if test="${ds.columns.DistrictName==site.area }">selected="selected"</c:if>>${ds.columns.DistrictName }</option>
							</c:forEach>
						</select>
						</span>
						<input type="text" class="input-text w-260 mustfill" id="customerAddress1" value="${orderCopy.customerAddress }" placeholder="详细地址" datatype="*" errormsg="格式错误" nullmsg="请输入详细地址"/>
						<a class="btn-dw" onclick="curmaskAddr()" id="btn-showaddr"></a>
						<span class="ml-5 c-fe0101 hide" id="distancealert">距离xxx公里</span>
						<%-- display: inline-block --%>
						<input type="hidden" class="input-text w-260 mustfill" value="${orderCopy.customerAddress }" name="customerAddress" id="customerAddress" placeholder="详细地址" datatype="*" errormsg="格式错误" nullmsg="请输入详细地址"/>
						<p class="errorwran">请输入详细地址</p>
						<input type="hidden" id="customerLnglat" value="${orderCopy.customerLnglat }" name="customerLnglat" readonly="true" id="lnglat" />
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
									 <option value="${ba.key }" <c:if test="${ba.key==orderCopy.applianceBrand }" >selected="selected"</c:if>>${ba.value }</option>
								</c:forEach>
								</select>
							<p class="errorwran">请选择家电品牌</p>
						</div>
						<div class="f-l pos-r txtwrap2 " style="width:199px;height:26px">
							<label class="lb lb2"><em class="mark">*</em>家电品类：</label>
								<select class="select w-110  "  style="position: absolute;z-index: 1;" class="choose" onmousedown="if(this.options.length>6){this.size=8}" onblur="this.size=0" onchange="this.size=0"  name="applianceCategory" id="applianceCategory" datatype="*" nullmsg="请选择家电品类！">
										<option value="">请选择</option>				
								<c:forEach items="${category }" var="ca" varStatus="cast">
									 <option value="${ca.columns.name }" <c:if test="${ca.columns.name==orderCopy.applianceCategory }" >selected="selected"</c:if>>${ca.columns.name }</option>
								</c:forEach>
								</select>
							<p class="errorwran">请选择家电品类</p>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">预约日期：</label>
							<input type="text" onfocus="WdatePicker({minDate: '%y-%M-%d' })"  id="promiseTime" name="promiseTime" class="input-text Wdate w-110">
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">时间要求：</label>
								<select class="select w-110" name="promiseLimit" id="promiseLimit">
									<option value="">请选择</option>
								</select>
						</div>
					</div>
					<div class="cl mb-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><em class="mark">*</em>服务描述：</label>
							<textarea class="input-text w-340 h-50 mustfill" ="" name="customerFeedback" id="customerFeedback" datatype="*" nullmsg="请输入服务描述">${orderCopy.customerFeedback }</textarea>
						<p class="errorwran"></p>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">备注：</label>
							<textarea class="input-text h-50 w-310" id="remarks"  name="remarks">${orderCopy.remarks }</textarea>
						</div>
					</div>
					
					<div class="cl mb-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><em class="mark">&nbsp;</em>产品型号：</label>
							<input type="text" class="input-text w-140" value="${orderCopy.applianceModel }" id="applianceModel" name="applianceModel"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">产品数量：</label>
							<input type="text" value="1" class="input-text w-110" value="${orderCopy.applianceNum }" name="applianceNum" id="applianceNum"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">内机条码：</label>
							<input type="text" class="input-text w-110" value="${orderCopy.applianceBarcode }"  name="applianceBarcode" id="applianceBarcode"/>
							<!-- <div class="ttipWrap codeIn hide">
								<div class="ttipbox radius">
									<i class="sficon sficon-note"></i>
									有<span class="va-t">3</span>条历史工单
								</div>
								<span class="bgArrow"></span>
							</div> -->
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">外机条码：</label>
							<input type="text" class="input-text w-110" value="${orderCopy.applianceMachineCode }" name="applianceMachineCode" id="applianceMachineCode"/>
							<!-- <div class="ttipWrap codeOut hide">
								<div class="ttipbox radius">
									<i class="sficon sficon-note"></i>
									有<span class="va-t">3</span>条历史工单
								</div>
								<span class="bgArrow"></span>
							</div> -->
						</div>
					</div>
					<div class="mb-10 cl">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">购买日期：</label>
							<input type="text" onfocus="WdatePicker({maxDate: '%y-%M-%d' })" value="<fmt:formatDate value='${orderCopy.applianceBuyTime }' pattern='yyyy-MM-dd'/>"  id="applianceBuyTime" name="applianceBuyTime" class="input-text Wdate w-140">
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">购机商场：</label>
							<input type="text" name="pleaseReferMall" id="pleaseReferMall" value="${orderCopy.pleaseReferMall }" class="input-text w-110">
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2"><em class="mark">&nbsp;</em>保修类型：</label>
								<select class="select w-110" id="warrantyType" name="warrantyType">
									<option value="">请选择</option>
									<option value="1" <c:if test="${orderCopy.warrantyType=='1' }">selected="selected"</c:if>>保内</option>
									<option value="2" <c:if test="${orderCopy.warrantyType=='2' }">selected="selected"</c:if>>保外</option>
								</select>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">重要程度：</label>
								<select class="select  w-110" id="level" name="level">
									<option value="">请选择</option>
									<option value="1" <c:if test="${orderCopy.level=='1' }">selected="selected"</c:if>>紧急</option>
									<option value="2" <c:if test="${orderCopy.level=='2' }">selected="selected"</c:if>>一般</option>
								</select>
						</div>
					</div>
					<div class="mb-10 cl">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1"><em class="mark">*</em>报修时间：</label>
							<input type="text"  class="input-text  w-140 mustfill" id="repairTime"  nullmsg="请选择报修时间！" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" name="repairTime" value ="<fmt:formatDate value="${order.repairTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" >
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">登记人：</label>
							<input type="text" class="input-text w-110 readonly" name="messengerName" value="${fns:getUserXm() }" readonly="readonly" />
						</div>
					</div>
				</div>
				<input type="hidden" name= "employeId" id="employeId">
			<div class="btnMenubox">
				<input class="sfbtn sfbtn-opt" value="保存" type="submit" id="baocunorder"/>
				<input class="sfbtn sfbtn-opt " value="重置" type="button"  onclick="resetOrderForm()" />
				<sfTags:pagePermission authFlag="SECONDORDER_WAITDEALORDER_ADDNEWSECONDORDER_DISPATCHORDERTOSITE_BTN" html='<input class="sfbtn sfbtn-opt" value="派工至网点" type="button" id="directOrder" onclick="directDis()"/>'></sfTags:pagePermission>
			</div>
			</form>
		</div>
	</div>
</div>


<div class="popupBox w-710 dispatchBox1 activeDispatch" >
	<h2 class="popupHead">
		我要派工
		<a href="javascript:;" class="sficon closePopup" onclick="closeDispatch()"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pd-15" >
			<div class="searchbox mb-10">
				<input type="text" placeholder="请输入二级网点名称、所在地区" id="filterName" class="input-text" />
				<a href="javascript:searchSite();" class="btn-search"><i class="Hui-iconfont Hui-iconfont-search2 f-16"></i></a>
			</div>
			<div class="tableWrap mt-10 " style="max-height: 320px; overflow: auto;">
				<table class="table table-bordered table-border table-bg text-c " >
					<thead>
						<tr>
							<th class="w-170 text-c"><strong class="f-13">所在地区</strong> </th>
							<th class="w-170 text-c"><strong class="f-13">二级网点</strong></th>
							<th class="w-170 text-c"><strong class="f-13">品牌品类</strong></th>
							<th class="w-140 text-c"><strong class="f-13">选择</strong></th>
						</tr>
					</thead>
					<tbody id="zhijiepaidan">
						
					</tbody>
				</table>
			</div>
			<div class="mt-20 pt-10 pb-5 bk-gray bg-e8f2fa">
				<div class="pos-r pl-60 pr-80">
					<label class="pos w-60"><em class="c-fe0101">派工至</em>：</label>
					<p class="lh-30"><span id="disPatchSiteName"></p>
					<input type="button" class="w-70 sfbtn sfbtn-opt3 pos-a" style="right: 10px;top: 0;" onclick="dispa()" value="确认派工" />
				</div>
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

<input type="hidden" name="customerLnglat" readonly="true" id="lnglat" value="" />
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
		
	}).keyup(); //DOM加载完时，绑定事件完成之后立即触发
	// 当预约时间没选择时给出提示
	$("#promiseLimit").focus(function () {
		$("#promiseLimit").empty();
		var html = "";
		if (isBlank($("#promiseTime").val())) {
			layer.msg("请选择预约时间");
			html = '<option value="">请选择</option>';
		} else {
			html = '<option value="">请选择</option>'
					+ '<option value="早上9点之前">早上9点之前</option>'
					+ '<option value="早上11点之前">早上11点之前</option>'
					+ '<option value="下午13点之前">下午13点之前</option>'
					+ '<option value="下午14点之前">下午14点之前</option>'
					+ '<option value="下午16点之前">下午16点之前</option>'
					+ '<option value="下午18点之前">下午18点之前</option>'
					+ '<option value="晚上20点之前">晚上20点之前</option>'
					+ '<option value="晚上22点之前">晚上22点之前</option>';
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
	
});

function resetOrderForm() {
	$("#serviceType").val("");
	$("#serviceMode").val("");
	$("#origin").val("");
	$("#customerName").val("");
	$("#customerMobile").val("");
	$("#customerTelephone").val("");
	$("#customerTelephone2").val("");
	$("#customerAddress").val("");
	$("#customerAddress1").val("");
	$("#pleaseReferMall").val("");
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
	$("#remarks").val("");
	$("#applianceBrand").select2('val', '请选择');
	$("#origin").select2('val', '请选择');
	$("#applianceCategory").select2('val', '请选择');
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
	if (isBlank(number)) {
		layer.msg("请输入工单编号");
	} else if (!num.test(number)) {
		layer.msg("请输入正确的工单编号");
	} else if (isBlank(serviceType)) {
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
	}  else if (isBlank(customerFeedback.replace(/(^\s*)|(\s*$)/g, ""))) {
		layer.msg("请输入服务描述");
	} else {
		$.ajax({
				type:"post",
				url:"${ctx}/order/checkonumber",
				data:{orderNumber:number},
				success:function(data){
					if(data=="existNumber"){
						layer.msg("工单编号已存在！");
						return false;
					}
					initSecondSiteMsg();
					$('.activeDispatch').popup({level:2,closeSelfOnly:true}); //显示我要派工弹出框和判断高度
					/* $.selectCheck2("serverSelected");
					initDispatchMap();
					employe(); */
				}
		});
	} 
}

// 验证手机号
function isPhoneNo(phone) {
	/* var moliereg=/^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][34578][0-9]{9}$)$/;
	var tel= /^(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^0?[1][34578][0-9]{9}$)|(^(0[0-9]{2,3})?([2-9][0-9]{6,7})+([0-9]{1,4})?$)$/;
	var pattern = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$|(^(1[0-9])\d{9}$)/; */
	var tel = /(^1\d{10}$)|(^(\d{3,4}\-)?\d{5,9}$)/;
	return tel.test($.trim(phone));
}







//直接派工中点击派工按钮
var confirmpai=false;
function dispa() {
    if(confirmpai){
        return;
    }
    var sdId = $('.table').find('.radiobox-selected').find("input[name='serverSelected']").val();
    $("#secondSiteId").val(sdId);
    var secondSiteId = $("#secondSiteId").val();
    if(isBlank(secondSiteId)){
    	layer.msg("请选择您要派工的网点");
    	return;
    }
	$('body').popup({
		level: '3',
		type: 2,  // 提示是否进行某种操作
		content: '确认要给网点' + $("#disPatchSiteName").text() + '派工吗？',
		closeSelfOnly: true,
		fnConfirm: function () {
               confirmpai=true;
			$.ajax({
				url: "${ctx}/secondOrder/save",
				type: "POST",
				data: $("#neworderForm").serialize(),
				success: function (data) {
					parent.layer.msg('派工成功！');
					parent.search();
                    $.closeAllDiv();
					/* $("#orderMsgMobile").val(data.mobile);
					$("#orderMsgId").val(data.id);
					saveorder(data); */
				},
				complete: function() {
                       confirmpai = false;
                   }
			});
		}
	});
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
			"num": /^[A-Za-z0-9]{1,20}$/,
			"tel": /(^1\d{10}$)|(^(\d{3,4}\-)?\d{5,9}$)/,
			"mtel": /^([\+][0-9]{1,3}[ \.\-])?([\(]{1}[0-9]{2,6}[\)])?([0-9 \.\-\/]{3,20})((x|ext|extension)[ ]?[0-9]{1,4})?$/
				},
		beforeCheck:function(curform){
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
            var addressspace=$("#customerAddress1").val();
			$("#customerAddress").val(addressspace);
			var repatrtime=$("#repairTime").val();
			if(isBlank(repatrtime)){
				layer.msg("请选择报修时间！");
				return false;
			}
		},
		callback: function (form) {
			$.ajax({
				url: "${ctx}/secondOrder/save",
				type: "POST",
				data: form.serialize(),
				success: function (data) {
					parent.layer.msg('保存成功');
                    parent.search();
                    $.closeAllDiv();
				}
			});
			return false;
		}
	
	});
	
		function isBlank(val) {
			if(val==null || $.trim(val)=='' || val == undefined) {
				return true;
			}
			return false;
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
			if($('#dingweidizhi').val() == ""){
				layer.msg("请输入地址定位");
			}else if(isBlank($("#lnglat").val())) {		
					layer.msg('请定位'); 
			}else{
			   $("#signPoint").val($('#dingweidizhi').val());
			   $("#signPoint").focus();
			   $("#pcd").citySelect({
				  url:'${ctxPlugin}/lib/city.min.js',
	  	  	      address:$('#dingweidizhi').val()
			  });
			  addressTwo($('#dingweidizhi').val());
			 
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

function addressTwo(address) {
    var sz = [];
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
        getDefaultAddress();
    }
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
        },
        error: function () {
            layer.msg("系统繁忙!");
            return;
        },
        complete: function () {
        }
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

function initSecondSiteMsg(){
	$("#filterName").val('');
	var searchName = $("#filterName").val();
	var selectcategory = $("#applianceCategory").val();
	var selectbrand = $("#applianceBrand").val();
	$.ajax({
		type:"post",
		url:"${ctx}/secondOrder/getSecondSiteDetailMsg",
		data:{searchName:searchName,selectcategory:selectcategory,selectbrand:selectbrand},
		success:function(data){
			var appendHtml="";
			var lg = data.length;
			$("#zhijiepaidan").empty();
			if(lg > 0){
				for(var i=0;i<lg;i++){
					var item = data[i].columns;
					appendHtml += '<tr>'
									+ '<td>' +  ((item.province==item.city) ? item.province : (item.province+item.city))  + '</td>'
									+ '<td>' + item.name + '</td>'
									+ '<td>' + item.b_name+item.c_name + '</td>'
									+ '<td><span class="radiobox selectOne"> <input type="radio" name="serverSelected" value="' + item.site_id + '" /><input name="siteName" value="'+item.name+'" /></span></td>'
								+ '</tr>';
				}
			}else{
				layer.msg("无二级网点！");
			}
			$("#secondSiteId").val('');
			$("#disPatchSiteName").text('');
			$("#zhijiepaidan").append(appendHtml);
			
			$('.table').on('click','.radiobox',function(){
				var flag = $(this).hasClass('radiobox-selected');
				$("#disPatchSiteName").text($(this).find("input[name='siteName']").val());
				$("#secondSiteId").val($(this).find("input[name='serverSelected']").val());
				if(!flag){
					$(this).closest('.table').find('.radiobox').removeClass('radiobox-selected');
					$(this).closest('.table').find('.radiobox input').prop({'checked':false});
					$(this).addClass('radiobox-selected');
					$(this).find('input').prop({'checked':true});
				}
			})
		}
	})
}

function closeDispatch(){
	//$.closeDiv($(".activeDispatch"));
	$("#secondSiteId").val('');
}

function addressSplit(str) {
	var sz = [];
	var regsheng = "省";
	var regshi = "市";
	var regqu = "区";
	var address = str;
	var flag = true;
	var province = "";
	var city = "";
	var area = "";

	if (!address) {
		return;
	}

	if (address.indexOf(regqu) > 0 && address.indexOf("县") <= 0) {
		sz = address.split(regqu);
		if (sz.length > 2) {
			$("#customerAddress1").val(sz[1] + "区" + sz[2]);
		} else if (1 < sz.length <= 2) {
			$("#customerAddress1").val(sz[1]);
			$("#customerAddress").val(sz[1]);
		} else {
			$("#customerAddress1").val(sz[0]);
			$("#customerAddress").val(sz[0]);
		}
	} else if (address.indexOf("县") > 0) {
		sz = address.split("县");
		if (sz.length > 2) {
			$("#customerAddress1").val(sz[1] + "县" + sz[2]);
		} else if (1 < sz.length <= 2) {
			$("#customerAddress1").val(sz[1]);
			$("#customerAddress").val(sz[1]);
		} else {
			$("#customerAddress1").val(sz[0]);
			$("#customerAddress").val(sz[0]);
		}
	}
}

function initAddrmap() {
	map = new AMap.Map('map-container', {
		zoom: 10
	});
}

function dingwei() {
	var slnglat;
	var address = $('#customerAddress1').val();
	if (isBlank(address)) {
	} else {
		var addr = $("#province").val() + $("#city").val() + $("#area").val() + address;
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

/* function searchSite(){
	var searchName = $("#filterName").val();
	var selectcategory = $("#applianceCategory").val();
	var selectbrand = $("#applianceBrand").val();
	$.ajax({
		type:"post",
		url:"${ctx}/secondOrder/getSecondSiteDetailMsg",
		data:{searchName:searchName,selectcategory:selectcategory,selectbrand:selectbrand},
		success:function(data){
			$("#secondSiteId").val('');
			var appendHtml="";
			var lg = data.length;
			$("#zhijiepaidan").empty();
			if(lg > 0){
				for(var i=0;i<lg;i++){
					var item = data[i].columns;
					appendHtml += '<tr>'
						+ '<td >' +  ((item.province==item.city) ? item.province : (item.province+item.city))  + '</td>'
						+ '<td>' + item.name + '</td>'
						+ '<td>' + item.b_name+item.c_name + '</td>'
						+ '<td><span class="radiobox selectOne"> <input type="radio" name="serverSelected" value="' + item.site_id + '" /><input name="siteName" value="'+item.name+'" /></span></td>'
					+ '</tr>';
				}
			}else{
				layer.msg("无二级网点！");
			}
			$("#zhijiepaidan").append(appendHtml);
			$('.table').on('click','.radiobox',function(){
				var flag = $(this).hasClass('radiobox-selected');
				$("#disPatchSiteName").text($(this).find("input[name='siteName']").val());
				$("#secondSiteId").val($(this).find("input[name='serverSelected']").val());
				if(!flag){
					$(this).closest('.table').find('.radiobox').removeClass('radiobox-selected');
					$(this).closest('.table').find('.radiobox input').prop({'checked':false});
					$(this).addClass('radiobox-selected');
					$(this).find('input').prop({'checked':true});
				}
			}) 
		}
	})
} */
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
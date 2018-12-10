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
	<script type="text/javascript" src="${ctxPlugin}/lib/jquery.cityselect.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/jquery.rotate.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/orderConnectionGoods.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>


	<script type="text/javascript" src="${ctxPlugin}/lib/lodop/LodopFuncs.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/lodop/base64.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/lodop/printdesign.js"></script>
	<style>
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
<div class="popupBox odWrap orderdetailVb" style="width: 950px;">
	<h2 class="popupHead">
		工单详情
		<a href="#" class="sficon closePopup" id="cloZongDiv"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pos-r pd-15" >
			<div class="">
				<div id="detialWd">
					<div class="tabBarP" >
						<a href="javascript:;" class="tabswitch current">基本信息</a>
						<a href="javascript:;" class="tabswitch ">过程信息</a>
						<span class="f-r">处理情况：<strong class="c-fe0101">${dispStatus}</strong></span>
					</div>
					<%--<form id="updateOrder" method="post" action="${ctx}/order/orderDispatch/update">--%>
					<div class="tabCon">
						<div class="cl mb-10 mt-10">
							<input type="hidden" name="id" value="${order.id}">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">工单编号：</label>
								<input type="text" class="input-text w-160 readonly dischange" readonly="readonly" name="number" value="${order.number }"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb w-100 text-r"><em class="mark"></em>服务类型：</label>
								<select id="serviceType" disabled="disabled" name="serviceType" class="select w-120 readonly">
									<c:forEach items="${fns:getServiceTypeWithDefault(order.serviceType) }" var="serm">
										<c:if test="${order.serviceType eq serm.columns.name }">
											<option value="${serm.columns.name }" selected="selected" >${serm.columns.name }</option>
										</c:if>

										<c:if test="${order.serviceType ne  serm.columns.name }">
											<option value="${serm.columns.name }">${serm.columns.name }</option>
										</c:if>
									</c:forEach>
								</select>
								<input type="text" class="input-text w-120 readonly hide" disabled="disabled" name="serviceType" value="${order.serviceType}"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2"><em class="mark"></em>服务方式：</label>
								<select id="serviceMode"  disabled="disabled" name="serviceMode" class="select w-120 readonly">
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
								<input type="hidden" class="input-text w-160" id="sign"   value=""/>
								<input type="hidden" class="input-text w-160"  id="siteMsgNums" value=""/>
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
						<div class="cl mt-10 mb-10" >
							<div class="pos-r txtwrap1" id="pcd">
								<label class="lb lb1"><em class="mark"></em>详细地址：</label>
								<span class="select-box w-90 mustfill " id="showProvince" style="display:none">
							<select class="prov select" id="province"></select>
							</span>
								<span class="select-box w-90 mustfill" id="showCity" style="display:none">
		                    <select class="city select" id="city" disabled="disabled"></select>
							</span>
								<span class="select-box w-90 mustfill" id="showArea" style="display:none">
		                    <select class="dist select" id="area" disabled="disabled"></select>
							</span>
								<c:if test="${order.province eq order.city }">
									<input type="text" style="width:588px;" class="input-text w-430 readonly" readonly="readonly" id="customerAddress1" name="customerAddress1" value="${order.city }${order.area }${order.customerAddress }"/>
								</c:if>
								<c:if test="${order.province ne order.city }">
									<input type="text" style="width:588px;" class="input-text w-430 readonly" readonly="readonly" id="customerAddress1" name="customerAddress1" value="${order.province }${order.city }${order.area }${order.customerAddress }"/>
								</c:if>
								<input type="hidden" id="customerAddress" name="customerAddress" value="${order.customerAddress}"/>
								<input type="hidden" id="lnglat" name="customerLnglat" value="${order.customerLnglat }"/>
							</div>
						</div>
						<div class="line"></div>
						<div class="cl mt-10" id="styleMark">
							<div class="f-l pos-r txtwrap1">
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
								<input type="text" id="applanceBrandMirror" class="input-text w-160 readonly hide" readonly="readonly" value="${order.applianceBrand }"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb w-100 text-r"><em class="mark"></em>家电品类：</label>
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
								<input id="promiseTime" type="text" onfocus="WdatePicker({minDate: '%y-%M-%d' })" class="input-text w-120 readonly" disabled="disabled" name="promiseTime" value="<fmt:formatDate value='${order.promiseTime }' pattern='yyyy-MM-dd'/>"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">时间要求：</label>
								<select id="promiseLimit" class="select w-130 readonly" name="promiseLimit"  disabled="disabled">
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
								<textarea type="text" class="input-text h-50 w-340 readonly" readonly="readonly" id="remarks" name="remarks" >${order.remarks}</textarea>
							</div>
						</div>


						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">产品型号：</label>
								<input type="text" class="input-text w-160 readonly" readonly="readonly" name="applianceModel" value="${order.applianceModel}"/>
								<input type="text" class="input-text w-160 readonly hide" hidden="hidden" id="count1" disabled="disabled" name="count1" value="${count1 }"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb w-100 text-r">产品数量：</label>
								<input type="text" class="input-text w-120 readonly" readonly="readonly" name="applianceNum" value="${order.applianceNum }"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">内机条码：</label>
								<input type="text" class="input-text w-120 readonly" readonly="readonly" name="applianceBarcode" value="${order.applianceBarcode}"/>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">外机条码：</label>
								<input type="text" class="input-text w-130 readonly" readonly="readonly" name="applianceMachineCode" value="${order.applianceMachineCode}"/>
							</div>
						</div>
						<div class="cl mt-10">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">购买日期：</label>
								<input id="buyDate" type="text" onfocus="WdatePicker({maxDate: '%y-%M-%d' })" class="input-text w-160 readonly" disabled="disabled" name="applianceBuyTime" value="<fmt:formatDate value='${order.applianceBuyTime }' pattern='yyyy-MM-dd'/>"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb w-100 text-r">购机商场：</label>
								<input type="text" name="pleaseReferMall" class="input-text w-120 readonly" readonly="readonly" value="${order.pleaseReferMall}">
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">保修类型：</label>
								<%-- <input type="text" class="input-text w-140 readonly" disabled="disabled" name="warrantyType" value="${order.warrantyType}"/> --%>
								<select class="select  w-120 readonly " name="warrantyType"  disabled="disabled" id="warrantyType">
									<option value="">请选择</option>
									<c:if test="${order.warrantyType eq '1' }">
										<option value="1" selected = "selected">保内</option>
										<option value="2">保外</option>
										<!-- 	<option value="3">保内转保外</option> -->
									</c:if>
									<c:if test="${order.warrantyType eq '2' }">
										<option value="1">保内</option>
										<option value="2" selected = "selected">保外</option>
										<!-- <option value="3">保内转保外</option> -->
									</c:if>
									<%-- 					<c:if test="${order.warrantyType eq 3 }">
                                        <option value="1">保内</option>
                                        <option value="2">保外</option>
                                        <option value="3" selected = "selected">保内转保外</option>
                                    </c:if> --%>
									<c:if test="${order.warrantyType ne '1' && order.warrantyType ne '2'}">
										<option value="1">保内</option>
										<option value="2">保外</option>
										<!-- <option value="3">保内转保外</option> -->
									</c:if>
								</select>
							</div>
							<div class="f-l pos-r txtwrap2">
								<label class="lb lb2">重要程度：</label>
								<select class="select w-130 readonly" name="level" id="level"  disabled="disabled">
									<option value="">请选择</option>
									<option value="1" <c:if test="${order.level eq '1' }">selected="selected"</c:if>>紧急</option>
									<option value="2" <c:if test="${order.level eq '2' }">selected="selected"</c:if>>一般</option>
								</select>
							</div>

						</div>
						<div class="mt-10 cl">
							<div class="f-l pos-r txtwrap1">
								<label class="lb lb1">报修时间：</label>
								<input type="text" class="input-text w-160 readonly dischange" readonly="readonly" name="repairTime" value="<fmt:formatDate value='${order.repairTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
							</div>
							<div class="f-l pos-r pl-100">
								<label class="lb w-100 text-r">登记人：</label>
								<input type="text" class="input-text w-120 readonly dischange" readonly="readonly" name="messengerName" value="${order.xm}"/>
							</div>
						</div>
					</div>
					<%--</form>--%>

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
				</div>
			</div>
		</div>
		<c:if test="${whereMark eq 1 }">

		</c:if>
	</div>
</div>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
    $(function(){
        $.Huitab("#detialWd .tabBarP .tabswitch","#detialWd .tabCon","current","click","0");
        $('.orderdetailVb').popup({fixedHeight:false});
    });

    $("#cloZongDiv").on("click",function(){
        parent.search();
    });

    function isBlank(val) {
        if(val==null || val=='' || val == undefined) {
            return true;
        }
        return false;
    }

</script>
</body>
</html>
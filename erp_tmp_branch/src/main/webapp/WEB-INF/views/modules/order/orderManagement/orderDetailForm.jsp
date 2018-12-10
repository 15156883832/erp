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
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
<style type="text/css">

.spimg1 .webuploader-pick{
	width:134px;
	height:134px;
}
</style>
</head>

<body>
<!-- 回访结算工单-工单详情 -->
<div class="popupBox odWrap orderdetailVb" style="width: 900px;">
	<h2 class="popupHead">
		工单详情
		<a href="javascript:;" class="sficon closePopup" id="closDivPoup"></a>
	</h2>
	<div class="popupContainer">
		<div class="popupMain pos-r" >
			<div class="pcontent" style="padding-right: 30px">
			<div id="detialWd">
				<div class="tabBarP" style="overflow: visible;">
					<a href="javascript:;" class="tabswitch current">基本信息</a>
					<a href="javascript:;" class="tabswitch ">报修图片</a>
					<a href="javascript:;" class="tabswitch ">过程信息</a>
					<c:if test="${count != 0 }">
						<a  class="tooltipLink">
							<i class="sficon sficon-note"></i>已发送<span class="va-t">${count }</span>条短信
						</a>
					</c:if>
				</div>
				<div class="tabCon">
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">工单编号：</label>
							<input type="text" id="orderNumber" class="input-text w-140 readonly" readonly="readonly" value="${order.columns.number }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务类型：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.columns.service_type}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务方式：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.columns.service_mode }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">信息来源：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.columns.origin }"/>
						</div>
					</div>
					<div class="cl mt-10 mb-25">
						<div class="pos-r txtwrap1">
							<label class="lb lb1">厂家工单编号：</label>
							<input type="text" class="input-text w-340 readonly" disabled="disabled" value="${order.columns.factory_number }"/>
						</div>
					</div>
					<div class="line"></div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">用户姓名：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${order.columns.customer_name }"/>
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${order.columns.customer_type }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">联系方式1：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${order.columns.customer_mobile }"/>
						</div>
						<%-- <div class="f-l pos-r txtwrap2">
							<label class="lb lb2">联系方式2：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${order.columns.customer_telephone }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">联系方式3：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.columns.customer_telephone2 }"/>
						</div> --%>
						<div class="f-l pos-r pl-90">
							<label class="lb w-90">其他联系方式：</label>
							<input  type="text" class="input-text w-110 readonly remarkUpdate" disabled="disabled"  value="${order.columns.customer_telephone }"/>
						</div>
						<div class="f-l pos-r " style="padding-left: 15px;">
							<input type="text" class="input-text w-110 readonly remarkUpdate" disabled="disabled"  value="${order.columns.customer_telephone2}"/>
						</div>
					</div>
					<div class="cl mt-10 mb-25">
						<div class="pos-r txtwrap1">
							<label class="lb lb1">详细地址：</label>
							<c:if test="${order.columns.province eq order.columns.city }">
								<input type="text" class="input-text w-340 readonly" disabled="disabled" value="${order.columns.province }${order.columns.area }${order.columns.customer_address }"/>
							</c:if>
							<c:if test="${order.columns.province ne order.columns.city }">
                                <input type="text" class="input-text w-340 readonly" disabled="disabled" value="${order.columns.province }${order.columns.city }${order.columns.area }${order.columns.customer_address }"/>
							</c:if>
						</div>
					</div>
					<div class="line"></div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">家电品牌：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order.columns.appliance_brand}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">家电品类：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.columns.appliance_category }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">预约日期：</label>
							<input type="text" class="input-text w-110 readonly" readonly="readonly" value="<fmt:formatDate value='${order.columns.promise_time }' pattern='yyyy-MM-dd'/>"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">时间要求：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${order.columns.promise_limit }"/>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1 h-50">
							<label class="lb lb1">服务描述：</label>
							<textarea type="text" class="input-text w-340 h-50 readonly" disabled="disabled">${order.columns.customer_feedback}</textarea>
						</div>
						<div class="f-l pos-r txtwrap3 h-50">
							<label class="lb lb3">备注：</label>
							<textarea type="text" class="input-text h-50 w-310 readonly" disabled="disabled" >${order.columns.remarks}</textarea>
						</div>
					</div>


					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">产品型号：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order.columns.appliance_model}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">产品数量：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" name="applianceNum" value="${order.columns.appliance_num }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">内机条码：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.columns.appliance_barcode}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">外机条码：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.columns.appliance_machine_code}"/>
						</div>

					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">购买日期：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="<fmt:formatDate value='${order.columns.appliance_buy_time }' pattern='yyyy-MM-dd'/>"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">保修类型：</label>
							<select class="select w-110 readonly " name="warrantyType"  disabled="disabled" id="warrantyType">
									<option value="">请选择</option>
									<c:if test="${order.columns.warranty_type eq 1 }">
										<option value="1" selected = "selected">保内</option>
										<option value="2">保外</option>
									</c:if>
									<c:if test="${order.columns.warranty_type eq 2 }">
										<option value="1">保内</option>
										<option value="2" selected = "selected">保外</option>
									</c:if>
									<c:if test="${order.columns.warranty_type eq 3 }">
										<option value="1">保内</option>
										<option value="2">保外</option>
									</c:if>
									<c:if test="${order.columns.warranty_type ne 1 && order.columns.warranty_type ne 2 && order.columns.warranty_type ne 3}">
										<option value="1">保内</option>
										<option value="2">保外</option>
									</c:if>
								</select>
						</div>
						<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">重要程度：</label>
						<select class="select w-110 readonly" name="level"  disabled="disabled">
								<option value="">请选择</option>
								<c:if test="${order.columns.level eq 1}">
									<option value="1" selected ="selected">紧急</option>
									<option value="2">一般</option>
								</c:if>
								<c:if test="${order.columns.level eq 2}">
									<option value="1">紧急</option>
									<option value="2" selected ="selected">一般</option>
								</c:if>
								<c:if test="${order.columns.level ne 1 && order.columns.level ne 2}">
									<option value="1">紧急</option>
									<option value="2">一般</option>
								</c:if>
						</select>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">报修时间：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="<fmt:formatDate value='${order.columns.repair_time }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">登记人：</label>
							<%-- <c:choose>
						     <c:when test="${ order400.columns.order_type=='7'}">    <!--如果 --> 
								<input type="text" class="input-text readonly" style="width: 595px;" disabled="disabled" value="家电协会" />
						 	 </c:when>      
						     <c:otherwise>  <!--否则 -->    
								<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order400.columns.create_by }" />
						 	 </c:otherwise> 
							</c:choose> --%>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order.columns.xm}"/>
							
						</div>
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">工单状态：</label>
							<c:choose>
							<c:when test="${order.columns.status eq 0 }"><input type="text" class="input-text w-110 readonly" disabled="disabled" value="待网点接收"/></c:when>
							<c:when test="${order.columns.status eq 1 }"><input type="text" class="input-text w-110 readonly" disabled="disabled" value="待派工"/></c:when>
							<c:when test="${order.columns.status eq 2 }"><input type="text" class="input-text w-110 readonly" disabled="disabled" value="服务中"/></c:when>
							<c:when test="${order.columns.status eq 3 }"><input type="text" class="input-text w-110 readonly" disabled="disabled" value="待回访待结算"/></c:when>
							<c:when test="${order.columns.status eq 4 }"><input type="text" class="input-text w-110 readonly" disabled="disabled" value="已回访待结算"/></c:when>
							<c:when test="${order.columns.status eq 5 }"><input type="text" class="input-text w-110 readonly" disabled="disabled" value="已完成"/></c:when>
							<c:when test="${order.columns.status eq 6 }"><input type="text" class="input-text w-110 readonly" disabled="disabled" value="取消工单"/></c:when>
							<c:when test="${order.columns.status eq 7 }"><input type="text" class="input-text w-110 readonly" disabled="disabled" value="暂不派工"/></c:when>
							<c:when test="${order.columns.status eq 8 }"><input type="text" class="input-text w-110 readonly" disabled="disabled" value="无效工单"/></c:when>
							<c:when test="${order.columns.status eq 9 }"><input type="text" class="input-text w-110 readonly" disabled="disabled" value="尚未指派"/></c:when>
							<c:otherwise>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value=""/>
							</c:otherwise>
							</c:choose>
						
						</div>
						<div class="f-l pos-r txtwrap2">
						<label class="lb lb2">购机商场：</label>
						<input type="text" value="${order.columns.please_refer_mall}" class="input-text w-110 readonly "   readonly="readonly" >
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">完工时间：</label>
							<input type="text" class="input-text w-110  readonly "   readonly="readonly" value="<fmt:formatDate value='${order.columns.end_time }' pattern='yyyy-MM-dd HH:mm'/>"/>
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
						
					</div>
				</div>
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
					<a href="javascript:showSYMsg();" class="tabswitch">配件使用</a>
					<a href="javascript:showSQMsg();" class="tabswitch">配件申请</a>
					<a href="javascript:showOldFitting();" class="tabswitch">旧件信息</a>
					<c:if test="${extendedCallback != null}">
						<a href="javascript:;" class="tabswitch">回访</a>
					</c:if>
					<c:if test="${hasSettlement}">
						<a href="javascript:showJsDetail();" class="tabswitch">结算</a>
					</c:if>
				</div>
				<div class="tabCon">
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">服务工程师：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled"  value="${order.columns.employe_name}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务状态：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${dispStatus}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">故障现象：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${order.columns.malfunction_type}"/>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">收费总额：</label>
							<div class="priceWrap w-140 readonly">
								<input type="text" class="input-text readonly" disabled="disabled"  value="${fns:getOrderTotalFee(order.columns.auxiliary_cost, order.columns.serve_cost, order.columns.warranty_cost)}"/>
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">辅材收费：</label>
							<div class="priceWrap w-110 readonly">
								<input type="text" class="input-text readonly" disabled="disabled" value="${order.columns.auxiliary_cost}" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务收费：</label>
							<div class="priceWrap w-110 readonly">
								<input type="text" class="input-text readonly" disabled="disabled" value="${order.columns.serve_cost}" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">延保收费：</label>
							<div class="priceWrap w-110 readonly">
								<input type="text" class="input-text readonly" disabled="disabled" value="${order.columns.warranty_cost}" />
								<span class="unit">元</span>
							</div>
						</div>
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
						<div class="pos-r txtwrap1 h-50 " id="Imgprocess2">
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
					<div style="width: 820px;overflow: auto;">
					<table id="pjsy" class="table table-border table-bordered table-bg table-relatedorder">
						<caption>工单关联配件使用</caption>
						<thead>
							<tr>
								<th class="w-180">备件条码</th>
								<th class="w-260">备件名称</th>
								<th class="w-120">备件型号</th>
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
					<div class="cl mt-10 pos-r txtwrap1 showimg">
					</div>
				</div>
				<div class="tabCon">
					<div >
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
				<c:if test="${extendedCallback != null}">
				<div class="tabCon">
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">交回卡单：</label>
							<input type="text" class="input-text w-140 readonly" readonly="readonly" value="${extendedOrder.translatedReturnCard}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务态度：</label>
							<input type="text" class="input-text w-110 readonly" readonly="readonly" value="${extendedCallback.translatedServiceAttitude}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">安全评价：</label>
							<input type="text" class="input-text w-110 readonly" readonly="readonly" value="${extendedCallback.translatedSafeEval}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">多次上门：</label>
							<input type="text" class="input-text w-110 readonly" readonly="readonly" value="${extendCallback.translateMultipleDropIn}"/>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">保修类型：</label>
							<input type="text" class="input-text w-140 readonly" readonly="readonly" value="${extendedOrder.translatedWarrantyType}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">是否交款：</label>
							<input type="text" class="input-text w-110 readonly" readonly="readonly" value="${extendedOrder.translatedWhetherCollection}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">交款总额：</label>
							<div class="priceWrap w-110 readonly">
								<input type="text" class="input-text readonly" readonly="readonly" value="${fns:getOrderTotalFee(order.columns.auxiliary_cost, order.columns.serve_cost, order.columns.warranty_cost)}"/>
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">实收总额：</label>
							<div class="priceWrap w-110 readonly">
								<input type="text" class="input-text readonly" readonly="readonly" value="${order.columns.confirm_cost}"/>
								<span class="unit">元</span>
							</div>
						</div>
					</div>
					<div class="pos-r mt-10 txtwrap1">
						<label class="lb lb1">回访结果：</label>
						<input type="text" class="input-text w-140 readonly" readonly="readonly" value="${extendedCallback.translatedResult}"/>
					</div>
					<div class="pos-r mt-10 txtwrap1">
						<label class="lb lb1">回访内容：</label>
						<textarea class="textarea h-50 readonly" readonly="readonly">${cbInfo.columns.remarks}</textarea>
					</div>
				</div>
				</c:if>
				<c:if test="${hasSettlement}">
					<div class="tabCon " id="settlementDetail">
				</c:if>
				</div>
			</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$("#closDivPoup").on("click",function(){
		//parent.search();
		$('#Hui-article-box',window.top.document).css({'z-index':'9'});
	});

	$(function(){
		$("#orderNumber").prop("disabled",false);
		$("#orderNumber").prop("readonly",true);
		$('#minusWrap').removeClass('minusWrap');
		$('#minusWrap').find('.prefix').hide();
		$.Huitab("#detialWd .tabBarP .tabswitch","#detialWd .tabCon","current","click","0");
		$.Huitab("#serveFb .tabBarP .tabswitch","#serveFb .tabCon","current","click","0");
		$.Huitab("#fbSettle .tabBarP .tabswitch","#fbSettle .tabCon","current","click","0");
		$('.orderdetailVb').popup({fixedHeight:false});
	});

	//显示重新结算
	function saveSettlementup(){
		$(".feyon").show();
		$(".jiesuan").hide();
		$("#seltment_form").show();
		$("#seltment_form_up").hide();

	}

	function saveCallback() {
		var postData = $("#callback_form").serializeJson();
		$.post('${ctx}/order/orderCallback/saveCallback', postData, function(result){
		});
	}

  	//显示结算
	function showjiesuan(){
 		$(".feyon").hide();
		$(".jiesuan").show();
	}

	//获取配件信息
	//获取工单关联备件使用信息
	function showSYMsg() {
		var orderNumber = "${order.columns.number}";
		var str = "";
		var imgstr = "";
		var img = [];
		$.ajax({
			url: "${ctx}/order/showSYMsg",
			data: {orderNumber:orderNumber, remark: 'SYMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
			dataType: 'json',
			async: false,
			success: function (result) {
				$("#pjsy").html("<caption>工单关联配件使用</caption>" +
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

				if (result.list.length > 0) {
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
						if (val.columns.status == "1") {
							str += "<td class='c-fe0101 w-70'><i class='oState state-verifyPass'></i>待核销</td>";
						}else if (val.columns.status == "2") {
							str += "<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>已核销</td>";
						}else if(val.columns.status=="3"){
                            str+="<td class='text-c c-fe0101 w-70'><i class='oState state-verify2nopass'></i>已拒绝</td>";
                        }
					});
				} else {
					$(".showimg").html("");
				}

				$("#pjsy").append(str);
			}
		});
	}

	//获取工单关联备件申请信息
	function showSQMsg() {
		var orderNumber = "${order.columns.number}";
		var str = "";
		var imgstr = "";
		var img = [];
		$.ajax({
			url: "${ctx}/order/showSQMsg",
			data: {orderNumber:orderNumber, remark: 'SQMsg'},// 备注信息 wxz 暂时取消，服务中的工单、待回访、待结算的工单中备件信息分为：使用的配件和申请的配件
			dataType: 'json',
			async: false,
			success: function (result) {
				$("#pjsq").html("<caption>工单关联配件申请</caption>" +
						"<thead>" +
						"<tr>" +
						"<th class='w-180'>备件条码</th>" +
						"<th class='w-260'>备件名称</th>" +
						"<th class='w-120'>备件型号</th>" +
						"<th class='w-50'>数量</th>" +
						"<th class='w-150'>审核备注</th>" +
						"<th class='w-70'>状态</th>" +
						"</tr>" +
						"</thead>");
				$(".showimg").html("<label class='lb lb1'>备件图片：</label>");

				if (result.list.length > 0) {
					$.each(result.list, function (index, val) {
						str += "<tr>" +
								"<td class='w-140'>" + val.columns.fitting_code + "</td>" +
								"<td class='w-300'>" + val.columns.fitting_name + "</td>" +
								"<td class='w-120'>" + val.columns.fitting_version + "</td>" +
								 "<td class='text-c w-50'>×" + val.columns.fitting_apply_num + "</td>" +
		                            "<td class='text-c w-150'>" + val.columns.audit_marks + "</td>" ;
						if (val.columns.status == "0") {
							str += "<td class='c-fe0101 w-70'><i class='oState state-verifyPass'></i>待审核</td>";
						} else if (val.columns.status == "1") {
							str += "<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>缺件中</td>";
						} else if (val.columns.status == "2") {
							str += "<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>待出库</td>";
						} else if (val.columns.status == "3") {
							str += "<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>待领取</td>";
						} else if (val.columns.status == "4") {
							str += "<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>已领取</td>";
						} else if (val.columns.status == "5") {
							str += "<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>已取消</td>";
						} else if (val.columns.status == "6") {
							str += "<td class='c-fe0101 w-70'><i class='oState state-waitVerify'></i>未通过</td>";
						}
						str += "</tr class='w-100'>";
						img = (val.columns.fitting_img).split(",");
						for (var i = 0; i < img.length; i++) {
							if (img[i] != "" && img[i] != null) {
								imgstr += ("<div class='f-l mr-10'><div class='imgWrap'><img src='${commonStaticImgPath}" + img[i] + "'></div></div>");
							}
						}
					});
					if (imgstr == "") {
						imgstr += ("<div class='f-l mr-10'><div class='imgWrap'><img src='${ctxPlugin}/static/h-ui.admin/images/img-default.png'></img></div></div>");
					}
				} else {
					$(".showimg").html("");
				}

				$("#pjsq").append(str);
				$(".showimg").append(imgstr);
				return;
			}

		});
	}
	function showJsDetail(){
	    if(${not isCurrent}){
            $("#settlementDetail").load("${ctx}/order/settlement/showHtml2017?id=${order.columns.id}");
		}else{
            $("#settlementDetail").load("${ctx}/order/settlement/showHtml?id=${order.columns.id}");
		}
	}

	$('#Imgprocess2').imgShow();

	//获取工单关联旧件信息
	function showOldFitting(){
		var orderNumber = "${order.columns.number}";
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
                });
				return;
			}

		});
	}

</script>
</body>
</html>
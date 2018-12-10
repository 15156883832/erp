<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>工单录入</title>
<meta name="decorator" content="base"/>

<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select2.min.css"/> 
<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
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
				<div class="tabBarP">
					<a href="javascript:;" class="tabswitch current">基本信息</a>
					<a href="javascript:;" class="tabswitch ">过程信息</a>
				</div>
				<div class="tabCon">
					<div class="cl mb-25 mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">工单编号：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order.number }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务类型：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.serviceType}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务方式：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" />
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">信息来源：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.origin }"/>
						</div>
					</div>
					<div class="line"></div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">用户姓名：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled"  value="${order.customerName }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">联系方式1：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${order.customerMobile }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">联系方式2：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${order.customerTelephone }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">联系方式3：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.customerTelephone2 }"/>
						</div>
					</div>
					<div class="cl mt-10 mb-25">
						<div class="pos-r txtwrap1">
							<label class="lb lb1">详细地址：</label>
							<input type="text" class="input-text w-340 readonly" disabled="disabled" value="${order.customerAddress }"/>
						</div>
					</div>
					<div class="line"></div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">家电品牌：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order.applianceBrand}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">家电品类：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.applianceCategory }"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">预约日期：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="<fmt:formatDate value='${order.promiseTime }' pattern='yyyy-MM-dd'/>"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">时间要求：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${order.promiseLimit }"/>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1 h-50">
							<label class="lb lb1">服务描述：</label>
							<textarea type="text" class="input-text w-340 h-50 readonly" disabled="disabled" value="${order.customerFeedback}"></textarea>
						</div>
						<div class="f-l pos-r txtwrap3 h-50">
							<label class="lb lb3">备注：</label>
							<textarea type="text" class="input-text h-50 w-310 readonly" disabled="disabled" >${order.remarks}</textarea>
						</div>
					</div>
					
					
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">产品型号：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order.applianceModel}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">内机条码：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.applianceBarcode}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">外机条码：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.applianceMachineCode}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">购买日期：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="<fmt:formatDate value='${order.applianceBuyTime }' pattern='yyyy-MM-dd'/>"/>
						</div>
					</div>
					<div class="cl mt-10">
						<div class="f-l pos-r txtwrap1">
							<label class="lb lb1">保修类型：</label>
							<input type="text" class="input-text w-140 readonly" disabled="disabled" value="${order.warrantyType}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">重要程度：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.level}"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">报修时间：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="<fmt:formatDate value='${order.repairTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"/>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">登记人：</label>
							<input type="text" class="input-text w-110 readonly" disabled="disabled" value="${order.xm}"/>
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
							<input type="text" class="input-text w-110 readonly" disabled="disabled"  value="${order.status}"/>
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
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">辅材收费：</label>
							<div class="priceWrap w-110 readonly">
								<input type="text" class="input-text readonly" disabled="disabled" value="${order.auxiliaryCost}" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">服务收费：</label>
							<div class="priceWrap w-110 readonly">
								<input type="text" class="input-text readonly" disabled="disabled" value="${order.serveCost}" />
								<span class="unit">元</span>
							</div>
						</div>
						<div class="f-l pos-r txtwrap2">
							<label class="lb lb2">延保收费：</label>
							<div class="priceWrap w-110 readonly">
								<input type="text" class="input-text readonly" disabled="disabled" value="${order.warrantyCost}" />
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
						<div class="pos-r txtwrap1 h-50">
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
								<img src="static/h-ui.admin/images/img1.png">
								<p class="lh-20">04-26 10:12 </p>
							</div>
						</div>
						<div class="f-l mr-10">
							<div class="imgWrap">
								<img src="static/h-ui.admin/images/img1.png">
								<p class="lh-20">04-26 10:12 </p>
							</div>
						</div>
						<div class="f-l mr-10">
							<div class="imgWrap">
								<img src="static/h-ui.admin/images/img1.png">
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
									<%-- <option value="3" ${order.warrantyType eq '3' ? 'selected=\'selected\'' : ''}>保内转保外</option> --%>
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
				<sfTags:pagePermission authFlag="ORDER_MODORDER_BTN_OTHERS" html='<input class="sfbtn sfbtn-opt3" value="修改工单" type="button" />'></sfTags:pagePermission>
				</c:if>
					<input class="sfbtn sfbtn-opt" value="直接封单" type="button"/>
				<input class="sfbtn sfbtn-opt" value="短信通知" type="button" />
				<a class="sfbtn sfbtn-opt sbtn" value="" target="_blank" href="${ctx}/print/order?orderId=${order.id}">打印工单</a>
				<input class="sfbtn sfbtn-opt" value="新建工单" type="button" onclick="newOrder('${order.id}')"/>
			</div>
				
			
		</div>
	</div>
</div>

<script type="text/javascript">
	
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
	});
	
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
		window.location.href="${ctx}/order/newFormFormDetail?id="+id;
	}
</script> 
</body>
</html>
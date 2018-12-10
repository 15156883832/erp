<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta name="decorator" content="base"/>
<title>回访结算工单-工单详情</title>
	<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/imgShow.js"></script>
</head>
<body>
<div class="popupBox orderFb">
	<h2 class="popupHead">
		工单回访
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<form id="callback_form">
		<input type="hidden" id="cb_id" name="id" value="${cbInfo.columns.id}">
		<input type="hidden" id="cb_orderId" name="orderId" value="${order.id}">
		<input type="hidden" id="cb_siteId" name="siteId" value="${order.siteId}">
		<input type="hidden" id="cb_dispatchId" name="dispatchId" value="${dispRd.columns.id}">
		<div class="popupMain pt-15 pb-15" >
			<div class="cl mb-10">
				<div class="f-l ">
					<label class="w-100 text-r f-l">交回卡单：</label>
					<select class="select w-120  f-l" name="return_card">
						<option value="1" ${order.returnCard == '1' ? 'selected=\'selected\'' : ''}>是</option>
						<option value="0" ${order.returnCard eq '0' ? 'selected=\'selected\'' : ''}>否</option>
					</select>
				</div>
				<div class="f-l">
					<label class="w-100 text-r f-l">多次上门：</label>
					<select class="select w-120  f-l" name="multipleDropin">
						<option value="1" ${cbInfo.columns.multiple_dropin eq '1' ? 'selected=\'selected\'' : ''}>是</option>
						<option value="0" ${(cbInfo.columns.multiple_dropin) eq '0' or (cbInfo eq null)? 'selected=\'selected\'' : ''}>否</option>
					</select>
				</div>
				<div class="f-l">
					<label class="w-100 text-r f-l">保修类型：</label>
					<select class="select w-120  f-l" name="warranty_type">
						<option value="1" ${order.warrantyType eq '1' ? 'selected=\'selected\'' : ''}>保内</option>
						<option value="2" ${order.warrantyType eq '2' ? 'selected=\'selected\'' : ''}>保外</option>
						<%-- <option value="3" ${order.warrantyType eq '3' ? 'selected=\'selected\'' : ''}>保内转保外</option> --%>
					</select>
				</div>
				
				
				
			</div>
			<div class="cl mb-10">
				<div class="f-l">
					<label class="w-100 text-r f-l"><em class="mark">*</em>服务态度：</label>
					<select class="select w-120 mustfill f-l" name="serviceAttitude" datatype="*" nullmsg="请选择服务态度">
						<option value="">请选择</option>
							<option value="5" ${cbInfo.columns.service_attitude eq '5' ? 'selected=\'selected\'' : ''}>十分满意</option>
						<option value="4" ${cbInfo.columns.service_attitude eq '4' ? 'selected=\'selected\'' : ''}>满意</option>
							<option value="3" ${cbInfo.columns.service_attitude eq '3' ? 'selected=\'selected\'' : ''}>一般</option>
							<option value="2" ${cbInfo.columns.service_attitude eq '2' ? 'selected=\'selected\'' : ''}>不满意</option>
						<option value="1" ${cbInfo.columns.service_attitude eq '1' ? 'selected=\'selected\'' : ''}>十分不满意</option>
						<option value="6" ${cbInfo.columns.service_attitude eq '6' ? 'selected=\'selected\'' : ''}>无效回访</option>
						<option value="7" ${cbInfo.columns.service_attitude eq '7' ? 'selected=\'selected\'' : ''}>回访未成功</option>
					</select>
				</div>
				<div class="f-l">
					<label class="w-100 text-r f-l">安全评价：</label>
					<select class="select  f-l" style="width:340px;" name="safetyEvaluation">
						<option value="1" ${cbInfo.columns.safety_evaluation eq '1' ? 'selected=\'selected\'' : ''}>按安全规范操作</option>
						<option value="2" ${cbInfo.columns.safety_evaluation eq '2' ? 'selected=\'selected\'' : ''}>未出示上岗证</option>
						<option value="3" ${cbInfo.columns.safety_evaluation eq '3' ? 'selected=\'selected\'' : ''}>未穿工作服鞋套</option>
						<option value="4" ${cbInfo.columns.safety_evaluation eq '4' ? 'selected=\'selected\'' : ''}>未清理现场</option>
						<option value="5" ${cbInfo.columns.safety_evaluation eq '5' ? 'selected=\'selected\'' : ''}>未按安全规范操作</option>
					</select>
				</div>
			</div>
			<div class="cl mb-10 pos-r pl-90 ml-10 pr-30">
				<label class="w-90 text-r lb"><em class="mark">*</em>回访内容：</label>
				<textarea class="textarea h-50 mustfill" name="remarks" datatype="*" nullmsg="请输入回访内容" errormsg="请输入回访内容">${cbInfo.columns.remarks }</textarea>
			</div>
			<div class="cl mb-10">
				<div class="f-l">
					<label class="w-100 text-r f-l">交款总额：</label>
					<div class="priceWrap w-120 f-l readonly">
						<input type="text" class="input-text readonly" value="${fns:getOrderTotalFee(order.auxiliaryCost, order.serveCost, order.warrantyCost)}" readonly id="totalfee"/>
						<span class="unit">元</span>
					</div>
				</div>
				<c:if test="${not empty collectionslist}">
				<c:forEach items="${collectionslist}" var="col">
					<c:set value="${sum + col.columns.payment_amount}" var="sum"/>
					<c:if test="${col.columns.payment_type=='0'}">
                        <c:set value="${sum1 + col.columns.payment_amount}" var="sum1"/>
                    </c:if>
                    <c:if test="${col.columns.payment_type=='1'}">
                        <c:set value="${sum2 + col.columns.payment_amount}" var="sum2"/>
                    </c:if>
				</c:forEach>
					<div class="ml-30 f-l"> 无现金收款：${sum}元（
						<c:if test="${not empty sum1}">
							<span>支付宝：${sum1}元</span>
						</c:if>
						<c:if test="${not empty sum2}">
							<span>微信：${sum2}元</span>
						</c:if>
								<span>）</span>
						<a class="proofImg c-0383dc" id="imgshows">凭证
							<c:forEach items="${collectionslist}" var="col">
								<c:if test="${not empty col.columns.imgs}">
									<img src="${commonStaticImgPath}${col.columns.imgs}"/>
								</c:if>
							</c:forEach>
						</a>
					</div>
			</c:if>
			</div>
			<div class="cl mb-10">
				<div class="f-l">
					<label class="w-100 text-r f-l">回访总额：</label>
					<div class="priceWrap w-120 f-l">
						<input type="text" class="input-text" name="callback_cost" datatype="price" ignore="ignore" errormsg="实收总额格式不正确（至多两位小数）" value="${order.callbackCost}" id="callback_cost"/>
						<span class="unit">元</span>
					</div>
				</div>
				<%-- <div class="f-l">
					<label class="w-100 text-r f-l">是否交款：</label>
					<select class="select w-120  f-l" name="whether_collection" id="whether_collection">
						<option value="1" ${order.whetherCollection eq '1' ? 'selected=\'selected\'' : ''}>是</option>
						<option value="0" ${order.whetherCollection eq '0' ? 'selected=\'selected\'' : ''}>否</option>
					</select>
				</div>
				<div class="f-l">
					<label class="w-100 text-r f-l">实收总额：</label>
					<c:if test="${order.whetherCollection == '1'}">
						<div class="priceWrap w-120 f-l">
							<input type="text" class="input-text" name="confirm_cost" datatype="price" ignore="ignore" errormsg="实收总额格式不正确（至多两位小数）" value="${order.confirmCost}" id="confirm_cost"/>
							<span class="unit">元</span>
						</div>
					</c:if>
					<c:if test="${order.whetherCollection != '1'}">
						<div class="priceWrap w-120 f-l readonly">
							<input type="text" class="input-text readonly" readonly="readonly" name="confirm_cost" datatype="price" ignore="ignore" errormsg="实收总额格式不正确（至多两位小数）" value="0.00" id="confirm_cost"/>
							<span class="unit">元</span>
						</div>
					</c:if>
				</div> --%>
				<%-- <div class="f-l">
					<label class="w-100 text-r f-l">多次上门：</label>
					<select class="select w-120  f-l" name="multipleDropin">
						<option value="1" ${cbInfo.columns.multiple_dropin eq '1' ? 'selected=\'selected\'' : ''}>是</option>
						<option value="0" ${(cbInfo.columns.multiple_dropin) eq '0' or (cbInfo eq null)? 'selected=\'selected\'' : ''}>否</option>
					</select>
				</div> --%>
				<div class="f-l ">
					<label class="w-100 text-r f-l"><em class="mark">*</em>回访结果：</label>
					<select class="select w-120 mustfill f-l" name="result" id="result" nullmsg="请选择回访结果" errormsg="请选择回访结果" datatype="*">
					<c:if test="${fromHistory eq 'ok'}">
						<option value="1">已完工</option>
					</c:if>
					<c:if test="${fromHistory ne 'ok'}">
						<option value="">请选择</option>
						<option value="1" ${cbInfo.columns.result eq '1' ? 'selected=\'selected\'' : ''}>已完工</option>
						<option value="2" ${cbInfo.columns.result eq '2' ? 'selected=\'selected\'' : ''}>仍需上门</option>
						<option value="3" ${cbInfo.columns.result eq '3' ? 'selected=\'selected\'' : ''}>待回访</option>
						<c:if test="${completionResult == '1'}">
							<option value="4" ${cbInfo.columns.result eq '4' ? 'selected=\'selected\'' : ''}>无效工单</option>
						</c:if>
					</c:if>
					</select>
				</div>
			</div>
			
			
			<div class="text-c mt-30">
				<a id="subBtn" href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5">保存</a>
				<a href="javascript:parent.closeCallbackForm();" class="sfbtn sfbtn-opt w-70 " id="btnCancel">取消</a>
			</div>
		</div>
		</form>
	</div>
</div>
<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script>
    $('#imgshows').imgShow();
	$(function () {

		$('.orderFb').popup({level:2});

		$('#callback_form').Validform({
			btnSubmit: "#subBtn",
			tiptype: function (msg, o, cssctl) {
				if (msg) {
					layer.msg(msg);
				}
			},
			postonce: true,
			datatype: {
				"price": /^\d+(\.\d{1,2})?$/
			},
			callback: function (form) {
				var result = $("#result").val();
				$.ajax({
					url: "${ctx}/order/orderCallback/saveCallback",
					type: "POST",
					data: form.serialize(),
					success: function (data) {
						parent.layer.msg("保存成功");
						window.parent.location.reload(true);
						parent.parent.search();
						if (result == '2') {
							$.closeAllDiv();
						} else if(result == '4'){
                            $.closeAllDiv();
						} else {
							parent.updateCallbackBtn();
							parent.closeCallbackForm();
						}
					}
				});
				return false;
			}
		});
		$('#whether_collection').change(function(){
			var slct = $("#whether_collection option:selected");
			var obj = $("#confirm_cost");
			if( slct.text()=="否"){
				obj.val('0.00');
				obj.attr("readonly","readonly");
				obj.addClass("readonly");
				obj.parent(".priceWrap").addClass("readonly");
			}else{
				obj.removeAttr("readonly");
				obj.removeClass("readonly");
				obj.parent(".priceWrap").removeClass("readonly");
				if('${order.whetherCollection}'=='1'){
					obj.val('${order.confirmCost}');
				}else{
					obj.val($("#totalfee").val());
				}
			}
        });
	});

	
	
	$('#btnCancel').on('click', function(){
		$.closeDiv($('.orderFb'));
	})

</script>
</body>
</html>

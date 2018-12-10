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
<div class="popupBox orderFb" style="width: 482px">
	<h2 class="popupHead">
		工单回访
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<form id="callback_form">
		<input type="hidden" id="cb_id" name="id" value="${cbInfo.columns.id}">
		<input type="hidden" id="cb_orderId" name="orderId" value="${order.id}">
		<div class="popupMain pt-15 pb-15" >
			<div class="cl mb-10">
				<div class="f-l">
					<label class="w-100 text-r f-l"><em class="mark">*</em>回访结果：</label>
					<select class="select w-120 mustfill f-l" name="result" id="result" nullmsg="请选择回访结果" errormsg="请选择回访结果" datatype="*">
						<c:if test="${fromHistory eq 'ok'}">
							<option value="1">已完工</option>
						</c:if>
						<c:if test="${fromHistory ne 'ok'}">
							<option value="">请选择</option>
							<option value="1" ${cbInfo.columns.result eq '1' ? 'selected=\'selected\'' : ''}>已完工</option>
							<%--<option value="2" ${cbInfo.columns.result eq '2' ? 'selected=\'selected\'' : ''}>仍需上门</option>--%>
							<option value="3" ${cbInfo.columns.result eq '3' ? 'selected=\'selected\'' : ''}>待回访</option>
							<c:if test="${completionResult == '1'}">
							<option value="4" ${cbInfo.columns.result eq '4' ? 'selected=\'selected\'' : ''}>无效工单</option>
							</c:if>
						</c:if>
					</select>
				</div>

				<div class="f-l">
					<label class="w-100 text-r f-l"><em class="mark">*</em>服务态度：</label>
					<select class="select w-120 mustfill f-l" name="serviceAttitude" datatype="*" nullmsg="请选择服务态度">
						<option value="">请选择</option>
						<option value="5" ${cbInfo.columns.service_attitude eq '5' ? 'selected=\'selected\'' : ''}>十分满意</option>
						<option value="4" ${cbInfo.columns.service_attitude eq '4' ? 'selected=\'selected\'' : ''}>满意</option>
						<option value="3" ${cbInfo.columns.service_attitude eq '3' ? 'selected=\'selected\'' : ''}>一般</option>
						<option value="2" ${cbInfo.columns.service_attitude eq '2' ? 'selected=\'selected\'' : ''}>不满意</option>
						<option value="1" ${cbInfo.columns.service_attitude eq '1' ? 'selected=\'selected\'' : ''}>十分不满意</option>
					</select>
				</div>
			</div>
			<div class="cl mb-10">
				<div class="f-l">
					<label class="w-100 text-r f-l">是否收款：</label>
					<select class="select w-120  f-l" name="resirveMoneyFlag" id="whether_collection" onchange="changeMoney(this.value)">
						<option value="0" ${cbInfo.columns.resirve_money_flag eq '0' ? 'selected' : ''}>否</option>
						<option value="1" ${cbInfo.columns.resirve_money_flag eq '1' ? 'selected' : ''}>是</option>
					</select>
				</div>

				<div class="f-l">
					<div id="canNull">
						<c:if test="${cbInfo.columns.resirve_money_flag eq '0' or empty cbInfo.columns.resirve_money_flag}">
							<label class="w-100 text-r f-l">收款金额：</label>
							<div class="priceWrap w-120 f-l">
								<input type="text" class="input-text readonly" name="resirveMoney" value="${cbInfo.columns.resirve_money}" readonly="readonly"/>
								<span class="unit">元</span>
							</div>
						</c:if>
					</div>
					<div id="noNull">
						<c:if test="${cbInfo.columns.resirve_money_flag eq '1'}">
							<label class="w-100 text-r f-l">收款金额：</label>
							<div class="priceWrap w-120 f-l">
								<input type="text" class="input-text" name="resirveMoney" value="${cbInfo.columns.resirve_money}" datatype="price" nullmsg="请输入收款金额" errormsg="请输入收款金额"/>
								<span class="unit">元</span>
							</div>
						</c:if>
					</div>
				</div>
			</div>
			<div class="cl mb-10 pos-r pl-90 ml-10 pr-30">
				<label class="w-90 text-r lb"><em class="mark">*</em>回访内容：</label>
				<textarea class="textarea h-50 mustfill" name="remarks" datatype="*" nullmsg="请输入回访内容" errormsg="请输入回访内容">${cbInfo.columns.remarks }</textarea>
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
					url: "${ctx}/order/orderParentCallback/saveSecCallback",
					type: "POST",
					data: form.serialize(),
					success: function (data) {
						window.top.layer.msg("保存成功");
						window.parent.location.reload(true);
						parent.parent.search();
						if (result == '1') {
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
	});

	function changeMoney(val){
		if(val=='1'){
		    $("#canNull").removeClass("hide");
		    $("#noNull").removeClass("hide");
            var html='<label class="w-100 text-r f-l">收款金额：</label>';
            html+='<div class="priceWrap w-120 f-l">';
            html+='<input type="text" class="input-text" name="resirveMoney" value="${cbInfo.columns.resirve_money}" datatype="price" nullmsg="请输入收款金额" errormsg="请输入收款金额"/>';
            html+='<span class="unit">元</span></div>';
            $("#noNull").empty().append(html);
            $("#canNull").empty();
		}else if(val=='0'){
            $("#canNull").removeClass("hide");
            $("#noNull").removeClass("hide");
            var html='<label class="w-100 text-r f-l">收款金额：</label>';
            html+='<div class="priceWrap w-120 f-l">';
            html+='<input type="text" class="input-text readonly" name="resirveMoney" value="${cbInfo.columns.resirve_money}" readonly="readonly"/>';
            html+='<span class="unit">元</span></div>';
            $("#canNull").empty().append(html);
            $("#noNull").empty();
		}
	}

	$('#btnCancel').on('click', function(){
		$.closeDiv($('.orderFb'));
	})

</script>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta name="decorator" content="base"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select2.full.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxPlugin}/lib/select/select2.min.css"/>
	<script type="text/javascript" src="${ctxPlugin}/lib/select/select2.full.min.js"></script>
	<script type="text/javascript" src="${ctxPlugin}/lib/Validform/5.3.2/Validform.min.js"></script>
	<title>标记工单</title>
</head>
<body>

<div class="popupBox w-520 orderflag">
	<h2 class="popupHead">
		标记工单
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<form id="markform">
	<div class="popupContainer pt-20 pb-15">
		<div class="popupMain " >
			<div class="cl mb-10">
				<input type="hidden" name="ids" value="${ids}">
				<input type="hidden" id="flagVal" name="flagVal">
				<label class="f-l w-100"><em class="mark">*</em>标记类型：</label>
				<select class="select f-l w-300" id="flag" name="flag">
					<option >请选择</option>
					<c:forEach items="${flags}" var="item">
						<option value="${item.id}">${item.name}</option>
					</c:forEach>
				</select>
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">提醒日期：</label>
				<input type="text" onfocus="WdatePicker({})" id="alertTime" name="alertTime" value="" class="input-text Wdate w-300">
			</div>
			<div class="cl mb-10">
				<label class="f-l w-100">标记备注：</label>
				<textarea class="textarea f-l w-300" style="height: 100px;" maxlength="40" name="flagDesc"></textarea>
			</div>
		</div>	
		<div class="text-c pt-15">
			<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="subBtn">确认</a>
			<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="$.closeDiv($('.orderflag'));">取消</a>
		</div>
	</div>
	</form>
</div>

<script type="text/javascript" src="${ctxPlugin}/static/h-ui.admin/js/popUpNew.js"></script>
<script type="text/javascript">
	var validform;
	$(function(){
        $("#flag").select2();
        $(".selection").css("width","300px");
		$('.orderflag').popup();

        validform = $('#markform').Validform({
            tiptype: function (msg, o, cssctl) {
                if (o.type === 3) {
                    layer.msg(msg);
                }
            },
            btnSubmit:"#subBtn",
            tipSweep: true,
            postonce: true,
            showAllError: false,
			beforeCheck: function() {
                var flag = $("#flag").select2('val');
                if (flag === "请选择") {
                    layer.msg("请选择标记类型");
                    return false;
                }
                return true;
			},
            callback: function (form) {
                $.ajax({
                    url: "${ctx}/order/markOrders?type=${type}",
                    type: "POST",
                    data: form.serialize(),
                    success: function (data) {
                        window.top.layer.msg('标记成功');
                        var $iFrame = $('#Hui-article-box iframe:visible', window.top.document)[0];
                        var win = $iFrame.contentWindow || $iFrame;
                        win.search();
                        $.closeDiv($('.orderflag'));
                    }
                });
                return false;
            }
        });

	});
</script> 
</body>
</html>

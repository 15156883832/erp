<!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta name="decorator" content="base"/>
<title>系统设置-厂家资料添加</title>
</head>
<body>
<!-- 新增信息来源 -->
<div class="popupBox pmanufacture addManufacture">
	<h2 class="popupHead">
		添加
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<form action="#" class="form-add-fitting">
				<div class="cl mb-10">
					<label class="f-l w-90">厂家名称：</label>
					<select class="select w-210"id="getSelectedId">
							<option value="">请选择</option>
							<c:forEach items="${vender}" var="ven">
								<option id="optioned" value="${ven.columns.id}">${ven.columns.name}</option>
							</c:forEach>
					</select>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90">账号：</label>
					<input type="text" id="loginNameAdd" class="input-text w-210 f-l"/>
				</div>
				<div class="cl mb-10">
					<label class="f-l w-90">密码：</label>
					<input type="text" id="passwordAdd" class="input-text w-210 f-l"/>
				</div>
				<div class="text-c mt-25">
					<a href="javascript:;" onclick="addSave()" class="sfbtn sfbtn-opt3 w-70 mr-5">确定</a>
					<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="quxiaotj()">取消</a>
				</div>
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(function(){
		//新增
	$('.addManufacture').popup({fixedHeight:false});
	});

	function addSave(){
		var loginName = $("#loginNameAdd").val();
		var password = $("#passwordAdd").val();
		var getSelectedId = $("#getSelectedId").val();
		if($.trim(getSelectedId)==null || $.trim(getSelectedId)==""){
			return layer.msg("请选择厂家！");
		}else if($.trim(loginName)==null || $.trim(loginName)==""){
			return layer.msg("请填写账号！");
		}else if($.trim(password)==null || $.trim(password)==""){
			return layer.msg("请填写密码！");
		}

        $.ajax({
            type: "POST",
            traditional: true,
            url: "${ctx}/order/siteVenderAccount/addSave",
            data: {
                getSelectedId: getSelectedId,
                loginName: loginName,
                password: password
            },
            dataType: 'text',
            success: function (result1) {
                if(result1=='ok'){
                    layer.msg("该账号已添加，不可重复添加！");
				}else if (result1 == "true") {
                    window.top.layer.msg("添加成功");
					parent.location.reload();
                    $.closeDiv($('.addManufacture'));
                } else {
                    layer.msg("添加失败，请联系管理员！");
                }

            }
        });
	}

	function quxiaotj(){
		$.closeDiv($('.addManufacture'));
	}
	


</script> 
</body>
</html> 
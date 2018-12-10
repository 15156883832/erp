<!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta name="decorator" content="base"/>
<title>系统设置-商品设置</title>
</head>
<body>
<!-- 修改信息来源 -->

<div class="popupBox w-400 exacctPopup" style="z-index: 199;">
	<h2 class="popupHead">
		修改
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer ">
		<div class="popupMain pb-50 pos-r pt-25 pl-15">
			<div class="pcontent" id="originbox" >
				<input type="hidden"  value="${exacct.id }"  id="ids"/>
				<div class="cl mb-10">
					<label class="f-l w-120"><em class="mark">*</em>费用科目名称：</label>
					<input type="text" class="input-text w-160 f-l  labelname" id="nowName"  value="${exacct.name }"/>
				</div>
			</div>
			<div class="text-c btnWrap pt-10">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btnSubmit">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="closed()">取消</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	
	var editMark = false;
	$(function() {
		$('.exacctPopup').popup();
		$("#btnSubmit").click(function() {
			if(editMark){
				return ;
			}
			var ids = document.getElementById("ids").value;
			var names = $("#nowName").val();
			editMark = true;
			$.ajax({
				type : 'POST',
				url : "${ctx}/finance/balanceManager/updateExacctEdit",
				data : {
					"name" : names,
					"id" : ids
				},
				success : function(data) {
					editMark = false;
					if(data.code=="200"){
						layer.msg("修改成功！");
						parent.search();
						$.closeDiv($(".exacctPopup"));
					}else if(data.code=="420"){
						layer.msg("修改失败,费用科目名“"+names+"”已存在！");
					}else{
						layer.msg("未知错误，请联系管理员！");
					}
					return;
				}
			});
		});
	});
	
	function closed() {
		$.closeDiv($('.exacctPopup'));
	}

	function delOrigin(obj) {
		var oParent = $('#originbox');
		$(obj).parent('div').remove();

		var childLenth = oParent.children().size();
		oParent.children().eq(childLenth - 1).find('a.sficon-add2').show();

		if (childLenth == 1) {
			oParent.children().eq(0).find('a.sficon-reduce2').hide();
		}
		$.setPos($('.exacctPopup'));
	}
</script> 
</body>
</html> 



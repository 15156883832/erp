<!DOCTYPE HTML>
<html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta name="decorator" content="base"/>
<title>系统设置-单位设置</title>
</head>
<body>
<!-- 修改信息来源 -->

<div class="popupBox porigin editOrigin" style="z-index: 199;">
	<h2 class="popupHead">
		修改
		<a href="javascript:;" class="sficon closePopup"></a>
	</h2>
	<div class="popupContainer pos-r">
		<div class="popupMain">
			<div class="pcontent" id="originbox" >
			<input type="hidden"  value="${unit.columns.id }"  id="ids"/>
				<div class="cl mb-10">
				<label class="f-l w-70"><em class="mark">*</em>单位名称：</label>
				<input type="text" class="input-text w-140 f-l labelname"  value="${unit.columns.name }"/>
				<label class="f-l w-90">单位类型：</label>
					<select class="select input-text w-140 f-l  labeltype" name="labeltype">
					<c:if test="${unit.columns.type=='i'}">
										<option value="i" selected="selected">整数</option>
										<option value="d" >实数</option>
										</c:if>
												<c:if test="${unit.columns.type=='d'}">
												<option value="i" >整数</option>
												<option value="d" selected="selected">实数</option>
												</c:if>
												
										</select>
			</div>
			</div>
			<div class="text-c mt-25 pt-20">
				<a href="javascript:;" class="sfbtn sfbtn-opt3 w-70 mr-5" id="btnSubmit">保存</a>
				<a href="javascript:;" class="sfbtn sfbtn-opt w-70 mr-5" onclick="closed()">取消</a>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(function(){
	$('.editOrigin').popup(); 
	$("#btnSubmit").click(function(){
	var ids=document.getElementById("ids").value;
		var names = $(".labelname").val();
		var type = $(".labeltype").val();
		var nameArr = [];
		nameArr[0]=names;
		if(	$.trim(names)==""|| $.trim(names)==null){
			layer.msg("“单位名称”不能为空！");
			return;
		}
		$.ajax({
			type:'POST',
			url:'${ctx}/order/unit/queryNums',
			traditional: true,
			data:{"nameArr":nameArr,
				     "id":ids}, 
			dataType:'json',
			async:false,
			success:function(result){
			if(result.flag){
				$.ajax({
					type:'POST',
					url:"${ctx}/order/unit/update",
					traditional: true,
					data:{
						"names":names,
					    "type":type,
					    "id":ids
					},
					success:function(data){
						layer.msg("修改成功");
						parent.location.reload(); 
						$.closeDiv($(".editOrigin"));
				    //window.location.href="${ctx}/order/unit";
					//window.location.reload(true);
					}
				
				});
			}else{
				layer.msg("单位名已存在");
				return;
			} 
			return;
			}
		}); 

	});
	});
	function closed(){
		   //window.location.href="${ctx}/order/unit"
		$.closeDiv($('.editOrigin'));
	}

	function delOrigin(obj){
		var oParent = $('#originbox');
		$(obj).parent('div').remove();
		
		var childLenth = oParent.children().size();
		oParent.children().eq(childLenth-1).find('a.sficon-add2').show();
		
		if( childLenth == 1){
			oParent.children().eq(0).find('a.sficon-reduce2').hide();
		}
		$.setPos($('.addOrigin'));	
	}


</script> 
</body>
</html> 